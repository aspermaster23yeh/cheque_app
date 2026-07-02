// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RolUsuario, String> rol =
      GeneratedColumn<String>(
        'rol',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RolUsuario>($UsuariosTable.$converterrol);
  static const VerificationMeta _pinAccesoMeta = const VerificationMeta(
    'pinAcceso',
  );
  @override
  late final GeneratedColumn<String> pinAcceso = GeneratedColumn<String>(
    'pin_acceso',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    rol,
    pinAcceso,
    activo,
    creadoEn,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('pin_acceso')) {
      context.handle(
        _pinAccesoMeta,
        pinAcceso.isAcceptableOrUnknown(data['pin_acceso']!, _pinAccesoMeta),
      );
    } else if (isInserting) {
      context.missing(_pinAccesoMeta);
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      rol: $UsuariosTable.$converterrol.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rol'],
        )!,
      ),
      pinAcceso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_acceso'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }

  static TypeConverter<RolUsuario, String> $converterrol =
      const RolUsuarioConverter();
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String nombre;
  final RolUsuario rol;

  /// Hash del PIN de acceso (nunca almacenar en texto plano en producción).
  final String pinAcceso;
  final bool activo;
  final DateTime creadoEn;
  final DateTime actualizadoEn;
  const Usuario({
    required this.id,
    required this.nombre,
    required this.rol,
    required this.pinAcceso,
    required this.activo,
    required this.creadoEn,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    {
      map['rol'] = Variable<String>($UsuariosTable.$converterrol.toSql(rol));
    }
    map['pin_acceso'] = Variable<String>(pinAcceso);
    map['activo'] = Variable<bool>(activo);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      rol: Value(rol),
      pinAcceso: Value(pinAcceso),
      activo: Value(activo),
      creadoEn: Value(creadoEn),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      rol: serializer.fromJson<RolUsuario>(json['rol']),
      pinAcceso: serializer.fromJson<String>(json['pinAcceso']),
      activo: serializer.fromJson<bool>(json['activo']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'rol': serializer.toJson<RolUsuario>(rol),
      'pinAcceso': serializer.toJson<String>(pinAcceso),
      'activo': serializer.toJson<bool>(activo),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  Usuario copyWith({
    int? id,
    String? nombre,
    RolUsuario? rol,
    String? pinAcceso,
    bool? activo,
    DateTime? creadoEn,
    DateTime? actualizadoEn,
  }) => Usuario(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    rol: rol ?? this.rol,
    pinAcceso: pinAcceso ?? this.pinAcceso,
    activo: activo ?? this.activo,
    creadoEn: creadoEn ?? this.creadoEn,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      rol: data.rol.present ? data.rol.value : this.rol,
      pinAcceso: data.pinAcceso.present ? data.pinAcceso.value : this.pinAcceso,
      activo: data.activo.present ? data.activo.value : this.activo,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('rol: $rol, ')
          ..write('pinAcceso: $pinAcceso, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, rol, pinAcceso, activo, creadoEn, actualizadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.rol == this.rol &&
          other.pinAcceso == this.pinAcceso &&
          other.activo == this.activo &&
          other.creadoEn == this.creadoEn &&
          other.actualizadoEn == this.actualizadoEn);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<RolUsuario> rol;
  final Value<String> pinAcceso;
  final Value<bool> activo;
  final Value<DateTime> creadoEn;
  final Value<DateTime> actualizadoEn;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.rol = const Value.absent(),
    this.pinAcceso = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required RolUsuario rol,
    required String pinAcceso,
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  }) : nombre = Value(nombre),
       rol = Value(rol),
       pinAcceso = Value(pinAcceso);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? rol,
    Expression<String>? pinAcceso,
    Expression<bool>? activo,
    Expression<DateTime>? creadoEn,
    Expression<DateTime>? actualizadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (rol != null) 'rol': rol,
      if (pinAcceso != null) 'pin_acceso': pinAcceso,
      if (activo != null) 'activo': activo,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
    });
  }

  UsuariosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<RolUsuario>? rol,
    Value<String>? pinAcceso,
    Value<bool>? activo,
    Value<DateTime>? creadoEn,
    Value<DateTime>? actualizadoEn,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      rol: rol ?? this.rol,
      pinAcceso: pinAcceso ?? this.pinAcceso,
      activo: activo ?? this.activo,
      creadoEn: creadoEn ?? this.creadoEn,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(
        $UsuariosTable.$converterrol.toSql(rol.value),
      );
    }
    if (pinAcceso.present) {
      map['pin_acceso'] = Variable<String>(pinAcceso.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('rol: $rol, ')
          ..write('pinAcceso: $pinAcceso, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }
}

class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, activo, orden, creadoEn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<Categoria> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int id;
  final String nombre;
  final bool activo;

  /// Orden de aparición en el menú del POS.
  final int orden;
  final DateTime creadoEn;
  const Categoria({
    required this.id,
    required this.nombre,
    required this.activo,
    required this.orden,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['activo'] = Variable<bool>(activo);
    map['orden'] = Variable<int>(orden);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      activo: Value(activo),
      orden: Value(orden),
      creadoEn: Value(creadoEn),
    );
  }

  factory Categoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      activo: serializer.fromJson<bool>(json['activo']),
      orden: serializer.fromJson<int>(json['orden']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'activo': serializer.toJson<bool>(activo),
      'orden': serializer.toJson<int>(orden),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  Categoria copyWith({
    int? id,
    String? nombre,
    bool? activo,
    int? orden,
    DateTime? creadoEn,
  }) => Categoria(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    activo: activo ?? this.activo,
    orden: orden ?? this.orden,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      activo: data.activo.present ? data.activo.value : this.activo,
      orden: data.orden.present ? data.orden.value : this.orden,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('activo: $activo, ')
          ..write('orden: $orden, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, activo, orden, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.activo == this.activo &&
          other.orden == this.orden &&
          other.creadoEn == this.creadoEn);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<bool> activo;
  final Value<int> orden;
  final Value<DateTime> creadoEn;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.activo = const Value.absent(),
    this.orden = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.activo = const Value.absent(),
    this.orden = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Categoria> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<bool>? activo,
    Expression<int>? orden,
    Expression<DateTime>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (activo != null) 'activo': activo,
      if (orden != null) 'orden': orden,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  CategoriasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<bool>? activo,
    Value<int>? orden,
    Value<DateTime>? creadoEn,
  }) {
    return CategoriasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      activo: activo ?? this.activo,
      orden: orden ?? this.orden,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('activo: $activo, ')
          ..write('orden: $orden, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $ProductosTable extends Productos
    with TableInfo<$ProductosTable, Producto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoriaIdMeta = const VerificationMeta(
    'categoriaId',
  );
  @override
  late final GeneratedColumn<int> categoriaId = GeneratedColumn<int>(
    'categoria_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categorias (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioUnidadMeta = const VerificationMeta(
    'precioUnidad',
  );
  @override
  late final GeneratedColumn<int> precioUnidad = GeneratedColumn<int>(
    'precio_unidad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _esPorPesoMeta = const VerificationMeta(
    'esPorPeso',
  );
  @override
  late final GeneratedColumn<bool> esPorPeso = GeneratedColumn<bool>(
    'es_por_peso',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("es_por_peso" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _inventarioDisponibleMeta =
      const VerificationMeta('inventarioDisponible');
  @override
  late final GeneratedColumn<double> inventarioDisponible =
      GeneratedColumn<double>(
        'inventario_disponible',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _imagenUrlMeta = const VerificationMeta(
    'imagenUrl',
  );
  @override
  late final GeneratedColumn<String> imagenUrl = GeneratedColumn<String>(
    'imagen_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoriaId,
    nombre,
    precioUnidad,
    esPorPeso,
    inventarioDisponible,
    imagenUrl,
    activo,
    creadoEn,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'productos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Producto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
        _categoriaIdMeta,
        categoriaId.isAcceptableOrUnknown(
          data['categoria_id']!,
          _categoriaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoriaIdMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('precio_unidad')) {
      context.handle(
        _precioUnidadMeta,
        precioUnidad.isAcceptableOrUnknown(
          data['precio_unidad']!,
          _precioUnidadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioUnidadMeta);
    }
    if (data.containsKey('es_por_peso')) {
      context.handle(
        _esPorPesoMeta,
        esPorPeso.isAcceptableOrUnknown(data['es_por_peso']!, _esPorPesoMeta),
      );
    }
    if (data.containsKey('inventario_disponible')) {
      context.handle(
        _inventarioDisponibleMeta,
        inventarioDisponible.isAcceptableOrUnknown(
          data['inventario_disponible']!,
          _inventarioDisponibleMeta,
        ),
      );
    }
    if (data.containsKey('imagen_url')) {
      context.handle(
        _imagenUrlMeta,
        imagenUrl.isAcceptableOrUnknown(data['imagen_url']!, _imagenUrlMeta),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Producto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Producto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoriaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}categoria_id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      precioUnidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_unidad'],
      )!,
      esPorPeso: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}es_por_peso'],
      )!,
      inventarioDisponible: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}inventario_disponible'],
      )!,
      imagenUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}imagen_url'],
      ),
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $ProductosTable createAlias(String alias) {
    return $ProductosTable(attachedDatabase, alias);
  }
}

class Producto extends DataClass implements Insertable<Producto> {
  final int id;
  final int categoriaId;
  final String nombre;

  /// Precio en centavos por unidad o por kilogramo según [esPorPeso].
  final int precioUnidad;
  final bool esPorPeso;

  /// KG si [esPorPeso], piezas en caso contrario.
  final double inventarioDisponible;
  final String? imagenUrl;
  final bool activo;
  final DateTime creadoEn;
  final DateTime actualizadoEn;
  const Producto({
    required this.id,
    required this.categoriaId,
    required this.nombre,
    required this.precioUnidad,
    required this.esPorPeso,
    required this.inventarioDisponible,
    this.imagenUrl,
    required this.activo,
    required this.creadoEn,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['categoria_id'] = Variable<int>(categoriaId);
    map['nombre'] = Variable<String>(nombre);
    map['precio_unidad'] = Variable<int>(precioUnidad);
    map['es_por_peso'] = Variable<bool>(esPorPeso);
    map['inventario_disponible'] = Variable<double>(inventarioDisponible);
    if (!nullToAbsent || imagenUrl != null) {
      map['imagen_url'] = Variable<String>(imagenUrl);
    }
    map['activo'] = Variable<bool>(activo);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  ProductosCompanion toCompanion(bool nullToAbsent) {
    return ProductosCompanion(
      id: Value(id),
      categoriaId: Value(categoriaId),
      nombre: Value(nombre),
      precioUnidad: Value(precioUnidad),
      esPorPeso: Value(esPorPeso),
      inventarioDisponible: Value(inventarioDisponible),
      imagenUrl: imagenUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imagenUrl),
      activo: Value(activo),
      creadoEn: Value(creadoEn),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory Producto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Producto(
      id: serializer.fromJson<int>(json['id']),
      categoriaId: serializer.fromJson<int>(json['categoriaId']),
      nombre: serializer.fromJson<String>(json['nombre']),
      precioUnidad: serializer.fromJson<int>(json['precioUnidad']),
      esPorPeso: serializer.fromJson<bool>(json['esPorPeso']),
      inventarioDisponible: serializer.fromJson<double>(
        json['inventarioDisponible'],
      ),
      imagenUrl: serializer.fromJson<String?>(json['imagenUrl']),
      activo: serializer.fromJson<bool>(json['activo']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoriaId': serializer.toJson<int>(categoriaId),
      'nombre': serializer.toJson<String>(nombre),
      'precioUnidad': serializer.toJson<int>(precioUnidad),
      'esPorPeso': serializer.toJson<bool>(esPorPeso),
      'inventarioDisponible': serializer.toJson<double>(inventarioDisponible),
      'imagenUrl': serializer.toJson<String?>(imagenUrl),
      'activo': serializer.toJson<bool>(activo),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  Producto copyWith({
    int? id,
    int? categoriaId,
    String? nombre,
    int? precioUnidad,
    bool? esPorPeso,
    double? inventarioDisponible,
    Value<String?> imagenUrl = const Value.absent(),
    bool? activo,
    DateTime? creadoEn,
    DateTime? actualizadoEn,
  }) => Producto(
    id: id ?? this.id,
    categoriaId: categoriaId ?? this.categoriaId,
    nombre: nombre ?? this.nombre,
    precioUnidad: precioUnidad ?? this.precioUnidad,
    esPorPeso: esPorPeso ?? this.esPorPeso,
    inventarioDisponible: inventarioDisponible ?? this.inventarioDisponible,
    imagenUrl: imagenUrl.present ? imagenUrl.value : this.imagenUrl,
    activo: activo ?? this.activo,
    creadoEn: creadoEn ?? this.creadoEn,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  Producto copyWithCompanion(ProductosCompanion data) {
    return Producto(
      id: data.id.present ? data.id.value : this.id,
      categoriaId: data.categoriaId.present
          ? data.categoriaId.value
          : this.categoriaId,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      precioUnidad: data.precioUnidad.present
          ? data.precioUnidad.value
          : this.precioUnidad,
      esPorPeso: data.esPorPeso.present ? data.esPorPeso.value : this.esPorPeso,
      inventarioDisponible: data.inventarioDisponible.present
          ? data.inventarioDisponible.value
          : this.inventarioDisponible,
      imagenUrl: data.imagenUrl.present ? data.imagenUrl.value : this.imagenUrl,
      activo: data.activo.present ? data.activo.value : this.activo,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Producto(')
          ..write('id: $id, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('nombre: $nombre, ')
          ..write('precioUnidad: $precioUnidad, ')
          ..write('esPorPeso: $esPorPeso, ')
          ..write('inventarioDisponible: $inventarioDisponible, ')
          ..write('imagenUrl: $imagenUrl, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoriaId,
    nombre,
    precioUnidad,
    esPorPeso,
    inventarioDisponible,
    imagenUrl,
    activo,
    creadoEn,
    actualizadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Producto &&
          other.id == this.id &&
          other.categoriaId == this.categoriaId &&
          other.nombre == this.nombre &&
          other.precioUnidad == this.precioUnidad &&
          other.esPorPeso == this.esPorPeso &&
          other.inventarioDisponible == this.inventarioDisponible &&
          other.imagenUrl == this.imagenUrl &&
          other.activo == this.activo &&
          other.creadoEn == this.creadoEn &&
          other.actualizadoEn == this.actualizadoEn);
}

class ProductosCompanion extends UpdateCompanion<Producto> {
  final Value<int> id;
  final Value<int> categoriaId;
  final Value<String> nombre;
  final Value<int> precioUnidad;
  final Value<bool> esPorPeso;
  final Value<double> inventarioDisponible;
  final Value<String?> imagenUrl;
  final Value<bool> activo;
  final Value<DateTime> creadoEn;
  final Value<DateTime> actualizadoEn;
  const ProductosCompanion({
    this.id = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.nombre = const Value.absent(),
    this.precioUnidad = const Value.absent(),
    this.esPorPeso = const Value.absent(),
    this.inventarioDisponible = const Value.absent(),
    this.imagenUrl = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  });
  ProductosCompanion.insert({
    this.id = const Value.absent(),
    required int categoriaId,
    required String nombre,
    required int precioUnidad,
    this.esPorPeso = const Value.absent(),
    this.inventarioDisponible = const Value.absent(),
    this.imagenUrl = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  }) : categoriaId = Value(categoriaId),
       nombre = Value(nombre),
       precioUnidad = Value(precioUnidad);
  static Insertable<Producto> custom({
    Expression<int>? id,
    Expression<int>? categoriaId,
    Expression<String>? nombre,
    Expression<int>? precioUnidad,
    Expression<bool>? esPorPeso,
    Expression<double>? inventarioDisponible,
    Expression<String>? imagenUrl,
    Expression<bool>? activo,
    Expression<DateTime>? creadoEn,
    Expression<DateTime>? actualizadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoriaId != null) 'categoria_id': categoriaId,
      if (nombre != null) 'nombre': nombre,
      if (precioUnidad != null) 'precio_unidad': precioUnidad,
      if (esPorPeso != null) 'es_por_peso': esPorPeso,
      if (inventarioDisponible != null)
        'inventario_disponible': inventarioDisponible,
      if (imagenUrl != null) 'imagen_url': imagenUrl,
      if (activo != null) 'activo': activo,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
    });
  }

  ProductosCompanion copyWith({
    Value<int>? id,
    Value<int>? categoriaId,
    Value<String>? nombre,
    Value<int>? precioUnidad,
    Value<bool>? esPorPeso,
    Value<double>? inventarioDisponible,
    Value<String?>? imagenUrl,
    Value<bool>? activo,
    Value<DateTime>? creadoEn,
    Value<DateTime>? actualizadoEn,
  }) {
    return ProductosCompanion(
      id: id ?? this.id,
      categoriaId: categoriaId ?? this.categoriaId,
      nombre: nombre ?? this.nombre,
      precioUnidad: precioUnidad ?? this.precioUnidad,
      esPorPeso: esPorPeso ?? this.esPorPeso,
      inventarioDisponible: inventarioDisponible ?? this.inventarioDisponible,
      imagenUrl: imagenUrl ?? this.imagenUrl,
      activo: activo ?? this.activo,
      creadoEn: creadoEn ?? this.creadoEn,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<int>(categoriaId.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (precioUnidad.present) {
      map['precio_unidad'] = Variable<int>(precioUnidad.value);
    }
    if (esPorPeso.present) {
      map['es_por_peso'] = Variable<bool>(esPorPeso.value);
    }
    if (inventarioDisponible.present) {
      map['inventario_disponible'] = Variable<double>(
        inventarioDisponible.value,
      );
    }
    if (imagenUrl.present) {
      map['imagen_url'] = Variable<String>(imagenUrl.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductosCompanion(')
          ..write('id: $id, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('nombre: $nombre, ')
          ..write('precioUnidad: $precioUnidad, ')
          ..write('esPorPeso: $esPorPeso, ')
          ..write('inventarioDisponible: $inventarioDisponible, ')
          ..write('imagenUrl: $imagenUrl, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }
}

class $VentasTable extends Ventas with TableInfo<$VentasTable, Venta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _fechaVentaMeta = const VerificationMeta(
    'fechaVenta',
  );
  @override
  late final GeneratedColumn<DateTime> fechaVenta = GeneratedColumn<DateTime>(
    'fecha_venta',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MetodoPago, String> metodoPago =
      GeneratedColumn<String>(
        'metodo_pago',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MetodoPago>($VentasTable.$convertermetodoPago);
  @override
  late final GeneratedColumnWithTypeConverter<EstadoVenta, String> estado =
      GeneratedColumn<String>(
        'estado',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('completado'),
      ).withConverter<EstadoVenta>($VentasTable.$converterestado);
  @override
  late final GeneratedColumnWithTypeConverter<TipoOrden, String> tipoOrden =
      GeneratedColumn<String>(
        'tipo_orden',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('para_llevar'),
      ).withConverter<TipoOrden>($VentasTable.$convertertipoOrden);
  static const VerificationMeta _mesaNumeroMeta = const VerificationMeta(
    'mesaNumero',
  );
  @override
  late final GeneratedColumn<int> mesaNumero = GeneratedColumn<int>(
    'mesa_numero',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calleMeta = const VerificationMeta('calle');
  @override
  late final GeneratedColumn<String> calle = GeneratedColumn<String>(
    'calle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entreCalleMeta = const VerificationMeta(
    'entreCalle',
  );
  @override
  late final GeneratedColumn<String> entreCalle = GeneratedColumn<String>(
    'entre_calle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coloniaMeta = const VerificationMeta(
    'colonia',
  );
  @override
  late final GeneratedColumn<String> colonia = GeneratedColumn<String>(
    'colonia',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numeroExteriorMeta = const VerificationMeta(
    'numeroExterior',
  );
  @override
  late final GeneratedColumn<String> numeroExterior = GeneratedColumn<String>(
    'numero_exterior',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
    'notas',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    fechaVenta,
    total,
    metodoPago,
    estado,
    tipoOrden,
    mesaNumero,
    telefono,
    calle,
    entreCalle,
    colonia,
    numeroExterior,
    notas,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ventas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Venta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('fecha_venta')) {
      context.handle(
        _fechaVentaMeta,
        fechaVenta.isAcceptableOrUnknown(data['fecha_venta']!, _fechaVentaMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('mesa_numero')) {
      context.handle(
        _mesaNumeroMeta,
        mesaNumero.isAcceptableOrUnknown(data['mesa_numero']!, _mesaNumeroMeta),
      );
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('calle')) {
      context.handle(
        _calleMeta,
        calle.isAcceptableOrUnknown(data['calle']!, _calleMeta),
      );
    }
    if (data.containsKey('entre_calle')) {
      context.handle(
        _entreCalleMeta,
        entreCalle.isAcceptableOrUnknown(data['entre_calle']!, _entreCalleMeta),
      );
    }
    if (data.containsKey('colonia')) {
      context.handle(
        _coloniaMeta,
        colonia.isAcceptableOrUnknown(data['colonia']!, _coloniaMeta),
      );
    }
    if (data.containsKey('numero_exterior')) {
      context.handle(
        _numeroExteriorMeta,
        numeroExterior.isAcceptableOrUnknown(
          data['numero_exterior']!,
          _numeroExteriorMeta,
        ),
      );
    }
    if (data.containsKey('notas')) {
      context.handle(
        _notasMeta,
        notas.isAcceptableOrUnknown(data['notas']!, _notasMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Venta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Venta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      fechaVenta: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_venta'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      metodoPago: $VentasTable.$convertermetodoPago.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}metodo_pago'],
        )!,
      ),
      estado: $VentasTable.$converterestado.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}estado'],
        )!,
      ),
      tipoOrden: $VentasTable.$convertertipoOrden.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tipo_orden'],
        )!,
      ),
      mesaNumero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mesa_numero'],
      ),
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      ),
      calle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calle'],
      ),
      entreCalle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entre_calle'],
      ),
      colonia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}colonia'],
      ),
      numeroExterior: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_exterior'],
      ),
      notas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notas'],
      ),
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $VentasTable createAlias(String alias) {
    return $VentasTable(attachedDatabase, alias);
  }

  static TypeConverter<MetodoPago, String> $convertermetodoPago =
      const MetodoPagoConverter();
  static TypeConverter<EstadoVenta, String> $converterestado =
      const EstadoVentaConverter();
  static TypeConverter<TipoOrden, String> $convertertipoOrden =
      const TipoOrdenConverter();
}

class Venta extends DataClass implements Insertable<Venta> {
  final int id;
  final int usuarioId;
  final DateTime fechaVenta;

  /// Total en centavos (suma de subtotales de detalles).
  final int total;
  final MetodoPago metodoPago;
  final EstadoVenta estado;

  /// Mesa, para llevar o domicilio.
  final TipoOrden tipoOrden;
  final int? mesaNumero;

  /// Datos de entrega a domicilio.
  final String? telefono;
  final String? calle;
  final String? entreCalle;
  final String? colonia;
  final String? numeroExterior;
  final String? notas;
  final DateTime creadoEn;
  const Venta({
    required this.id,
    required this.usuarioId,
    required this.fechaVenta,
    required this.total,
    required this.metodoPago,
    required this.estado,
    required this.tipoOrden,
    this.mesaNumero,
    this.telefono,
    this.calle,
    this.entreCalle,
    this.colonia,
    this.numeroExterior,
    this.notas,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['fecha_venta'] = Variable<DateTime>(fechaVenta);
    map['total'] = Variable<int>(total);
    {
      map['metodo_pago'] = Variable<String>(
        $VentasTable.$convertermetodoPago.toSql(metodoPago),
      );
    }
    {
      map['estado'] = Variable<String>(
        $VentasTable.$converterestado.toSql(estado),
      );
    }
    {
      map['tipo_orden'] = Variable<String>(
        $VentasTable.$convertertipoOrden.toSql(tipoOrden),
      );
    }
    if (!nullToAbsent || mesaNumero != null) {
      map['mesa_numero'] = Variable<int>(mesaNumero);
    }
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    if (!nullToAbsent || calle != null) {
      map['calle'] = Variable<String>(calle);
    }
    if (!nullToAbsent || entreCalle != null) {
      map['entre_calle'] = Variable<String>(entreCalle);
    }
    if (!nullToAbsent || colonia != null) {
      map['colonia'] = Variable<String>(colonia);
    }
    if (!nullToAbsent || numeroExterior != null) {
      map['numero_exterior'] = Variable<String>(numeroExterior);
    }
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  VentasCompanion toCompanion(bool nullToAbsent) {
    return VentasCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      fechaVenta: Value(fechaVenta),
      total: Value(total),
      metodoPago: Value(metodoPago),
      estado: Value(estado),
      tipoOrden: Value(tipoOrden),
      mesaNumero: mesaNumero == null && nullToAbsent
          ? const Value.absent()
          : Value(mesaNumero),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      calle: calle == null && nullToAbsent
          ? const Value.absent()
          : Value(calle),
      entreCalle: entreCalle == null && nullToAbsent
          ? const Value.absent()
          : Value(entreCalle),
      colonia: colonia == null && nullToAbsent
          ? const Value.absent()
          : Value(colonia),
      numeroExterior: numeroExterior == null && nullToAbsent
          ? const Value.absent()
          : Value(numeroExterior),
      notas: notas == null && nullToAbsent
          ? const Value.absent()
          : Value(notas),
      creadoEn: Value(creadoEn),
    );
  }

  factory Venta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venta(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      fechaVenta: serializer.fromJson<DateTime>(json['fechaVenta']),
      total: serializer.fromJson<int>(json['total']),
      metodoPago: serializer.fromJson<MetodoPago>(json['metodoPago']),
      estado: serializer.fromJson<EstadoVenta>(json['estado']),
      tipoOrden: serializer.fromJson<TipoOrden>(json['tipoOrden']),
      mesaNumero: serializer.fromJson<int?>(json['mesaNumero']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      calle: serializer.fromJson<String?>(json['calle']),
      entreCalle: serializer.fromJson<String?>(json['entreCalle']),
      colonia: serializer.fromJson<String?>(json['colonia']),
      numeroExterior: serializer.fromJson<String?>(json['numeroExterior']),
      notas: serializer.fromJson<String?>(json['notas']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'fechaVenta': serializer.toJson<DateTime>(fechaVenta),
      'total': serializer.toJson<int>(total),
      'metodoPago': serializer.toJson<MetodoPago>(metodoPago),
      'estado': serializer.toJson<EstadoVenta>(estado),
      'tipoOrden': serializer.toJson<TipoOrden>(tipoOrden),
      'mesaNumero': serializer.toJson<int?>(mesaNumero),
      'telefono': serializer.toJson<String?>(telefono),
      'calle': serializer.toJson<String?>(calle),
      'entreCalle': serializer.toJson<String?>(entreCalle),
      'colonia': serializer.toJson<String?>(colonia),
      'numeroExterior': serializer.toJson<String?>(numeroExterior),
      'notas': serializer.toJson<String?>(notas),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  Venta copyWith({
    int? id,
    int? usuarioId,
    DateTime? fechaVenta,
    int? total,
    MetodoPago? metodoPago,
    EstadoVenta? estado,
    TipoOrden? tipoOrden,
    Value<int?> mesaNumero = const Value.absent(),
    Value<String?> telefono = const Value.absent(),
    Value<String?> calle = const Value.absent(),
    Value<String?> entreCalle = const Value.absent(),
    Value<String?> colonia = const Value.absent(),
    Value<String?> numeroExterior = const Value.absent(),
    Value<String?> notas = const Value.absent(),
    DateTime? creadoEn,
  }) => Venta(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    fechaVenta: fechaVenta ?? this.fechaVenta,
    total: total ?? this.total,
    metodoPago: metodoPago ?? this.metodoPago,
    estado: estado ?? this.estado,
    tipoOrden: tipoOrden ?? this.tipoOrden,
    mesaNumero: mesaNumero.present ? mesaNumero.value : this.mesaNumero,
    telefono: telefono.present ? telefono.value : this.telefono,
    calle: calle.present ? calle.value : this.calle,
    entreCalle: entreCalle.present ? entreCalle.value : this.entreCalle,
    colonia: colonia.present ? colonia.value : this.colonia,
    numeroExterior: numeroExterior.present
        ? numeroExterior.value
        : this.numeroExterior,
    notas: notas.present ? notas.value : this.notas,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  Venta copyWithCompanion(VentasCompanion data) {
    return Venta(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      fechaVenta: data.fechaVenta.present
          ? data.fechaVenta.value
          : this.fechaVenta,
      total: data.total.present ? data.total.value : this.total,
      metodoPago: data.metodoPago.present
          ? data.metodoPago.value
          : this.metodoPago,
      estado: data.estado.present ? data.estado.value : this.estado,
      tipoOrden: data.tipoOrden.present ? data.tipoOrden.value : this.tipoOrden,
      mesaNumero: data.mesaNumero.present
          ? data.mesaNumero.value
          : this.mesaNumero,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      calle: data.calle.present ? data.calle.value : this.calle,
      entreCalle: data.entreCalle.present
          ? data.entreCalle.value
          : this.entreCalle,
      colonia: data.colonia.present ? data.colonia.value : this.colonia,
      numeroExterior: data.numeroExterior.present
          ? data.numeroExterior.value
          : this.numeroExterior,
      notas: data.notas.present ? data.notas.value : this.notas,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Venta(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('fechaVenta: $fechaVenta, ')
          ..write('total: $total, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('estado: $estado, ')
          ..write('tipoOrden: $tipoOrden, ')
          ..write('mesaNumero: $mesaNumero, ')
          ..write('telefono: $telefono, ')
          ..write('calle: $calle, ')
          ..write('entreCalle: $entreCalle, ')
          ..write('colonia: $colonia, ')
          ..write('numeroExterior: $numeroExterior, ')
          ..write('notas: $notas, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    usuarioId,
    fechaVenta,
    total,
    metodoPago,
    estado,
    tipoOrden,
    mesaNumero,
    telefono,
    calle,
    entreCalle,
    colonia,
    numeroExterior,
    notas,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venta &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.fechaVenta == this.fechaVenta &&
          other.total == this.total &&
          other.metodoPago == this.metodoPago &&
          other.estado == this.estado &&
          other.tipoOrden == this.tipoOrden &&
          other.mesaNumero == this.mesaNumero &&
          other.telefono == this.telefono &&
          other.calle == this.calle &&
          other.entreCalle == this.entreCalle &&
          other.colonia == this.colonia &&
          other.numeroExterior == this.numeroExterior &&
          other.notas == this.notas &&
          other.creadoEn == this.creadoEn);
}

class VentasCompanion extends UpdateCompanion<Venta> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<DateTime> fechaVenta;
  final Value<int> total;
  final Value<MetodoPago> metodoPago;
  final Value<EstadoVenta> estado;
  final Value<TipoOrden> tipoOrden;
  final Value<int?> mesaNumero;
  final Value<String?> telefono;
  final Value<String?> calle;
  final Value<String?> entreCalle;
  final Value<String?> colonia;
  final Value<String?> numeroExterior;
  final Value<String?> notas;
  final Value<DateTime> creadoEn;
  const VentasCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.fechaVenta = const Value.absent(),
    this.total = const Value.absent(),
    this.metodoPago = const Value.absent(),
    this.estado = const Value.absent(),
    this.tipoOrden = const Value.absent(),
    this.mesaNumero = const Value.absent(),
    this.telefono = const Value.absent(),
    this.calle = const Value.absent(),
    this.entreCalle = const Value.absent(),
    this.colonia = const Value.absent(),
    this.numeroExterior = const Value.absent(),
    this.notas = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  VentasCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    this.fechaVenta = const Value.absent(),
    required int total,
    required MetodoPago metodoPago,
    this.estado = const Value.absent(),
    this.tipoOrden = const Value.absent(),
    this.mesaNumero = const Value.absent(),
    this.telefono = const Value.absent(),
    this.calle = const Value.absent(),
    this.entreCalle = const Value.absent(),
    this.colonia = const Value.absent(),
    this.numeroExterior = const Value.absent(),
    this.notas = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       total = Value(total),
       metodoPago = Value(metodoPago);
  static Insertable<Venta> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<DateTime>? fechaVenta,
    Expression<int>? total,
    Expression<String>? metodoPago,
    Expression<String>? estado,
    Expression<String>? tipoOrden,
    Expression<int>? mesaNumero,
    Expression<String>? telefono,
    Expression<String>? calle,
    Expression<String>? entreCalle,
    Expression<String>? colonia,
    Expression<String>? numeroExterior,
    Expression<String>? notas,
    Expression<DateTime>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (fechaVenta != null) 'fecha_venta': fechaVenta,
      if (total != null) 'total': total,
      if (metodoPago != null) 'metodo_pago': metodoPago,
      if (estado != null) 'estado': estado,
      if (tipoOrden != null) 'tipo_orden': tipoOrden,
      if (mesaNumero != null) 'mesa_numero': mesaNumero,
      if (telefono != null) 'telefono': telefono,
      if (calle != null) 'calle': calle,
      if (entreCalle != null) 'entre_calle': entreCalle,
      if (colonia != null) 'colonia': colonia,
      if (numeroExterior != null) 'numero_exterior': numeroExterior,
      if (notas != null) 'notas': notas,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  VentasCompanion copyWith({
    Value<int>? id,
    Value<int>? usuarioId,
    Value<DateTime>? fechaVenta,
    Value<int>? total,
    Value<MetodoPago>? metodoPago,
    Value<EstadoVenta>? estado,
    Value<TipoOrden>? tipoOrden,
    Value<int?>? mesaNumero,
    Value<String?>? telefono,
    Value<String?>? calle,
    Value<String?>? entreCalle,
    Value<String?>? colonia,
    Value<String?>? numeroExterior,
    Value<String?>? notas,
    Value<DateTime>? creadoEn,
  }) {
    return VentasCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      fechaVenta: fechaVenta ?? this.fechaVenta,
      total: total ?? this.total,
      metodoPago: metodoPago ?? this.metodoPago,
      estado: estado ?? this.estado,
      tipoOrden: tipoOrden ?? this.tipoOrden,
      mesaNumero: mesaNumero ?? this.mesaNumero,
      telefono: telefono ?? this.telefono,
      calle: calle ?? this.calle,
      entreCalle: entreCalle ?? this.entreCalle,
      colonia: colonia ?? this.colonia,
      numeroExterior: numeroExterior ?? this.numeroExterior,
      notas: notas ?? this.notas,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (fechaVenta.present) {
      map['fecha_venta'] = Variable<DateTime>(fechaVenta.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (metodoPago.present) {
      map['metodo_pago'] = Variable<String>(
        $VentasTable.$convertermetodoPago.toSql(metodoPago.value),
      );
    }
    if (estado.present) {
      map['estado'] = Variable<String>(
        $VentasTable.$converterestado.toSql(estado.value),
      );
    }
    if (tipoOrden.present) {
      map['tipo_orden'] = Variable<String>(
        $VentasTable.$convertertipoOrden.toSql(tipoOrden.value),
      );
    }
    if (mesaNumero.present) {
      map['mesa_numero'] = Variable<int>(mesaNumero.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (calle.present) {
      map['calle'] = Variable<String>(calle.value);
    }
    if (entreCalle.present) {
      map['entre_calle'] = Variable<String>(entreCalle.value);
    }
    if (colonia.present) {
      map['colonia'] = Variable<String>(colonia.value);
    }
    if (numeroExterior.present) {
      map['numero_exterior'] = Variable<String>(numeroExterior.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentasCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('fechaVenta: $fechaVenta, ')
          ..write('total: $total, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('estado: $estado, ')
          ..write('tipoOrden: $tipoOrden, ')
          ..write('mesaNumero: $mesaNumero, ')
          ..write('telefono: $telefono, ')
          ..write('calle: $calle, ')
          ..write('entreCalle: $entreCalle, ')
          ..write('colonia: $colonia, ')
          ..write('numeroExterior: $numeroExterior, ')
          ..write('notas: $notas, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $DetallesVentaTable extends DetallesVenta
    with TableInfo<$DetallesVentaTable, DetallesVentaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetallesVentaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ventaIdMeta = const VerificationMeta(
    'ventaId',
  );
  @override
  late final GeneratedColumn<int> ventaId = GeneratedColumn<int>(
    'venta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ventas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES productos (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioHistoricoMeta = const VerificationMeta(
    'precioHistorico',
  );
  @override
  late final GeneratedColumn<int> precioHistorico = GeneratedColumn<int>(
    'precio_historico',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ventaId,
    productoId,
    cantidad,
    precioHistorico,
    subtotal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detalles_venta';
  @override
  VerificationContext validateIntegrity(
    Insertable<DetallesVentaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('venta_id')) {
      context.handle(
        _ventaIdMeta,
        ventaId.isAcceptableOrUnknown(data['venta_id']!, _ventaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ventaIdMeta);
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_historico')) {
      context.handle(
        _precioHistoricoMeta,
        precioHistorico.isAcceptableOrUnknown(
          data['precio_historico']!,
          _precioHistoricoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioHistoricoMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetallesVentaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetallesVentaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ventaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}venta_id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      precioHistorico: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_historico'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
    );
  }

  @override
  $DetallesVentaTable createAlias(String alias) {
    return $DetallesVentaTable(attachedDatabase, alias);
  }
}

class DetallesVentaData extends DataClass
    implements Insertable<DetallesVentaData> {
  final int id;
  final int ventaId;
  final int productoId;

  /// Cantidad fraccionada (KG) o entera (piezas).
  final double cantidad;

  /// Precio unitario en centavos al momento de la venta.
  final int precioHistorico;

  /// Subtotal en centavos (cantidad × precio, redondeado).
  final int subtotal;
  const DetallesVentaData({
    required this.id,
    required this.ventaId,
    required this.productoId,
    required this.cantidad,
    required this.precioHistorico,
    required this.subtotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['venta_id'] = Variable<int>(ventaId);
    map['producto_id'] = Variable<int>(productoId);
    map['cantidad'] = Variable<double>(cantidad);
    map['precio_historico'] = Variable<int>(precioHistorico);
    map['subtotal'] = Variable<int>(subtotal);
    return map;
  }

  DetallesVentaCompanion toCompanion(bool nullToAbsent) {
    return DetallesVentaCompanion(
      id: Value(id),
      ventaId: Value(ventaId),
      productoId: Value(productoId),
      cantidad: Value(cantidad),
      precioHistorico: Value(precioHistorico),
      subtotal: Value(subtotal),
    );
  }

  factory DetallesVentaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetallesVentaData(
      id: serializer.fromJson<int>(json['id']),
      ventaId: serializer.fromJson<int>(json['ventaId']),
      productoId: serializer.fromJson<int>(json['productoId']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      precioHistorico: serializer.fromJson<int>(json['precioHistorico']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ventaId': serializer.toJson<int>(ventaId),
      'productoId': serializer.toJson<int>(productoId),
      'cantidad': serializer.toJson<double>(cantidad),
      'precioHistorico': serializer.toJson<int>(precioHistorico),
      'subtotal': serializer.toJson<int>(subtotal),
    };
  }

  DetallesVentaData copyWith({
    int? id,
    int? ventaId,
    int? productoId,
    double? cantidad,
    int? precioHistorico,
    int? subtotal,
  }) => DetallesVentaData(
    id: id ?? this.id,
    ventaId: ventaId ?? this.ventaId,
    productoId: productoId ?? this.productoId,
    cantidad: cantidad ?? this.cantidad,
    precioHistorico: precioHistorico ?? this.precioHistorico,
    subtotal: subtotal ?? this.subtotal,
  );
  DetallesVentaData copyWithCompanion(DetallesVentaCompanion data) {
    return DetallesVentaData(
      id: data.id.present ? data.id.value : this.id,
      ventaId: data.ventaId.present ? data.ventaId.value : this.ventaId,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioHistorico: data.precioHistorico.present
          ? data.precioHistorico.value
          : this.precioHistorico,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetallesVentaData(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('productoId: $productoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioHistorico: $precioHistorico, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ventaId, productoId, cantidad, precioHistorico, subtotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetallesVentaData &&
          other.id == this.id &&
          other.ventaId == this.ventaId &&
          other.productoId == this.productoId &&
          other.cantidad == this.cantidad &&
          other.precioHistorico == this.precioHistorico &&
          other.subtotal == this.subtotal);
}

class DetallesVentaCompanion extends UpdateCompanion<DetallesVentaData> {
  final Value<int> id;
  final Value<int> ventaId;
  final Value<int> productoId;
  final Value<double> cantidad;
  final Value<int> precioHistorico;
  final Value<int> subtotal;
  const DetallesVentaCompanion({
    this.id = const Value.absent(),
    this.ventaId = const Value.absent(),
    this.productoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioHistorico = const Value.absent(),
    this.subtotal = const Value.absent(),
  });
  DetallesVentaCompanion.insert({
    this.id = const Value.absent(),
    required int ventaId,
    required int productoId,
    required double cantidad,
    required int precioHistorico,
    required int subtotal,
  }) : ventaId = Value(ventaId),
       productoId = Value(productoId),
       cantidad = Value(cantidad),
       precioHistorico = Value(precioHistorico),
       subtotal = Value(subtotal);
  static Insertable<DetallesVentaData> custom({
    Expression<int>? id,
    Expression<int>? ventaId,
    Expression<int>? productoId,
    Expression<double>? cantidad,
    Expression<int>? precioHistorico,
    Expression<int>? subtotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ventaId != null) 'venta_id': ventaId,
      if (productoId != null) 'producto_id': productoId,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioHistorico != null) 'precio_historico': precioHistorico,
      if (subtotal != null) 'subtotal': subtotal,
    });
  }

  DetallesVentaCompanion copyWith({
    Value<int>? id,
    Value<int>? ventaId,
    Value<int>? productoId,
    Value<double>? cantidad,
    Value<int>? precioHistorico,
    Value<int>? subtotal,
  }) {
    return DetallesVentaCompanion(
      id: id ?? this.id,
      ventaId: ventaId ?? this.ventaId,
      productoId: productoId ?? this.productoId,
      cantidad: cantidad ?? this.cantidad,
      precioHistorico: precioHistorico ?? this.precioHistorico,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ventaId.present) {
      map['venta_id'] = Variable<int>(ventaId.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (precioHistorico.present) {
      map['precio_historico'] = Variable<int>(precioHistorico.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetallesVentaCompanion(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('productoId: $productoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioHistorico: $precioHistorico, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $ProductosTable productos = $ProductosTable(this);
  late final $VentasTable ventas = $VentasTable(this);
  late final $DetallesVentaTable detallesVenta = $DetallesVentaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usuarios,
    categorias,
    productos,
    ventas,
    detallesVenta,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ventas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('detalles_venta', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      required String nombre,
      required RolUsuario rol,
      required String pinAcceso,
      Value<bool> activo,
      Value<DateTime> creadoEn,
      Value<DateTime> actualizadoEn,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<RolUsuario> rol,
      Value<String> pinAcceso,
      Value<bool> activo,
      Value<DateTime> creadoEn,
      Value<DateTime> actualizadoEn,
    });

final class $$UsuariosTableReferences
    extends BaseReferences<_$LocalDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VentasTable, List<Venta>> _ventasRefsTable(
    _$LocalDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ventas,
    aliasName: $_aliasNameGenerator(db.usuarios.id, db.ventas.usuarioId),
  );

  $$VentasTableProcessedTableManager get ventasRefs {
    final manager = $$VentasTableTableManager(
      $_db,
      $_db.ventas,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ventasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$LocalDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RolUsuario, RolUsuario, String> get rol =>
      $composableBuilder(
        column: $table.rol,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get pinAcceso => $composableBuilder(
    column: $table.pinAcceso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ventasRefs(
    Expression<bool> Function($$VentasTableFilterComposer f) f,
  ) {
    final $$VentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableFilterComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$LocalDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinAcceso => $composableBuilder(
    column: $table.pinAcceso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$LocalDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RolUsuario, String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<String> get pinAcceso =>
      $composableBuilder(column: $table.pinAcceso, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );

  Expression<T> ventasRefs<T extends Object>(
    Expression<T> Function($$VentasTableAnnotationComposer a) f,
  ) {
    final $$VentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableAnnotationComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({bool ventasRefs})
        > {
  $$UsuariosTableTableManager(_$LocalDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<RolUsuario> rol = const Value.absent(),
                Value<String> pinAcceso = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                nombre: nombre,
                rol: rol,
                pinAcceso: pinAcceso,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required RolUsuario rol,
                required String pinAcceso,
                Value<bool> activo = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => UsuariosCompanion.insert(
                id: id,
                nombre: nombre,
                rol: rol,
                pinAcceso: pinAcceso,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ventasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ventasRefs) db.ventas],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ventasRefs)
                    await $_getPrefetchedData<Usuario, $UsuariosTable, Venta>(
                      currentTable: table,
                      referencedTable: $$UsuariosTableReferences
                          ._ventasRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsuariosTableReferences(db, table, p0).ventasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.usuarioId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({bool ventasRefs})
    >;
typedef $$CategoriasTableCreateCompanionBuilder =
    CategoriasCompanion Function({
      Value<int> id,
      required String nombre,
      Value<bool> activo,
      Value<int> orden,
      Value<DateTime> creadoEn,
    });
typedef $$CategoriasTableUpdateCompanionBuilder =
    CategoriasCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<bool> activo,
      Value<int> orden,
      Value<DateTime> creadoEn,
    });

final class $$CategoriasTableReferences
    extends BaseReferences<_$LocalDatabase, $CategoriasTable, Categoria> {
  $$CategoriasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductosTable, List<Producto>>
  _productosRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.productos,
    aliasName: $_aliasNameGenerator(db.categorias.id, db.productos.categoriaId),
  );

  $$ProductosTableProcessedTableManager get productosRefs {
    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.categoriaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriasTableFilterComposer
    extends Composer<_$LocalDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productosRefs(
    Expression<bool> Function($$ProductosTableFilterComposer f) f,
  ) {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$LocalDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriasTableAnnotationComposer
    extends Composer<_$LocalDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  Expression<T> productosRefs<T extends Object>(
    Expression<T> Function($$ProductosTableAnnotationComposer a) f,
  ) {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $CategoriasTable,
          Categoria,
          $$CategoriasTableFilterComposer,
          $$CategoriasTableOrderingComposer,
          $$CategoriasTableAnnotationComposer,
          $$CategoriasTableCreateCompanionBuilder,
          $$CategoriasTableUpdateCompanionBuilder,
          (Categoria, $$CategoriasTableReferences),
          Categoria,
          PrefetchHooks Function({bool productosRefs})
        > {
  $$CategoriasTableTableManager(_$LocalDatabase db, $CategoriasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => CategoriasCompanion(
                id: id,
                nombre: nombre,
                activo: activo,
                orden: orden,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<bool> activo = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => CategoriasCompanion.insert(
                id: id,
                nombre: nombre,
                activo: activo,
                orden: orden,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productosRefs) db.productos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productosRefs)
                    await $_getPrefetchedData<
                      Categoria,
                      $CategoriasTable,
                      Producto
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriasTableReferences
                          ._productosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriasTableReferences(
                            db,
                            table,
                            p0,
                          ).productosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.categoriaId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $CategoriasTable,
      Categoria,
      $$CategoriasTableFilterComposer,
      $$CategoriasTableOrderingComposer,
      $$CategoriasTableAnnotationComposer,
      $$CategoriasTableCreateCompanionBuilder,
      $$CategoriasTableUpdateCompanionBuilder,
      (Categoria, $$CategoriasTableReferences),
      Categoria,
      PrefetchHooks Function({bool productosRefs})
    >;
typedef $$ProductosTableCreateCompanionBuilder =
    ProductosCompanion Function({
      Value<int> id,
      required int categoriaId,
      required String nombre,
      required int precioUnidad,
      Value<bool> esPorPeso,
      Value<double> inventarioDisponible,
      Value<String?> imagenUrl,
      Value<bool> activo,
      Value<DateTime> creadoEn,
      Value<DateTime> actualizadoEn,
    });
typedef $$ProductosTableUpdateCompanionBuilder =
    ProductosCompanion Function({
      Value<int> id,
      Value<int> categoriaId,
      Value<String> nombre,
      Value<int> precioUnidad,
      Value<bool> esPorPeso,
      Value<double> inventarioDisponible,
      Value<String?> imagenUrl,
      Value<bool> activo,
      Value<DateTime> creadoEn,
      Value<DateTime> actualizadoEn,
    });

final class $$ProductosTableReferences
    extends BaseReferences<_$LocalDatabase, $ProductosTable, Producto> {
  $$ProductosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _categoriaIdTable(_$LocalDatabase db) =>
      db.categorias.createAlias(
        $_aliasNameGenerator(db.productos.categoriaId, db.categorias.id),
      );

  $$CategoriasTableProcessedTableManager get categoriaId {
    final $_column = $_itemColumn<int>('categoria_id')!;

    final manager = $$CategoriasTableTableManager(
      $_db,
      $_db.categorias,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoriaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DetallesVentaTable, List<DetallesVentaData>>
  _detallesVentaRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.detallesVenta,
    aliasName: $_aliasNameGenerator(
      db.productos.id,
      db.detallesVenta.productoId,
    ),
  );

  $$DetallesVentaTableProcessedTableManager get detallesVentaRefs {
    final manager = $$DetallesVentaTableTableManager(
      $_db,
      $_db.detallesVenta,
    ).filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_detallesVentaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductosTableFilterComposer
    extends Composer<_$LocalDatabase, $ProductosTable> {
  $$ProductosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioUnidad => $composableBuilder(
    column: $table.precioUnidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get esPorPeso => $composableBuilder(
    column: $table.esPorPeso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get inventarioDisponible => $composableBuilder(
    column: $table.inventarioDisponible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagenUrl => $composableBuilder(
    column: $table.imagenUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriasTableFilterComposer get categoriaId {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableFilterComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> detallesVentaRefs(
    Expression<bool> Function($$DetallesVentaTableFilterComposer f) f,
  ) {
    final $$DetallesVentaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detallesVenta,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetallesVentaTableFilterComposer(
            $db: $db,
            $table: $db.detallesVenta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductosTableOrderingComposer
    extends Composer<_$LocalDatabase, $ProductosTable> {
  $$ProductosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioUnidad => $composableBuilder(
    column: $table.precioUnidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get esPorPeso => $composableBuilder(
    column: $table.esPorPeso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get inventarioDisponible => $composableBuilder(
    column: $table.inventarioDisponible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagenUrl => $composableBuilder(
    column: $table.imagenUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriasTableOrderingComposer get categoriaId {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableOrderingComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductosTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ProductosTable> {
  $$ProductosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get precioUnidad => $composableBuilder(
    column: $table.precioUnidad,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get esPorPeso =>
      $composableBuilder(column: $table.esPorPeso, builder: (column) => column);

  GeneratedColumn<double> get inventarioDisponible => $composableBuilder(
    column: $table.inventarioDisponible,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagenUrl =>
      $composableBuilder(column: $table.imagenUrl, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );

  $$CategoriasTableAnnotationComposer get categoriaId {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> detallesVentaRefs<T extends Object>(
    Expression<T> Function($$DetallesVentaTableAnnotationComposer a) f,
  ) {
    final $$DetallesVentaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detallesVenta,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetallesVentaTableAnnotationComposer(
            $db: $db,
            $table: $db.detallesVenta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductosTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ProductosTable,
          Producto,
          $$ProductosTableFilterComposer,
          $$ProductosTableOrderingComposer,
          $$ProductosTableAnnotationComposer,
          $$ProductosTableCreateCompanionBuilder,
          $$ProductosTableUpdateCompanionBuilder,
          (Producto, $$ProductosTableReferences),
          Producto,
          PrefetchHooks Function({bool categoriaId, bool detallesVentaRefs})
        > {
  $$ProductosTableTableManager(_$LocalDatabase db, $ProductosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoriaId = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> precioUnidad = const Value.absent(),
                Value<bool> esPorPeso = const Value.absent(),
                Value<double> inventarioDisponible = const Value.absent(),
                Value<String?> imagenUrl = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => ProductosCompanion(
                id: id,
                categoriaId: categoriaId,
                nombre: nombre,
                precioUnidad: precioUnidad,
                esPorPeso: esPorPeso,
                inventarioDisponible: inventarioDisponible,
                imagenUrl: imagenUrl,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoriaId,
                required String nombre,
                required int precioUnidad,
                Value<bool> esPorPeso = const Value.absent(),
                Value<double> inventarioDisponible = const Value.absent(),
                Value<String?> imagenUrl = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => ProductosCompanion.insert(
                id: id,
                categoriaId: categoriaId,
                nombre: nombre,
                precioUnidad: precioUnidad,
                esPorPeso: esPorPeso,
                inventarioDisponible: inventarioDisponible,
                imagenUrl: imagenUrl,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoriaId = false, detallesVentaRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (detallesVentaRefs) db.detallesVenta,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoriaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoriaId,
                                    referencedTable: $$ProductosTableReferences
                                        ._categoriaIdTable(db),
                                    referencedColumn: $$ProductosTableReferences
                                        ._categoriaIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (detallesVentaRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          DetallesVentaData
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._detallesVentaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).detallesVentaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductosTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ProductosTable,
      Producto,
      $$ProductosTableFilterComposer,
      $$ProductosTableOrderingComposer,
      $$ProductosTableAnnotationComposer,
      $$ProductosTableCreateCompanionBuilder,
      $$ProductosTableUpdateCompanionBuilder,
      (Producto, $$ProductosTableReferences),
      Producto,
      PrefetchHooks Function({bool categoriaId, bool detallesVentaRefs})
    >;
typedef $$VentasTableCreateCompanionBuilder =
    VentasCompanion Function({
      Value<int> id,
      required int usuarioId,
      Value<DateTime> fechaVenta,
      required int total,
      required MetodoPago metodoPago,
      Value<EstadoVenta> estado,
      Value<TipoOrden> tipoOrden,
      Value<int?> mesaNumero,
      Value<String?> telefono,
      Value<String?> calle,
      Value<String?> entreCalle,
      Value<String?> colonia,
      Value<String?> numeroExterior,
      Value<String?> notas,
      Value<DateTime> creadoEn,
    });
typedef $$VentasTableUpdateCompanionBuilder =
    VentasCompanion Function({
      Value<int> id,
      Value<int> usuarioId,
      Value<DateTime> fechaVenta,
      Value<int> total,
      Value<MetodoPago> metodoPago,
      Value<EstadoVenta> estado,
      Value<TipoOrden> tipoOrden,
      Value<int?> mesaNumero,
      Value<String?> telefono,
      Value<String?> calle,
      Value<String?> entreCalle,
      Value<String?> colonia,
      Value<String?> numeroExterior,
      Value<String?> notas,
      Value<DateTime> creadoEn,
    });

final class $$VentasTableReferences
    extends BaseReferences<_$LocalDatabase, $VentasTable, Venta> {
  $$VentasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _usuarioIdTable(_$LocalDatabase db) => db.usuarios
      .createAlias($_aliasNameGenerator(db.ventas.usuarioId, db.usuarios.id));

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DetallesVentaTable, List<DetallesVentaData>>
  _detallesVentaRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.detallesVenta,
    aliasName: $_aliasNameGenerator(db.ventas.id, db.detallesVenta.ventaId),
  );

  $$DetallesVentaTableProcessedTableManager get detallesVentaRefs {
    final manager = $$DetallesVentaTableTableManager(
      $_db,
      $_db.detallesVenta,
    ).filter((f) => f.ventaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_detallesVentaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VentasTableFilterComposer
    extends Composer<_$LocalDatabase, $VentasTable> {
  $$VentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaVenta => $composableBuilder(
    column: $table.fechaVenta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MetodoPago, MetodoPago, String>
  get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<EstadoVenta, EstadoVenta, String> get estado =>
      $composableBuilder(
        column: $table.estado,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TipoOrden, TipoOrden, String> get tipoOrden =>
      $composableBuilder(
        column: $table.tipoOrden,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get mesaNumero => $composableBuilder(
    column: $table.mesaNumero,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calle => $composableBuilder(
    column: $table.calle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entreCalle => $composableBuilder(
    column: $table.entreCalle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colonia => $composableBuilder(
    column: $table.colonia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numeroExterior => $composableBuilder(
    column: $table.numeroExterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> detallesVentaRefs(
    Expression<bool> Function($$DetallesVentaTableFilterComposer f) f,
  ) {
    final $$DetallesVentaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detallesVenta,
      getReferencedColumn: (t) => t.ventaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetallesVentaTableFilterComposer(
            $db: $db,
            $table: $db.detallesVenta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VentasTableOrderingComposer
    extends Composer<_$LocalDatabase, $VentasTable> {
  $$VentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaVenta => $composableBuilder(
    column: $table.fechaVenta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoOrden => $composableBuilder(
    column: $table.tipoOrden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mesaNumero => $composableBuilder(
    column: $table.mesaNumero,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calle => $composableBuilder(
    column: $table.calle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entreCalle => $composableBuilder(
    column: $table.entreCalle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colonia => $composableBuilder(
    column: $table.colonia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeroExterior => $composableBuilder(
    column: $table.numeroExterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VentasTableAnnotationComposer
    extends Composer<_$LocalDatabase, $VentasTable> {
  $$VentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaVenta => $composableBuilder(
    column: $table.fechaVenta,
    builder: (column) => column,
  );

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MetodoPago, String> get metodoPago =>
      $composableBuilder(
        column: $table.metodoPago,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<EstadoVenta, String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoOrden, String> get tipoOrden =>
      $composableBuilder(column: $table.tipoOrden, builder: (column) => column);

  GeneratedColumn<int> get mesaNumero => $composableBuilder(
    column: $table.mesaNumero,
    builder: (column) => column,
  );

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get calle =>
      $composableBuilder(column: $table.calle, builder: (column) => column);

  GeneratedColumn<String> get entreCalle => $composableBuilder(
    column: $table.entreCalle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colonia =>
      $composableBuilder(column: $table.colonia, builder: (column) => column);

  GeneratedColumn<String> get numeroExterior => $composableBuilder(
    column: $table.numeroExterior,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> detallesVentaRefs<T extends Object>(
    Expression<T> Function($$DetallesVentaTableAnnotationComposer a) f,
  ) {
    final $$DetallesVentaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detallesVenta,
      getReferencedColumn: (t) => t.ventaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetallesVentaTableAnnotationComposer(
            $db: $db,
            $table: $db.detallesVenta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VentasTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $VentasTable,
          Venta,
          $$VentasTableFilterComposer,
          $$VentasTableOrderingComposer,
          $$VentasTableAnnotationComposer,
          $$VentasTableCreateCompanionBuilder,
          $$VentasTableUpdateCompanionBuilder,
          (Venta, $$VentasTableReferences),
          Venta,
          PrefetchHooks Function({bool usuarioId, bool detallesVentaRefs})
        > {
  $$VentasTableTableManager(_$LocalDatabase db, $VentasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<DateTime> fechaVenta = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<MetodoPago> metodoPago = const Value.absent(),
                Value<EstadoVenta> estado = const Value.absent(),
                Value<TipoOrden> tipoOrden = const Value.absent(),
                Value<int?> mesaNumero = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> calle = const Value.absent(),
                Value<String?> entreCalle = const Value.absent(),
                Value<String?> colonia = const Value.absent(),
                Value<String?> numeroExterior = const Value.absent(),
                Value<String?> notas = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => VentasCompanion(
                id: id,
                usuarioId: usuarioId,
                fechaVenta: fechaVenta,
                total: total,
                metodoPago: metodoPago,
                estado: estado,
                tipoOrden: tipoOrden,
                mesaNumero: mesaNumero,
                telefono: telefono,
                calle: calle,
                entreCalle: entreCalle,
                colonia: colonia,
                numeroExterior: numeroExterior,
                notas: notas,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int usuarioId,
                Value<DateTime> fechaVenta = const Value.absent(),
                required int total,
                required MetodoPago metodoPago,
                Value<EstadoVenta> estado = const Value.absent(),
                Value<TipoOrden> tipoOrden = const Value.absent(),
                Value<int?> mesaNumero = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> calle = const Value.absent(),
                Value<String?> entreCalle = const Value.absent(),
                Value<String?> colonia = const Value.absent(),
                Value<String?> numeroExterior = const Value.absent(),
                Value<String?> notas = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => VentasCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                fechaVenta: fechaVenta,
                total: total,
                metodoPago: metodoPago,
                estado: estado,
                tipoOrden: tipoOrden,
                mesaNumero: mesaNumero,
                telefono: telefono,
                calle: calle,
                entreCalle: entreCalle,
                colonia: colonia,
                numeroExterior: numeroExterior,
                notas: notas,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VentasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({usuarioId = false, detallesVentaRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (detallesVentaRefs) db.detallesVenta,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (usuarioId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.usuarioId,
                                    referencedTable: $$VentasTableReferences
                                        ._usuarioIdTable(db),
                                    referencedColumn: $$VentasTableReferences
                                        ._usuarioIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (detallesVentaRefs)
                        await $_getPrefetchedData<
                          Venta,
                          $VentasTable,
                          DetallesVentaData
                        >(
                          currentTable: table,
                          referencedTable: $$VentasTableReferences
                              ._detallesVentaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VentasTableReferences(
                                db,
                                table,
                                p0,
                              ).detallesVentaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ventaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VentasTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $VentasTable,
      Venta,
      $$VentasTableFilterComposer,
      $$VentasTableOrderingComposer,
      $$VentasTableAnnotationComposer,
      $$VentasTableCreateCompanionBuilder,
      $$VentasTableUpdateCompanionBuilder,
      (Venta, $$VentasTableReferences),
      Venta,
      PrefetchHooks Function({bool usuarioId, bool detallesVentaRefs})
    >;
typedef $$DetallesVentaTableCreateCompanionBuilder =
    DetallesVentaCompanion Function({
      Value<int> id,
      required int ventaId,
      required int productoId,
      required double cantidad,
      required int precioHistorico,
      required int subtotal,
    });
typedef $$DetallesVentaTableUpdateCompanionBuilder =
    DetallesVentaCompanion Function({
      Value<int> id,
      Value<int> ventaId,
      Value<int> productoId,
      Value<double> cantidad,
      Value<int> precioHistorico,
      Value<int> subtotal,
    });

final class $$DetallesVentaTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $DetallesVentaTable,
          DetallesVentaData
        > {
  $$DetallesVentaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VentasTable _ventaIdTable(_$LocalDatabase db) =>
      db.ventas.createAlias(
        $_aliasNameGenerator(db.detallesVenta.ventaId, db.ventas.id),
      );

  $$VentasTableProcessedTableManager get ventaId {
    final $_column = $_itemColumn<int>('venta_id')!;

    final manager = $$VentasTableTableManager(
      $_db,
      $_db.ventas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ventaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductosTable _productoIdTable(_$LocalDatabase db) =>
      db.productos.createAlias(
        $_aliasNameGenerator(db.detallesVenta.productoId, db.productos.id),
      );

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DetallesVentaTableFilterComposer
    extends Composer<_$LocalDatabase, $DetallesVentaTable> {
  $$DetallesVentaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioHistorico => $composableBuilder(
    column: $table.precioHistorico,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  $$VentasTableFilterComposer get ventaId {
    final $$VentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableFilterComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetallesVentaTableOrderingComposer
    extends Composer<_$LocalDatabase, $DetallesVentaTable> {
  $$DetallesVentaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioHistorico => $composableBuilder(
    column: $table.precioHistorico,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  $$VentasTableOrderingComposer get ventaId {
    final $$VentasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableOrderingComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetallesVentaTableAnnotationComposer
    extends Composer<_$LocalDatabase, $DetallesVentaTable> {
  $$DetallesVentaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<int> get precioHistorico => $composableBuilder(
    column: $table.precioHistorico,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  $$VentasTableAnnotationComposer get ventaId {
    final $$VentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableAnnotationComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetallesVentaTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $DetallesVentaTable,
          DetallesVentaData,
          $$DetallesVentaTableFilterComposer,
          $$DetallesVentaTableOrderingComposer,
          $$DetallesVentaTableAnnotationComposer,
          $$DetallesVentaTableCreateCompanionBuilder,
          $$DetallesVentaTableUpdateCompanionBuilder,
          (DetallesVentaData, $$DetallesVentaTableReferences),
          DetallesVentaData,
          PrefetchHooks Function({bool ventaId, bool productoId})
        > {
  $$DetallesVentaTableTableManager(
    _$LocalDatabase db,
    $DetallesVentaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DetallesVentaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DetallesVentaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DetallesVentaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ventaId = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<int> precioHistorico = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
              }) => DetallesVentaCompanion(
                id: id,
                ventaId: ventaId,
                productoId: productoId,
                cantidad: cantidad,
                precioHistorico: precioHistorico,
                subtotal: subtotal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ventaId,
                required int productoId,
                required double cantidad,
                required int precioHistorico,
                required int subtotal,
              }) => DetallesVentaCompanion.insert(
                id: id,
                ventaId: ventaId,
                productoId: productoId,
                cantidad: cantidad,
                precioHistorico: precioHistorico,
                subtotal: subtotal,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DetallesVentaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ventaId = false, productoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ventaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ventaId,
                                referencedTable: $$DetallesVentaTableReferences
                                    ._ventaIdTable(db),
                                referencedColumn: $$DetallesVentaTableReferences
                                    ._ventaIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productoId,
                                referencedTable: $$DetallesVentaTableReferences
                                    ._productoIdTable(db),
                                referencedColumn: $$DetallesVentaTableReferences
                                    ._productoIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DetallesVentaTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $DetallesVentaTable,
      DetallesVentaData,
      $$DetallesVentaTableFilterComposer,
      $$DetallesVentaTableOrderingComposer,
      $$DetallesVentaTableAnnotationComposer,
      $$DetallesVentaTableCreateCompanionBuilder,
      $$DetallesVentaTableUpdateCompanionBuilder,
      (DetallesVentaData, $$DetallesVentaTableReferences),
      DetallesVentaData,
      PrefetchHooks Function({bool ventaId, bool productoId})
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db, _db.productos);
  $$VentasTableTableManager get ventas =>
      $$VentasTableTableManager(_db, _db.ventas);
  $$DetallesVentaTableTableManager get detallesVenta =>
      $$DetallesVentaTableTableManager(_db, _db.detallesVenta);
}
