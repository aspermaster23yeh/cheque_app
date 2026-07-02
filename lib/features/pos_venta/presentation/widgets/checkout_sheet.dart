import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/pos_venta/presentation/cubit/cart_cubit.dart';
import 'package:carnitas_cheque/shared/core/enums/tipo_orden.dart';
import 'package:carnitas_cheque/shared/core/models/datos_orden.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';

/// Hoja de cobro: tipo de orden (mesa / llevar / domicilio) y datos de entrega.
class CheckoutSheet extends StatefulWidget {
  const CheckoutSheet({
    super.key,
    required this.usuarioId,
    required this.totalDisplay,
  });

  final int usuarioId;
  final String totalDisplay;

  @override
  State<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends State<CheckoutSheet> {
  TipoOrden _tipo = TipoOrden.paraLlevar;
  final _mesaCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _calleCtrl = TextEditingController();
  final _entreCalleCtrl = TextEditingController();
  final _coloniaCtrl = TextEditingController();
  final _numeroCtrl = TextEditingController();

  @override
  void dispose() {
    _mesaCtrl.dispose();
    _telefonoCtrl.dispose();
    _calleCtrl.dispose();
    _entreCalleCtrl.dispose();
    _coloniaCtrl.dispose();
    _numeroCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              'Confirmar cobro',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: ${widget.totalDisplay}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.accentStrong,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tipo de orden',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            _tipoSelector(),
            const SizedBox(height: 16),
            if (_tipo == TipoOrden.mesa) _mesaFields(),
            if (_tipo == TipoOrden.domicilio) _domicilioCard(),
            const SizedBox(height: 20),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final procesando =
                    state.checkoutStatus == CheckoutStatus.procesando;
                return SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: procesando ? null : _confirmar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppRadius.button),
                      ),
                    ),
                    child: procesando
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'CONFIRMAR Y COBRAR',
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
    );
  }

  Widget _tipoSelector() {
    return Row(
      children: TipoOrden.values.map((tipo) {
        final selected = _tipo == tipo;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: tipo != TipoOrden.domicilio ? 8 : 0,
            ),
            child: GestureDetector(
              onTap: () => setState(() => _tipo = tipo),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: selected ? AppColors.textPrimary : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  boxShadow: selected ? null : AppShadows.soft,
                ),
                alignment: Alignment.center,
                child: Text(
                  tipo.etiqueta,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: selected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _mesaFields() {
    return _field('Número de mesa', _mesaCtrl,
        keyboard: TextInputType.number);
  }

  Widget _domicilioCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutralSoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Datos de entrega',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          _field('Teléfono', _telefonoCtrl, keyboard: TextInputType.phone),
          const SizedBox(height: 10),
          _field('Calle', _calleCtrl),
          const SizedBox(height: 10),
          _field('Entre calle', _entreCalleCtrl),
          const SizedBox(height: 10),
          _field('Colonia', _coloniaCtrl),
          const SizedBox(height: 10),
          _field('Número exterior', _numeroCtrl,
              keyboard: TextInputType.number),
        ],
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
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  void _confirmar() {
    if (_tipo == TipoOrden.mesa) {
      final mesa = int.tryParse(_mesaCtrl.text.trim());
      if (mesa == null || mesa <= 0) {
        _mostrarError('Ingresa un número de mesa válido');
        return;
      }
      _cobrar(DatosOrden(tipo: TipoOrden.mesa, mesaNumero: mesa));
      return;
    }

    if (_tipo == TipoOrden.domicilio) {
      final telefono = _telefonoCtrl.text.trim();
      final calle = _calleCtrl.text.trim();
      final entre = _entreCalleCtrl.text.trim();
      final colonia = _coloniaCtrl.text.trim();
      final numero = _numeroCtrl.text.trim();

      if (telefono.isEmpty ||
          calle.isEmpty ||
          entre.isEmpty ||
          colonia.isEmpty ||
          numero.isEmpty) {
        _mostrarError('Completa todos los datos de domicilio');
        return;
      }

      _cobrar(
        DatosOrden(
          tipo: TipoOrden.domicilio,
          telefono: telefono,
          calle: calle,
          entreCalle: entre,
          colonia: colonia,
          numeroExterior: numero,
        ),
      );
      return;
    }

    _cobrar(const DatosOrden(tipo: TipoOrden.paraLlevar));
  }

  void _cobrar(DatosOrden datos) {
    context.read<CartCubit>().confirmarOrden(
          usuarioId: widget.usuarioId,
          datosOrden: datos,
        );
  }

  void _mostrarError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.danger,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
