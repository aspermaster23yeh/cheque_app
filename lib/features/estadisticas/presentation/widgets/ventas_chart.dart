import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/models/kpi_models.dart';

class VentasChart extends StatelessWidget {
  const VentasChart({super.key, required this.datos});

  final List<VentaPorHora> datos;

  @override
  Widget build(BuildContext context) {
    if (datos.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'Sin ventas registradas hoy',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    final maxY = datos
        .map((d) => d.totalCentavos.toDouble())
        .reduce((a, b) => a > b ? a : b);

    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY * 1.2,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY > 0 ? maxY / 4 : 1,
            getDrawingHorizontalLine: (_) => const FlLine(
              color: AppColors.border,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                getTitlesWidget: (value, _) {
                  if (value == 0) return const SizedBox.shrink();
                  return Text(
                    '\$${(value / 100).round()}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= datos.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      '${datos[index].hora}h',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(datos.length, (i) {
            final d = datos[i];
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: d.totalCentavos.toDouble(),
                  color: AppColors.accent,
                  width: 22,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
              ],
            );
          }),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, _, rod, __) {
                final d = datos[group.x];
                return BarTooltipItem(
                  '${d.hora}:00\n${MoneyFormatter.toDisplay(d.totalCentavos)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
