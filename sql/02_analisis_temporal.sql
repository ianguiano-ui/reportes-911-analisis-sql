-- Análisis temporal
-- Proyecto: Reportes 911 2026

USE Reportes_911;

-- =====================================================
-- INCIDENTES POR MES
-- =====================================================

SELECT 
    MONTHNAME(fecha) AS mes, 
    COUNT(*) AS incidentes_mensuales
FROM reportes_911.incidencias_2026
GROUP BY MONTH(fecha), MONTHNAME(fecha)
ORDER BY MONTH(fecha);

-- =====================================================
-- INCIDENTES POR SEMANA
-- =====================================================
SELECT 
    DAYNAME(fecha) AS día_semana, 
    COUNT(*) AS incidentes_por_día_semana
FROM reportes_911.incidencias_2026
GROUP BY DAYOFWEEK(fecha), DAYNAME(fecha)
ORDER BY DAYOFWEEK(fecha);

-- =====================================================
-- INCIDENTES POR HORA
-- =====================================================

SELECT 
    HOUR(HORA) AS horario, 
    COUNT(*) AS incidentes_por_hora
FROM reportes_911.incidencias_2026
GROUP BY horario
ORDER BY horario;

-- =====================================================
-- INCIDENTES POR HORA Y TIPO
-- =====================================================

SELECT 
    HOUR(HORA) AS horario,
        SUM(CASE WHEN tipo='Médico' THEN 1 ELSE 0 END) AS Médico,
        SUM(CASE WHEN tipo='Seguridad' THEN 1 ELSE 0 END) AS Seguridad,
        SUM(CASE WHEN tipo='Protección Civil' THEN 1 ELSE 0 END) AS Protección_Civil,
        SUM(CASE WHEN tipo='Improcedentes' THEN 1 ELSE 0 END) AS Improcedentes,
        SUM(CASE WHEN tipo='Servicio Públicos' THEN 1 ELSE 0 END) AS Servicio_Públicos,
        SUM(CASE WHEN tipo='Otros Servicios' THEN 1 ELSE 0 END) AS Otros_Servicios,        
        SUM(CASE WHEN tipo='Asistencia' THEN 1 ELSE 0 END) AS Asistencia,
        COUNT(*) AS Total_Hora
FROM reportes_911.incidencias_2026
GROUP BY horario WITH ROLLUP
ORDER BY horario;

-- =====================================================
-- INCIDENTES POR MUNICIPIO,HORA Y TIPO
-- =====================================================

/*
PREGUNTA DE ANÁLISIS:
¿Cómo se distribuyen los tipos de incidentes por hora
en cada municipio?

OBJETIVO:
Identificar diferencias en la concentración horaria de los
tipos de incidentes entre municipios.
*/

SELECT 
	municipio,
    HOUR(HORA) AS horario,
        SUM(CASE WHEN tipo='Médico' THEN 1 ELSE 0 END) AS Médico,
        SUM(CASE WHEN tipo='Seguridad' THEN 1 ELSE 0 END) AS Seguridad,
        SUM(CASE WHEN tipo='Protección Civil' THEN 1 ELSE 0 END) AS Protección_Civil,
        SUM(CASE WHEN tipo='Improcedentes' THEN 1 ELSE 0 END) AS Improcedentes,
        SUM(CASE WHEN tipo='Servicio Públicos' THEN 1 ELSE 0 END) AS Servicio_Públicos,
        SUM(CASE WHEN tipo='Otros Servicios' THEN 1 ELSE 0 END) AS Otros_Servicios,        
        SUM(CASE WHEN tipo='Asistencia' THEN 1 ELSE 0 END) AS Asistencia,
        COUNT(*) AS Total_Hora
FROM reportes_911.incidencias_2026
GROUP BY municipio, horario WITH ROLLUP
ORDER BY municipio, horario;
