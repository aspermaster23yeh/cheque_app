import 'package:flutter/material.dart';

/// Tokens de diseño — estética premium minimalista (inspiración McDonald's app).
class AppColors {
  AppColors._();

  /// Fondo global sutilmente crema/gris muy suave.
  static const Color background = Color(0xFFF7F6F3);

  /// Contenedores y tarjetas — blanco puro.
  static const Color surface = Color(0xFFFFFFFF);

  /// Texto principal — casi negro.
  static const Color textPrimary = Color(0xFF1A1A1A);

  /// Texto secundario / metadatos.
  static const Color textSecondary = Color(0xFF9A9A9A);

  /// Color de acento cálido (naranja) para acciones primarias.
  static const Color accent = Color(0xFFFF6B00);

  /// Variante del acento para checkout / confirmación.
  static const Color accentStrong = Color(0xFFE65100);

  /// Chips y contenedores neutros suaves.
  static const Color neutralSoft = Color(0xFFF1F0EC);

  /// Bordes discretos.
  static const Color border = Color(0xFFEDECE8);

  static const Color danger = Color(0xFFE53935);
  static const Color success = Color(0xFF2E7D32);
}

class AppRadius {
  AppRadius._();
  static const double card = 24;
  static const double chip = 40;
  static const double button = 20;
  static const double pill = 16;
}

class AppShadows {
  AppShadows._();

  /// Sombra muy sutil para tarjetas (soft shadow).
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  /// Sombra elevada para el panel de carrito.
  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 30,
      offset: Offset(0, -10),
    ),
  ];
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        primary: AppColors.accent,
        surface: AppColors.surface,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
        fontFamily: 'Roboto',
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }
}
