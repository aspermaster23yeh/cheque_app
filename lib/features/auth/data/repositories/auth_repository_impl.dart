import 'package:carnitas_cheque/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:carnitas_cheque/features/auth/domain/entities/usuario.dart';
import 'package:carnitas_cheque/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);

  final AuthLocalDataSource _dataSource;

  @override
  Future<UsuarioEntity?> loginConPin(String pin) =>
      _dataSource.buscarPorPin(pin);
}
