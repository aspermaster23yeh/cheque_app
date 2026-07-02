/// Tipo de servicio al cobrar una orden.
enum TipoOrden {
  mesa('mesa'),
  paraLlevar('para_llevar'),
  domicilio('domicilio');

  const TipoOrden(this.value);
  final String value;

  static TipoOrden fromValue(String value) {
    return TipoOrden.values.firstWhere(
      (t) => t.value == value,
      orElse: () => TipoOrden.paraLlevar,
    );
  }

  String get etiqueta => switch (this) {
        TipoOrden.mesa => 'Mesa',
        TipoOrden.paraLlevar => 'Para llevar',
        TipoOrden.domicilio => 'Domicilio',
      };
}
