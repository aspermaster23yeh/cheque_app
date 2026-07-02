import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/inventario/data/datasources/inventario_local_datasource.dart';
import 'package:carnitas_cheque/features/inventario/presentation/cubit/inventario_cubit.dart';
import 'package:carnitas_cheque/features/inventario/presentation/widgets/producto_edit_sheet.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

/// Lista completa de productos con acceso a edición de inventario y precios.
class ProductosAdminPage extends StatelessWidget {
  const ProductosAdminPage({super.key, required this.db});

  final LocalDatabase db;

  @override
  Widget build(BuildContext context) {
    final dataSource = InventarioLocalDataSource(db);

    return BlocProvider(
      create: (_) => InventarioCubit(dataSource),
      child: _ProductosView(dataSource: dataSource),
    );
  }
}

class _ProductosView extends StatefulWidget {
  const _ProductosView({required this.dataSource});

  final InventarioLocalDataSource dataSource;

  @override
  State<_ProductosView> createState() => _ProductosViewState();
}

class _ProductosViewState extends State<_ProductosView> {
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.chip),
              boxShadow: AppShadows.soft,
            ),
            child: TextField(
              onChanged: (v) => setState(() => _busqueda = v.trim().toLowerCase()),
              decoration: const InputDecoration(
                hintText: 'Buscar en todos los productos...',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Producto>>(
            stream: widget.dataSource.watchProductos(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                );
              }

              final productos = snap.data!
                  .where((p) =>
                      _busqueda.isEmpty ||
                      p.nombre.toLowerCase().contains(_busqueda))
                  .toList();

              if (productos.isEmpty) {
                return const Center(
                  child: Text(
                    'Sin productos',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              return StreamBuilder<List<Categoria>>(
                stream: widget.dataSource.watchCategorias(),
                builder: (context, catSnap) {
                  final categorias = catSnap.data ?? [];
                  final catMap = {
                    for (final c in categorias) c.id: c.nombre,
                  };

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: productos.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final p = productos[i];
                      return _ProductoAdminTile(
                        producto: p,
                        categoriaNombre:
                            catMap[p.categoriaId] ?? 'Sin categoría',
                        onTap: () => _abrirEdicion(context, p, categorias),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _abrirEdicion(
    BuildContext context,
    Producto producto,
    List<Categoria> categorias,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<InventarioCubit>(),
        child: ProductoEditSheet(
          producto: producto,
          categorias: categorias,
        ),
      ),
    );
  }
}

class _ProductoAdminTile extends StatelessWidget {
  const _ProductoAdminTile({
    required this.producto,
    required this.categoriaNombre,
    required this.onTap,
  });

  final Producto producto;
  final String categoriaNombre;
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
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: AppShadows.soft,
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _thumb(),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      producto.nombre,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: producto.activo
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        decoration: producto.activo
                            ? null
                            : TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      categoriaNombre,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _chip(
                          producto.esPorPeso
                              ? '${MoneyFormatter.toDisplay(producto.precioUnidad)}/kg'
                              : MoneyFormatter.toDisplay(producto.precioUnidad),
                        ),
                        const SizedBox(width: 6),
                        _chip(
                          'Inv: ${MoneyFormatter.cantidadDisplay(cantidad: producto.inventarioDisponible, esPorPeso: producto.esPorPeso)}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumb() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.neutralSoft,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      clipBehavior: Clip.antiAlias,
      child: (producto.imagenUrl != null && producto.imagenUrl!.isNotEmpty)
          ? Image.network(
              producto.imagenUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _icono(),
            )
          : _icono(),
    );
  }

  Widget _icono() {
    return Icon(
      producto.esPorPeso ? Icons.scale_outlined : Icons.fastfood_outlined,
      color: AppColors.textSecondary.withValues(alpha: 0.5),
      size: 28,
    );
  }

  Widget _chip(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutralSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
