import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:carnitas_cheque/main.dart';
import 'package:carnitas_cheque/shared/database/local_db.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Muestra la pantalla de login al iniciar', (tester) async {
    final db = LocalDatabase.forTesting(NativeDatabase.memory());

    await tester.pumpWidget(CarnitasChequeApp(database: db));
    await tester.pumpAndSettle();

    expect(find.text('Carnitas Cheque'), findsOneWidget);
    expect(find.text('Ingresa tu PIN de acceso'), findsOneWidget);
  });
}
