-- ============================================================
-- SCRIPT 1: CREACIÓN DE BASE DE DATOS Y TABLAS
-- Proyecto: Sistema de Gestión de Salas y Equipos
-- Descripción: Controla el estado de las salas, equipos y mantenimientos
-- ============================================================

CREATE DATABASE IF NOT EXISTS Empresa CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE Empresa;

-- ============================================================
-- Tabla: tipo_usuarios
-- Contiene los diferentes roles del sistema (admin, docente, funcionario)
-- ============================================================
CREATE TABLE tipo_usuarios (
  id_tipo_usuarios INT AUTO_INCREMENT PRIMARY KEY,
  nombre_tipo_usuario VARCHAR(100) NOT NULL,
  desc_tipo_usuario VARCHAR(200),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1)),
  -- CHECK: nombre no vacío
  CHECK (nombre_tipo_usuario <> '')
) ENGINE=InnoDB;

-- ============================================================
-- Tabla: usuarios
-- Almacena los datos personales y credenciales de acceso
-- ============================================================
CREATE TABLE usuarios (
  id_usuarios INT AUTO_INCREMENT PRIMARY KEY,
  nombre_usuario VARCHAR(100) NOT NULL,
  contraseña VARCHAR(100) NOT NULL,
  correo VARCHAR(100) NOT NULL,
  fecha_nac DATE NOT NULL,
  id_tipo_usuarios INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1)),
  CONSTRAINT fk_usuarios_tipo
    FOREIGN KEY (id_tipo_usuarios) REFERENCES tipo_usuarios(id_tipo_usuarios)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  CHECK (correo LIKE '%@%')
) ENGINE=InnoDB;

-- ============================================================
-- Tabla: estado_sala
-- Define los posibles estados de una sala (Encendida, Apagada, En Mantenimiento)
-- ============================================================
CREATE TABLE estado_sala (
  id_estado_sala INT AUTO_INCREMENT PRIMARY KEY,
  nombre_estado_sala VARCHAR(50) NOT NULL,
  desc_estado_sala VARCHAR(150),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1))
) ENGINE=InnoDB;

-- ============================================================
-- Tabla: estado_mantenimiento
-- Guarda los posibles estados del proceso de mantenimiento
-- ============================================================
CREATE TABLE estado_mantenimiento (
  id_estado_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
  nombre_estado_mantenimiento VARCHAR(50) NOT NULL,
  desc_estado_mantenimiento VARCHAR(150),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1))
) ENGINE=InnoDB;

-- ============================================================
-- Tabla: mantenimiento
-- Registra los trabajos de mantenimiento realizados
-- ============================================================
CREATE TABLE mantenimiento (
  id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
  fecha_mantenimiento DATE NOT NULL,
  desc_mantenimiento VARCHAR(150) NOT NULL,
  id_estado_mantenimiento INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1)),
  CONSTRAINT fk_mantenimiento_estado
    FOREIGN KEY (id_estado_mantenimiento) REFERENCES estado_mantenimiento(id_estado_mantenimiento)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
-- Tabla: salas
-- Representa las salas físicas que se gestionan en el sistema
-- ============================================================
CREATE TABLE salas (
  id_salas INT AUTO_INCREMENT PRIMARY KEY,
  nombre_sala VARCHAR(100) NOT NULL,
  desc_sala VARCHAR(150),
  id_estado_sala INT NOT NULL,
  mantenimiento_id_mantenimiento INT,
  admin INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1)),
  CONSTRAINT fk_sala_estado
    FOREIGN KEY (id_estado_sala) REFERENCES estado_sala(id_estado_sala)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  CONSTRAINT fk_sala_mant
    FOREIGN KEY (mantenimiento_id_mantenimiento) REFERENCES mantenimiento(id_mantenimiento)
      ON UPDATE CASCADE
      ON DELETE SET NULL,
  CONSTRAINT fk_sala_admin
    FOREIGN KEY (admin) REFERENCES usuarios(id_usuarios)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  CHECK (nombre_sala <> '')
) ENGINE=InnoDB;

-- ============================================================
-- Tabla: estado_dispositivo
-- Define los posibles estados de los equipos (Operativo, Dañado, En Reparación)
-- ============================================================
CREATE TABLE estado_dispositivo (
  id_estado_dispositivo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_estado_equipo VARCHAR(50) NOT NULL,
  desc_estado_equipo VARCHAR(150),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1))
) ENGINE=InnoDB;

-- ============================================================
-- Tabla: tipo_dispositivo
-- Contiene las categorías de dispositivos (PC, proyector, monitor, etc.)
-- ============================================================
CREATE TABLE tipo_dispositivo (
  id_tipo_dispositivo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_tipo_dispositivo VARCHAR(50) NOT NULL,
  desc_tipo_dispositivo VARCHAR(150),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1))
) ENGINE=InnoDB;

-- ============================================================
-- Tabla: dispositivos
-- Registra los equipos dentro de cada sala y su estado
-- ============================================================
CREATE TABLE dispositivos (
  id_dispositivos INT AUTO_INCREMENT PRIMARY KEY,
  nombre_dispositivo VARCHAR(100) NOT NULL,
  IP_dispositivo VARCHAR(45),
  id_salas INT NOT NULL,
  id_estado_dispositivo INT NOT NULL,
  id_tipo_dispositivo INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT DEFAULT 0 CHECK (deleted IN (0,1)),
  CONSTRAINT fk_dispositivo_sala
    FOREIGN KEY (id_salas) REFERENCES salas(id_salas)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
  CONSTRAINT fk_dispositivo_estado
    FOREIGN KEY (id_estado_dispositivo) REFERENCES estado_dispositivo(id_estado_dispositivo)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  CONSTRAINT fk_dispositivo_tipo
    FOREIGN KEY (id_tipo_dispositivo) REFERENCES tipo_dispositivo(id_tipo_dispositivo)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  CHECK (nombre_dispositivo <> '')
) ENGINE=InnoDB;
