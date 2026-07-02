import 'package:drift/drift.dart';

class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nombre => text().withLength(min: 1, max: 80).unique()();

  BoolColumn get activo => boolean().withDefault(const Constant(true))();

  /// Orden de aparición en el menú del POS.
  IntColumn get orden => integer().withDefault(const Constant(0))();

  DateTimeColumn get creadoEn =>
      dateTime().withDefault(currentDateAndTime)();
}
