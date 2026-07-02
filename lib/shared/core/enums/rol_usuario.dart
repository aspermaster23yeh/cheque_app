/// Roles de acceso al sistema POS.
enum RolUsuario {
  admin('admin'),
  vendedor('vendedor');

  const RolUsuario(this.value);
  final String value;

  static RolUsuario fromValue(String value) {
    return RolUsuario.values.firstWhere(
      (r) => r.value == value,
      orElse: () => RolUsuario.vendedor,
    );
  }
}
