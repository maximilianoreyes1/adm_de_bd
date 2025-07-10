-- Crear la base de datos y usarla
DROP DATABASE IF EXISTS clinica_veterinaria;
CREATE DATABASE clinica_veterinaria;
USE clinica_veterinaria;

create table dueños(-- 1
id_dueño INT AUTO_INCREMENT PRIMARY KEY, 
nombre_dueño varchar(50) not null 
CHECK (CHAR_LENGTH(nombre_dueño) >= 3 AND nombre_dueño REGEXP '^[A-Za-zÁÉÍÓÚÑáéíóúñ ]+$'),
rut varchar(25) unique not null,
correo VARCHAR(100) UNIQUE,
direccion varchar(200),
telefono varchar(20),
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE tipo_usuarios (-- 2
id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY, 
nombre_tipo VARCHAR(100) NOT NULL 
check (nombre_tipo in ('veterinario', 'dueño', 'recepcionista')), 
descripcion_tipo varchar(300) not null,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);

CREATE TABLE usuarios (-- 3
id_usuario INT AUTO_INCREMENT PRIMARY KEY, 
nombre_usuario VARCHAR(100) NOT NULL 
CHECK (CHAR_LENGTH(nombre_usuario) >= 3 AND nombre_usuario REGEXP '^[A-Za-zÁÉÍÓÚÑáéíóúñ. ]+$'),
contraseña varchar(100) not null,
id_tipo_usuario INT,
foreign key(id_tipo_usuario) references tipo_usuarios(id_tipo_usuario),
id_dueño int,
foreign key (id_dueño) references dueños(id_dueño),
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);



create table tipo_mascotas(-- 5
id_tipo_mascota int primary key auto_increment,
especie varchar(100) not null,
descripcion_especie varchar(300) not null,
-- campos de auditoria
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp 
on update current_timestamp,
created_by int,
updated_by int,
deleted boolean default false
);

create table razas (-- 6
id_raza int primary key auto_increment,
raza varchar(100) not null
CHECK (CHAR_LENGTH(raza) >= 3 AND raza REGEXP '^[A-Za-zÁÉÍÓÚÑáéíóúñ. ]+$'),
id_tipo_mascota int,
foreign key (id_tipo_mascota) references tipo_mascotas(id_tipo_mascota),
-- campos de auditoria
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp
on update current_timestamp,
created_by int,
updated_by int,
deleted boolean default false
);

create table mascotas(-- 7
id_mascota int primary key auto_increment,
nombre_mascota varchar(100) not null
CHECK (CHAR_LENGTH(nombre_mascota) >= 3 AND nombre_mascota REGEXP '^[A-Za-zÁÉÍÓÚÑáéíóúñ. ]+$'),
comportamiento varchar(300) not null,
fecha_nacimiento date not null,
sexo varchar(50) CHECK(sexo in ('macho', 'hembra')),
id_dueño int,
foreign key (id_dueño) references dueños(id_dueño),
id_raza int,
foreign key (id_raza) references razas(id_raza),
-- campos de auditoria
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp 
on update current_timestamp,
created_by int,
updated_by int,
deleted boolean default false
);

create table diagnosticos(-- 8
id_diagnostico int primary key auto_increment,
descripcion_diagnostico varchar(100) not null,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);

create table consultas(-- 9
id_consulta int primary key auto_increment,
fecha_consulta date not null,
motivo varchar(100) not null,
id_diagnostico int,
foreign key (id_diagnostico) references diagnosticos(id_diagnostico),
id_mascota int,
foreign key (id_mascota) references mascotas(id_mascota),
id_usuario int,
foreign key (id_usuario) references usuarios(id_usuario),
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

create table recetas(-- 10
id_receta int primary key auto_increment,
fecha_emision datetime,
id_consulta int,
foreign key (id_consulta) references consultas(id_consulta),
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT CHECK (created_by <> 0),
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);



create table evaluaciones_medicas( -- 11
id_evaluacion_medica int primary key auto_increment,
id_receta int not null,
id_diagnostico int not null, 
fecha_evaluacion datetime,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT CHECK (created_by <> 0),
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);

alter table evaluaciones_medicas
add constraint fk_diagnosticos_evaluaciones_medicas
foreign key (id_diagnostico) references	diagnosticos(id_diagnostico);

alter table evaluaciones_medicas
add constraint fk_recetas_evaluaciones_medicas
foreign key (id_receta) references	recetas(id_receta); 

create table medicamentos(-- 12
id_medicamento int primary key auto_increment,
nombre_medicamento varchar(100) not null,
principio_activo varchar(100) not null,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

create table prescripciones(-- 13
id_prescripcion int primary key auto_increment,
id_receta int not null,
id_medicamento int not null, 
dosis int not null,
frecuencia int not null,
duracion int not null,
fecha_analisis datetime,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT 
CHECK (created_by <> 0),
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);

alter table prescripciones
add constraint fk_recetas_prescripciones
foreign key (id_receta) references	recetas(id_receta);

alter table prescripciones
add constraint fk_medicamentos_prescripciones
foreign key (id_medicamento) references	medicamentos(id_medicamento);
