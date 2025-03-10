CREATE DATABASE agencia_viajes;

USE agencia_viajes;

CREATE TABLE persona (
    RUT INT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    fecha_nac DATE,
    pais VARCHAR(45),
    created DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tipo_usuarios (
    id_tipo_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo_usuario VARCHAR(45) NOT NULL,
    desc_tipo_usuario VARCHAR(45),
    created DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(45) NOT NULL UNIQUE,
    password VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
    telefono INT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_usuarios_id_tipo_usuario INT NOT NULL,
    persona_RUT INT NOT NULL,
    FOREIGN KEY (tipo_usuarios_id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo_usuario) ON DELETE CASCADE,
    FOREIGN KEY (persona_RUT) REFERENCES persona(RUT) ON DELETE CASCADE
);

CREATE TABLE viajes (
    id_viajes INT PRIMARY KEY AUTO_INCREMENT,
    destino VARCHAR(45) NOT NULL,
    lugar_salida VARCHAR(45) NOT NULL,
    hora_salida DATETIME NOT NULL,
    hora_llegada DATETIME NOT NULL,
    numero_asiento INT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usuarios_has_viajes (
    usuarios_id_usuario INT NOT NULL,
    viajes_id_viajes INT NOT NULL,
    PRIMARY KEY (usuarios_id_usuario, viajes_id_viajes),
    FOREIGN KEY (usuarios_id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (viajes_id_viajes) REFERENCES viajes(id_viajes) ON DELETE CASCADE
);