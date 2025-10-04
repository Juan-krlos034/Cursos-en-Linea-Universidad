-- pruebas.sql
USE universidad;

-- 1) Inscribir estudiante en curso
CALL sp_inscribir_estudiante(1, 2);

-- 2) Promedio de notas de Luis Fernández (id=5)
CALL sp_promedio_estudiante(5);

-- 3) Cursos de Carlos Ramírez (id=3)
CALL sp_cursos_por_estudiante(3);

-- 4) Actualizar nota de Carlos Ramírez en Fundamentos de Redes (curso 3)
CALL sp_actualizar_calificacion(3, 3, 89.00);

-- 5) Eliminar inscripción de Ana Torres en Java Avanzado (curso 4)
CALL sp_eliminar_inscripcion(4, 4);
