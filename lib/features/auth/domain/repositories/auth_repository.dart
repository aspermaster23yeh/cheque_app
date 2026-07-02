import 'package:carnitas_cheque/features/auth/domain/entities/usuario.dart';

abstract class AuthRepository {
  Future<UsuarioEntity?> loginConPin(String pin);
}
