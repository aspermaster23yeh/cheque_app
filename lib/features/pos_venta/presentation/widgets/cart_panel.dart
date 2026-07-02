import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/pos_venta/domain/entities/cart_item.dart';
import 'package:carnitas_cheque/features/pos_venta/presentation/cubit/cart_cubit.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';

/// Panel inferior elevado — lista del carrito, total gigante y botón de cobro.
class CartPanel extends StatelessWidget {
  const CartPanel({super.key, required this.usuarioId});

  final int usuarioId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: AppShadows.elevated,
      ),
      child: SafeArea(
        top: false,
        child: BlocConsumer<CartCubit, CartState>(
          listenWhen: (prev, curr) =>
              prev.checkoutStatus != curr.checkoutStatus,
          listener: _onCheckoutChange,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _grabber(),
                Expanded(child: _CartList(state: state)),
                _CheckoutBar(state: state, usuarioId: usuarioId),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onCheckoutChange(BuildContext context, CartState state) {
    final messenger = ScaffoldMessenger.of(context);
    if (state.checkoutStatus == CheckoutStatus.exito) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Orden #${state.ultimaVentaId} registrada'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.read<CartCubit>().resetCheckout();
    } else if (state.checkoutStatus == CheckoutStatus.error) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(state.errorMensaje ?? 'Error al registrar la venta'),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.read<CartCubit>().resetCheckout();
    }
  }

  Widget _grabber() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 6),
      height: 5,
      width: 44,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({required this.state});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    if (state.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag_outlined,
                size: 40, color: AppColors.textSecondary),
            SizedBox(height: 8),
            Text(
              'Toca un producto para empezar',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      itemCount: state.items.length,
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        color: AppColors.border,
      ),
      itemBuilder: (context, index) =>
          _CartRow(item: state.items[index]),
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.producto.nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtotalDisplay,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentStrong,
                  ),
                ),
              ],
            ),
          ),
          _QtyButton(
            icon: Icons.remove,
            onTap: () => cubit.decrementar(item.producto.id),
          ),
          SizedBox(
            width: 64,
            child: Text(
              item.cantidadDisplay,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _QtyButton(
            icon: Icons.add,
            onTap: () => cubit.incrementar(item.producto.id),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: AppColors.neutralSoft,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, size: 24, color: AppColors.textPrimary),
      ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.state, required this.usuarioId});

  final CartState state;
  final int usuarioId;

  @override
  Widget build(BuildContext context) {
    final procesando = state.checkoutStatus == CheckoutStatus.procesando;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                state.totalDisplay,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 62,
            child: ElevatedButton(
              onPressed: (state.isEmpty || procesando)
                  ? null
                  : () => context.read<CartCubit>().confirmarOrden(
                        usuarioId: usuarioId,
                      ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                disabledBackgroundColor: AppColors.border,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
              ),
              child: procesando
                  ? const SizedBox(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'COBRAR',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
