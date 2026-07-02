import 'package:flutter/material.dart';

import 'package:carnitas_cheque/shared/core/enums/tipo_orden.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/models/ticket_models.dart';
import 'package:carnitas_cheque/shared/printer/thermal_print_button.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket});

  final TicketVenta ticket;

  @override
  Widget build(BuildContext context) {
    final hora =
        '${ticket.fecha.hour.toString().padLeft(2, '0')}:${ticket.fecha.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Row(
            children: [
              Text(
                '#${ticket.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              _chip(ticket.tipoEtiqueta),
              const Spacer(),
              Text(
                hora,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _subtitulo(),
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                MoneyFormatter.toDisplay(ticket.totalCentavos),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              ThermalPrintButton(ticket: ticket),
            ],
          ),
          children: [
            ...ticket.lineas.map(_linea),
            const Divider(color: AppColors.border),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(
                  MoneyFormatter.toDisplay(ticket.totalCentavos),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _subtitulo() {
    return switch (ticket.tipoOrden) {
      TipoOrden.mesa => 'Mesa ${ticket.mesaNumero ?? '?'}',
      TipoOrden.paraLlevar => 'Para llevar',
      TipoOrden.domicilio =>
        '${ticket.colonia ?? ''} · ${ticket.telefono ?? ''}',
    };
  }

  Widget _chip(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.neutralSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _linea(TicketLinea linea) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              linea.productoNombre,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            MoneyFormatter.cantidadDisplay(
              cantidad: linea.cantidad,
              esPorPeso: linea.esPorPeso,
            ),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            MoneyFormatter.toDisplay(linea.subtotal),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
