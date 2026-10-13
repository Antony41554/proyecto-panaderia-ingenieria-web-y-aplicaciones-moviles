USE PanaderiaBarriosDB;

SET NAMES utf8mb4;

-- =====================================================
-- LIMPIAR DATOS ANTERIORES
-- Permite ejecutar este script todas las veces necesarias
-- =====================================================

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM comprobante;
DELETE FROM pago;
DELETE FROM pedido_producto;
DELETE FROM pedido;

DELETE FROM carrito_producto;
DELETE FROM carrito;

DELETE FROM pack_producto;
DELETE FROM inventario;

DELETE FROM zona_disponible_envio;

DELETE FROM direccion;

DELETE FROM producto;
DELETE FROM categoria;

DELETE FROM sede;
DELETE FROM empresa;

DELETE FROM distrito;
DELETE FROM provincia;
DELETE FROM departamento;

DELETE FROM cliente;

-- Reiniciar AUTO_INCREMENT
ALTER TABLE comprobante AUTO_INCREMENT = 1;
ALTER TABLE pago AUTO_INCREMENT = 1;
ALTER TABLE pedido AUTO_INCREMENT = 1;

ALTER TABLE carrito AUTO_INCREMENT = 1;
ALTER TABLE pack_producto AUTO_INCREMENT = 1;
ALTER TABLE inventario AUTO_INCREMENT = 1;

ALTER TABLE zona_disponible_envio AUTO_INCREMENT = 1;
ALTER TABLE direccion AUTO_INCREMENT = 1;

ALTER TABLE producto AUTO_INCREMENT = 1;
ALTER TABLE categoria AUTO_INCREMENT = 1;

ALTER TABLE sede AUTO_INCREMENT = 1;
ALTER TABLE empresa AUTO_INCREMENT = 1;

ALTER TABLE distrito AUTO_INCREMENT = 1;
ALTER TABLE provincia AUTO_INCREMENT = 1;
ALTER TABLE departamento AUTO_INCREMENT = 1;

ALTER TABLE cliente AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;

START TRANSACTION;

-- =====================================================
-- UBICACIONES
-- =====================================================

INSERT INTO departamento (id_departamento, nombre) VALUES
(1, 'Tacna');

INSERT INTO provincia (id_provincia, nombre, id_departamento) VALUES
(1, 'Tacna', 1),
(2, 'Jorge Basadre', 1);

INSERT INTO distrito (id_distrito, nombre, id_provincia) VALUES
(1, 'Tacna', 1),
(2, 'Alto de la Alianza', 1),
(3, 'Ciudad Nueva', 1),
(4, 'Pocollay', 1),
(5, 'Gregorio Albarracín Lanchipa', 1),
(6, 'Locumba', 2);


-- =====================================================
-- CLIENTES
-- =====================================================
-- NOTA:
-- SHA2 funciona correctamente en MySQL.
-- Si tu aplicación usa BCrypt para autenticar,
-- reemplaza estas contraseñas por hashes BCrypt reales.
-- =====================================================

INSERT INTO cliente (
    id_cliente,
    nombre,
    apellidos,
    email,
    telefono,
    contrasenia,
    rol,
    ruc,
    razon_social
) VALUES
(
    1,
    'Administrador',
    'Panadería Barrios',
    'admin@panaderiabarrios.pe',
    '987654321',
    '$2a$10$Wu610ceqSJltj4gC0adkWOnX9sEz19vrImvfG6ik8NZA0WwV8uwUK',
    'ADMIN',
    NULL,
    NULL
),
(
    2,
    'Ana',
    'Mamani Flores',
    'ana.mamani@gmail.com',
    '912345678',
    '$2a$10$CE8YQO29Y29ZcpGHdsQev.oPkUmY/ifW5Dou/6GCL4nI8iAY0Roze',
    'CLIENTE',
    NULL,
    NULL
),
(
    3,
    'Luis',
    'Condori Quispe',
    'luis.condori@gmail.com',
    '923456789',
    '$2a$10$CE8YQO29Y29ZcpGHdsQev.oPkUmY/ifW5Dou/6GCL4nI8iAY0Roze',
    'CLIENTE',
    '20601234567',
    'Comercial Condori S.A.C.'
),
(
    4,
    'Carla',
    'Flores Vargas',
    'carla.flores@gmail.com',
    '934567890',
    '$2a$10$CE8YQO29Y29ZcpGHdsQev.oPkUmY/ifW5Dou/6GCL4nI8iAY0Roze',
    'CLIENTE',
    NULL,
    NULL
);


-- =====================================================
-- DIRECCIONES
-- =====================================================

INSERT INTO direccion (
    id_direccion,
    calle,
    numero,
    referencia,
    alias,
    id_cliente,
    id_distrito
) VALUES
(1, 'Av. Bolognesi', '1250', 'Frente al parque principal', 'Casa', 2, 1),
(2, 'Av. Industrial', '450', 'A una cuadra del mercado', 'Trabajo', 2, 2),
(3, 'Av. Jorge Basadre Grohmann', '1820', 'Costado de la farmacia', 'Oficina', 3, 1),
(4, 'Av. Municipal', '720', 'Cerca de la plaza Pérez Gamboa', 'Casa', 4, 5),
(5, 'Calle Los Álamos', '155', 'Portón de color marrón', 'Casa de padres', 4, 4);


-- =====================================================
-- EMPRESA
-- =====================================================

INSERT INTO empresa (
    id_empresa,
    nombre,
    ruc
) VALUES
(
    1,
    'Panadería Barrios S.A.C.',
    '20609876543'
);


-- =====================================================
-- SEDES
-- =====================================================

INSERT INTO sede (
    id_sede,
    nombre,
    telefono,
    id_empresa,
    id_distrito
) VALUES
(1, 'Panadería Barrios - Centro', '952111222', 1, 1),
(2, 'Panadería Barrios - Gregorio Albarracín', '952333444', 1, 5);


-- =====================================================
-- ZONAS DE ENVÍO
-- =====================================================

INSERT INTO zona_disponible_envio (
    id_zona,
    id_sede,
    id_distrito,
    costo_envio,
    monto_minimo_gratis,
    tiempo_estimado_min
) VALUES
(1, 1, 1, 4.00, 60.00, 25),
(2, 1, 2, 6.00, 80.00, 35),
(3, 1, 3, 6.00, 80.00, 40),
(4, 1, 4, 5.00, 70.00, 30),

(5, 2, 5, 4.00, 60.00, 25),
(6, 2, 1, 5.50, 75.00, 35),
(7, 2, 4, 6.00, 80.00, 40);


-- =====================================================
-- CATEGORÍAS
-- =====================================================

INSERT INTO categoria (
    id_categoria,
    nombre
) VALUES
(1, 'Panes'),
(2, 'Pastelería'),
(3, 'Salados'),
(4, 'Bebidas'),
(5, 'Packs');


-- =====================================================
-- PRODUCTOS
-- =====================================================

INSERT INTO producto (
    id_producto,
    nombre,
    descripcion,
    foto,
    precio,
    stock_minimo,
    compra_minima,
    disponible,
    id_categoria
) VALUES
(
    1,
    'Pan Francés',
    'Pan tradicional crocante por fuera y suave por dentro.',
    '/images/productos/pan_frances.jpg',
    0.50,
    30,
    6,
    TRUE,
    1
),
(
    2,
    'Pan Ciabatta',
    'Pan artesanal de corteza crujiente y miga aireada.',
    '/images/productos/pan_ciabatta.jpg',
    1.50,
    20,
    4,
    TRUE,
    1
),
(
    3,
    'Croissant de Mantequilla',
    'Croissant artesanal elaborado con mantequilla.',
    '/images/productos/croissant_mantequilla.jpg',
    3.50,
    10,
    1,
    TRUE,
    1
),
(
    4,
    'Empanada de Pollo',
    'Empanada horneada rellena de pollo sazonado.',
    '/images/productos/empanada_pollo.jpg',
    5.50,
    10,
    1,
    TRUE,
    3
),
(
    5,
    'Torta de Chocolate',
    'Torta húmeda de chocolate con cobertura de fudge.',
    '/images/productos/torta_chocolate.jpg',
    55.00,
    2,
    1,
    TRUE,
    2
),
(
    6,
    'Torta Tres Leches',
    'Bizcochuelo bañado en tres leches con crema.',
    '/images/productos/torta_tres_leches.jpg',
    60.00,
    2,
    1,
    TRUE,
    2
),
(
    7,
    'Café Americano',
    'Café americano preparado al momento.',
    '/images/productos/cafe_americano.jpg',
    6.00,
    10,
    1,
    TRUE,
    4
),
(
    8,
    'Chocolate Caliente',
    'Chocolate caliente preparado con leche.',
    '/images/productos/chocolate_caliente.jpg',
    7.00,
    10,
    1,
    TRUE,
    4
),
(
    9,
    'Pack Desayuno Familiar',
    'Pack especial para compartir en familia.',
    '/images/productos/pack_desayuno_familiar.jpg',
    30.00,
    3,
    1,
    TRUE,
    5
),
(
    10,
    'Pack Lonche',
    'Pack variado para disfrutar durante la tarde.',
    '/images/productos/pack_lonche.jpg',
    22.00,
    3,
    1,
    TRUE,
    5
);


-- =====================================================
-- PACKS
-- =====================================================

INSERT INTO pack_producto (
    id_pack_producto,
    id_pack,
    id_componente,
    cantidad
) VALUES
(1, 9, 1, 12),
(2, 9, 3, 4),
(3, 9, 7, 2),

(4, 10, 2, 4),
(5, 10, 4, 2),
(6, 10, 8, 1);


-- =====================================================
-- INVENTARIO
-- =====================================================

INSERT INTO inventario (
    id_inventario,
    id_sede,
    id_producto,
    stock,
    fecha
) VALUES
-- Sede Centro
(1, 1, 1, 250, NOW()),
(2, 1, 2, 120, NOW()),
(3, 1, 3, 60, NOW()),
(4, 1, 4, 45, NOW()),
(5, 1, 5, 10, NOW()),
(6, 1, 6, 8, NOW()),
(7, 1, 7, 80, NOW()),
(8, 1, 8, 60, NOW()),
(9, 1, 9, 15, NOW()),
(10, 1, 10, 18, NOW()),

-- Sede Gregorio Albarracín
(11, 2, 1, 200, NOW()),
(12, 2, 2, 100, NOW()),
(13, 2, 3, 50, NOW()),
(14, 2, 4, 40, NOW()),
(15, 2, 5, 7, NOW()),
(16, 2, 6, 6, NOW()),
(17, 2, 7, 70, NOW()),
(18, 2, 8, 55, NOW()),
(19, 2, 9, 12, NOW()),
(20, 2, 10, 14, NOW());


-- =====================================================
-- CARRITOS
-- =====================================================

INSERT INTO carrito (
    id_carrito,
    id_cliente
) VALUES
(1, 2),
(2, 3),
(3, 4);


INSERT INTO carrito_producto (
    id_carrito,
    id_producto,
    cantidad
) VALUES
(1, 6, 1),
(1, 7, 2),

(2, 1, 24),
(2, 4, 6);


-- =====================================================
-- PEDIDOS
-- =====================================================

INSERT INTO pedido (
    id_pedido,
    id_cliente,
    id_sede,
    id_direccion_entrega,
    tipo_entrega,
    fecha_registro,
    fecha_entrega,
    subtotal_productos,
    costo_envio,
    descuento,
    costo_total,
    estado,
    tipo_comprobante
) VALUES
(
    1,
    2,
    1,
    1,
    'DOMICILIO',
    NOW() - INTERVAL 1 DAY,
    CURDATE() + INTERVAL 1 DAY,
    31.00,
    4.00,
    0.00,
    35.00,
    'PAGADO',
    'BOLETA'
),
(
    2,
    3,
    1,
    NULL,
    'RECOJO_TIENDA',
    NOW() - INTERVAL 5 DAY,
    CURDATE() - INTERVAL 4 DAY,
    79.00,
    0.00,
    5.00,
    74.00,
    'ENTREGADO',
    'FACTURA'
),
(
    3,
    4,
    2,
    4,
    'DOMICILIO',
    NOW() - INTERVAL 3 HOUR,
    CURDATE() + INTERVAL 1 DAY,
    74.00,
    0.00,
    0.00,
    74.00,
    'EN_PREPARACION',
    'BOLETA'
),
(
    4,
    2,
    1,
    NULL,
    'RECOJO_TIENDA',
    NOW(),
    CURDATE() + INTERVAL 1 DAY,
    26.00,
    0.00,
    0.00,
    26.00,
    'PENDIENTE_PAGO',
    'BOLETA'
);


-- =====================================================
-- DETALLE DE PEDIDOS
-- =====================================================

INSERT INTO pedido_producto (
    id_pedido,
    id_producto,
    cantidad,
    precio_unitario_congelado,
    subtotal
) VALUES
-- Pedido 1 = 31
(1, 1, 12, 0.50, 6.00),
(1, 3, 4, 3.50, 14.00),
(1, 4, 2, 5.50, 11.00),

-- Pedido 2 = 79
(2, 5, 1, 55.00, 55.00),
(2, 7, 4, 6.00, 24.00),

-- Pedido 3 = 74
(3, 9, 2, 30.00, 60.00),
(3, 8, 2, 7.00, 14.00),

-- Pedido 4 = 26
(4, 2, 8, 1.50, 12.00),
(4, 8, 2, 7.00, 14.00);


-- =====================================================
-- PAGOS
-- =====================================================

INSERT INTO pago (
    id_pago,
    id_pedido,
    monto,
    metodo_pago,
    fecha_pago,
    estado,
    referencia_pago
) VALUES
(
    1,
    1,
    35.00,
    'YAPE',
    NOW() - INTERVAL 1 DAY,
    'CONFIRMADO',
    'YAPE-001-TEST'
),
(
    2,
    2,
    74.00,
    'CREDITO',
    NOW() - INTERVAL 5 DAY,
    'CONFIRMADO',
    'VISA-002-TEST'
),
(
    3,
    3,
    74.00,
    'PLIN',
    NOW() - INTERVAL 3 HOUR,
    'CONFIRMADO',
    'PLIN-003-TEST'
),
(
    4,
    4,
    26.00,
    'EFECTIVO',
    NOW(),
    'PENDIENTE',
    NULL
);


-- =====================================================
-- COMPROBANTES
-- =====================================================

INSERT INTO comprobante (
    id_comprobante,
    id_pedido,
    numero_comprobante,
    tipo_comprobante,
    fecha_generacion,
    archivo_path
) VALUES
(
    1,
    1,
    'B001-000001',
    'BOLETA',
    NOW() - INTERVAL 1 DAY,
    'comprobantes/B001-000001.pdf'
),
(
    2,
    2,
    'F001-000001',
    'FACTURA',
    NOW() - INTERVAL 5 DAY,
    'comprobantes/F001-000001.pdf'
),
(
    3,
    3,
    'B001-000002',
    'BOLETA',
    NOW() - INTERVAL 3 HOUR,
    'comprobantes/B001-000002.pdf'
);


COMMIT;


-- =====================================================
-- VERIFICACIÓN
-- =====================================================

SELECT 'DATOS CARGADOS CORRECTAMENTE' AS resultado;

SELECT
    (SELECT COUNT(*) FROM cliente) AS clientes,
    (SELECT COUNT(*) FROM producto) AS productos,
    (SELECT COUNT(*) FROM inventario) AS inventarios,
    (SELECT COUNT(*) FROM pedido) AS pedidos,
    (SELECT COUNT(*) FROM pedido_producto) AS detalles_pedido,
    (SELECT COUNT(*) FROM pago) AS pagos,
    (SELECT COUNT(*) FROM comprobante) AS comprobantes;