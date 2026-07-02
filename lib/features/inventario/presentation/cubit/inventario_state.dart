part of 'inventario_cubit.dart';

enum InventarioStatus { inicial, guardando, guardado, error }

class InventarioState extends Equatable {
  const InventarioState({
    this.status = InventarioStatus.inicial,
    this.errorMensaje,
  });

  final InventarioStatus status;
  final String? errorMensaje;

  InventarioState copyWith({
    InventarioStatus? status,
    String? errorMensaje,
    bool limpiarError = false,
  }) {
    return InventarioState(
      status: status ?? this.status,
      errorMensaje: limpiarError ? null : (errorMensaje ?? this.errorMensaje),
    );
  }

  @override
  List<Object?> get props => [status, errorMensaje];
}
