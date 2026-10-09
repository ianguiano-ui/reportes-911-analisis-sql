-- Análisis exploratorio inicial
-- Proyecto: Reportes 911 2026

USE Reportes_911;
-- =====================================================
-- VERIFICAR CANTIDAD TOTAL DE REGISTROS
-- =====================================================
-- Verificar cantidad total de registros
SELECT COUNT(*) AS total_registros
FROM Incidencias_2026;

-- =====================================================
-- CONSULTA POR PRIORIDAD
-- =====================================================

SELECT prioridad, COUNT(*) AS núm_incidentes
FROM reportes_911.incidencias_2026
GROUP BY prioridad
ORDER BY núm_incidentes DESC;

-- =====================================================
-- CONSULTA POR TIPO
-- =====================================================

SELECT tipo, COUNT(*) AS núm_incidentes
FROM reportes_911.incidencias_2026
GROUP BY tipo
ORDER BY núm_incidentes DESC;

-- =====================================================
-- CONSULTA POR MUNICIPIO
-- =====================================================

SELECT municipio, COUNT(*) AS núm_incidentes
FROM reportes_911.incidencias_2026
GROUP BY municipio
ORDER BY núm_incidentes DESC;

-- =====================================================
-- CONSULTA POR MUNICIPIO Y TIPO
-- =====================================================

SELECT municipio, tipo, COUNT(*) AS núm_incidentes
FROM reportes_911.incidencias_2026
GROUP BY municipio, tipo
ORDER BY municipio;

-- ====================================================================
-- CONSULTA DE INCIDENTES POR MUNICIPIO Y % QUE REPRESENTA CADA TIPO
-- ====================================================================

SELECT
    municipio,

    ROUND((SUM(CASE WHEN tipo = 'Médico' THEN 1 ELSE 0 END)/COUNT(*))*100.0,2) AS Medico,
    ROUND((SUM(CASE WHEN tipo = 'Seguridad' THEN 1 ELSE 0 END)/COUNT(*))*100.0,2) AS Seguridad,
    ROUND((SUM(CASE WHEN tipo = 'Protección Civil' THEN 1 ELSE 0 END)/COUNT(*))*100.0,2) AS Proteccion_Civil,
    ROUND((SUM(CASE WHEN tipo = 'Improcedentes' THEN 1 ELSE 0 END)/COUNT(*))*100.0,2) AS Improcedentes,
    ROUND((SUM(CASE WHEN tipo = 'Servicio Públicos' THEN 1 ELSE 0 END)/COUNT(*))*100.0,2) AS Servicio_Publicos,
    ROUND((SUM(CASE WHEN tipo = 'Otros Servicios' THEN 1 ELSE 0 END)/COUNT(*))*100.0,2) AS Otros_Servicios,
    ROUND((SUM(CASE WHEN tipo = 'Asistencia' THEN 1 ELSE 0 END)/COUNT(*))*100.0,2) AS Asistencia,

    COUNT(*) AS Total_Incidentes

FROM reportes_911.incidencias_2026

GROUP BY municipio
ORDER BY Total_Incidentes DESC;

