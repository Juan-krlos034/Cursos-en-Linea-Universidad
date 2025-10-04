# 📘 Ejercicio: Procedimientos Almacenados en MySQL

Este repositorio contiene un ejercicio académico con procedimientos almacenados, usando MySQL.

## 📂 Archivos incluidos

- `estructura.sql` → Creación de tablas (`Cursos`, `Estudiantes`, `Inscripciones`, `Calificaciones`).
- `datos_prueba.sql` → Inserción de datos de ejemplo (10 registros por tabla).
- `procedimientos.sql` → Implementación de los 5 procedimientos solicitados:
  1. `sp_inscribir_estudiante`
  2. `sp_promedio_estudiante`
  3. `sp_cursos_por_estudiante`
  4. `sp_actualizar_calificacion`
  5. `sp_eliminar_inscripcion`
- `pruebas.sql` → Llamadas de prueba para ejecutar los procedimientos.
- `README.md` → Explicación del proyecto.

## ▶️ Pasos para ejecutar

1. Crear la base de datos y tablas:
   ```sql
   SOURCE estructura.sql;
   ```
2. Insertar datos de prueba:
   ```sql
   SOURCE datos_prueba.sql;
   ```
3. Crear los procedimientos almacenados:
   ```sql
   SOURCE procedimientos.sql;
   ```
4. Probar las funciones:
   ```sql
   SOURCE pruebas.sql;
   ```

## 🧑‍💻 Autor
Trabajo académico - Octubre 2025
