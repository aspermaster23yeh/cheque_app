import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/inventario/data/datasources/inventario_local_datasource.dart';
import 'package:carnitas_cheque/features/inventario/presentation/cubit/inventario_cubit.dart';
import 'package:carnitas_cheque/features/inventario/presentation/widgets/producto_edit_sheet.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

/// Lista completa de productos con acceso a edición y creación.
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
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirCreacion(context),
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Nuevo producto',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
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
                onChanged: (v) =>
                    setState(() => _busqueda = v.trim().toLowerCase()),
                decoration: const InputDecoration(
                  hintText: 'Buscar en todos los productos...',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  prefixIcon:
                      Icon(Icons.search, color: AppColors.textSecondary),
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

                final todos = snap.data!;
                final productos = todos
                    .where((p) =>
                        _busqueda.isEmpty ||
                        p.nombre.toLowerCase().contains(_busqueda))
                    .toList();

                return StreamBuilder<List<Categoria>>(
                  stream: widget.dataSource.watchCategorias(),
                  builder: (context, catSnap) {
                    final categorias = catSnap.data ?? [];

                    if (productos.isEmpty) {
                      return _emptyState(
                        hayProductos: todos.isNotEmpty,
                        categorias: categorias,
                      );
                    }

                    final catMap = {
                      for (final c in categorias) c.id: c.nombre,
                    };

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
                      itemCount: productos.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) {
                        final p = productos[i];
                        return _ProductoAdminTile(
                          producto: p,
                          categoriaNombre:
                              catMap[p.categoriaId] ?? 'Sin categoría',
                          onTap: () =>
                              _abrirEdicion(context, p, categorias),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState({
    required bool hayProductos,
    required List<Categoria> categorias,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hayProductos ? Icons.search_off : Icons.inventory_2_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 12),
            Text(
              hayProductos
                  ? 'No hay coincidencias'
                  : 'Aún no hay productos',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            if (!hayProductos && categorias.isNotEmpty) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _abrirCreacion(context, categorias),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.add),
                label: const Text('Crear primer producto'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _abrirCreacion(
    BuildContext context, [
    List<Categoria>? categoriasPrecargadas,
  ]) {
    final categorias = categoriasPrecargadas;
    if (categorias != null && categorias.isNotEmpty) {
      _mostrarSheet(context, categorias);
      return;
    }

    widget.dataSource.watchCategorias().first.then((cats) {
      if (!context.mounted) return;
      if (cats.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hay categorías disponibles'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      _mostrarSheet(context, cats);
    });
  }

  void _abrirEdicion(
    BuildContext context,
    Producto producto,
    List<Categoria> categorias,
  ) {
    _mostrarSheet(context, categorias, producto: producto);
  }

  void _mostrarSheet(
    BuildContext context,
    List<Categoria> categorias, {
    Producto? producto,
  }) {
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
