import 'package:equatable/equatable.dart';

import 'package:carnitas_cheque/shared/core/enums/rol_usuario.dart';

/// Entidad de negocio del usuario autenticado (sin dependencias de Drift).
class UsuarioEntity extends Equatable {
  const UsuarioEntity({
    required this.id,
    required this.nombre,
    required this.rol,
  });

  final int id;
  final String nombre;
  final RolUsuario rol;

  bool get esAdmin => rol == RolUsuario.admin;
  bool get esVendedor => rol == RolUsuario.vendedor;

  @override
  List<Object?> get props => [id, nombre, rol];
}
