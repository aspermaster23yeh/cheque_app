import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Abre la base de datos SQLite nativa en el directorio de documentos de la app.
LazyDatabase openNativeConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'carnitas_cheque.db'));
    return NativeDatabase.createInBackground(file);
  });
}
