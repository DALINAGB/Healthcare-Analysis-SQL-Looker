-- Creación de la Vista Maestra unificando Pacientes, Condiciones y Encuentros
-- Se aplica corrección lógica de 'Edad al Diagnóstico' para precisión epidemiológica.

CREATE OR REPLACE VIEW `tu_proyecto.clinica_datos.v_master_pacientes_diagnosticos` AS
SELECT 
    p.id AS paciente_id,
    p.gender AS genero,
    p.race AS raza,
    c.description AS diagnostico_nombre,
    c.start AS fecha_inicio_diagnostico,
    -- Cálculo de edad al momento del evento clínico
    TIMESTAMP_DIFF(CAST(c.start AS TIMESTAMP), CAST(p.birthdate AS TIMESTAMP), YEAR) AS edad_al_diagnostico,
    -- Segmentación etaria clínica
    CASE 
        WHEN TIMESTAMP_DIFF(CAST(c.start AS TIMESTAMP), CAST(p.birthdate AS TIMESTAMP), YEAR) <= 17 THEN 'Pediatría (0-17)'
        WHEN TIMESTAMP_DIFF(CAST(c.start AS TIMESTAMP), CAST(p.birthdate AS TIMESTAMP), YEAR) <= 40 THEN 'Adulto Joven (18-40)'
        WHEN TIMESTAMP_DIFF(CAST(c.start AS TIMESTAMP), CAST(p.birthdate AS TIMESTAMP), YEAR) <= 65 THEN 'Adulto Maduro (41-65)'
        ELSE 'Adulto Mayor (65+)'
    END AS grupo_etario
FROM `tu_proyecto.clinica_datos.patients` p
JOIN `tu_proyecto.clinica_datos.conditions` c ON p.id = c.patient;
