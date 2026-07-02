import 'package:drift/drift.dart';

import 'package:carnitas_cheque/shared/core/enums/rol_usuario.dart';

class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nombre => text().withLength(min: 1, max: 100)();

  TextColumn get rol => text().map(const RolUsuarioConverter())();

  /// Hash del PIN de acceso (nunca almacenar en texto plano en producción).
  TextColumn get pinAcceso => text().withLength(min: 4, max: 128)();

  BoolColumn get activo => boolean().withDefault(const Constant(true))();

  DateTimeColumn get creadoEn =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get actualizadoEn =>
      dateTime().withDefault(currentDateAndTime)();
}

class RolUsuarioConverter extends TypeConverter<RolUsuario, String> {
  const RolUsuarioConverter();

  @override
  RolUsuario fromSql(String fromDb) => RolUsuario.fromValue(fromDb);

  @override
  String toSql(RolUsuario value) => value.value;
}
