import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/estadisticas/data/datasources/estadisticas_local_datasource.dart';
import 'package:carnitas_cheque/features/estadisticas/domain/entities/kpi_resumen.dart';

part 'estadisticas_state.dart';

class EstadisticasCubit extends Cubit<EstadisticasState> {
  EstadisticasCubit(this._dataSource) : super(const EstadisticasState());

  final EstadisticasLocalDataSource _dataSource;

  Future<void> cargar() async {
    emit(state.copyWith(status: EstadisticasStatus.cargando));

    try {
      final resumen = await _dataSource.obtenerResumenHoy();
      emit(state.copyWith(
        status: EstadisticasStatus.exito,
        resumen: resumen,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: EstadisticasStatus.error,
        errorMensaje: 'No se pudieron cargar las estadísticas',
      ));
    }
  }
}
