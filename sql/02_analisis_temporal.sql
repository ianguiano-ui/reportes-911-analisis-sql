

/* INCIDENTES POR MES */
SELECT 
    MONTHNAME(fecha) AS mes, 
    COUNT(*) AS incidentes_mensuales
FROM reportes_911.incidencias_2026
GROUP BY MONTH(fecha), MONTHNAME(fecha)
ORDER BY MONTH(fecha);
