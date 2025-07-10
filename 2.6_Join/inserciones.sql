Use clinica_veterinaria;

INSERT INTO tipo_usuarios (nombre_tipo, descripcion_tipo)
VALUES 
('veterinario', 'Profesional encargado de la atención médica de animales.'),
('dueño', 'Persona que posee una o más mascotas.'),
('recepcionista', 'Encargado de la atención en la recepción de la clínica.');

INSERT INTO dueños (nombre_dueño, rut, correo, direccion, telefono)
VALUES 
('Carla Pérez', '19.234.567-8', 'carla.perez@mail.com', 'Calle 1, Santiago', '912345678'),
('Luis González', '18.987.654-3', 'luis.gonzalez@mail.com', 'Avenida 2, La Florida', '923456789'),
('Andrea Rojas', '20.111.222-5', 'andrea.rojas@mail.com', 'Pasaje 3, Ñuñoa', '934567890'),
('Marco Díaz', '17.456.789-0', 'marco.diaz@mail.com', 'Calle 4, Providencia', '945678901'),
('Sofía Fuentes', '21.123.456-1', 'sofia.fuentes@mail.com', 'Calle 5, Las Condes', '956789012'),
('Jorge Herrera', '16.789.123-6', 'jorge.herrera@mail.com', 'Calle 6, Puente Alto', '967890123'),
('Camila Soto', '15.654.321-2', 'camila.soto@mail.com', 'Villa 7, San Bernardo', '978901234'),
('Nicolás Vargas', '14.321.987-4', 'nicolas.vargas@mail.com', 'Calle 8, Maipú', '989012345'),
('Paula Núñez', '13.876.543-5', 'paula.nunez@mail.com', 'Calle 9, Recoleta', '990123456'),
('Matías Bravo', '12.345.678-9', 'matias.bravo@mail.com', 'Calle 10, Independencia', '901234567');

INSERT INTO usuarios (nombre_usuario, contraseña, id_tipo_usuario, id_dueño)
VALUES 
('Dr. Ramírez', 'clave123', 1, NULL),
('Dra. López', 'vet456', 1, NULL),
('Recep. Juan', 'rec789', 3, NULL),
('Carla Pérez', 'carla123', 2, 1),
('Luis González', 'luis123', 2, 2),
('Andrea Rojas', 'andrea123', 2, 3),
('Marco Díaz', 'marco123', 2, 4),
('Sofía Fuentes', 'sofia123', 2, 5),
('Jorge Herrera', 'jorge123', 2, 6),
('Camila Soto', 'camila123', 2, 7);

INSERT INTO tipo_mascotas (especie, descripcion_especie)
VALUES 
('Perro', 'Animal doméstico leal, conocido por su compañía.'),
('Gato', 'Felino independiente y curioso, ideal como mascota.'),
('Conejo', 'Pequeño roedor suave y tranquilo como mascota.');

INSERT INTO razas (raza, id_tipo_mascota)
VALUES 
('Labrador', 1),
('Poodle', 1),
('Siames', 2),
('Persa', 2),
('Cabeza de León', 3),
('Mini Lop', 3);

INSERT INTO mascotas (nombre_mascota, comportamiento, fecha_nacimiento, sexo, id_dueño, id_raza)
VALUES 
('Max', 'Muy activo y sociable con personas.', '2020-05-01', 'macho', 1, 1),
('Luna', 'Tranquila y cariñosa.', '2019-08-15', 'hembra', 2, 2),
('Simba', 'Curioso y juguetón.', '2021-01-22', 'macho', 3, 3),
('Nala', 'Tímida pero afectuosa.', '2020-11-05', 'hembra', 4, 4),
('Bunny', 'Saltarina y amistosa.', '2022-03-18', 'hembra', 5, 5),
('Coco', 'Tranquilo y dormilón.', '2018-09-30', 'macho', 6, 6),
('Rocky', 'Protector y valiente.', '2017-07-07', 'macho', 7, 1),
('Mía', 'Juguetona con niños.', '2021-12-25', 'hembra', 8, 2),
('Pelusa', 'Escurridizo pero tierno.', '2023-02-10', 'macho', 9, 5),
('Tom', 'Cazador nato, muy inquieto.', '2020-06-06', 'macho', 10, 3);

INSERT INTO diagnosticos (descripcion_diagnostico)
VALUES 
('Infección bacteriana en el oído de leve intensidad.'),
('Fractura en una pata trasera, requiere reposo.'),
('Dermatitis alérgica causada por picadura de pulga.'),
('Gastroenteritis leve, probablemente por alimento contaminado.'),
('Obstrucción respiratoria aguda por cuerpo extraño.'),
('Otitis aguda con secreción abundante.'),
('Parásitos intestinales detectados en examen.'),
('Deshidratación por insolación leve.'),
('Dolor abdominal con sospecha de obstrucción.'),
('Herida abierta por pelea con otro animal.');

INSERT INTO consultas (fecha_consulta, motivo, id_diagnostico, id_mascota, id_usuario)
VALUES 
('2024-07-01', 'Consulta por urgencia debido a vómitos constantes.', 4, 1, 1),
('2024-07-02', 'Consulta de control por vacuna anual.', 7, 2, 1),
('2024-07-03', 'Consulta por urgencia tras caída desde altura.', 2, 3, 2),
('2024-07-04', 'Evaluación por rascarse en exceso.', 3, 4, 2),
('2024-07-05', 'Consulta por comportamiento agresivo repentino.', 10, 5, 1),
('2024-07-06', 'Consulta de rutina para control general.', 1, 6, 2),
('2024-07-07', 'Consulta por urgencia tras ataque de otro perro.', 9, 7, 1),
('2024-07-08', 'Evaluación de cojera en pata delantera.', 2, 8, 1),
('2024-07-09', 'Consulta preventiva tras paseo por campo.', 8, 9, 2),
('2024-07-10', 'Consulta por urgencia por dificultad respiratoria.', 5, 10, 2);