-- Análisis exploratorio inicial
-- Proyecto: Reportes 911 2026

-- =====================================================
-- ¿CUAL ES LA CANTIDAD TOTAL DE REGISTROS?
-- =====================================================

-- Verificar cantidad total de registros
SELECT COUNT(*) AS total_registros
FROM reportes_911.incidencias_2026;

-- =====================================================
-- ¿CUANTOS INCIDENTES DE CADA PRIORIDAD?
-- NOS PERMITIRÁ IDENTIFICAR LA DISTRIBUCIÓN DE LOS INCIDENTES POR PRIORIDAD 
-- =====================================================

SELECT prioridad, COUNT(*) AS núm_incidentes
FROM reportes_911.incidencias_2026
GROUP BY prioridad
ORDER BY núm_incidentes DESC;

-- =====================================================
-- ¿COMO SE ENCUENTRA LA DISTRIBUCIÓN DE INCIDENTES POR TIPO?
-- IDENTIFICAR CUAL ES EL TIPO QUE MAS INCIDENTES TIENE
-- =====================================================

SELECT tipo, COUNT(*) AS núm_incidentes
FROM reportes_911.incidencias_2026
GROUP BY tipo
ORDER BY núm_incidentes DESC;

-- =====================================================
-- ¿QUE MUNICIPIO CONCENTRA LA MAYOR CANTIDAD DE INCIDENTES?
-- NOS PERMITIRÁ IDENTIFICAR EL MUNICIPIO CON MAYOR NÚMERO DE INCIDENTES, Y PARTIR PARA DETALLAR HORARIOS Y LUGARES
-- =====================================================

SELECT municipio, COUNT(*) AS núm_incidentes
FROM reportes_911.incidencias_2026
GROUP BY municipio
ORDER BY núm_incidentes DESC;

-- =====================================================
-- ¿CUAL ES LA DISTRIBUCIÓN POR TIPO DE INCIDENTE EN CADA MUNICIPIO?
-- CON ESTO EN UN CASO REAL, PODRÍAN TOMARSE ACCIONES QUE PERMITAN MEJORAR LA ATENCIÓN
-- =====================================================

SELECT municipio, tipo, COUNT(*) AS núm_incidentes
FROM reportes_911.incidencias_2026
GROUP BY municipio, tipo
ORDER BY municipio;

-- ====================================================================
-- ¿QUE PORCENTAJE REPRESENTA CADA TIPO DE INCIDENTE EN CADA MUNICIPIO?
-- PERMITIRÁ IDENTIFICAREL SESGO EN POR TIPO DE INCIDENTE EN CADA MUNICIPIO
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

-- ====================================================================
-- ¿CUANTOS INCIDENTES DEL TIPO MÉDICO Y CON PRIORIDAD ALTA TIENE CADA MUNICIPIO?
-- PODEMOS EMPEZAR A ENTRAR EN EL DETALLE DE CADA MUNICIPIO, DEPENDIENDO SU DISTRIBUCIÓN
-- ====================================================================

SELECT municipio, COUNT(*) AS num_incidentes
FROM reportes_911.incidencias_2026
WHERE tipo = 'Médico' AND prioridad = 'ALTA'
GROUP BY municipio
ORDER BY num_incidentes DESC;

-- ====================================================================
-- ¿CUANTOS INCIDENTES DE SEGURIDAD, PRIORIDAD ALTA Y EL RESTO TIENE CADA MUNICIPIO?
-- ====================================================================
SELECT
    municipio,
    SUM(CASE WHEN tipo = 'Seguridad' 
    THEN 1 ELSE 0 END) AS Seguridad,
    SUM(CASE WHEN (tipo = 'Seguridad' AND prioridad = 'ALTA') 
    THEN 1 ELSE 0 END) AS Seguridad_alta,
    SUM(CASE WHEN (tipo = 'Seguridad' AND prioridad <> 'ALTA') 
    THEN 1 ELSE 0 END) AS Seguridad_no_alta,
    COUNT(*) AS Total_Incidentes
FROM reportes_911.incidencias_2026
GROUP BY municipio
ORDER BY Total_Incidentes DESC;
