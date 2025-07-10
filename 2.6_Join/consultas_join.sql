-- Consultas JOIN

USE clinica_veterinaria;

-- mascotas, fecha de su consulta y el motivo
SELECT 
    m.nombre_mascota,
    c.fecha_consulta,
    c.motivo
FROM mascotas m
JOIN consultas c ON m.id_mascota = c.id_mascota;