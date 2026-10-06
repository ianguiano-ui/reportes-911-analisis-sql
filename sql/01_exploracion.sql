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


