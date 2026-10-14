
-- =====================================================
-- EXTRACCIÓN DE LONGITUD Y LATITUD
-- =====================================================

SELECT 
folio, 
municipio, 
ST_X(coordenadas) AS longitud,
ST_Y(coordenadas) AS latitud
FROM reportes_911.incidencias_2026
;

-- =====================================================
-- ENCONTRAR LOS LÍMITES GEOGRÁFICOS DE LOS DATOS
-- =====================================================

SELECT 
MIN(ST_X(coordenadas)) AS longitud_minima,
MIN(ST_Y(coordenadas)) AS latitud_minima,
MAX(ST_X(coordenadas)) AS longitud_maxima,
MAX(ST_Y(coordenadas)) AS latitud_maxima
FROM reportes_911.incidencias_2026
;

