import 'package:equatable/equatable.dart';

import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

/// Incremento por defecto para productos por peso (250 g).
const double kIncrementoPeso = 0.250;

/// Una línea del carrito en memoria. Congela el precio al momento de agregar.
class CartItem extends Equatable {
  const CartItem({
    required this.producto,
    required this.cantidad,
  });

  final Producto producto;
  final double cantidad;

  bool get esPorPeso => producto.esPorPeso;

  /// Precio unitario en centavos al momento de la venta.
  int get precioHistorico => producto.precioUnidad;

  /// Subtotal en centavos usando la lógica centralizada de dinero.
  int get subtotalCentavos => MoneyFormatter.calcularSubtotal(
        precioUnidadCentavos: producto.precioUnidad,
        cantidad: cantidad,
        esPorPeso: esPorPeso,
      );

  String get subtotalDisplay => MoneyFormatter.toDisplay(subtotalCentavos);

  String get cantidadDisplay => MoneyFormatter.cantidadDisplay(
        cantidad: cantidad,
        esPorPeso: esPorPeso,
      );

  /// Paso de incremento/decremento según el tipo de producto.
  double get step => esPorPeso ? kIncrementoPeso : 1;

  CartItem copyWith({double? cantidad}) {
    return CartItem(
      producto: producto,
      cantidad: cantidad ?? this.cantidad,
    );
  }

  @override
  List<Object?> get props => [producto.id, cantidad];
}
