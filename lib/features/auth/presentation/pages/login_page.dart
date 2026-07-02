import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/app/app_shell.dart';
import 'package:carnitas_cheque/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:carnitas_cheque/features/auth/presentation/widgets/pin_pad.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.db});

  final LocalDatabase db;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.autenticado && state.usuario != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => AppShell(db: db, usuario: state.usuario!),
            ),
          );
        }
      },
      child: const Scaffold(
        body: SafeArea(
          child: _LoginBody(),
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          const Spacer(flex: 2),
          const Icon(
            Icons.restaurant_menu_rounded,
            size: 72,
            color: AppColors.accent,
          ),
          const SizedBox(height: 20),
          const Text(
            'Carnitas Cheque',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ingresa tu PIN de acceso',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 40),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (prev, curr) =>
                prev.pin != curr.pin || prev.status != curr.status,
            builder: (context, state) {
              return Column(
                children: [
                  PinIndicator(
                    length: state.pin.length,
                    maxLength: AuthState.pinLength,
                  ),
                  if (state.status == AuthStatus.error) ...[
                    const SizedBox(height: 16),
                    Text(
                      state.errorMensaje ?? 'PIN incorrecto',
                      style: const TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  if (state.status == AuthStatus.cargando) ...[
                    const SizedBox(height: 24),
                    const CircularProgressIndicator(color: AppColors.accent),
                  ],
                ],
              );
            },
          ),
          const Spacer(flex: 3),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              final cargando = state.status == AuthStatus.cargando;
              return PinPad(
                onDigito: cargando
                    ? (_) {}
                    : context.read<AuthCubit>().agregarDigito,
                onBorrar: cargando
                    ? () {}
                    : context.read<AuthCubit>().borrarDigito,
                onLimpiar: cargando
                    ? () {}
                    : context.read<AuthCubit>().limpiarPin,
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
