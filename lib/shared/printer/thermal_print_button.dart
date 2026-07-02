import 'package:flutter/material.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/database/models/ticket_models.dart';
import 'package:carnitas_cheque/shared/printer/thermal_printer_service.dart';

class ThermalPrintButton extends StatefulWidget {
  const ThermalPrintButton({super.key, required this.ticket});

  final TicketVenta ticket;

  @override
  State<ThermalPrintButton> createState() => _ThermalPrintButtonState();
}

class _ThermalPrintButtonState extends State<ThermalPrintButton> {
  bool _printing = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Imprimir ticket',
      onPressed: _printing ? null : _print,
      icon: _printing
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.print_rounded, color: AppColors.accent),
    );
  }

  Future<void> _print() async {
    setState(() => _printing = true);
    try {
      var connected = await ThermalPrinterService.isConnected;
      if (!connected && mounted) {
        connected = await _selectAndConnectPrinter(context);
      }

      if (!connected) {
        _message('No se conectó ninguna impresora', error: true);
        return;
      }

      final ok = await ThermalPrinterService.printTicket(widget.ticket);
      _message(
        ok ? 'Ticket enviado a impresora' : 'No se pudo imprimir el ticket',
        error: !ok,
      );
    } finally {
      if (mounted) setState(() => _printing = false);
    }
  }

  Future<bool> _selectAndConnectPrinter(BuildContext context) async {
    final printers = await ThermalPrinterService.pairedPrinters;
    if (!context.mounted) return false;

    if (printers.isEmpty) {
      _message(
        'Vincula la ticketera desde Bluetooth del teléfono primero',
        error: true,
      );
      return false;
    }

    final selected = await showModalBottomSheet<BluetoothInfo>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _PrinterPicker(printers: printers),
    );

    if (selected == null) return false;
    return ThermalPrinterService.connect(selected.macAdress);
  }

  void _message(String text, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: error ? AppColors.danger : AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _PrinterPicker extends StatelessWidget {
  const _PrinterPicker({required this.printers});

  final List<BluetoothInfo> printers;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              'Seleccionar ticketera',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ...printers.map(
              (printer) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppColors.neutralSoft,
                  child: Icon(Icons.print_rounded, color: AppColors.accent),
                ),
                title: Text(
                  printer.name,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(printer.macAdress),
                onTap: () => Navigator.pop(context, printer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
