import 'package:drift/drift.dart';

import 'package:carnitas_cheque/shared/core/enums/estado_venta.dart';
import 'package:carnitas_cheque/shared/core/enums/metodo_pago.dart';
import 'package:carnitas_cheque/shared/core/enums/tipo_orden.dart';
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

  /// Mesa, para llevar o domicilio.
  TextColumn get tipoOrden => text()
      .map(const TipoOrdenConverter())
      .withDefault(const Constant('para_llevar'))();

  IntColumn get mesaNumero => integer().nullable()();

  /// Datos de entrega a domicilio.
  TextColumn get telefono => text().nullable()();
  TextColumn get calle => text().nullable()();
  TextColumn get entreCalle => text().nullable()();
  TextColumn get colonia => text().nullable()();
  TextColumn get numeroExterior => text().nullable()();

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

class TipoOrdenConverter extends TypeConverter<TipoOrden, String> {
  const TipoOrdenConverter();

  @override
  TipoOrden fromSql(String fromDb) => TipoOrden.fromValue(fromDb);

  @override
  String toSql(TipoOrden value) => value.value;
}
