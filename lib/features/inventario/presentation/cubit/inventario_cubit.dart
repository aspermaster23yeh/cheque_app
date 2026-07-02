import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/inventario/data/datasources/inventario_local_datasource.dart';

part 'inventario_state.dart';

class InventarioCubit extends Cubit<InventarioState> {
  InventarioCubit(this._dataSource) : super(const InventarioState());

  final InventarioLocalDataSource _dataSource;

  Future<void> guardarProducto({
    required int id,
    required String nombre,
    required int categoriaId,
    required int precioUnidadCentavos,
    required double inventarioDisponible,
    required bool esPorPeso,
    required bool activo,
    String? imagenUrl,
  }) async {
    emit(state.copyWith(status: InventarioStatus.guardando, limpiarError: true));

    try {
      await _dataSource.guardarProducto(
        id: id,
        nombre: nombre,
        categoriaId: categoriaId,
        precioUnidadCentavos: precioUnidadCentavos,
        inventarioDisponible: inventarioDisponible,
        esPorPeso: esPorPeso,
        activo: activo,
        imagenUrl: imagenUrl,
      );
      emit(state.copyWith(status: InventarioStatus.guardado));
    } catch (e) {
      emit(state.copyWith(
        status: InventarioStatus.error,
        errorMensaje: 'No se pudo guardar el producto',
      ));
    }
  }

  void resetStatus() {
    emit(state.copyWith(status: InventarioStatus.inicial, limpiarError: true));
  }
}
