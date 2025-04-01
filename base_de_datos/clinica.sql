CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- -----------------------------------------------------
-- Table `tipo_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_usuarios` (
  `id_tipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_usuario` VARCHAR(255) NOT NULL,
  `desc_tipo_usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_usuario`)
);

-- -----------------------------------------------------
-- Table `usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `created` DATETIME NOT NULL,
  `tipo_usuarios_id_tipo_usuario` INT NOT NULL,
  PRIMARY KEY (`id_usuarios`),
  INDEX `fk_usuarios_tipo_usuarios_idx` (`tipo_usuarios_id_tipo_usuario`),
  CONSTRAINT `fk_usuarios_tipo_usuarios`
    FOREIGN KEY (`tipo_usuarios_id_tipo_usuario`)
    REFERENCES `tipo_usuarios` (`id_tipo_usuario`)
);

-- -----------------------------------------------------
-- Table `pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pacientes` (
  `id_pacientes` INT NOT NULL AUTO_INCREMENT,
  `created` DATETIME NOT NULL,
  `usuarios_id_usuarios` INT NOT NULL,
  PRIMARY KEY (`id_pacientes`),
  INDEX `fk_pacientes_usuarios1_idx` (`usuarios_id_usuarios`),
  CONSTRAINT `fk_pacientes_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `usuarios` (`id_usuarios`)
);

-- -----------------------------------------------------
-- Table `medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medicos` (
  `id_medicos` INT NOT NULL AUTO_INCREMENT,
  `especialidad` VARCHAR(45) NOT NULL,
  `created` DATETIME NOT NULL,
  `usuarios_id_usuarios` INT NOT NULL,
  PRIMARY KEY (`id_medicos`),
  INDEX `fk_medicos_usuarios1_idx` (`usuarios_id_usuarios`),
  CONSTRAINT `fk_medicos_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `usuarios` (`id_usuarios`)
);

-- -----------------------------------------------------
-- Table `consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultas` (
  `id_consulta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `motivo` VARCHAR(100) NOT NULL,
  `diagnostico` VARCHAR(200) NOT NULL,
  `created` DATETIME NOT NULL,
  `medicos_id_medicos` INT NOT NULL,
  `pacientes_id_pacientes` INT NOT NULL,
  PRIMARY KEY (`id_consulta`),
  INDEX `fk_consultas_medicos1_idx` (`medicos_id_medicos`),
  INDEX `fk_consultas_pacientes1_idx` (`pacientes_id_pacientes`),
  CONSTRAINT `fk_consultas_medicos1`
    FOREIGN KEY (`medicos_id_medicos`)
    REFERENCES `medicos` (`id_medicos`),
  CONSTRAINT `fk_consultas_pacientes1`
    FOREIGN KEY (`pacientes_id_pacientes`)
    REFERENCES `pacientes` (`id_pacientes`)
);

-- -----------------------------------------------------
-- Table `tratamientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tratamientos` (
  `id_tratamientos` INT NOT NULL AUTO_INCREMENT,
  `desc_tratamiento` VARCHAR(45) NOT NULL,
  `created` DATETIME NOT NULL,
  PRIMARY KEY (`id_tratamientos`)
);

-- -----------------------------------------------------
-- Table `citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citas` (
  `id_cita` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `created` DATETIME NOT NULL,
  `medicos_id_medicos` INT NOT NULL,
  `pacientes_id_pacientes` INT NOT NULL,
  PRIMARY KEY (`id_cita`),
  INDEX `fk_citas_medicos1_idx` (`medicos_id_medicos`),
  INDEX `fk_citas_pacientes1_idx` (`pacientes_id_pacientes`),
  CONSTRAINT `fk_citas_medicos1`
    FOREIGN KEY (`medicos_id_medicos`)
    REFERENCES `medicos` (`id_medicos`),
  CONSTRAINT `fk_citas_pacientes1`
    FOREIGN KEY (`pacientes_id_pacientes`)
    REFERENCES `pacientes` (`id_pacientes`)
);

-- -----------------------------------------------------
-- Table `consultas_has_tratamientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultas_has_tratamientos` (
  `consultas_id_consulta` INT NOT NULL,
  `tratamientos_id_tratamientos` INT NOT NULL,
  PRIMARY KEY (`consultas_id_consulta`, `tratamientos_id_tratamientos`),
  INDEX `fk_consultas_has_tratamientos_tratamientos1_idx` (`tratamientos_id_tratamientos`),
  INDEX `fk_consultas_has_tratamientos_consultas1_idx` (`consultas_id_consulta`),
  CONSTRAINT `fk_consultas_has_tratamientos_consultas1`
    FOREIGN KEY (`consultas_id_consulta`)
    REFERENCES `consultas` (`id_consulta`),
  CONSTRAINT `fk_consultas_has_tratamientos_tratamientos1`
    FOREIGN KEY (`tratamientos_id_tratamientos`)
    REFERENCES `tratamientos` (`id_tratamientos`)
);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Insertar en tipo_usuarios
INSERT INTO `mydb`.`tipo_usuarios` (nombre_tipo_usuario, desc_tipo_usuario) VALUES 
('Administrador', 'Acceso total'),
('Médico', 'Acceso a consultas y pacientes'),
('Paciente', 'Acceso a citas y tratamientos'),
('Recepcionista', 'Acceso a citas y registros'),
('Enfermero', 'Acceso a tratamientos');

-- Insertar en usuarios
INSERT INTO `mydb`.`usuarios` (nombre_usuario, correo, telefono, created, tipo_usuarios_id_tipo_usuario) VALUES 
('Juan Perez', 'juanperez@gmail.com', 12345678, NOW(), 1),
('Maria Lopez', 'marialopez@gmail.com', 87654321, NOW(), 2),
('Carlos Nuñez', 'carlosn@gmail.com', 11223344, NOW(), 3),
('Ana Torres', 'ana.torres@gmail.com', 44332211, NOW(), 4),
('Pedro Gomez', 'pedro.gomez@gmail.com', 66778899, NOW(), 5);

-- Insertar en pacientes
INSERT INTO `mydb`.`pacientes` (created, usuarios_id_usuarios) VALUES 
(NOW(), 3),
(NOW(), 4),
(NOW(), 5),
(NOW(), 2),
(NOW(), 1);

-- Insertar en médicos
INSERT INTO `mydb`.`medicos` (especialidad, created, usuarios_id_usuarios) VALUES 
('Cardiología', NOW(), 2),
('Pediatría', NOW(), 5),
('Neurología', NOW(), 1),
('Dermatología', NOW(), 4),
('Ortopedia', NOW(), 3);

-- Insertar en consultas
INSERT INTO `mydb`.`consultas` (fecha, hora, motivo, diagnostico, created, medicos_id_medicos, pacientes_id_pacientes) VALUES 
('2025-03-06', '10:00:00', 'Dolor de cabeza', 'Migraña', NOW(), 1, 2),
('2025-03-07', '11:00:00', 'Fiebre', 'Gripe', NOW(), 2, 3),
('2025-03-08', '12:00:00', 'Fractura', 'Yeso colocado', NOW(), 3, 4),
('2025-03-09', '13:00:00', 'Alergia', 'Antihistamínicos recetados', NOW(), 4, 5),
('2025-03-10', '14:00:00', 'Presión alta', 'Medicamentos recetados', NOW(), 5, 1);

-- Insertar en tratamientos
INSERT INTO `mydb`.`tratamientos` (desc_tratamiento, created) VALUES 
('Antibióticos', NOW()),
('Terapia física', NOW()),
('Cirugía menor', NOW()),
('Vacunación', NOW()),
('Rehabilitación', NOW());

-- Insertar en citas
INSERT INTO `mydb`.`citas` (fecha, hora, estado, created, pacientes_id_pacientes, medicos_id_medicos) VALUES 
('2025-03-11', '09:00:00', 'Pendiente', NOW(), 1, 3),
('2025-03-12', '10:00:00', 'Pendiente', NOW(), 2, 4),
('2025-03-13', '11:00:00', 'Pendiente', NOW(), 3, 5),
('2025-03-14', '12:00:00', 'Pendiente', NOW(), 4, 1),
('2025-03-15', '13:00:00', 'Pendiente', NOW(), 5, 2);

-- Insertar en consultas_has_tratamientos
INSERT INTO `mydb`.`consultas_has_tratamientos` (consultas_id_consulta, tratamientos_id_tratamientos) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

SELECT * FROM tipo_usuarios;
SELECT * FROM usuarios;
SELECT * FROM pacientes;
SELECT * FROM medicos;
SELECT * FROM consultas;
SELECT * FROM tratamientos;
SELECT * FROM citas;
SELECT * FROM consultas_has_tratamientos;

-- Modificar el nombre de un usuario
UPDATE usuarios 
SET nombre_usuario = 'Juan Pablo Perez' 
WHERE id_usuarios = 1;

-- Modificar la especialidad de un médico
UPDATE medicos 
SET especialidad = 'Oncología' 
WHERE id_medicos = 2;

-- Cambiar el diagnóstico de una consulta
UPDATE consultas 
SET diagnostico = 'Gripe severa' 
WHERE id_consulta = 2;

-- Modificar el estado de una cita
UPDATE citas 
SET estado = 'Confirmada' 
WHERE id_cita = 3;

-- Modificar un tratamiento
UPDATE tratamientos 
SET desc_tratamiento = 'Terapia intensiva' 
WHERE id_tratamientos = 2;

-- Verificar cambios en la tabla usuarios
SELECT * FROM usuarios WHERE id_usuarios = 1;

-- Verificar cambios en la tabla medicos
SELECT * FROM medicos WHERE id_medicos = 2;

-- Verificar cambios en la tabla consultas
SELECT * FROM consultas WHERE id_consulta = 2;

-- Verificar cambios en la tabla citas
SELECT * FROM citas WHERE id_cita = 3;

-- Verificar cambios en la tabla tratamientos
SELECT * FROM tratamientos WHERE id_tratamientos = 2;


-- Eliminar un usuario de prueba
DELETE FROM usuarios WHERE id_usuarios = 5;

-- Eliminar un paciente de prueba
DELETE FROM pacientes WHERE id_pacientes = 5;

-- Eliminar una consulta de prueba
DELETE FROM consultas WHERE id_consulta = 5;

-- Eliminar un tratamiento de prueba
DELETE FROM tratamientos WHERE id_tratamientos = 5;

-- Eliminar una cita de prueba
DELETE FROM citas WHERE id_cita = 5;

-- Verificar cambios en la tabla usuarios después del DELETE
SELECT * FROM usuarios;

-- Verificar cambios en la tabla medicos después del DELETE
SELECT * FROM medicos;

-- Verificar cambios en la tabla consultas después del DELETE
SELECT * FROM consultas;

-- Verificar cambios en la tabla citas después del DELETE
SELECT * FROM citas;

-- Verificar cambios en la tabla tratamientos después del DELETE
SELECT * FROM tratamientos;