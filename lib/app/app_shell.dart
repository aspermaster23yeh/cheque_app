import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/auth/domain/entities/usuario.dart';
import 'package:carnitas_cheque/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:carnitas_cheque/features/auth/presentation/pages/login_page.dart';
import 'package:carnitas_cheque/features/estadisticas/presentation/pages/estadisticas_page.dart';
import 'package:carnitas_cheque/features/pos_venta/presentation/pages/pos_venta_screen.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

/// Contenedor post-login. Admin ve Venta + Estadísticas; vendedor solo Venta.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.db, required this.usuario});

  final LocalDatabase db;
  final UsuarioEntity usuario;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final esAdmin = widget.usuario.esAdmin;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          _titulo(esAdmin),
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              tooltip: 'Cerrar sesión',
              onPressed: () => _cerrarSesion(context),
              icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
      body: esAdmin ? _bodyAdmin() : _bodyVendedor(),
      bottomNavigationBar: esAdmin ? _navAdmin() : null,
    );
  }

  String _titulo(bool esAdmin) {
    if (!esAdmin) return 'Punto de Venta';
    return _tabIndex == 0 ? 'Punto de Venta' : 'Estadísticas';
  }

  Widget _bodyVendedor() {
    return PosVentaScreen(
      db: widget.db,
      usuarioId: widget.usuario.id,
    );
  }

  Widget _bodyAdmin() {
    return IndexedStack(
      index: _tabIndex,
      children: [
        PosVentaScreen(db: widget.db, usuarioId: widget.usuario.id),
        EstadisticasPage(db: widget.db),
      ],
    );
  }

  Widget _navAdmin() {
    return NavigationBar(
      selectedIndex: _tabIndex,
      onDestinationSelected: (i) => setState(() => _tabIndex = i),
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.neutralSoft,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.point_of_sale_outlined),
          selectedIcon: Icon(Icons.point_of_sale),
          label: 'Venta',
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart),
          label: 'Estadísticas',
        ),
      ],
    );
  }

  void _cerrarSesion(BuildContext context) {
    context.read<AuthCubit>().cerrarSesion();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginPage(db: widget.db)),
      (_) => false,
    );
  }
}
