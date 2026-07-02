import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/inventario/presentation/cubit/inventario_cubit.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

/// Formulario modal para editar precio, inventario, imagen y más.
class ProductoEditSheet extends StatefulWidget {
  const ProductoEditSheet({
    super.key,
    required this.producto,
    required this.categorias,
  });

  final Producto producto;
  final List<Categoria> categorias;

  @override
  State<ProductoEditSheet> createState() => _ProductoEditSheetState();
}

class _ProductoEditSheetState extends State<ProductoEditSheet> {
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _precioCtrl;
  late final TextEditingController _inventarioCtrl;
  late final TextEditingController _imagenCtrl;
  late int _categoriaId;
  late bool _esPorPeso;
  late bool _activo;

  @override
  void initState() {
    super.initState();
    final p = widget.producto;
    _nombreCtrl = TextEditingController(text: p.nombre);
    _precioCtrl = TextEditingController(
      text: (p.precioUnidad / 100).toStringAsFixed(2),
    );
    _inventarioCtrl = TextEditingController(
      text: p.inventarioDisponible.toString(),
    );
    _imagenCtrl = TextEditingController(text: p.imagenUrl ?? '');
    _categoriaId = p.categoriaId;
    _esPorPeso = p.esPorPeso;
    _activo = p.activo;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _precioCtrl.dispose();
    _inventarioCtrl.dispose();
    _imagenCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventarioCubit, InventarioState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: (context, state) {
        if (state.status == InventarioStatus.guardado) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Producto actualizado'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<InventarioCubit>().resetStatus();
        } else if (state.status == InventarioStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMensaje ?? 'Error al guardar'),
              backgroundColor: AppColors.danger,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<InventarioCubit>().resetStatus();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Editar producto',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              _field('Nombre', _nombreCtrl),
              const SizedBox(height: 12),
              _field('Precio (\$)', _precioCtrl,
                  keyboard: TextInputType.number),
              const SizedBox(height: 12),
              _field('Inventario', _inventarioCtrl,
                  keyboard: const TextInputType.numberWithOptions(
                    decimal: true,
                  )),
              const SizedBox(height: 12),
              _field('URL de imagen', _imagenCtrl),
              const SizedBox(height: 12),
              _dropdownCategoria(),
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Venta por peso (KG)',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                value: _esPorPeso,
                activeThumbColor: AppColors.accent,
                onChanged: (v) => setState(() => _esPorPeso = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Producto activo',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                value: _activo,
                activeThumbColor: AppColors.accent,
                onChanged: (v) => setState(() => _activo = v),
              ),
              const SizedBox(height: 16),
              BlocBuilder<InventarioCubit, InventarioState>(
                builder: (context, state) {
                  final guardando =
                      state.status == InventarioStatus.guardando;
                  return SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: guardando ? null : _guardar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.button),
                        ),
                      ),
                      child: guardando
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'GUARDAR CAMBIOS',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.neutralSoft,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _dropdownCategoria() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.neutralSoft,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: _categoriaId,
          items: widget.categorias
              .map(
                (c) => DropdownMenuItem(
                  value: c.id,
                  child: Text(c.nombre,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) setState(() => _categoriaId = v);
          },
        ),
      ),
    );
  }

  void _guardar() {
    final nombre = _nombreCtrl.text.trim();
    if (nombre.isEmpty) return;

    context.read<InventarioCubit>().guardarProducto(
          id: widget.producto.id,
          nombre: nombre,
          categoriaId: _categoriaId,
          precioUnidadCentavos: MoneyFormatter.fromInput(_precioCtrl.text),
          inventarioDisponible:
              double.tryParse(_inventarioCtrl.text) ?? 0,
          esPorPeso: _esPorPeso,
          activo: _activo,
          imagenUrl: _imagenCtrl.text.trim().isEmpty
              ? null
              : _imagenCtrl.text.trim(),
        );
  }
}
