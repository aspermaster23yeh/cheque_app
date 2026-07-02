# Estructura Feature-First — carnitas_cheque

```
lib/
├── main.dart                          # Entry point → App bootstrap
├── app/
│   ├── app.dart                       # MaterialApp, tema, providers globales
│   ├── router.dart                    # GoRouter / rutas por rol
│   └── di/
│       └── injection.dart             # Registro de dependencias (repos, DB)
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── usuario_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── usuario.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       └── login_with_pin.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── auth_cubit.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/
│   │       │   └── login_page.dart
│   │       └── widgets/
│   │           └── pin_pad.dart
│   │
│   ├── pos_venta/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── producto_local_datasource.dart
│   │   │   │   └── venta_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── producto_model.dart
│   │   │   │   ├── venta_model.dart
│   │   │   │   └── detalle_venta_model.dart
│   │   │   └── repositories/
│   │   │       ├── producto_repository_impl.dart
│   │   │       └── venta_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── producto.dart
│   │   │   │   ├── categoria.dart
│   │   │   │   ├── venta.dart
│   │   │   │   ├── detalle_venta.dart
│   │   │   │   └── carrito_item.dart
│   │   │   ├── repositories/
│   │   │   │   ├── producto_repository.dart
│   │   │   │   └── venta_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_productos_por_categoria.dart
│   │   │       ├── crear_venta.dart
│   │   │       └── cancelar_venta.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── pos_cubit.dart
│   │       │   ├── pos_state.dart
│   │       │   ├── carrito_cubit.dart
│   │       │   └── carrito_state.dart
│   │       ├── pages/
│   │       │   └── pos_page.dart
│   │       └── widgets/
│   │           ├── categoria_tabs.dart
│   │           ├── producto_card.dart
│   │           ├── carrito_panel.dart
│   │           └── checkout_sheet.dart
│   │
│   └── estadisticas/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── estadisticas_local_datasource.dart
│       │   ├── models/
│       │   │   └── kpi_model.dart
│       │   └── repositories/
│       │       └── estadisticas_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── kpi_resumen.dart
│       │   │   └── venta_por_hora.dart
│       │   ├── repositories/
│       │   │   └── estadisticas_repository.dart
│       │   └── usecases/
│       │       ├── get_ventas_del_dia.dart
│       │       └── get_top_productos.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── estadisticas_cubit.dart
│           │   └── estadisticas_state.dart
│           ├── pages/
│           │   └── estadisticas_page.dart
│           └── widgets/
│               ├── kpi_card.dart
│               └── ventas_chart.dart
│
└── shared/
    ├── database/
    │   ├── local_db.dart              # AppDatabase (Drift)
    │   ├── local_db.g.dart            # Generado por build_runner
    │   ├── connection/
    │   │   └── native.dart            # LazyDatabase → sqlite3 nativo
    │   └── tables/
    │       ├── usuarios.dart
    │       ├── categorias.dart
    │       ├── productos.dart
    │       ├── ventas.dart
    │       └── detalles_venta.dart
    ├── core/
    │   ├── constants/
    │   │   └── app_constants.dart
    │   ├── enums/
    │   │   ├── rol_usuario.dart
    │   │   ├── metodo_pago.dart
    │   │   └── estado_venta.dart
    │   ├── errors/
    │   │   └── failures.dart
    │   └── utils/
    │       └── money_formatter.dart   # centavos ↔ "$280.00"
    └── widgets/
        └── app_scaffold.dart

database/
└── schema.sql                         # DDL de referencia (documentación + migraciones manuales)

test/
├── features/
│   ├── auth/
│   ├── pos_venta/
│   └── estadisticas/
└── shared/
    └── database/
        └── local_db_test.dart
```

## Flujo de dependencias (Clean Architecture)

```
Presentation (Cubit/Widget)
        ↓
    Domain (UseCase → Repository interface)
        ↑
    Data (Repository impl → DataSource → Drift DAO)
```

## Convenciones

| Capa          | Responsabilidad                                      |
|---------------|------------------------------------------------------|
| `entities/`   | Objetos de negocio puros (sin dependencia de Drift)  |
| `models/`     | Mapeo Drift/JSON ↔ Entity                            |
| `datasources/`| Queries directas a SQLite vía Drift                  |
| `cubit/`      | Estado UI reactivo (flutter_bloc)                    |
