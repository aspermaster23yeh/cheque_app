import 'package:flutter/material.dart';

import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';

class KpiCard extends StatelessWidget {
  const KpiCard({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icono,
    this.subtitulo,
  });

  final String titulo;
  final String valor;
  final IconData icono;
  final String? subtitulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.neutralSoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icono, color: AppColors.accent, size: 26),
          ),
          const Spacer(),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          if (subtitulo != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitulo!,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
