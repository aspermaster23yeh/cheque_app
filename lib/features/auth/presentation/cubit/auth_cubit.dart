import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/auth/domain/entities/usuario.dart';
import 'package:carnitas_cheque/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState());

  final AuthRepository _repository;

  void agregarDigito(String digito) {
    if (state.status == AuthStatus.cargando) return;
    if (state.pin.length >= AuthState.pinLength) return;

    final nuevoPin = state.pin + digito;
    emit(state.copyWith(
      pin: nuevoPin,
      status: AuthStatus.inicial,
      limpiarError: true,
    ));

    if (nuevoPin.length == AuthState.pinLength) {
      _autenticar(nuevoPin);
    }
  }

  void borrarDigito() {
    if (state.status == AuthStatus.cargando) return;
    if (state.pin.isEmpty) return;
    emit(state.copyWith(
      pin: state.pin.substring(0, state.pin.length - 1),
      limpiarError: true,
    ));
  }

  void limpiarPin() {
    emit(state.copyWith(pin: '', limpiarError: true));
  }

  void cerrarSesion() {
    emit(const AuthState());
  }

  Future<void> _autenticar(String pin) async {
    emit(state.copyWith(status: AuthStatus.cargando, limpiarError: true));

    try {
      final usuario = await _repository.loginConPin(pin);
      if (usuario == null) {
        emit(state.copyWith(
          status: AuthStatus.error,
          pin: '',
          errorMensaje: 'PIN incorrecto',
        ));
        return;
      }

      emit(state.copyWith(
        status: AuthStatus.autenticado,
        usuario: usuario,
        pin: '',
        limpiarError: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        pin: '',
        errorMensaje: 'Error al iniciar sesión',
      ));
    }
  }
}
