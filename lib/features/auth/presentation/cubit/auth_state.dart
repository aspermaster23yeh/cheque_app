part of 'auth_cubit.dart';

enum AuthStatus { inicial, cargando, autenticado, error }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.inicial,
    this.pin = '',
    this.usuario,
    this.errorMensaje,
  });

  final AuthStatus status;
  final String pin;
  final UsuarioEntity? usuario;
  final String? errorMensaje;

  static const int pinLength = 4;

  bool get pinCompleto => pin.length >= pinLength;

  AuthState copyWith({
    AuthStatus? status,
    String? pin,
    UsuarioEntity? usuario,
    String? errorMensaje,
    bool limpiarUsuario = false,
    bool limpiarError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      pin: pin ?? this.pin,
      usuario: limpiarUsuario ? null : (usuario ?? this.usuario),
      errorMensaje:
          limpiarError ? null : (errorMensaje ?? this.errorMensaje),
    );
  }

  @override
  List<Object?> get props => [status, pin, usuario, errorMensaje];
}
