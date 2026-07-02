import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carnitas_cheque/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:carnitas_cheque/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:carnitas_cheque/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:carnitas_cheque/features/auth/presentation/pages/login_page.dart';
import 'package:carnitas_cheque/shared/core/theme/app_theme.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = LocalDatabase();

  runApp(CarnitasChequeApp(database: database));
}

class CarnitasChequeApp extends StatelessWidget {
  const CarnitasChequeApp({super.key, required this.database});

  final LocalDatabase database;

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl(
      AuthLocalDataSource(database),
    );

    return BlocProvider(
      create: (_) => AuthCubit(authRepository),
      child: MaterialApp(
        title: 'Carnitas Cheque',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: LoginPage(db: database),
      ),
    );
  }
}
