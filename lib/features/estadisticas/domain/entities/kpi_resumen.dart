import 'package:equatable/equatable.dart';

import 'package:carnitas_cheque/shared/database/models/kpi_models.dart';

class KpiResumen extends Equatable {
  const KpiResumen({
    required this.totalCentavos,
    required this.cantidadVentas,
    required this.ticketPromedioCentavos,
    required this.ventasPorHora,
    required this.topProductos,
  });

  final int totalCentavos;
  final int cantidadVentas;
  final int ticketPromedioCentavos;
  final List<VentaPorHora> ventasPorHora;
  final List<ProductoTop> topProductos;

  factory KpiResumen.vacio() => const KpiResumen(
        totalCentavos: 0,
        cantidadVentas: 0,
        ticketPromedioCentavos: 0,
        ventasPorHora: [],
        topProductos: [],
      );

  @override
  List<Object?> get props => [
        totalCentavos,
        cantidadVentas,
        ticketPromedioCentavos,
        ventasPorHora,
        topProductos,
      ];
}
