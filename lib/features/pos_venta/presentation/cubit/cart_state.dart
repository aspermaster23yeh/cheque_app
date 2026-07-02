part of 'cart_cubit.dart';

enum CheckoutStatus { idle, procesando, exito, error }

class CartState extends Equatable {
  const CartState({
    this.items = const [],
    this.checkoutStatus = CheckoutStatus.idle,
    this.ultimaVentaId,
    this.errorMensaje,
  });

  final List<CartItem> items;
  final CheckoutStatus checkoutStatus;
  final int? ultimaVentaId;
  final String? errorMensaje;

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  int get totalArticulos => items.length;

  /// Total del carrito en centavos.
  int get totalCentavos =>
      items.fold<int>(0, (sum, item) => sum + item.subtotalCentavos);

  String get totalDisplay => MoneyFormatter.toDisplay(totalCentavos);

  CartState copyWith({
    List<CartItem>? items,
    CheckoutStatus? checkoutStatus,
    int? ultimaVentaId,
    String? errorMensaje,
    bool limpiarError = false,
  }) {
    return CartState(
      items: items ?? this.items,
      checkoutStatus: checkoutStatus ?? this.checkoutStatus,
      ultimaVentaId: ultimaVentaId ?? this.ultimaVentaId,
      errorMensaje: limpiarError ? null : (errorMensaje ?? this.errorMensaje),
    );
  }

  @override
  List<Object?> get props =>
      [items, checkoutStatus, ultimaVentaId, errorMensaje];
}
