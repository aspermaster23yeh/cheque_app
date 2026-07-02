import 'package:carnitas_cheque/features/auth/domain/entities/usuario.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

class AuthLocalDataSource {
  const AuthLocalDataSource(this._db);

  final LocalDatabase _db;

  Future<UsuarioEntity?> buscarPorPin(String pin) async {
    final row = await _db.findUsuarioByPin(pin);
    if (row == null) return null;
    return UsuarioEntity(
      id: row.id,
      nombre: row.nombre,
      rol: row.rol,
    );
  }
}
