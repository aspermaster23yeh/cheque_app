-- =============================================================================
-- carnitas_cheque — Esquema SQLite (Fase 1: Local-Only)
-- =============================================================================
-- Convenciones de tipos:
--   • Dinero  → INTEGER almacenado en CENTAVOS (ej. $150.50 MXN = 15050).
--               Nunca usar REAL/DOUBLE para montos financieros.
--   • Peso    → REAL con precisión suficiente para fracciones de KG (0.250).
--   • Fechas  → INTEGER Unix epoch en milisegundos (compatible con Drift).
--   • Boolean → INTEGER CHECK (0 = false, 1 = true).
-- =============================================================================

PRAGMA foreign_keys = ON;

-- -----------------------------------------------------------------------------
-- usuarios
-- Roles: admin (estadísticas + venta), vendedor (solo venta).
-- pin_acceso: hash SHA-256 del PIN (nunca almacenar PIN en texto plano).
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT    NOT NULL,
    rol           TEXT    NOT NULL CHECK (rol IN ('admin', 'vendedor')),
    pin_acceso    TEXT    NOT NULL,
    activo        INTEGER NOT NULL DEFAULT 1 CHECK (activo IN (0, 1)),
    creado_en     INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER) * 1000),
    actualizado_en INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER) * 1000)
);

CREATE INDEX IF NOT EXISTS idx_usuarios_rol ON usuarios (rol);
CREATE INDEX IF NOT EXISTS idx_usuarios_activo ON usuarios (activo);

-- -----------------------------------------------------------------------------
-- categorias
-- Agrupa productos: Carnitas, Tacos, Tortas, Bebidas, etc.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS categorias (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT    NOT NULL UNIQUE,
    activo        INTEGER NOT NULL DEFAULT 1 CHECK (activo IN (0, 1)),
    orden         INTEGER NOT NULL DEFAULT 0,
    creado_en     INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER) * 1000)
);

CREATE INDEX IF NOT EXISTS idx_categorias_activo_orden ON categorias (activo, orden);

-- -----------------------------------------------------------------------------
-- productos
-- precio_unidad: centavos por unidad o por kilogramo según es_por_peso.
-- inventario_disponible: REAL — KG si es_por_peso=1, piezas si es_por_peso=0.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS productos (
    id                     INTEGER PRIMARY KEY AUTOINCREMENT,
    categoria_id           INTEGER NOT NULL,
    nombre                 TEXT    NOT NULL,
    precio_unidad          INTEGER NOT NULL CHECK (precio_unidad >= 0),
    es_por_peso            INTEGER NOT NULL DEFAULT 0 CHECK (es_por_peso IN (0, 1)),
    inventario_disponible  REAL    NOT NULL DEFAULT 0 CHECK (inventario_disponible >= 0),
    imagen_url             TEXT,
    activo                 INTEGER NOT NULL DEFAULT 1 CHECK (activo IN (0, 1)),
    creado_en              INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER) * 1000),
    actualizado_en         INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER) * 1000),
    FOREIGN KEY (categoria_id) REFERENCES categorias (id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_productos_categoria ON productos (categoria_id);
CREATE INDEX IF NOT EXISTS idx_productos_activo ON productos (activo);
CREATE INDEX IF NOT EXISTS idx_productos_categoria_activo ON productos (categoria_id, activo);

-- -----------------------------------------------------------------------------
-- ventas
-- total: centavos. Se calcula como SUM(detalles_venta.subtotal).
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ventas (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id    INTEGER NOT NULL,
    fecha_venta   INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER) * 1000),
    total         INTEGER NOT NULL CHECK (total >= 0),
    metodo_pago   TEXT    NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia')),
    estado        TEXT    NOT NULL DEFAULT 'completado' CHECK (estado IN ('completado', 'cancelado')),
    notas         TEXT,
    creado_en     INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER) * 1000),
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_ventas_usuario ON ventas (usuario_id);
CREATE INDEX IF NOT EXISTS idx_ventas_fecha ON ventas (fecha_venta);
CREATE INDEX IF NOT EXISTS idx_ventas_estado_fecha ON ventas (estado, fecha_venta);

-- -----------------------------------------------------------------------------
-- detalles_venta
-- cantidad: REAL para soportar fracciones de KG (ej. 0.250, 1.750).
-- precio_historico / subtotal: centavos al momento de la venta (inmutables).
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS detalles_venta (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    venta_id         INTEGER NOT NULL,
    producto_id      INTEGER NOT NULL,
    cantidad         REAL    NOT NULL CHECK (cantidad > 0),
    precio_historico INTEGER NOT NULL CHECK (precio_historico >= 0),
    subtotal         INTEGER NOT NULL CHECK (subtotal >= 0),
    FOREIGN KEY (venta_id) REFERENCES ventas (id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_detalles_venta_venta ON detalles_venta (venta_id);
CREATE INDEX IF NOT EXISTS idx_detalles_venta_producto ON detalles_venta (producto_id);

-- -----------------------------------------------------------------------------
-- Datos semilla (desarrollo / primera instalación)
-- PIN '1234' → reemplazar con hash real en producción.
-- -----------------------------------------------------------------------------
INSERT OR IGNORE INTO usuarios (id, nombre, rol, pin_acceso) VALUES
    (1, 'Administrador', 'admin',    '2323'),
    (2, 'Vendedor',      'vendedor', '0423');

INSERT OR IGNORE INTO categorias (id, nombre, orden) VALUES
    (1, 'Carnitas',  1),
    (2, 'Tacos',     2),
    (3, 'Tortas',    3),
    (4, 'Bebidas',   4);

INSERT OR IGNORE INTO productos (id, categoria_id, nombre, precio_unidad, es_por_peso, inventario_disponible) VALUES
    (1, 1, 'Carnitas (por KG)', 28000, 1, 50.0),   -- $280.00 / KG
    (2, 1, 'Orden 1/4 KG',       7000,  0, 999.0), -- $70.00 fijo
    (3, 2, 'Taco',               2500,  0, 999.0), -- $25.00
    (4, 3, 'Torta',              6500,  0, 999.0), -- $65.00
    (5, 4, 'Refresco',           2500,  0, 999.0), -- $25.00
    (6, 4, 'Agua',               2000,  0, 999.0); -- $20.00
