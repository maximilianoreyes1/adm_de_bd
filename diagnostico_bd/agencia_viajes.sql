CREATE DATABASE agencia_viajes;

USE agencia_viajes;

CREATE TABLE persona (
    RUT INT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    fecha_nac DATE,
    pais VARCHAR(45),
    created VARCHAR(45)
);

CREATE TABLE tipo_usuarios (
    id_tipo_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo_usuario VARCHAR(45) NOT NULL,
    desc_tipo_usuario VARCHAR(45),
    created DATETIME
);

CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(45) NOT NULL,
    password VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    telefono INT,
    created DATETIME,
    tipo_usuarios_id_tipo_usuario INT NOT NULL,
    persona_RUT INT NOT NULL,
    FOREIGN KEY (tipo_usuarios_id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo_usuario),
    FOREIGN KEY (persona_RUT) REFERENCES persona(RUT)
);

CREATE TABLE aeropuertos (
    id_aeropuerto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_aeropuerto VARCHAR(45) NOT NULL,
    ubicacion VARCHAR(45) NOT NULL,
    created VARCHAR(45)
);

CREATE TABLE viajes (
    idviajes INT PRIMARY KEY AUTO_INCREMENT,
    fecha_salida DATE NOT NULL,
    fecha_llegada DATE NOT NULL,
    numero_asiento INT NOT NULL,
    costo INT NOT NULL,
    created DATETIME,
    origen INT NOT NULL,
    destino INT NOT NULL,
    FOREIGN KEY (origen) REFERENCES aeropuertos(id_aeropuerto),
    FOREIGN KEY (destino) REFERENCES aeropuertos(id_aeropuerto)
);

CREATE TABLE usuarios_has_viajes (
    usuarios_id_usuario INT NOT NULL,
    viajes_idviajes INT NOT NULL,
    PRIMARY KEY (usuarios_id_usuario, viajes_idviajes),
    FOREIGN KEY (usuarios_id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (viajes_idviajes) REFERENCES viajes(idviajes)
);


INSERT INTO persona (RUT, nombre, apellido, fecha_nac, pais, created) VALUES
(101, 'Juan', 'Pérez', '1990-05-14', 'Chile', NOW()),
(102, 'María', 'González', '1985-08-20', 'Argentina', NOW()),
(103, 'Carlos', 'Rodríguez', '1992-11-02', 'Perú', NOW()),
(104, 'Ana', 'López', '1998-03-30', 'México', NOW()),
(105, 'Pedro', 'Martínez', '1980-07-10', 'España', NOW());


INSERT INTO tipo_usuarios (nombre_tipo_usuario, desc_tipo_usuario, created) VALUES
('Administrador', 'Acceso total al sistema', NOW()),
('Cliente', 'Puede reservar y consultar viajes', NOW()),
('Empleado', 'Gestiona vuelos y pasajeros', NOW()),
('Piloto', 'Encargado de operar vuelos', NOW()),
('Asistente', 'Asistencia en aeropuertos', NOW());

INSERT INTO usuarios (username, password, email, telefono, created, tipo_usuarios_id_tipo_usuario, persona_RUT) VALUES
('juanperez', '123456', 'juanperez@email.com', 987654321, NOW(), 2, 101),
('mariagonz', 'abcdef', 'mariagonz@email.com', 987654322, NOW(), 2, 102),
('carlosr', 'qwerty', 'carlosr@email.com', 987654323, NOW(), 1, 103),
('analopez', 'pass123', 'analopez@email.com', 987654324, NOW(), 3, 104),
('pedrom', 'adminpass', 'pedrom@email.com', 987654325, NOW(), 1, 105);


INSERT INTO aeropuertos (nombre_aeropuerto, ubicacion, created) VALUES
('Aeropuerto Internacional de Santiago', 'Chile', NOW()),
('Aeropuerto de Ezeiza', 'Argentina', NOW()),
('Aeropuerto Jorge Chávez', 'Perú', NOW()),
('Aeropuerto Benito Juárez', 'México', NOW()),
('Aeropuerto de Madrid-Barajas', 'España', NOW());

INSERT INTO viajes (fecha_salida, fecha_llegada, numero_asiento, costo, created, origen, destino) VALUES
('2024-03-10', '2024-03-11', 23, 500, NOW(), 1, 2),
('2024-04-15', '2024-04-16', 45, 600, NOW(), 2, 3),
('2024-05-20', '2024-05-21', 10, 700, NOW(), 3, 4),
('2024-06-25', '2024-06-26', 30, 800, NOW(), 4, 5),
('2024-07-30', '2024-07-31', 50, 900, NOW(), 5, 1);


INSERT INTO usuarios_has_viajes (usuarios_id_usuario, viajes_idviajes) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
