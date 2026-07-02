import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/pos_venta/domain/entities/cart_item.dart';
import 'package:carnitas_cheque/shared/core/enums/metodo_pago.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

part 'cart_state.dart';

/// Gestiona el carrito en memoria y confirma la venta vía transacción Drift.
class CartCubit extends Cubit<CartState> {
  CartCubit(this._db) : super(const CartState());

  final LocalDatabase _db;

  /// Cantidad mínima aceptada (evita items en 0).
  static const double _minCantidad = 0.001;

  /// Agrega un producto al carrito. Si ya existe, incrementa su cantidad
  /// (+1 pieza o +0.250 kg según [Producto.esPorPeso]).
  void agregarProducto(Producto producto) {
    final index = _indexOf(producto.id);
    final step = producto.esPorPeso ? kIncrementoPeso : 1.0;

    if (index == -1) {
      final nuevo = CartItem(producto: producto, cantidad: step);
      emit(state.copyWith(items: [...state.items, nuevo]));
    } else {
      _actualizarCantidad(index, state.items[index].cantidad + step);
    }
  }

  /// Incrementa la cantidad de una línea existente.
  void incrementar(int productoId) {
    final index = _indexOf(productoId);
    if (index == -1) return;
    final item = state.items[index];
    _actualizarCantidad(index, item.cantidad + item.step);
  }

  /// Disminuye la cantidad; si llega a (casi) cero, elimina la línea.
  void decrementar(int productoId) {
    final index = _indexOf(productoId);
    if (index == -1) return;
    final item = state.items[index];
    final nueva = item.cantidad - item.step;
    if (nueva < _minCantidad) {
      eliminar(productoId);
    } else {
      _actualizarCantidad(index, nueva);
    }
  }

  /// Elimina una línea del carrito.
  void eliminar(int productoId) {
    final items =
        state.items.where((i) => i.producto.id != productoId).toList();
    emit(state.copyWith(items: items));
  }

  /// Vacía todo el carrito.
  void limpiar() {
    emit(const CartState());
  }

  /// Ejecuta la transacción atómica de venta.
  Future<void> confirmarOrden({
    required int usuarioId,
    MetodoPago metodoPago = MetodoPago.efectivo,
    String? notas,
  }) async {
    if (state.isEmpty || state.checkoutStatus == CheckoutStatus.procesando) {
      return;
    }

    emit(state.copyWith(
      checkoutStatus: CheckoutStatus.procesando,
      limpiarError: true,
    ));

    try {
      final detalles = state.items
          .map(
            (item) => DetallesVentaCompanion.insert(
              ventaId: 0, // reasignado dentro de la transacción.
              productoId: item.producto.id,
              cantidad: item.cantidad,
              precioHistorico: item.precioHistorico,
              subtotal: item.subtotalCentavos,
            ),
          )
          .toList();

      final ventaId = await _db.crearVentaConDetalles(
        usuarioId: usuarioId,
        metodoPago: metodoPago,
        detalles: detalles,
        notas: notas,
      );

      emit(state.copyWith(
        items: const [],
        checkoutStatus: CheckoutStatus.exito,
        ultimaVentaId: ventaId,
      ));
    } catch (e) {
      emit(state.copyWith(
        checkoutStatus: CheckoutStatus.error,
        errorMensaje: 'No se pudo registrar la venta: $e',
      ));
    }
  }

  /// Reinicia el estado de checkout tras mostrar feedback en la UI.
  void resetCheckout() {
    emit(state.copyWith(
      checkoutStatus: CheckoutStatus.idle,
      limpiarError: true,
    ));
  }

  int _indexOf(int productoId) =>
      state.items.indexWhere((i) => i.producto.id == productoId);

  void _actualizarCantidad(int index, double cantidad) {
    final items = List<CartItem>.from(state.items);
    items[index] = items[index].copyWith(cantidad: cantidad);
    emit(state.copyWith(items: items));
  }
}
