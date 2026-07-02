part of 'inventario_cubit.dart';

enum InventarioStatus { inicial, guardando, guardado, error }

class InventarioState extends Equatable {
  const InventarioState({
    this.status = InventarioStatus.inicial,
    this.errorMensaje,
    this.fueCreacion = false,
  });

  final InventarioStatus status;
  final String? errorMensaje;
  final bool fueCreacion;

  InventarioState copyWith({
    InventarioStatus? status,
    String? errorMensaje,
    bool? fueCreacion,
    bool limpiarError = false,
  }) {
    return InventarioState(
      status: status ?? this.status,
      errorMensaje: limpiarError ? null : (errorMensaje ?? this.errorMensaje),
      fueCreacion: fueCreacion ?? this.fueCreacion,
    );
  }

  @override
  List<Object?> get props => [status, errorMensaje, fueCreacion];
}
