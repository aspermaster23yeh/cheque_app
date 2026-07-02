import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/pos_venta/presentation/cubit/cart_cubit.dart';
import 'package:carnitas_cheque/features/pos_venta/presentation/widgets/cart_panel.dart';
import 'package:carnitas_cheque/features/pos_venta/presentation/widgets/producto_card.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

/// Pantalla principal del POS. Vertical, dividida en catálogo (65%)
/// y carrito/checkout (35%).
class PosVentaScreen extends StatelessWidget {
  const PosVentaScreen({
    super.key,
    required this.db,
    required this.usuarioId,
  });

  final LocalDatabase db;
  final int usuarioId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(db),
      child: _PosView(db: db, usuarioId: usuarioId),
    );
  }
}

class _PosView extends StatefulWidget {
  const _PosView({required this.db, required this.usuarioId});

  final LocalDatabase db;
  final int usuarioId;

  @override
  State<_PosView> createState() => _PosViewState();
}

class _PosViewState extends State<_PosView> {
  int? _categoriaSeleccionada;
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 65,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  _SearchBar(
                    onChanged: (v) =>
                        setState(() => _busqueda = v.trim().toLowerCase()),
                  ),
                  _CategoriaTabs(
                    db: widget.db,
                    seleccionada: _categoriaSeleccionada,
                    onSelect: (id) =>
                        setState(() => _categoriaSeleccionada = id),
                  ),
                  Expanded(
                    child: _ProductosGrid(
                      db: widget.db,
                      categoriaId: _categoriaSeleccionada,
                      busqueda: _busqueda,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 35,
            child: CartPanel(usuarioId: widget.usuarioId),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          boxShadow: AppShadows.soft,
        ),
        child: TextField(
          onChanged: onChanged,
          textInputAction: TextInputAction.search,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            hintText: 'Buscar producto...',
            hintStyle: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          ),
        ),
      ),
    );
  }
}

class _CategoriaTabs extends StatelessWidget {
  const _CategoriaTabs({
    required this.db,
    required this.seleccionada,
    required this.onSelect,
  });

  final LocalDatabase db;
  final int? seleccionada;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Categoria>>(
      stream: db.watchCategoriasActivas(),
      builder: (context, snapshot) {
        final categorias = snapshot.data ?? const [];
        if (categorias.isEmpty) {
          return const SizedBox(height: 56);
        }

        // Selección inicial → primera categoría.
        final activa = seleccionada ?? categorias.first.id;
        if (seleccionada == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onSelect(categorias.first.id);
          });
        }

        return SizedBox(
          height: 56,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categorias.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = categorias[index];
              final selected = cat.id == activa;
              return _CategoriaChip(
                nombre: cat.nombre,
                selected: selected,
                onTap: () => onSelect(cat.id),
              );
            },
          ),
        );
      },
    );
  }
}

class _CategoriaChip extends StatelessWidget {
  const _CategoriaChip({
    required this.nombre,
    required this.selected,
    required this.onTap,
  });

  final String nombre;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          boxShadow: selected ? null : AppShadows.soft,
        ),
        child: Text(
          nombre,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: selected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ProductosGrid extends StatelessWidget {
  const _ProductosGrid({
    required this.db,
    required this.categoriaId,
    required this.busqueda,
  });

  final LocalDatabase db;
  final int? categoriaId;
  final String busqueda;

  @override
  Widget build(BuildContext context) {
    if (categoriaId == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<List<Producto>>(
      stream: db.watchProductosPorCategoria(categoriaId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final productos = snapshot.data!
            .where((p) =>
                busqueda.isEmpty ||
                p.nombre.toLowerCase().contains(busqueda))
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

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemCount: productos.length,
          itemBuilder: (context, index) {
            final producto = productos[index];
            return ProductoCard(
              producto: producto,
              onTap: () =>
                  context.read<CartCubit>().agregarProducto(producto),
            );
          },
        );
      },
    );
  }
}
