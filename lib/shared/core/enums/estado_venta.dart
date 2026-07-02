/// Estado del ciclo de vida de una venta.
enum EstadoVenta {
  completado('completado'),
  cancelado('cancelado');

  const EstadoVenta(this.value);
  final String value;

  static EstadoVenta fromValue(String value) {
    return EstadoVenta.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EstadoVenta.completado,
    );
  }
}
