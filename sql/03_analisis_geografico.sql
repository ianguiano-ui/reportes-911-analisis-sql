
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

-- =====================================================
-- SE CALCULA ALTO Y ANCHO, PARA IDENTIFICAR EL CUADRANTE
DENTRO DEL QUE CAEN TODOS LOS INCIDENTES
-- =====================================================

SELECT 
MAX(ST_X(coordenadas)) - MIN(ST_X(coordenadas)) AS rango_longitud,
MAX(ST_Y(coordenadas)) - MIN(ST_Y(coordenadas)) AS rango_latitud
FROM reportes_911.incidencias_2026
;
