import 'package:equatable/equatable.dart';

import 'package:carnitas_cheque/shared/core/enums/tipo_orden.dart';

/// Datos de servicio capturados al momento del cobro.
class DatosOrden extends Equatable {
  const DatosOrden({
    required this.tipo,
    this.mesaNumero,
    this.telefono,
    this.calle,
    this.entreCalle,
    this.colonia,
    this.numeroExterior,
  });

  final TipoOrden tipo;
  final int? mesaNumero;
  final String? telefono;
  final String? calle;
  final String? entreCalle;
  final String? colonia;
  final String? numeroExterior;

  String get resumenCorto => switch (tipo) {
        TipoOrden.mesa => 'Mesa ${mesaNumero ?? '?'}',
        TipoOrden.paraLlevar => 'Para llevar',
        TipoOrden.domicilio => 'Domicilio · ${colonia ?? ''}',
      };

  @override
  List<Object?> get props => [
        tipo,
        mesaNumero,
        telefono,
        calle,
        entreCalle,
        colonia,
        numeroExterior,
      ];
}
