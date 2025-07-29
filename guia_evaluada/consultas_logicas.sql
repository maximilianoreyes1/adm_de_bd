-- QUITAR MODO SEGURO
SET SQL_SAFE_UPDATES = 0;

-- 1.- LIMPIEZA DE DATOS
USE gestion_academica;

-- a.- tabla personas
select * from personas
where rut is null or correo is null;

-- b.- tabla usuarios
select * from usuarios
where username is null;

-- c.- tabla cursos
select * from cursos
where fecha_inicio is null or nombre_curso is null or duracion_horas is null;

-- d.- tabla matriculas
select * from matriculas 
where fecha_matricula is null or estado is null;

-- BORRADO FÍSICO DE REGISTROS NULOS

-- a.- borrado de tabla personas
delete from personas
where rut is null;
select * from personas;

-- b.- borrado de tabla usuarios
delete from matriculas
where id_usuario = 2 or id_usuario = 6 ;

delete from docente_curso
where id_usuario = 2 or id_usuario = 6;

delete from usuarios
where username is null;
select * from usuarios;

-- c.- borrado de tabla cursos
delete from matriculas
where id_curso = 7;

delete from docente_curso
where id_curso = 7;

delete from cursos
where nombre_curso is null;
select * from cursos;

-- d.- borrado de tabla matriculas
delete from matriculas
where estado is null;
select * from matriculas;

-- 3.- CORRECCIÓN DE DATOS

-- a.- acutalizar correos
update personas
set correo = 'correoCorregido@email.com'
where correo is null;
select * from personas where correo = 'correoCorregido@email.com';

-- b.- actualizar fecha_inicio
update cursos
set fecha_inicio = '2025-05-15'
where fecha_inicio is null;
select * from cursos where fecha_inicio = '2025-05-15';

-- 4.- BORRADO LÓGICO

-- a.- Marca como deleted = 1 un curso y un estudiante de tu elección.
UPDATE cursos SET deleted = 1 WHERE id_curso = 3;
UPDATE usuarios SET deleted = 1 WHERE id_usuario = 8;

-- b.- select que muestre los usuarios y cursos activos
select * from cursos where deleted = 0;
select * from usuarios where deleted = 0;

-- 5.- VALIDACIÓN DE REGISTROS ACTIVOS
select * from cursos where deleted = 1;
select * from usuarios where deleted = 1;

-- 6.- JOIN DE 2 TABLAS
select 
    u.username,
    p.nombre_completo,
    u.id_tipo_usuario as tipo_usuario
from usuarios u
join personas p on u.id_persona = p.id_persona
where u.deleted = 0 and p.deleted = 0;

-- 7.- JOIN ENTRE 3 TABLAS
select p.nombre_completo, c.nombre_curso, m.estado
from matriculas m
join cursos c on m.id_curso = c.id_curso
join personas p on m.id_usuario = p.id_persona
where p.deleted = 0 and c.deleted = 0;

-- 8.- JOIN ENTRE 4 TABLAS

-- 9.- FILTROS AVANZADOS
-- a.-Lista todos los cursos activos que tengan duracion_horas > 30.
SELECT * FROM cursos WHERE deleted = 0 AND duracion_horas > 30;

-- b.- Lista los estudiantes activos cuyo correo tenga más de 15 caracteres.
select p.nombre_completo, p.correo from usuarios u
join personas p on u.id_persona = p.id_persona
where u.deleted = 0 and p.deleted = 0 and u.id_tipo_usuario = 3 and length(p.correo) > 15;
-- 10.- FECHAS Y OPERADORES LÓGICOS
-- a.- Muestra todas las matrículas realizadas después de '2025-08-22' que estén en estado vigente.
select * from matriculas
where fecha_matricula > '2025-08-22' and estado = 'vigente';

-- b.- Muestra cursos activos cuyo fecha_inicio no sea NULL y esté entre '2025-09-01' y '2025-09-30'.
select * from cursos
where deleted = 0 and fecha_inicio is not null and fecha_inicio between '2025-09-01' and '2025-09-30';
