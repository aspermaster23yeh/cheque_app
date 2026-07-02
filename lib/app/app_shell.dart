import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/auth/domain/entities/usuario.dart';
import 'package:carnitas_cheque/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:carnitas_cheque/features/auth/presentation/pages/login_page.dart';
import 'package:carnitas_cheque/features/estadisticas/presentation/pages/estadisticas_page.dart';
import 'package:carnitas_cheque/features/inventario/presentation/pages/productos_admin_page.dart';
import 'package:carnitas_cheque/features/pos_venta/presentation/pages/pos_venta_screen.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

/// Contenedor post-login. Admin: Venta + Productos + Estadísticas.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.db, required this.usuario});

  final LocalDatabase db;
  final UsuarioEntity usuario;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tabIndex = 0;

  static const _titulosAdmin = [
    'Punto de Venta',
    'Todos los productos',
    'Estadísticas',
  ];

  @override
  Widget build(BuildContext context) {
    final esAdmin = widget.usuario.esAdmin;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          esAdmin ? _titulosAdmin[_tabIndex] : 'Punto de Venta',
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
              icon: const Icon(
                Icons.logout_rounded,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
      body: esAdmin ? _bodyAdmin() : _bodyVendedor(),
      bottomNavigationBar: esAdmin ? _navAdmin() : null,
    );
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
        ProductosAdminPage(db: widget.db),
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
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.point_of_sale_outlined),
          selectedIcon: Icon(Icons.point_of_sale),
          label: 'Venta',
        ),
        NavigationDestination(
          icon: Icon(Icons.inventory_2_outlined),
          selectedIcon: Icon(Icons.inventory_2),
          label: 'Productos',
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart),
          label: 'Stats',
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
