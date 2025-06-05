CREATE DATABASE ventas;

USE ventas;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL,
    contraseña VARCHAR(45) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    tipo_usuario_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE tipos_usuarios (
    id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion_tipo VARCHAR(200) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    precio FLOAT NOT NULL,
    stock INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    fecha DATE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE detalles_ventas (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario FLOAT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

ALTER TABLE usuarios
    ADD CONSTRAINT fk_usuarios_tipo_usuario
    FOREIGN KEY (tipo_usuario_id) REFERENCES tipos_usuarios (id_tipo_usuario);

ALTER TABLE ventas
    ADD CONSTRAINT fk_ventas_usuario
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id_usuario);

ALTER TABLE detalles_ventas
    ADD CONSTRAINT fk_detalles_ventas_venta
    FOREIGN KEY (venta_id) REFERENCES ventas(id_venta);

ALTER TABLE detalles_ventas
    ADD CONSTRAINT fk_detalles_ventas_producto
    FOREIGN KEY (producto_id) REFERENCES productos(id_producto);

INSERT INTO tipos_usuarios (nombre_tipo, descripcion_tipo, created_by, updated_by)
VALUES 
    ('administrador', 'Accede a todas las funciones del sistema, incluida la administración de usuarios.', 1, 1),
    ('vendedor', 'Interactúa con los clientes para vender los productos.', 1, 1);

INSERT INTO usuarios (nombre_usuario, contraseña, correo, tipo_usuario_id, created_by, updated_by)
VALUES 
    ('admin', 'admin123', 'admin@plataforma.cl', 1, 1, 1),
    ('camila.perez', 'Camila2025', 'camila.perez@correo.cl', 2, 1, 1),
    ('luis.gomez', 'LGomez$2025', 'luis.gomez@correo.cl', 2, 1, 1),
    ('karla.munoz', 'KarlaMZ99', 'karla.munoz@correo.cl', 2, 1, 1);

INSERT INTO productos (nombre_producto, precio, stock, created_by, updated_by)
VALUES 
    ('papas fritas', 1500, 200, 1, 1),
    ('coca-cola 1.25l', 1200, 150, 1, 1),
    ('cheetos', 1800, 100, 1, 1);

INSERT INTO ventas (usuario_id, fecha, created_by, updated_by)
VALUES 
    (2, '2025-01-23', 1, 1),
    (3, '2025-02-17', 1, 1),
    (4, '2025-03-12', 1, 1),
    (2, '2025-04-30', 1, 1);

INSERT INTO detalles_ventas (venta_id, producto_id, cantidad, precio_unitario, created_by, updated_by)
VALUES 
    (1, 1, 3, 1500, 1, 1),
    (1, 2, 2, 1200, 1, 1),
    (2, 3, 1, 1800, 1, 1),
    (3, 1, 4, 1500, 1, 1),
    (4, 2, 5, 1200, 1, 1);


select * from usuarios;

select nombre_usuario
from usuarios
where deleted = 1;

select nombre_usuario
from usuarios
where tipo_usuario_id = 1;

select nombre_usuario
from usuarios
where nombre_usuario like 'k%';

select nombre_usuario
from usuarios
where created_at between "2025-06-02" and "2025-06-04";

-- Usuarios no elimidados y con un punto en su nombre
SELECT nombre_usuario
FROM usuarios
WHERE deleted = 0 AND nombre_usuario LIKE '%.%';

-- Usuarios que no sean administradores
SELECT nombre_usuario
FROM usuarios
WHERE tipo_usuario_id != 1;

-- Usuarios que tengan una "a" en su nombre y esten creados antes de julio
SELECT nombre_usuario, created_at
FROM usuarios
WHERE nombre_usuario LIKE '%a%' AND created_at < '2025-07-01';

-- Usuarios que sean vendedores y tengan "perez en su nombre"
SELECT nombre_usuario, correo
FROM usuarios
WHERE tipo_usuario_id = 2 AND correo LIKE '%perez%';

-- Usuarios que sean administradores o vendedores
SELECT nombre_usuario
FROM usuarios
WHERE tipo_usuario_id = 1 OR tipo_usuario_id = 2;