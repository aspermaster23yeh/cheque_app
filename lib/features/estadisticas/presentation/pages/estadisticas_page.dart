import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/estadisticas/data/datasources/estadisticas_local_datasource.dart';
import 'package:carnitas_cheque/features/estadisticas/domain/entities/kpi_resumen.dart';
import 'package:carnitas_cheque/features/estadisticas/presentation/cubit/estadisticas_cubit.dart';
import 'package:carnitas_cheque/features/estadisticas/presentation/widgets/kpi_card.dart';
import 'package:carnitas_cheque/features/estadisticas/presentation/widgets/ticket_card.dart';
import 'package:carnitas_cheque/features/estadisticas/presentation/widgets/ventas_chart.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';
import 'package:carnitas_cheque/shared/database/models/kpi_models.dart';
import 'package:carnitas_cheque/shared/database/models/ticket_models.dart';

class EstadisticasPage extends StatelessWidget {
  const EstadisticasPage({super.key, required this.db});

  final LocalDatabase db;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          EstadisticasCubit(EstadisticasLocalDataSource(db))..cargar(),
      child: const _EstadisticasView(),
    );
  }
}

class _EstadisticasView extends StatelessWidget {
  const _EstadisticasView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EstadisticasCubit, EstadisticasState>(
      builder: (context, state) {
        if (state.status == EstadisticasStatus.cargando &&
            state.resumen.cantidadVentas == 0) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          );
        }

        if (state.status == EstadisticasStatus.error) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.errorMensaje ?? 'Error'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context.read<EstadisticasCubit>().cargar(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: AppColors.accent,
          onRefresh: () => context.read<EstadisticasCubit>().cargar(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              _kpiGrid(state.resumen),
              const SizedBox(height: 20),
              const Text(
                'Ventas por hora',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              VentasChart(datos: state.resumen.ventasPorHora),
              const SizedBox(height: 24),
              const Text(
                'Top productos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _topProductos(state.resumen.topProductos),
              const SizedBox(height: 24),
              const Text(
                'Tickets del día',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _ticketsDelDia(state.resumen.tickets),
            ],
          ),
        );
      },
    );
  }

  Widget _kpiGrid(KpiResumen resumen) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: KpiCard(
            titulo: 'VENTAS HOY',
            valor: MoneyFormatter.toDisplay(resumen.totalCentavos),
            icono: Icons.payments_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: KpiCard(
            titulo: 'ÓRDENES',
            valor: '${resumen.cantidadVentas}',
            icono: Icons.receipt_long_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: KpiCard(
            titulo: 'TICKET PROM.',
            valor: MoneyFormatter.toDisplay(resumen.ticketPromedioCentavos),
            icono: Icons.trending_up_rounded,
          ),
        ),
      ],
    );
  }

  Widget _topProductos(List<ProductoTop> productos) {
    if (productos.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: const Center(
          child: Text(
            'Aún no hay productos vendidos hoy',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: List.generate(productos.length, (i) {
          final p = productos[i];
          final esUltimo = i == productos.length - 1;
          return Column(
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                leading: CircleAvatar(
                  backgroundColor: AppColors.neutralSoft,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.accentStrong,
                    ),
                  ),
                ),
                title: Text(
                  p.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'Cant: ${p.cantidad.toStringAsFixed(p.cantidad % 1 == 0 ? 0 : 3)}',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                trailing: Text(
                  MoneyFormatter.toDisplay(p.totalCentavos),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (!esUltimo) const Divider(height: 1, color: AppColors.border),
            ],
          );
        }),
      ),
    );
  }

  Widget _ticketsDelDia(List<TicketVenta> tickets) {
    if (tickets.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: const Center(
          child: Text(
            'Aún no hay tickets registrados hoy',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Column(
      children: tickets.map((t) => TicketCard(ticket: t)).toList(),
    );
  }
}
