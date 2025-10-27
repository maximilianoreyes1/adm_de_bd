-- ============================================================
-- SCRIPT 3: CREACIÓN DE PROCEDIMIENTOS ALMACENADOS
-- Proyecto: Sistema de Gestión de Salas y Equipos
-- Descripción: Define los SP para Inserción, Borrado Lógico y
-- ============================================================

USE Empresa;

-- ============================================================
-- Tabla: tipo_usuarios
-- ============================================================

/* 1. Insertar tipo_usuarios */
DELIMITER //
CREATE PROCEDURE sp_insertar_tipo_usuario(
    IN p_nombre_tipo_usuario VARCHAR(100),
    IN p_desc_tipo_usuario VARCHAR(200)
)
BEGIN
    INSERT INTO tipo_usuarios(nombre_tipo_usuario, desc_tipo_usuario)
    VALUES (p_nombre_tipo_usuario, p_desc_tipo_usuario);
END//
DELIMITER ;

/* 2. Borrado lógico tipo_usuarios (pone deleted = 1) */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_tipo_usuario(
    IN p_id_tipo_usuarios INT
)
BEGIN
    UPDATE tipo_usuarios SET deleted = 1 WHERE id_tipo_usuarios = p_id_tipo_usuarios;
END//
DELIMITER ;

/* 3. Mostrar activos tipo_usuarios (WHERE deleted = 0) */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_tipo_usuarios()
BEGIN
    SELECT * FROM tipo_usuarios WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos tipo_usuarios */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_tipo_usuarios()
BEGIN
    SELECT * FROM tipo_usuarios;
END//
DELIMITER ;

-- ============================================================
-- Tabla: usuarios
-- ============================================================

/* 1. Insertar usuarios */
DELIMITER //
CREATE PROCEDURE sp_insertar_usuario(
    IN p_nombre_usuario VARCHAR(100),
    IN p_contraseña VARCHAR(100),
    IN p_correo VARCHAR(100),
    IN p_fecha_nac DATE,
    IN p_id_tipo_usuarios INT
)
BEGIN
    INSERT INTO usuarios(nombre_usuario, contraseña, correo, fecha_nac, id_tipo_usuarios)
    VALUES (p_nombre_usuario, p_contraseña, p_correo, p_fecha_nac, p_id_tipo_usuarios);
END//
DELIMITER ;

/* 2. Borrado lógico usuarios */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_usuario(
    IN p_id_usuarios INT
)
BEGIN
    UPDATE usuarios SET deleted = 1 WHERE id_usuarios = p_id_usuarios;
END//
DELIMITER ;

/* 3. Mostrar activos usuarios */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_usuarios()
BEGIN
    SELECT * FROM usuarios WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos usuarios */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_usuarios()
BEGIN
    SELECT * FROM usuarios;
END//
DELIMITER ;

-- ============================================================
-- Tabla: estado_sala
-- ============================================================

/* 1. Insertar estado_sala */
DELIMITER //
CREATE PROCEDURE sp_insertar_estado_sala(
    IN p_nombre_estado_sala VARCHAR(50),
    IN p_desc_estado_sala VARCHAR(150)
)
BEGIN
    INSERT INTO estado_sala(nombre_estado_sala, desc_estado_sala)
    VALUES (p_nombre_estado_sala, p_desc_estado_sala);
END//
DELIMITER ;

/* 2. Borrado lógico estado_sala */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_estado_sala(
    IN p_id_estado_sala INT
)
BEGIN
    UPDATE estado_sala SET deleted = 1 WHERE id_estado_sala = p_id_estado_sala;
END//
DELIMITER ;

/* 3. Mostrar activos estado_sala */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_estado_sala()
BEGIN
    SELECT * FROM estado_sala WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos estado_sala */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_estado_sala()
BEGIN
    SELECT * FROM estado_sala;
END//
DELIMITER ;

-- ============================================================
-- Tabla: estado_mantenimiento
-- ============================================================

/* 1. Insertar estado_mantenimiento */
DELIMITER //
CREATE PROCEDURE sp_insertar_estado_mantenimiento(
    IN p_nombre_estado_mantenimiento VARCHAR(50),
    IN p_desc_estado_mantenimiento VARCHAR(150)
)
BEGIN
    INSERT INTO estado_mantenimiento(nombre_estado_mantenimiento, desc_estado_mantenimiento)
    VALUES (p_nombre_estado_mantenimiento, p_desc_estado_mantenimiento);
END//
DELIMITER ;

/* 2. Borrado lógico estado_mantenimiento */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_estado_mantenimiento(
    IN p_id_estado_mantenimiento INT
)
BEGIN
    UPDATE estado_mantenimiento SET deleted = 1 WHERE id_estado_mantenimiento = p_id_estado_mantenimiento;
END//
DELIMITER ;

/* 3. Mostrar activos estado_mantenimiento */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_estado_mantenimiento()
BEGIN
    SELECT * FROM estado_mantenimiento WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos estado_mantenimiento */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_estado_mantenimiento()
BEGIN
    SELECT * FROM estado_mantenimiento;
END//
DELIMITER ;

-- ============================================================
-- Tabla: mantenimiento
-- ============================================================

/* 1. Insertar mantenimiento */
DELIMITER //
CREATE PROCEDURE sp_insertar_mantenimiento(
    IN p_fecha_mantenimiento DATE,
    IN p_desc_mantenimiento VARCHAR(150),
    IN p_id_estado_mantenimiento INT
)
BEGIN
    INSERT INTO mantenimiento(fecha_mantenimiento, desc_mantenimiento, id_estado_mantenimiento)
    VALUES (p_fecha_mantenimiento, p_desc_mantenimiento, p_id_estado_mantenimiento);
END//
DELIMITER ;

/* 2. Borrado lógico mantenimiento */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_mantenimiento(
    IN p_id_mantenimiento INT
)
BEGIN
    UPDATE mantenimiento SET deleted = 1 WHERE id_mantenimiento = p_id_mantenimiento;
END//
DELIMITER ;

/* 3. Mostrar activos mantenimiento */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_mantenimiento()
BEGIN
    SELECT * FROM mantenimiento WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos mantenimiento */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_mantenimiento()
BEGIN
    SELECT * FROM mantenimiento;
END//
DELIMITER ;

-- ============================================================
-- Tabla: salas
-- ============================================================

/* 1. Insertar salas */
DELIMITER //
CREATE PROCEDURE sp_insertar_sala(
    IN p_nombre_sala VARCHAR(100),
    IN p_desc_sala VARCHAR(150),
    IN p_id_estado_sala INT,
    IN p_mantenimiento_id_mantenimiento INT,
    IN p_admin INT
)
BEGIN
    INSERT INTO salas(nombre_sala, desc_sala, id_estado_sala, mantenimiento_id_mantenimiento, admin)
    VALUES (p_nombre_sala, p_desc_sala, p_id_estado_sala, p_mantenimiento_id_mantenimiento, p_admin);
END//
DELIMITER ;

/* 2. Borrado lógico salas */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_sala(
    IN p_id_salas INT
)
BEGIN
    UPDATE salas SET deleted = 1 WHERE id_salas = p_id_salas;
END//
DELIMITER ;

/* 3. Mostrar activos salas */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_salas()
BEGIN
    SELECT * FROM salas WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos salas */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_salas()
BEGIN
    SELECT * FROM salas;
END//
DELIMITER ;

-- ============================================================
-- Tabla: estado_dispositivo
-- ============================================================

/* 1. Insertar estado_dispositivo */
DELIMITER //
CREATE PROCEDURE sp_insertar_estado_dispositivo(
    IN p_nombre_estado_equipo VARCHAR(50),
    IN p_desc_estado_equipo VARCHAR(150)
)
BEGIN
    INSERT INTO estado_dispositivo(nombre_estado_equipo, desc_estado_equipo)
    VALUES (p_nombre_estado_equipo, p_desc_estado_equipo);
END//
DELIMITER ;

/* 2. Borrado lógico estado_dispositivo */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_estado_dispositivo(
    IN p_id_estado_dispositivo INT
)
BEGIN
    UPDATE estado_dispositivo SET deleted = 1 WHERE id_estado_dispositivo = p_id_estado_dispositivo;
END//
DELIMITER ;

/* 3. Mostrar activos estado_dispositivo */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_estado_dispositivo()
BEGIN
    SELECT * FROM estado_dispositivo WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos estado_dispositivo */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_estado_dispositivo()
BEGIN
    SELECT * FROM estado_dispositivo;
END//
DELIMITER ;

-- ============================================================
-- Tabla: tipo_dispositivo
-- ============================================================

/* 1. Insertar tipo_dispositivo */
DELIMITER //
CREATE PROCEDURE sp_insertar_tipo_dispositivo(
    IN p_nombre_tipo_dispositivo VARCHAR(50),
    IN p_desc_tipo_dispositivo VARCHAR(150)
)
BEGIN
    INSERT INTO tipo_dispositivo(nombre_tipo_dispositivo, desc_tipo_dispositivo)
    VALUES (p_nombre_tipo_dispositivo, p_desc_tipo_dispositivo);
END//
DELIMITER ;

/* 2. Borrado lógico tipo_dispositivo */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_tipo_dispositivo(
    IN p_id_tipo_dispositivo INT
)
BEGIN
    UPDATE tipo_dispositivo SET deleted = 1 WHERE id_tipo_dispositivo = p_id_tipo_dispositivo;
END//
DELIMITER ;

/* 3. Mostrar activos tipo_dispositivo */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_tipo_dispositivo()
BEGIN
    SELECT * FROM tipo_dispositivo WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos tipo_dispositivo */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_tipo_dispositivo()
BEGIN
    SELECT * FROM tipo_dispositivo;
END//
DELIMITER ;

-- ============================================================
-- Tabla: dispositivos
-- ============================================================

/* 1. Insertar dispositivos */
DELIMITER //
CREATE PROCEDURE sp_insertar_dispositivo(
    IN p_nombre_dispositivo VARCHAR(100),
    IN p_IP_dispositivo VARCHAR(45),
    IN p_id_salas INT,
    IN p_id_estado_dispositivo INT,
    IN p_id_tipo_dispositivo INT
)
BEGIN
    INSERT INTO dispositivos(nombre_dispositivo, IP_dispositivo, id_salas, id_estado_dispositivo, id_tipo_dispositivo)
    VALUES (p_nombre_dispositivo, p_IP_dispositivo, p_id_salas, p_id_estado_dispositivo, p_id_tipo_dispositivo);
END//
DELIMITER ;

/* 2. Borrado lógico dispositivos */
DELIMITER //
CREATE PROCEDURE sp_borrado_logico_dispositivo(
    IN p_id_dispositivos INT
)
BEGIN
    UPDATE dispositivos SET deleted = 1 WHERE id_dispositivos = p_id_dispositivos;
END//
DELIMITER ;

/* 3. Mostrar activos dispositivos */
DELIMITER //
CREATE PROCEDURE sp_mostrar_activos_dispositivos()
BEGIN
    SELECT * FROM dispositivos WHERE deleted = 0;
END//
DELIMITER ;

/* 4. Mostrar todos dispositivos */
DELIMITER //
CREATE PROCEDURE sp_mostrar_todos_dispositivos()
BEGIN
    SELECT * FROM dispositivos;
END//
DELIMITER ;
