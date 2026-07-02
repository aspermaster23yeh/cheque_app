import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';

/// Teclado numérico grande para ingreso de PIN.
class PinPad extends StatelessWidget {
  const PinPad({
    super.key,
    required this.onDigito,
    required this.onBorrar,
    this.onLimpiar,
  });

  final ValueChanged<String> onDigito;
  final VoidCallback onBorrar;
  final VoidCallback? onLimpiar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _fila(['1', '2', '3']),
        const SizedBox(height: 12),
        _fila(['4', '5', '6']),
        const SizedBox(height: 12),
        _fila(['7', '8', '9']),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _PinKey(
                label: 'C',
                onTap: onLimpiar ?? onBorrar,
                style: _PinKeyStyle.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _PinKey(
                label: '0',
                onTap: () => onDigito('0'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _PinKey(
                label: '⌫',
                onTap: onBorrar,
                style: _PinKeyStyle.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fila(List<String> digitos) {
    return Row(
      children: [
        for (var i = 0; i < digitos.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(
            child: _PinKey(
              label: digitos[i],
              onTap: () => onDigito(digitos[i]),
            ),
          ),
        ],
      ],
    );
  }
}

enum _PinKeyStyle { primary, secondary }

class _PinKey extends StatelessWidget {
  const _PinKey({
    required this.label,
    required this.onTap,
    this.style = _PinKeyStyle.primary,
  });

  final String label;
  final VoidCallback onTap;
  final _PinKeyStyle style;

  @override
  Widget build(BuildContext context) {
    final esSecundario = style == _PinKeyStyle.secondary;
    return Material(
      color: esSecundario ? AppColors.neutralSoft : AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.button),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Ink(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.button),
            boxShadow: esSecundario ? null : AppShadows.soft,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: label == '⌫' ? 26 : 30,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Indicador visual de dígitos ingresados (● ○ ○ ○).
class PinIndicator extends StatelessWidget {
  const PinIndicator({
    super.key,
    required this.length,
    required this.maxLength,
  });

  final int length;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxLength, (i) {
        final filled = i < length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? AppColors.accent : AppColors.border,
          ),
        );
      }),
    );
  }
}
