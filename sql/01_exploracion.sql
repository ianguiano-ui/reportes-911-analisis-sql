-- Análisis exploratorio inicial
-- Proyecto: Reportes 911 2026

USE Reportes_911;

-- Verificar cantidad total de registros
SELECT COUNT(*) AS total_registros
FROM Incidencias_2026;

-- =====================================================
-- INCIDENTES POR MES
-- =====================================================

SELECT 
    MONTHNAME(fecha) AS mes, 
    COUNT(*) AS incidentes_mensuales
FROM reportes_911.incidencias_2026
GROUP BY MONTH(fecha), MONTHNAME(fecha)
ORDER BY MONTH(fecha);
