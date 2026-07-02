import 'package:carnitas_cheque/features/estadisticas/domain/entities/kpi_resumen.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

class EstadisticasLocalDataSource {
  const EstadisticasLocalDataSource(this._db);

  final LocalDatabase _db;

  /// Rango [inicio del día, inicio del día siguiente) en hora local.
  (DateTime, DateTime) rangoHoy() {
    final ahora = DateTime.now();
    final inicio = DateTime(ahora.year, ahora.month, ahora.day);
    final fin = inicio.add(const Duration(days: 1));
    return (inicio, fin);
  }

  Future<KpiResumen> obtenerResumenHoy() async {
    final (desde, hasta) = rangoHoy();

    final results = await Future.wait([
      _db.totalVentasEnRango(desde, hasta),
      _db.contarVentasEnRango(desde, hasta),
      _db.ventasPorHoraEnRango(desde, hasta),
      _db.topProductosEnRango(desde, hasta),
      _db.obtenerTicketsEnRango(desde, hasta),
    ]);

    final total = results[0] as int;
    final cantidad = results[1] as int;
    final porHora = results[2] as List;
    final top = results[3] as List;
    final tickets = results[4] as List;

    final ticketPromedio =
        cantidad > 0 ? (total / cantidad).round() : 0;

    return KpiResumen(
      totalCentavos: total,
      cantidadVentas: cantidad,
      ticketPromedioCentavos: ticketPromedio,
      ventasPorHora: porHora.cast(),
      topProductos: top.cast(),
      tickets: tickets.cast(),
    );
  }
}
