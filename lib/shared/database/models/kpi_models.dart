/// Ventas agrupadas por hora del día.
class VentaPorHora {
  const VentaPorHora({
    required this.hora,
    required this.totalCentavos,
  });

  final int hora;
  final int totalCentavos;
}

/// Producto más vendido en un periodo.
class ProductoTop {
  const ProductoTop({
    required this.nombre,
    required this.cantidad,
    required this.totalCentavos,
  });

  final String nombre;
  final double cantidad;
  final int totalCentavos;
}
