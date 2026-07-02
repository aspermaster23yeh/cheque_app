import 'dart:convert';

import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import 'package:carnitas_cheque/shared/core/enums/tipo_orden.dart';
import 'package:carnitas_cheque/shared/core/utils/money_formatter.dart';
import 'package:carnitas_cheque/shared/database/models/ticket_models.dart';

class ThermalPrinterService {
  ThermalPrinterService._();

  static const String negocioTitulo = 'Tortas Ahogadas el Cheque';
  static const String negocioDireccion =
      'Av. México Nte. 4196, Jardines del Valle, 63038 Tepic, Nay.';

  static Future<bool> get isConnected =>
      PrintBluetoothThermal.connectionStatus;

  static Future<List<BluetoothInfo>> get pairedPrinters =>
      PrintBluetoothThermal.pairedBluetooths;

  static Future<bool> connect(String macAddress) {
    return PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
  }

  static Future<bool> printTicket(TicketVenta ticket) async {
    final connected = await isConnected;
    if (!connected) return false;
    return PrintBluetoothThermal.writeBytes(_ticketBytes(ticket));
  }

  static List<int> _ticketBytes(TicketVenta ticket) {
    final bytes = <int>[];
    void raw(List<int> data) => bytes.addAll(data);
    void line(String text) => bytes.addAll(latin1.encode('$text\n'));

    raw([27, 64]); // init
    raw([27, 97, 1]); // center
    raw([27, 69, 1]); // bold on
    raw([29, 33, 17]); // double height + width
    line(negocioTitulo.toUpperCase());
    raw([29, 33, 0]);
    raw([27, 69, 0]);
    for (final l in _wrap(negocioDireccion, 32)) {
      line(l);
    }
    line('');

    raw([27, 97, 0]); // left
    line(_separator());
    raw([27, 69, 1]);
    line('TICKET #${ticket.id}');
    raw([27, 69, 0]);
    line('Fecha: ${_fecha(ticket.fecha)}');
    line('Tipo: ${ticket.tipoEtiqueta}');
    _serviceLines(ticket).forEach(line);
    line(_separator());

    for (final item in ticket.lineas) {
      final cantidad = MoneyFormatter.cantidadDisplay(
        cantidad: item.cantidad,
        esPorPeso: item.esPorPeso,
      );
      for (final nameLine in _wrap(item.productoNombre, 32)) {
        line(nameLine);
      }
      line(_columns(
        '$cantidad x ${MoneyFormatter.toDisplay(item.precioHistorico)}',
        MoneyFormatter.toDisplay(item.subtotal),
      ));
    }

    line(_separator());
    raw([27, 69, 1]);
    raw([29, 33, 16]); // double height
    line(_columns('TOTAL', MoneyFormatter.toDisplay(ticket.totalCentavos)));
    raw([29, 33, 0]);
    raw([27, 69, 0]);
    line(_separator());
    raw([27, 97, 1]); // center
    line('Gracias por su compra');
    line('');
    line('');
    line('');
    raw([29, 86, 66, 0]); // partial cut
    return bytes;
  }

  static List<String> _serviceLines(TicketVenta ticket) {
    return switch (ticket.tipoOrden) {
      TipoOrden.mesa => [
          'Mesa: ${ticket.mesaNumero ?? '-'}',
        ],
      TipoOrden.paraLlevar => [
          'Orden para llevar',
        ],
      TipoOrden.domicilio => [
          'ENTREGA A DOMICILIO',
          'Tel: ${ticket.telefono ?? '-'}',
          'Calle: ${ticket.calle ?? '-'} #${ticket.numeroExterior ?? '-'}',
          'Entre: ${ticket.entreCalle ?? '-'}',
          'Colonia: ${ticket.colonia ?? '-'}',
        ],
    };
  }

  static String _fecha(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  static String _separator() => '-' * 32;

  static String _columns(String left, String right) {
    const width = 32;
    final cleanLeft = left.length > 22 ? left.substring(0, 22) : left;
    final space = width - cleanLeft.length - right.length;
    return '$cleanLeft${' ' * (space > 1 ? space : 1)}$right';
  }

  static List<String> _wrap(String text, int width) {
    final words = text.split(' ');
    final lines = <String>[];
    var current = '';
    for (final word in words) {
      if (current.isEmpty) {
        current = word;
      } else if ('$current $word'.length <= width) {
        current = '$current $word';
      } else {
        lines.add(current);
        current = word;
      }
    }
    if (current.isNotEmpty) lines.add(current);
    return lines;
  }
}
