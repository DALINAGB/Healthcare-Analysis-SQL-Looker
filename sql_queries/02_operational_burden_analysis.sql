-- Análisis de Carga Operativa: Pacientes Únicos vs. Volumen de Registros
-- Identifica qué patologías consumen más recursos administrativos y clínicos.

SELECT 
    diagnostico_nombre,
    COUNT(DISTINCT paciente_id) as total_pacientes,
    COUNT(*) as total_registros_clinicos,
    ROUND(COUNT(*) / COUNT(DISTINCT paciente_id), 2) as ratio_visitas_por_paciente
FROM `tu_proyecto.clinica_datos.v_master_pacientes_diagnosticos`
GROUP BY 1
ORDER BY total_registros_clinicos DESC
LIMIT 10;
