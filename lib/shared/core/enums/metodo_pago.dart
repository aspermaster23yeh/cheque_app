/// Métodos de pago aceptados en el punto de venta.
enum MetodoPago {
  efectivo('efectivo'),
  tarjeta('tarjeta'),
  transferencia('transferencia');

  const MetodoPago(this.value);
  final String value;

  static MetodoPago fromValue(String value) {
    return MetodoPago.values.firstWhere(
      (m) => m.value == value,
      orElse: () => MetodoPago.efectivo,
    );
  }
}
