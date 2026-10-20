-- Análisis temporal
-- Proyecto: Reportes 911 2026

-- =====================================================
-- ANTES DE INICIAR CON EL ANALISIS DE LA INFORMACIÓN, 
-- SE VALIDA QUE LOS CAMPOS TENGAN EL FORMATO CORRECTO
-- =====================================================

DESCRIBE reportes_911.incidencias_2026;

-- =====================================================
-- ¿CUANTOS INCIDENTES EN CADA MES SE TIENEN?
-- NOS PERMITE IDENTIFICAR FECHAS CON MAYOR INCIDENCIA
-- =====================================================

SELECT 
    MONTHNAME(fecha) AS mes, 
    COUNT(*) AS incidentes_mensuales
FROM reportes_911.incidencias_2026
GROUP BY MONTH(fecha), MONTHNAME(fecha)
ORDER BY incidentes_mensuales DESC;

-- =====================================================
-- ¿CUAL ES EL DÍA DE LA SEMANA CON MAYOR INCIDENCIA?
-- SON CONSULTAS INDIVIDUALES, SIN EMBARGO PERMITEN LA IDENTIFICACIÓN DE FECHAS CON MAYOR INCIDENCIA
-- =====================================================
SELECT 
    DAYNAME(fecha) AS día_semana, 
    COUNT(*) AS incidentes_por_día_semana
FROM reportes_911.incidencias_2026
GROUP BY DAYOFWEEK(fecha), DAYNAME(fecha)
ORDER BY DAYOFWEEK(fecha);

-- =====================================================
-- ¿CUAL ES EL HORARIO CON MAYOR INCIDENCIA ?
-- PERMITIRÁ CREAR UN RELOJ CRIMINOLOGICO QUE AYUDA A LA TOMA DE DECISIONES 
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
/*
PREGUNTA DE ANÁLISIS:
¿Cómo se distribuyen los tipos de incidentes por hora
y tipo?

OBJETIVO:
Identificar diferencias en la concentración horaria por tipo de incidente.
*/
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
