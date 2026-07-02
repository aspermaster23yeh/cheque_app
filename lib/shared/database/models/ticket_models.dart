import 'package:carnitas_cheque/shared/core/enums/tipo_orden.dart';

/// Línea de un ticket de venta.
class TicketLinea {
  const TicketLinea({
    required this.productoNombre,
    required this.cantidad,
    required this.precioHistorico,
    required this.subtotal,
    required this.esPorPeso,
  });

  final String productoNombre;
  final double cantidad;
  final int precioHistorico;
  final int subtotal;
  final bool esPorPeso;
}

/// Ticket completo de una orden con todos sus productos.
class TicketVenta {
  const TicketVenta({
    required this.id,
    required this.fecha,
    required this.totalCentavos,
    required this.tipoOrden,
    required this.lineas,
    this.mesaNumero,
    this.telefono,
    this.calle,
    this.entreCalle,
    this.colonia,
    this.numeroExterior,
  });

  final int id;
  final DateTime fecha;
  final int totalCentavos;
  final TipoOrden tipoOrden;
  final List<TicketLinea> lineas;
  final int? mesaNumero;
  final String? telefono;
  final String? calle;
  final String? entreCalle;
  final String? colonia;
  final String? numeroExterior;

  String get tipoEtiqueta => tipoOrden.etiqueta;
}
