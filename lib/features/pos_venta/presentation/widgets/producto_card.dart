import 'package:flutter/material.dart';

import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

/// Tarjeta blanca de producto — limpia, con imagen HD, nombre en negrita,
/// precio en chip gris y stock discreto. Un toque agrega al carrito.
class ProductoCard extends StatelessWidget {
  const ProductoCard({
    super.key,
    required this.producto,
    required this.onTap,
  });

  final Producto producto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: AppShadows.soft,
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _ProductImage(producto: producto)),
              const SizedBox(height: 10),
              Text(
                producto.nombre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Inventario: ${MoneyFormatter.cantidadDisplay(cantidad: producto.inventarioDisponible, esPorPeso: producto.esPorPeso)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.neutralSoft,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        producto.esPorPeso
                            ? '${MoneyFormatter.toDisplay(producto.precioUnidad)}/kg'
                            : MoneyFormatter.toDisplay(producto.precioUnidad),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 42,
                    width: 42,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.producto});

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutralSoft,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      alignment: Alignment.center,
      child: (producto.imagenUrl != null && producto.imagenUrl!.isNotEmpty)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Image.network(
                producto.imagenUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => _placeholder(),
              ),
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Icon(
      producto.esPorPeso ? Icons.scale_outlined : Icons.fastfood_outlined,
      size: 48,
      color: AppColors.textSecondary.withValues(alpha: 0.5),
    );
  }
}
