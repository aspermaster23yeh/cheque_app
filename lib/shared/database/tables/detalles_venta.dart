import 'package:drift/drift.dart';

import 'package:carnitas_cheque/shared/database/tables/productos.dart';
import 'package:carnitas_cheque/shared/database/tables/ventas.dart';

class DetallesVenta extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get ventaId =>
      integer().references(Ventas, #id, onDelete: KeyAction.cascade)();

  IntColumn get productoId =>
      integer().references(Productos, #id, onDelete: KeyAction.restrict)();

  /// Cantidad fraccionada (KG) o entera (piezas).
  RealColumn get cantidad => real()();

  /// Precio unitario en centavos al momento de la venta.
  IntColumn get precioHistorico => integer()();

  /// Subtotal en centavos (cantidad × precio, redondeado).
  IntColumn get subtotal => integer()();
}
