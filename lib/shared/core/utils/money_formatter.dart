/// Utilidades para manejar montos en centavos sin usar double.
class MoneyFormatter {
  MoneyFormatter._();

  /// Convierte centavos a representación legible: 28000 → "\$280.00"
  static String toDisplay(int centavos) {
    final pesos = centavos ~/ 100;
    final cents = (centavos % 100).abs().toString().padLeft(2, '0');
    return '\$$pesos.$cents';
  }

  /// Calcula subtotal en centavos para productos por peso.
  /// Usa redondeo bancario para evitar errores de punto flotante.
  static int calcularSubtotal({
    required int precioUnidadCentavos,
    required double cantidad,
    required bool esPorPeso,
  }) {
    if (esPorPeso) {
      return (precioUnidadCentavos * cantidad).round();
    }
    return precioUnidadCentavos * cantidad.round();
  }

  /// Formatea una cantidad para mostrar: piezas como entero, KG con 3 decimales.
  /// Ej: esPorPeso=true → "0.250 kg"; esPorPeso=false → "2".
  static String cantidadDisplay({
    required double cantidad,
    required bool esPorPeso,
  }) {
    if (esPorPeso) {
      return '${cantidad.toStringAsFixed(3)} kg';
    }
    return cantidad.toStringAsFixed(0);
  }
}
