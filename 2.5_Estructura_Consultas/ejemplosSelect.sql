-- Creación de la base de datos
CREATE DATABASE ejemploSelect;
USE ejemploSelect;

-- Tabla: tipo_usuarios
CREATE TABLE tipo_usuarios (
    id_tipo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL CHECK (length(nombre_tipo) >= 4),
    descripcion_tipo VARCHAR(200) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

-- Tabla: usuarios (se añade campo created_at con valor por defecto)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    contraseña VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'), --
id_tipo_usuario INT,
    CONSTRAINT fk_usuarios_tipo_usuarios FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

-- Tabla: ciudad (nueva)
CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL CHECK (length(nombre_ciudad) >= 4),
    region VARCHAR(100),
    id_tipo_usuario INT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);

-- Tabla: personas (relacionada con usuarios y ciudad)
CREATE TABLE personas (
    rut VARCHAR(13) NOT NULL UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    fecha_nac DATE CHECK (fecha_nac >= '1910-01-01'),
    id_usuario INT,
    id_ciudad INT,
id_tipo_usuario INT,
    CONSTRAINT fk_personas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_personas_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE
);


-- Poblar tabla tipo_usuarios
INSERT INTO tipo_usuarios (nombre_tipo, descripcion_tipo, created_by, updated_by) VALUES
('Administrador', 'Acceso completo al sistema', 1, 1),
('Cliente', 'Usuario con acceso restringido', 1, 1),
('Moderador', 'Puede revisar y aprobar contenido', 1, 1);

-- Poblar tabla usuarios
INSERT INTO usuarios (username, contraseña, email, id_tipo_usuario, created_by, updated_by) VALUES
('admin01', 'pass1234', 'admin01@mail.com', 1, 1, 1),
('jvaldes', 'abc123', 'jvaldes@mail.com', 2, 1, 1),
('cmorales', '123456', 'cmorales@mail.com', 3, 1, 1),
('anavarro', 'pass4321', 'anavarro@mail.com', 2, 1, 1),
('rquezada', 'clave2023', 'rquezada@mail.com', 1, 1, 1),
('pgodoy', 'segura123', 'pgodoy@mail.com', 2, 1, 1),
('mdiaz', 'token456', 'mdiaz@mail.com', 3, 1, 1),
('scarvajal', 'azul789', 'scarvajal@mail.com', 2, 1, 1),
('ltapia', 'lt123', 'ltapia@mail.com', 3, 1, 1),
('afarias', 'afpass', 'afarias@mail.com', 2, 1, 1);

-- Poblar tabla ciudad
INSERT INTO ciudad (nombre_ciudad, region, created_by, updated_by) VALUES
('Santiago', 'Región Metropolitana', 1, 1),
('Valparaíso', 'Región de Valparaíso', 1, 1),
('Concepción', 'Región del Biobío', 1, 1),
('La Serena', 'Región de Coquimbo', 1, 1),
('Puerto Montt', 'Región de Los Lagos', 1, 1);

-- Poblar tabla personas (relacionadas con usuarios y ciudades)
INSERT INTO personas (rut, nombre_completo, fecha_nac, id_usuario, id_ciudad, created_by, updated_by) VALUES
('11.111.111-1', 'Juan Valdés', '1990-04-12', 2, 1, 1, 1),
('22.222.222-2', 'Camila Morales', '1985-09-25', 3, 2, 1, 1),
('33.333.333-3', 'Andrea Navarro', '1992-11-03', 4, 3, 1, 1),
('44.444.444-4', 'Rodrigo Quezada', '1980-06-17', 5, 1, 1, 1),
('55.555.555-5', 'Patricio Godoy', '1998-12-01', 6, 4, 1, 1),
('66.666.666-6', 'María Díaz', '1987-07-14', 7, 5, 1, 1),
('77.777.777-7', 'Sebastián Carvajal', '1993-03-22', 8, 2, 1, 1),
('88.888.888-8', 'Lorena Tapia', '2000-10-10', 9, 3, 1, 1),
('99.999.999-9', 'Ana Farías', '1995-01-28', 10, 4, 1, 1),
('10.101.010-0', 'Carlos Soto', '1991-08-08', 1, 1, 1, 1);

-- 1.-  Mostrar todos los usuarios de tipo Cliente
-- Seleccionar nombre de usuario, correo y tipo_usuario
SELECT u.username, u.email, t.nombre_tipo
FROM usuarios u, tipo_usuarios t
WHERE u.id_tipo_usuario = 2
AND u.id_tipo_usuario = t.id_tipo;

-- 2.-  Mostrar Personas nacidas despues del año 1990
-- Seleccionar Nombre, fecha de nacimiento y username.
SELECT p.nombre_completo, p.fecha_nac, u.username
FROM personas p, usuarios u
WHERE p.id_usuario = u.id_usuario
AND p.fecha_nac > '1990-12-31';

-- 3.- Seleccionar nombres de personas que comiencen con la
-- letra A - Seleccionar nombre y correo la persona.
SELECT p.nombre_completo, u.email
FROM personas p, usuarios u
WHERE p.id_usuario = u.id_usuario
AND p.nombre_completo LIKE 'A%';

-- 4.- Mostrar usuarios cuyos dominios de correo sean
-- mail.commit LIKE '%mail.com%'
SELECT u.username, u.email
FROM usuarios u
WHERE u.email LIKE '%mail.com%';

-- 5.- Mostrar todas las personas que no viven en
-- Valparaiso y su usuario + ciudad.
 -- select * from ciudad; -- ID 2 VALPARAISO
SELECT u.username, c.nombre_ciudad
FROM personas p, usuarios u, ciudad c
WHERE p.id_usuario = u.id_usuario
AND p.id_ciudad = c.id_ciudad
AND c.id_ciudad != 2;

-- 6.- Mostrar usuarios que contengan más de 7
-- carácteres de longitud.
SELECT u.username
FROM usuarios u
WHERE LENGTH(u.username) > 7;

-- 7.- Mostrar username de personas nacidas entre
-- 1990 y 1995
SELECT u.username
FROM personas p, usuarios u
WHERE p.id_usuario = u.id_usuario
AND p.fecha_nac BETWEEN '1990-01-01' AND '1995-12-31';