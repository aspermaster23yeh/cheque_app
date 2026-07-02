import 'package:drift/drift.dart';

import 'package:carnitas_cheque/shared/database/tables/categorias.dart';

class Productos extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get categoriaId =>
      integer().references(Categorias, #id, onDelete: KeyAction.restrict)();

  TextColumn get nombre => text().withLength(min: 1, max: 120)();

  /// Precio en centavos por unidad o por kilogramo según [esPorPeso].
  IntColumn get precioUnidad => integer()();

  BoolColumn get esPorPeso => boolean().withDefault(const Constant(false))();

  /// KG si [esPorPeso], piezas en caso contrario.
  RealColumn get inventarioDisponible =>
      real().withDefault(const Constant(0))();

  TextColumn get imagenUrl => text().nullable()();

  BoolColumn get activo => boolean().withDefault(const Constant(true))();

  DateTimeColumn get creadoEn =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get actualizadoEn =>
      dateTime().withDefault(currentDateAndTime)();
}
