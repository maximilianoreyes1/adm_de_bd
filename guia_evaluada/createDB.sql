-- =========================================
-- CREACIÓN DE BASE DE DATOS
-- =========================================
CREATE DATABASE IF NOT EXISTS gestion_academica;
USE gestion_academica;

-- =========================================
-- TABLA TIPO_USUARIOS
-- =========================================
CREATE TABLE tipo_usuarios (
    id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0
);

-- =========================================
-- TABLA MODALIDADES (para cursos)
-- =========================================
CREATE TABLE modalidades (
    id_modalidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_modalidad VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0
);

-- =========================================
-- TABLA PERSONAS
-- =========================================
CREATE TABLE personas (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    rut VARCHAR(12) UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    correo VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0
);

-- =========================================
-- TABLA USUARIOS
-- =========================================
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(100) NOT NULL,
    id_persona INT NOT NULL,
    id_tipo_usuario INT NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona),
    FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo_usuario)
);

-- =========================================
-- TABLA CURSOS
-- =========================================
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(100),
    id_modalidad INT NOT NULL,
    fecha_inicio DATE,
    duracion_horas INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_modalidad) REFERENCES modalidades(id_modalidad)
);

-- =========================================
-- TABLA MATRICULAS
-- =========================================
CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_matricula DATE,
    estado VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- =========================================
-- TABLA DOCENTE_CURSO
-- =========================================
CREATE TABLE docente_curso (
    id_docente_curso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- =========================================
-- INSERCIÓN DE DATOS
-- =========================================
-- TIPOS DE USUARIOS
INSERT INTO tipo_usuarios (nombre_tipo) VALUES
('Administrador'),
('Docente'),
('Estudiante');

-- MODALIDADES
INSERT INTO modalidades (nombre_modalidad) VALUES
('Online'),
('Presencial');

-- PERSONAS (con algunos campos nulos)
INSERT INTO personas (rut, nombre_completo, fecha_nacimiento, correo) VALUES
('11.111.111-1', 'Andrés Soto', '1985-03-21', 'andres.soto@email.com'),
(NULL, 'Lucía Fuentes', '1990-07-10', 'lucia.fuentes@email.com'),
('13.333.333-3', 'María López', '1992-01-15', NULL),
('14.444.444-4', 'Pedro González', '1995-11-20', 'pedro.gonzalez@email.com'),
('15.555.555-5', 'Claudia Díaz', '1998-04-09', 'claudia.diaz@email.com'),
(NULL, 'Javier Silva', '1980-06-22', 'javier.silva@email.com'),
('17.777.777-7', 'Patricia Reyes', '1988-09-30', 'patricia.reyes@email.com'),
('18.888.888-8', 'Daniel Hernández', '1993-12-14', 'daniel.hernandez@email.com'),
('19.999.999-9', 'Carolina Vega', '1997-05-05', NULL),
('10.000.000-0', 'Esteban Morales', '1994-08-18', 'esteban.morales@email.com');

-- USUARIOS (con algunos usernames nulos)
INSERT INTO usuarios (username, password, id_persona, id_tipo_usuario, estado) VALUES
('asoto', 'clave123', 1, 1, 'activo'),
(NULL, 'clave123', 2, 1, 'activo'),
('mlopez', 'clave123', 3, 2, 'activo'),
('pgonzalez', 'clave123', 4, 2, 'activo'),
('cdiaz', 'clave123', 5, 2, 'activo'),
(NULL, 'clave123', 6, 3, 'activo'),
('preyes', 'clave123', 7, 3, 'activo'),
('dhernandez', 'clave123', 8, 3, 'inactivo'),
('cvega', 'clave123', 9, 3, 'activo'),
('emorales', 'clave123', 10, 3, 'activo');

-- CURSOS (con algunos campos nulos)
INSERT INTO cursos (nombre_curso, id_modalidad, fecha_inicio, duracion_horas) VALUES
('Fundamentos de SQL', 1, '2025-09-01', 30),
('Desarrollo Web', 1, NULL, 40),
('Redes y Comunicaciones', 2, '2025-09-10', NULL),
('Seguridad Informática', 2, '2025-09-15', 35),
('Administración de BD', 1, '2025-09-20', 50),
('Python Básico', 1, '2025-09-25', 30),
(NULL, 2, '2025-10-01', 20),
('Ciberseguridad', 2, '2025-10-05', 45),
('Big Data y Análisis', 1, NULL, 60),
('Machine Learning', 1, '2025-10-15', 55);

-- MATRICULAS (con campos nulos)
INSERT INTO matriculas (id_usuario, id_curso, fecha_matricula, estado) VALUES
(6, 1, '2025-08-20', 'vigente'),
(7, 1, '2025-08-21', 'vigente'),
(8, 2, '2025-08-22', NULL),
(9, 3, NULL, 'vigente'),
(10, 4, '2025-08-24', 'vigente'),
(6, 5, '2025-08-25', 'vigente'),
(7, 6, '2025-08-26', 'finalizado'),
(8, 7, '2025-08-27', 'vigente'),
(9, 8, NULL, 'vigente'),
(10, 9, '2025-08-29', 'vigente');

-- DOCENTE_CURSO (correcto)
INSERT INTO docente_curso (id_usuario, id_curso) VALUES
(3, 1), (3, 2),
(4, 3), (4, 4),
(5, 5), (5, 6),
(3, 7), (4, 8),
(5, 9), (3, 10);