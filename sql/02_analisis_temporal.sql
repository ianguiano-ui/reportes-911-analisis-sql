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

