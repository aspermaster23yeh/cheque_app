part of 'estadisticas_cubit.dart';

enum EstadisticasStatus { inicial, cargando, exito, error }

class EstadisticasState extends Equatable {
  const EstadisticasState({
    this.status = EstadisticasStatus.inicial,
    this.resumen = const KpiResumen(
      totalCentavos: 0,
      cantidadVentas: 0,
      ticketPromedioCentavos: 0,
      ventasPorHora: [],
      topProductos: [],
    ),
    this.errorMensaje,
  });

  final EstadisticasStatus status;
  final KpiResumen resumen;
  final String? errorMensaje;

  EstadisticasState copyWith({
    EstadisticasStatus? status,
    KpiResumen? resumen,
    String? errorMensaje,
  }) {
    return EstadisticasState(
      status: status ?? this.status,
      resumen: resumen ?? this.resumen,
      errorMensaje: errorMensaje ?? this.errorMensaje,
    );
  }

  @override
  List<Object?> get props => [status, resumen, errorMensaje];
}
