
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
-- DENTRO DEL QUE CAEN TODOS LOS INCIDENTES
-- =====================================================

SELECT 
MAX(ST_X(coordenadas)) - MIN(ST_X(coordenadas)) AS rango_longitud,
MAX(ST_Y(coordenadas)) - MIN(ST_Y(coordenadas)) AS rango_latitud
FROM reportes_911.incidencias_2026
;

-- =====================================================
-- SE CALCULA ALTO Y ANCHO DE CADA CUADRANTE, PARA ESTE PROYECTO
-- SE TRABAJARA CON UNA DE CUADRICULA DE 4X4
-- =====================================================
  
SELECT 
MIN(ST_X(coordenadas)) AS longitud_minima,
MAX(ST_X(coordenadas)) AS longitud_maxima,
(MAX(ST_X(coordenadas)) - MIN(ST_X(coordenadas)))/4 AS ancho_longitud,
MIN(ST_Y(coordenadas)) AS latitud_minima,
MAX(ST_Y(coordenadas)) AS latitud_maxima,
(MAX(ST_Y(coordenadas)) - MIN(ST_Y(coordenadas)))/4 AS alto_latitud
FROM reportes_911.incidencias_2026
;

-- =====================================================
-- SE ESTABLECEN LOS LÍMITES DE CADA CUADRANTE
-- =====================================================

SELECT 
MIN(ST_X(coordenadas)) AS longitud_minima,
MIN(ST_X(coordenadas))+((MAX(ST_X(coordenadas)) - MIN(ST_X(coordenadas)))/4) AS longitud_1,
MIN(ST_X(coordenadas))+((MAX(ST_X(coordenadas)) - MIN(ST_X(coordenadas)))/4)*2 AS longitud_2,
MIN(ST_X(coordenadas))+((MAX(ST_X(coordenadas)) - MIN(ST_X(coordenadas)))/4)*3 AS longitud_3,
MIN(ST_X(coordenadas))+((MAX(ST_X(coordenadas)) - MIN(ST_X(coordenadas)))/4)*4 AS longitud_4,
MIN(ST_Y(coordenadas)) AS latitud_minima,
MIN(ST_Y(coordenadas))+((MAX(ST_Y(coordenadas)) - MIN(ST_Y(coordenadas)))/4) AS latitud_1,
MIN(ST_Y(coordenadas))+((MAX(ST_Y(coordenadas)) - MIN(ST_Y(coordenadas)))/4)*2 AS latitud_2,
MIN(ST_Y(coordenadas))+((MAX(ST_Y(coordenadas)) - MIN(ST_Y(coordenadas)))/4)*3 AS latitud_3,
MIN(ST_Y(coordenadas))+((MAX(ST_Y(coordenadas)) - MIN(ST_Y(coordenadas)))/4)*4 AS latitud_4
FROM reportes_911.incidencias_2026
;

-- =================================================================
-- CLASIFICACIÓN INICIAL DE LOS INCIDENTES PARA VALIDACIÓN Q01 Y Q02
-- =================================================================

SELECT *,
CASE WHEN (longitud >= -99.28589
		AND longitud < -99.235422)
    AND (latitud >= 18.767031
		AND latitud < 18.836225)
	THEN 'Q01'
	WHEN (longitud >= -99.235422
		AND longitud < -99.184954)
    AND (latitud >= 18.767031
		AND latitud < 18.836225)
	THEN 'Q02'
	ELSE 'Fuera de Rango'
END AS Cuadrante

FROM (
	SELECT *,
    ST_X(coordenadas) AS longitud,
	ST_Y(coordenadas) AS latitud
	FROM reportes_911.incidencias_2026
) AS Subconsulta_Cuadrantes
;

-- =================================================================
-- VALIDACIÓN Q01 Y Q02
-- =================================================================

SELECT COUNT(*), 
    Cuadrante
FROM (
SELECT *,
CASE WHEN (longitud >= -99.28589
		AND longitud < -99.235422)
    AND (latitud >= 18.767031
		AND latitud < 18.836225)
	THEN 'Q01'
	WHEN (longitud >= -99.235422
		AND longitud < -99.184954)
    AND (latitud >= 18.767031
		AND latitud < 18.836225)
	THEN 'Q02'
	ELSE 'Fuera de Rango'
END AS Cuadrante
FROM (
	SELECT *,
    ST_X(coordenadas) AS longitud,
	ST_Y(coordenadas) AS latitud
	FROM reportes_911.incidencias_2026
) AS Subconsulta_Cuadrantes
) AS Validación_Cuadrantes
GROUP BY Cuadrante
;
