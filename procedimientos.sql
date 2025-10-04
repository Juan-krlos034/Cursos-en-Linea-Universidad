-- procedimientos.sql
DELIMITER $$

CREATE PROCEDURE sp_inscribir_estudiante(IN p_id_estudiante INT, IN p_id_curso INT)
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*) INTO v_count FROM Estudiantes WHERE id_estudiante = p_id_estudiante;
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estudiante no existe.';
    END IF;

    SELECT COUNT(*) INTO v_count FROM Cursos WHERE id_curso = p_id_curso;
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Curso no existe.';
    END IF;

    SELECT COUNT(*) INTO v_count FROM Inscripciones WHERE id_estudiante = p_id_estudiante AND id_curso = p_id_curso;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estudiante ya inscrito en este curso.';
    END IF;

    INSERT INTO Inscripciones (id_estudiante, id_curso, fecha_inscripcion)
    VALUES (p_id_estudiante, p_id_curso, CURDATE());

    SELECT LAST_INSERT_ID() AS id_inscripcion;
END$$

CREATE PROCEDURE sp_promedio_estudiante(IN p_id_estudiante INT)
BEGIN
    DECLARE v_exists INT;

    SELECT COUNT(*) INTO v_exists FROM Estudiantes WHERE id_estudiante = p_id_estudiante;
    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estudiante no existe.';
    END IF;

    SELECT ROUND(AVG(c.nota), 2) AS promedio
    FROM Calificaciones c
    JOIN Inscripciones i ON c.id_inscripcion = i.id_inscripcion
    WHERE i.id_estudiante = p_id_estudiante;
END$$

CREATE PROCEDURE sp_cursos_por_estudiante(IN p_id_estudiante INT)
BEGIN
    SELECT c.id_curso, c.nombre, c.descripcion, c.duracion, i.fecha_inscripcion
    FROM Cursos c
    JOIN Inscripciones i ON c.id_curso = i.id_curso
    WHERE i.id_estudiante = p_id_estudiante
    ORDER BY i.fecha_inscripcion;
END$$

CREATE PROCEDURE sp_actualizar_calificacion(IN p_id_estudiante INT, IN p_id_curso INT, IN p_nota DECIMAL(5,2))
BEGIN
    DECLARE v_id_insc INT;
    DECLARE v_count INT;

    SELECT id_inscripcion INTO v_id_insc FROM Inscripciones
    WHERE id_estudiante = p_id_estudiante AND id_curso = p_id_curso LIMIT 1;

    IF v_id_insc IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante no está inscrito en este curso.';
    END IF;

    SELECT COUNT(*) INTO v_count FROM Calificaciones WHERE id_inscripcion = v_id_insc;

    IF v_count > 0 THEN
        UPDATE Calificaciones SET nota = p_nota, fecha_evaluacion = CURDATE()
        WHERE id_inscripcion = v_id_insc;
    ELSE
        INSERT INTO Calificaciones (id_inscripcion, nota, fecha_evaluacion)
        VALUES (v_id_insc, p_nota, CURDATE());
    END IF;

    SELECT 'OK' AS resultado;
END$$

CREATE PROCEDURE sp_eliminar_inscripcion(IN p_id_estudiante INT, IN p_id_curso INT)
BEGIN
    DECLARE v_id_insc INT;

    SELECT id_inscripcion INTO v_id_insc FROM Inscripciones
    WHERE id_estudiante = p_id_estudiante AND id_curso = p_id_curso LIMIT 1;

    IF v_id_insc IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Inscripción no encontrada.';
    END IF;

    DELETE FROM Calificaciones WHERE id_inscripcion = v_id_insc;
    DELETE FROM Inscripciones WHERE id_inscripcion = v_id_insc;

    SELECT 'ELIMINADA' AS resultado;
END$$

DELIMITER ;
