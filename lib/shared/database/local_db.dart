import 'package:drift/drift.dart';

import 'package:carnitas_cheque/shared/core/enums/estado_venta.dart';
import 'package:carnitas_cheque/shared/core/enums/metodo_pago.dart';
import 'package:carnitas_cheque/shared/core/enums/rol_usuario.dart';
import 'package:carnitas_cheque/shared/database/connection/native.dart';
import 'package:carnitas_cheque/shared/database/models/kpi_models.dart';
import 'package:carnitas_cheque/shared/database/tables/categorias.dart';
import 'package:carnitas_cheque/shared/database/tables/detalles_venta.dart';
import 'package:carnitas_cheque/shared/database/tables/productos.dart';
import 'package:carnitas_cheque/shared/database/tables/usuarios.dart';
import 'package:carnitas_cheque/shared/database/tables/ventas.dart';

part 'local_db.g.dart';

@DriftDatabase(
  tables: [
    Usuarios,
    Categorias,
    Productos,
    Ventas,
    DetallesVenta,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(openNativeConnection());

  /// Constructor para tests con base de datos en memoria.
  LocalDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedInitialData();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await _actualizarPinesUsuarios();
          }
        },
      );

  // ---------------------------------------------------------------------------
  // Queries de referencia — usadas por los DataSources de cada feature.
  // ---------------------------------------------------------------------------

  /// Stream reactivo de categorías activas ordenadas para el menú POS.
  Stream<List<Categoria>> watchCategoriasActivas() {
    return (select(categorias)
          ..where((c) => c.activo.equals(true))
          ..orderBy([(c) => OrderingTerm.asc(c.orden)]))
        .watch();
  }

  /// Stream reactivo de productos activos filtrados por categoría.
  Stream<List<Producto>> watchProductosPorCategoria(int categoriaId) {
    return (select(productos)
          ..where(
            (p) =>
                p.categoriaId.equals(categoriaId) & p.activo.equals(true),
          )
          ..orderBy([(p) => OrderingTerm.asc(p.nombre)]))
        .watch();
  }

  /// Busca usuario por PIN (Fase 1: comparación directa; migrar a hash).
  Future<Usuario?> findUsuarioByPin(String pin) {
    return (select(usuarios)
          ..where((u) => u.pinAcceso.equals(pin) & u.activo.equals(true))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Inserta una venta con sus detalles en una transacción atómica.
  Future<int> crearVentaConDetalles({
    required int usuarioId,
    required MetodoPago metodoPago,
    required List<DetallesVentaCompanion> detalles,
    String? notas,
  }) async {
    return transaction(() async {
      final totalCentavos = detalles.fold<int>(
        0,
        (sum, d) => sum + (d.subtotal.value),
      );

      final ventaId = await into(ventas).insert(
        VentasCompanion.insert(
          usuarioId: usuarioId,
          total: totalCentavos,
          metodoPago: metodoPago,
          notas: Value(notas),
        ),
      );

      await batch((b) {
        b.insertAll(
          detallesVenta,
          detalles.map((d) => d.copyWith(ventaId: Value(ventaId))).toList(),
        );
      });

      return ventaId;
    });
  }

  /// KPI: total de ventas completadas en un rango de fechas (centavos).
  Future<int> totalVentasEnRango(DateTime desde, DateTime hasta) async {
    final query = selectOnly(ventas)
      ..addColumns([ventas.total.sum()])
      ..where(
        ventas.estado.equals(EstadoVenta.completado.value) &
            ventas.fechaVenta.isBiggerOrEqualValue(desde) &
            ventas.fechaVenta.isSmallerThanValue(hasta),
      );

    final row = await query.getSingle();
    return row.read(ventas.total.sum()) ?? 0;
  }

  /// Cantidad de ventas completadas en un rango.
  Future<int> contarVentasEnRango(DateTime desde, DateTime hasta) async {
    final query = selectOnly(ventas)
      ..addColumns([ventas.id.count()])
      ..where(
        ventas.estado.equals(EstadoVenta.completado.value) &
            ventas.fechaVenta.isBiggerOrEqualValue(desde) &
            ventas.fechaVenta.isSmallerThanValue(hasta),
      );

    final row = await query.getSingle();
    return row.read(ventas.id.count()) ?? 0;
  }

  /// Ventas agrupadas por hora del día (centavos).
  Future<List<VentaPorHora>> ventasPorHoraEnRango(
    DateTime desde,
    DateTime hasta,
  ) async {
    final rows = await customSelect(
      '''
      SELECT CAST(
        strftime('%H', datetime(fecha_venta / 1000, 'unixepoch', 'localtime'))
        AS INTEGER
      ) AS hora,
      COALESCE(SUM(total), 0) AS total_centavos
      FROM ventas
      WHERE estado = ?1
        AND fecha_venta >= ?2
        AND fecha_venta < ?3
      GROUP BY hora
      ORDER BY hora
      ''',
      variables: [
        Variable<String>(EstadoVenta.completado.value),
        Variable<DateTime>(desde),
        Variable<DateTime>(hasta),
      ],
      readsFrom: {ventas},
    ).get();

    return rows
        .map(
          (row) => VentaPorHora(
            hora: row.read<int>('hora'),
            totalCentavos: row.read<int>('total_centavos'),
          ),
        )
        .toList();
  }

  /// Top productos por ingresos en un rango.
  Future<List<ProductoTop>> topProductosEnRango(
    DateTime desde,
    DateTime hasta, {
    int limite = 5,
  }) async {
    final rows = await customSelect(
      '''
      SELECT p.nombre AS nombre,
             COALESCE(SUM(d.cantidad), 0) AS cantidad,
             COALESCE(SUM(d.subtotal), 0) AS total_centavos
      FROM detalles_venta d
      INNER JOIN productos p ON p.id = d.producto_id
      INNER JOIN ventas v ON v.id = d.venta_id
      WHERE v.estado = ?1
        AND v.fecha_venta >= ?2
        AND v.fecha_venta < ?3
      GROUP BY p.id, p.nombre
      ORDER BY total_centavos DESC
      LIMIT $limite
      ''',
      variables: [
        Variable<String>(EstadoVenta.completado.value),
        Variable<DateTime>(desde),
        Variable<DateTime>(hasta),
      ],
      readsFrom: {detallesVenta, productos, ventas},
    ).get();

    return rows
        .map(
          (row) => ProductoTop(
            nombre: row.read<String>('nombre'),
            cantidad: row.read<double>('cantidad'),
            totalCentavos: row.read<int>('total_centavos'),
          ),
        )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Seed inicial — datos de desarrollo para el MVP.
  // ---------------------------------------------------------------------------

  Future<void> _seedInitialData() async {
    await batch((b) {
      b.insertAll(usuarios, [
        UsuariosCompanion.insert(
          nombre: 'Administrador',
          rol: RolUsuario.admin,
          pinAcceso: '2323',
        ),
        UsuariosCompanion.insert(
          nombre: 'Vendedor',
          rol: RolUsuario.vendedor,
          pinAcceso: '0423',
        ),
      ]);

      b.insertAll(categorias, [
        CategoriasCompanion.insert(nombre: 'Carnitas', orden: const Value(1)),
        CategoriasCompanion.insert(nombre: 'Tacos', orden: const Value(2)),
        CategoriasCompanion.insert(nombre: 'Tortas', orden: const Value(3)),
        CategoriasCompanion.insert(nombre: 'Bebidas', orden: const Value(4)),
      ]);
    });

    // Productos requieren IDs de categoría ya insertados.
    final cats = await select(categorias).get();
    final carnitas = cats.firstWhere((c) => c.nombre == 'Carnitas');
    final tacos = cats.firstWhere((c) => c.nombre == 'Tacos');
    final tortas = cats.firstWhere((c) => c.nombre == 'Tortas');
    final bebidas = cats.firstWhere((c) => c.nombre == 'Bebidas');

    await batch((b) {
      b.insertAll(productos, [
        ProductosCompanion.insert(
          categoriaId: carnitas.id,
          nombre: 'Carnitas (por KG)',
          precioUnidad: 28000,
          esPorPeso: const Value(true),
          inventarioDisponible: const Value(50.0),
        ),
        ProductosCompanion.insert(
          categoriaId: carnitas.id,
          nombre: 'Orden 1/4 KG',
          precioUnidad: 7000,
          inventarioDisponible: const Value(999.0),
        ),
        ProductosCompanion.insert(
          categoriaId: tacos.id,
          nombre: 'Taco',
          precioUnidad: 2500,
          inventarioDisponible: const Value(999.0),
        ),
        ProductosCompanion.insert(
          categoriaId: tortas.id,
          nombre: 'Torta',
          precioUnidad: 6500,
          inventarioDisponible: const Value(999.0),
        ),
        ProductosCompanion.insert(
          categoriaId: bebidas.id,
          nombre: 'Refresco',
          precioUnidad: 2500,
          inventarioDisponible: const Value(999.0),
        ),
        ProductosCompanion.insert(
          categoriaId: bebidas.id,
          nombre: 'Agua',
          precioUnidad: 2000,
          inventarioDisponible: const Value(999.0),
        ),
      ]);
    });
  }

  /// Actualiza PINs en instalaciones existentes (migración v1 → v2).
  Future<void> _actualizarPinesUsuarios() async {
    await (update(usuarios)..where((u) => u.rol.equals(RolUsuario.admin.value)))
        .write(const UsuariosCompanion(pinAcceso: Value('2323')));
    await (update(usuarios)..where((u) => u.rol.equals(RolUsuario.vendedor.value)))
        .write(const UsuariosCompanion(pinAcceso: Value('0423')));
  }
}
