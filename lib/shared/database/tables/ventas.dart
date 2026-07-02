import 'package:drift/drift.dart';

import 'package:carnitas_cheque/shared/core/enums/estado_venta.dart';
import 'package:carnitas_cheque/shared/core/enums/metodo_pago.dart';
import 'package:carnitas_cheque/shared/database/tables/usuarios.dart';

class Ventas extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get usuarioId =>
      integer().references(Usuarios, #id, onDelete: KeyAction.restrict)();

  DateTimeColumn get fechaVenta =>
      dateTime().withDefault(currentDateAndTime)();

  /// Total en centavos (suma de subtotales de detalles).
  IntColumn get total => integer()();

  TextColumn get metodoPago =>
      text().map(const MetodoPagoConverter())();

  TextColumn get estado => text()
      .map(const EstadoVentaConverter())
      .withDefault(const Constant('completado'))();

  TextColumn get notas => text().nullable()();

  DateTimeColumn get creadoEn =>
      dateTime().withDefault(currentDateAndTime)();
}

class MetodoPagoConverter extends TypeConverter<MetodoPago, String> {
  const MetodoPagoConverter();

  @override
  MetodoPago fromSql(String fromDb) => MetodoPago.fromValue(fromDb);

  @override
  String toSql(MetodoPago value) => value.value;
}

class EstadoVentaConverter extends TypeConverter<EstadoVenta, String> {
  const EstadoVentaConverter();

  @override
  EstadoVenta fromSql(String fromDb) => EstadoVenta.fromValue(fromDb);

  @override
  String toSql(EstadoVenta value) => value.value;
}
