-- ============================================================
-- SCRIPT 2: INSERCIÓN DE DATOS Y CONSULTAS
-- Proyecto: Sistema de Gestión de Salas y Equipos
-- Descripción: Pobla la base de datos con datos de ejemplo basados
-- en los Apuntes de Análisis de Requerimientos y verifica la integridad.
-- Autor: Juan (modificado por IA)
-- ============================================================

USE Empresa;

-- ============================================================
-- SECCIÓN 1: INSERCIÓN DE DATOS (POBLAR TABLAS)
-- ============================================================

-- 1. Insertar Tipos de Usuarios (Admin, Docente, Funcionario)
INSERT INTO tipo_usuarios (nombre_tipo_usuario, desc_tipo_usuario) VALUES
('Administrador', 'Acceso total al sistema'),
('Docente', 'Acceso a gestión de estado de salas'),
('Funcionario', 'Acceso a gestión de inventario y mantenimiento');

-- 2. Insertar Usuarios (Asociados a los tipos)
-- Se asume que los ID de tipo_usuarios son 1 (Admin), 2 (Docente), 3 (Funcionario)
INSERT INTO usuarios (nombre_usuario, contraseña, correo, fecha_nac, id_tipo_usuarios) VALUES
('admin_sistema', 'hash_pass_admin_123', 'admin@institucion.com', '1990-01-15', 1),
('ana_docente', 'hash_pass_docente_456', 'ana.perez@institucion.com', '1985-06-20', 2),
('juan_funcionario', 'hash_pass_func_789', 'juan.diaz@institucion.com', '1992-11-30', 3);

-- 3. Insertar Estados de Sala (Encendido, Apagado)
INSERT INTO estado_sala (nombre_estado_sala, desc_estado_sala) VALUES
('Encendida', 'La sala está operativa y con equipos encendidos'),
('Apagada', 'La sala está cerrada y con equipos apagados'),
('En Mantenimiento', 'La sala está cerrada por revisión técnica');

-- 4. Insertar Estados de Mantenimiento
INSERT INTO estado_mantenimiento (nombre_estado_mantenimiento, desc_estado_mantenimiento) VALUES
('Pendiente', 'Mantenimiento programado, no iniciado'),
('En Progreso', 'Mantenimiento en ejecución'),
('Completado', 'Mantenimiento finalizado exitosamente');

-- 5. Insertar Registros de Mantenimiento
-- Se asume que los ID de estado_mantenimiento son 1 (Pendiente), 3 (Completado)
INSERT INTO mantenimiento (fecha_mantenimiento, desc_mantenimiento, id_estado_mantenimiento) VALUES
('2025-10-15', 'Revisión proyector sala C-303', 1), -- Pendiente
('2025-10-18', 'Cambio PC 3 sala B-202', 3); -- Completado

-- 6. Insertar Estados de Dispositivos
INSERT INTO estado_dispositivo (nombre_estado_equipo, desc_estado_equipo) VALUES
('Operativo', 'El dispositivo funciona correctamente'),
('Dañado', 'El dispositivo presenta fallas'),
('En Reparación', 'El dispositivo está en revisión técnica');

-- 7. Insertar Tipos de Dispositivos (PC, Proyector, etc.)
INSERT INTO tipo_dispositivo (nombre_tipo_dispositivo, desc_tipo_dispositivo) VALUES
('Computador (PC)', 'Equipo de escritorio o notebook'),
('Proyector', 'Dispositivo de proyección multimedia'),
('Monitor', 'Pantalla de visualización'),
('Pizarra Interactiva', 'Pizarra digital táctil');

-- 8. Insertar Salas (Vinculadas a estado, admin y mantenimiento opcional)
-- Se asume ID Usuario Admin = 1
-- Se asume ID Estado Sala: 1 (Encendida), 2 (Apagada), 3 (En Mantenimiento)
-- Se asume ID Mantenimiento: 1 (Pendiente C-303), 2 (Completado B-202)
INSERT INTO salas (nombre_sala, desc_sala, id_estado_sala, mantenimiento_id_mantenimiento, admin) VALUES
('Sala A-101', 'Laboratorio Computación 1', 1, NULL, 1), -- Encendida
('Sala B-202', 'Sala Multimedia 2', 2, 2, 1), -- Apagada, con mant. completado
('Sala C-303', 'Auditorio', 3, 1, 1); -- En Mantenimiento, con mant. pendiente

-- 9. Insertar Dispositivos (Asociados a salas, estados y tipos)
-- Se asume ID Salas: 1 (A-101), 2 (B-202), 3 (C-303)
-- Se asume ID Estado Dispositivo: 1 (Operativo), 2 (Dañado), 3 (En Reparación)
-- Se asume ID Tipo Dispositivo: 1 (PC), 2 (Proyector), 4 (Pizarra)
INSERT INTO dispositivos (nombre_dispositivo, IP_dispositivo, id_salas, id_estado_dispositivo, id_tipo_dispositivo) VALUES
('PC-A101-01', '192.168.1.10', 1, 1, 1), -- PC Operativo en Sala A-101
('PROY-A101-01', '192.168.1.11', 1, 1, 2), -- Proyector Operativo en Sala A-101
('PC-B202-01', '192.168.2.10', 2, 2, 1), -- PC Dañado en Sala B-202
('PC-B202-02', '192.168.2.11', 2, 1, 1), -- PC Operativo en Sala B-202
('PIZARRA-C303', NULL, 3, 3, 4); -- Pizarra En Reparación en Sala C-303

-- ============================================================
-- SECCIÓN 2: CONSULTAS DE VERIFICACIÓN
-- ============================================================

-- Verificación simple (SELECT *)
SELECT * FROM tipo_usuarios;
SELECT * FROM usuarios;
SELECT * FROM salas;
SELECT * FROM dispositivos;
SELECT * FROM mantenimiento;

-- Verificación de registros activos (deleted = 0)
SELECT * FROM usuarios WHERE deleted = 0;
SELECT * FROM salas WHERE deleted = 0;
SELECT * FROM dispositivos WHERE deleted = 0;

-- ============================================================
-- SECCIÓN 3: CONSULTAS DE VALIDACIÓN (Relaciones y Lógica de Negocio)
-- ============================================================

-- 1. Ver usuarios y sus roles (Validar FK)
SELECT
    u.nombre_usuario,
    u.correo,
    tu.nombre_tipo_usuario
FROM usuarios u
JOIN tipo_usuarios tu ON u.id_tipo_usuarios = tu.id_tipo_usuarios
WHERE u.deleted = 0;

-- 2. Ver dispositivos por sala, con su tipo y estado (Validar FKs múltiples)
SELECT
    s.nombre_sala,
    d.nombre_dispositivo,
    td.nombre_tipo_dispositivo,
    ed.nombre_estado_equipo
FROM dispositivos d
JOIN salas s ON d.id_salas = s.id_salas
JOIN tipo_dispositivo td ON d.id_tipo_dispositivo = td.id_tipo_dispositivo
JOIN estado_dispositivo ed ON d.id_estado_dispositivo = ed.id_estado_dispositivo
WHERE s.nombre_sala = 'Sala A-101' AND d.deleted = 0;

-- 3. Ver salas que están "En Mantenimiento" y qué mantenimiento tienen asociado (Validar FK opcional)
SELECT
    s.nombre_sala,
    es.nombre_estado_sala,
    m.fecha_mantenimiento,
    m.desc_mantenimiento,
    em.nombre_estado_mantenimiento
FROM salas s
JOIN estado_sala es ON s.id_estado_sala = es.id_estado_sala
LEFT JOIN mantenimiento m ON s.mantenimiento_id_mantenimiento = m.id_mantenimiento
LEFT JOIN estado_mantenimiento em ON m.id_estado_mantenimiento = em.id_estado_mantenimiento
WHERE es.nombre_estado_sala = 'En Mantenimiento';