import 'package:carnitas_cheque/shared/database/local_db.dart';

class InventarioLocalDataSource {
  const InventarioLocalDataSource(this._db);

  final LocalDatabase _db;

  Stream<List<Producto>> watchProductos() => _db.watchTodosLosProductos();

  Stream<List<Categoria>> watchCategorias() => _db.watchCategoriasActivas();

  Future<void> guardarProducto({
    required int id,
    required String nombre,
    required int categoriaId,
    required int precioUnidadCentavos,
    required double inventarioDisponible,
    required bool esPorPeso,
    required bool activo,
    String? imagenUrl,
  }) {
    return _db.actualizarProducto(
      id: id,
      nombre: nombre,
      categoriaId: categoriaId,
      precioUnidadCentavos: precioUnidadCentavos,
      inventarioDisponible: inventarioDisponible,
      esPorPeso: esPorPeso,
      activo: activo,
      imagenUrl: imagenUrl,
    );
  }
}
