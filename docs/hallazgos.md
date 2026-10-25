# Hallazgos
> ⚠️ **Nota metodológica:** Es importante hacer constar que este conjunto de datos es **sintético**. Aunque es funcional para fines educativos y de desarrollo técnico, el volumen y comportamiento de las variables no reflejan necesariamente la distribución ni la realidad estadística de la incidencia delictiva o de emergencias en el estado de Morelos.
> 
## 1. Distribución municipal

Consulta utilizada:
```sql
SELECT 
	municipio, 
	COUNT(*) AS núm_incidentes,
    ROUND((COUNT(*)/(SELECT COUNT(*) FROM reportes_911.incidencias_2026))*100,2) AS distribución_porcentaje
FROM 
	reportes_911.incidencias_2026
GROUP BY 
	municipio
ORDER BY 
	núm_incidentes DESC
;
```

Resultado:

| municipio       | núm_incidentes | distribución_porcentaje |
| :--- | :---: |:---: |
| Cuernavaca      | 7754           | 38.77                   |
| Jiutepec        | 4412           | 22.06                   |
| Temixco         | 2505           | 12.53                   |
| Emiliano Zapata | 2193           | 10.97                   |
| Xochitepec      | 1507           | 7.54                    |
| Tepoztlán       | 1127           | 5.64                    |
| Huitzilac       | 502            | 2.51                    |

**Hallazgo**: Se identifica que la carga operativa se concentra principalmente en la zona metropolitana del estado. **Cuernavaca** registra el mayor volumen de actividad con **7,754 incidentes (38.77%)**, seguido por **Jiutepec** con **4,412 reportes (22.06%)**. En conjunto, ambos municipios absorben más del 60% de la inicidencia total, una tendencia que se alinea directamente con la densidad poblacional y la concentración urbana características del estado de Morelos.

## 1.1 Distribución municipal por tipo

Consulta utilizada:
```sql
SELECT 
	tipo, 
    COUNT(*) AS núm_incidentes
FROM 
	reportes_911.incidencias_2026
GROUP BY 
	tipo
ORDER BY 
	núm_incidentes DESC
    ;
```

Resultado:

| tipo              | núm_incidentes |
| :--- | :---: |
| Médico            | 5965           |
| Seguridad         | 4739           |
| Protección Civil  | 2822           |
| Improcedentes     | 2119           |
| Servicio Públicos | 1700           |
| Asistencia        | 1683           |
| Otros Servicios   | 972            |

**Hallazgo**: A nivel general, la naturaleza de los reportes recibidos en los servicios de emergencia muestra que las **emergencias de tipo Médico** constituyen la principal demanda operativa con **5,965 incidentes**, seguidas por los eventos de **Seguridad** con **4,739 registros**. 

Este hallazgo inicial es clave, ya que establece el preludio para un desglose posterior más exhaustivo, donde se evaluará el impacto porcentual de cada tipología a nivel municipal. Identificar que el rubro médico lidera la estadística abre una oportunidad crítica para profundizar en los subtipos de incidentes específicos, proporcionando bases sólidas para la optimización de protocolos de despacho y la asignación eficiente de recursos médicos en campo.

## 1.2 Distribución Relativa de Incidentes por Municipio (%)

Consulta utilizada:
```sql
SELECT
    municipio,
    ROUND((SUM(CASE WHEN tipo = 'Médico' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS Medico,
    ROUND((SUM(CASE WHEN tipo = 'Seguridad' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS Seguridad,
    ROUND((SUM(CASE WHEN tipo = 'Protección Civil' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS Proteccion_Civil,
    ROUND((SUM(CASE WHEN tipo = 'Improcedentes' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS Improcedentes,
    ROUND((SUM(CASE WHEN tipo = 'Servicio Públicos' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS Servicio_Publicos,
    ROUND((SUM(CASE WHEN tipo = 'Otros Servicios' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS Otros_Servicios,
    ROUND((SUM(CASE WHEN tipo = 'Asistencia' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS Asistencia,
    COUNT(*) AS Total_Incidentes
FROM 
	reportes_911.incidencias_2026
GROUP BY
	municipio
ORDER BY 
	Total_Incidentes DESC
;
```

Resultado:

| municipio       | Medico | Seguridad | Proteccion_Civil | Improcedentes | Servicio_Publicos | Otros_Servicios | Asistencia | Total_Incidentes |
| :--- | :---: |:---: |:---: |:---: |:---: |:---: |:---: |:---: |
| Cuernavaca      | 29.46  | 24.03     | 13.99            | 10.55         | 8.63              | 5.61            | 7.74       | 7754             |
| Jiutepec        | 30.42  | 23.73     | 13.58            | 10.06         | 8.23              | 4.87            | 9.11       | 4412             |
| Temixco         | 29.06  | 25.87     | 12.93            | 10.74         | 8.82              | 4.07            | 8.50       | 2505             |
| Emiliano Zapata | 30.23  | 20.98     | 15.05            | 11.31         | 8.85              | 4.79            | 8.80       | 2193             |
| Xochitepec      | 29.93  | 24.35     | 14.80            | 11.61         | 7.50              | 3.25            | 8.56       | 1507             |
| Tepoztlán       | 31.85  | 21.12     | 16.59            | 9.58          | 8.61              | 3.73            | 8.52       | 1127             |
| Huitzilac       | 27.49  | 23.11     | 14.74            | 11.35         | 8.57              | 4.78            | 9.96       | 502              |


**Hallazgo**: Al cruzar las tipologías de incidentes con las distintas demarcaciones geográficas, se observa un comportamiento estadístico notablemente homogéneo a lo largo del estado. No existen variaciones significativas en la composición de la demanda entre municipios; de manera sistemática, el rubro **Médico** se consolida como la primera prioridad operativa en todas las localidades (oscilando entre el 27% y el 31%), seguido por los eventos de **Seguridad** (entre el 20% y el 25%).

Esta uniformidad en los datos permite inferir dos conclusiones estratégicas fundamentales:

1. **Estandarización de Protocolos Médicos:** Dado que la necesidad de asistencia médica mantiene una proporción idéntica sin importar el municipio, se confirma la urgencia de revisar y homologar los protocolos de atención y despacho a nivel estatal, garantizando una respuesta médica uniforme.
2. **Focalización Táctica de Seguridad:** La constante presencia de incidentes de seguridad abre la puerta de manera directa a un análisis microespacial y temporal. Al no haber diferencias drásticas a nivel municipal, el verdadero valor estratégico radica en analizar la incidencia mediante la segmentación por **cuadrantes y franjas horarias**, permitiendo así la optimización del despliegue policial y el diseño de patrullajes predictivos. 

## 2. Análisis Temporal: Enfoque de Macro a Micro

Para comprender la dinámica de los reportes al servicio de emergencia, el análisis temporal se aborda bajo un enfoque de mayor a menor escala. Este método permite identificar primero la estacionalidad mensual para luego desmenuzar los datos en días de la semana y franjas horarias específicas, localizando con precisión los picos de demanda que guiarán las acciones operativas en campo.

## 2.1 Comportamiento mensual

Consulta utilizada:

```sql
SELECT 
    MONTHNAME(fecha) AS mes, 
    COUNT(*) AS incidentes_mensuales
FROM 
	reportes_911.incidencias_2026
GROUP BY MONTH
	(fecha), 
    MONTHNAME(fecha)
ORDER BY
	incidentes_mensuales DESC
    ;
```

Resultado:

| mes       | incidentes_mensuales |
| :--- | :---: |
| October   | 1765                 |
| May       | 1738                 |
| December  | 1731                 |
| January   | 1726                 |
| March     | 1700                 |
| April     | 1672                 |
| June      | 1662                 |
| November  | 1659                 |
| September | 1655                 |
| February  | 1590                 |
| July      | 1554                 |
| August    | 1548                 |

**Hallazgo**: La distribución mensual de los incidentes muestra un comportamiento globalmente homogéneo, manteniendo un promedio constante a lo largo del año. Sin embargo, se identifican repuntes críticos en los meses de **Octubre (1,765 incidentes)**, **Mayo (1,738)** y **Diciembre (1,731)**. 

Este hallazgo establece la pauta para la siguiente fase del análisis: como ejemplo tomaré el mes con mayor incidencia como punto de partida para desglosarlo por día de la semana, aislando si el despunte operativo está ligado a festividades o fechas particulares, antes de mapear sus horarios y zonas calientes.

## 2.2 Comportamiento por día de la semana, del mes con mayor incidencia

Consulta utilizada:

```sql
SELECT 
    DAYNAME(fecha) AS día_semana, 
    COUNT(*) AS incidentes_por_día_semana
FROM 
	reportes_911.incidencias_2026
WHERE  
	MONTH(fecha) = (
		SELECT 
		MONTH(fecha) AS mes
	FROM 
		reportes_911.incidencias_2026
	GROUP BY MONTH
		(fecha), 
		MONTH(fecha)
	ORDER BY
		COUNT(*) DESC
	LIMIT 1
	)
GROUP BY 
	DAYOFWEEK(fecha), 
    DAYNAME(fecha)
ORDER BY 
	incidentes_por_día_semana DESC
;
```

Resultado:

| día_semana | incidentes_por_día_semana |
| :--- | :---: |
| Saturday   | 342                       |
| Thursday   | 293                       |
| Friday     | 274                       |
| Monday     | 248                       |
| Sunday     | 212                       |
| Tuesday    | 201                       |
| Wednesday  | 195                       |

**Hallazgo**: Al desmenuzar el mes de máxima incidencia (Octubre) por día de la semana, se identifican patrones de comportamiento específicos que rompen la homogeneidad macro y apuntan a dinámicas socioeconómicas locales.

El **Sábado se consolida como el día crítico con 342 incidentes**, seguido por el **Jueves con 293** y el **Viernes con 274**. En contraste, el Domingo y los días laborales de inicio de semana (Martes y Miércoles) registran los niveles más bajos de actividad operativa.

**Siguientes Pasos:**
*   **Hipótesis de Fin de Semana (Sábado):** El repunte del sábado coincide de manera lógica con el perfil turístico y de descanso del estado de Morelos, el cual experimenta una alta fluctuación poblacional y un incremento de actividades recreativas durante los fines de semana.
*   **Anomalía del Jueves:** La presencia del jueves como el segundo día con mayor carga operativa representa un hallazgo crítico. Esto sugiere la existencia de dinámicas locales (como actividad nocturna anticipada o patrones específicos de movilidad urbana) que ameritan ser investigados a fondo.

Para transformar estos hallazgos en estrategias de prevención, el análisis avanzará hacia la dimensión micro-temporal, evaluando las **franjas horarias pico específicamente para los días Sábado y Jueves**, aislando los momentos exactos de mayor vulnerabilidad antes de delimitar su distribución geográfica por cuadrantes.

## 2.3 Comportamiento por hora del día de la semana con mayor incidencia, del mes con mayor número de reportes

Consulta utilizada:

```sql
SELECT 
    HOUR(HORA) AS horario, 
    COUNT(*) AS incidentes_por_hora
FROM 
	reportes_911.incidencias_2026
WHERE
MONTH(fecha) = 
(
SELECT 
	MONTH(fecha) AS mes
FROM 
	reportes_911.incidencias_2026
GROUP BY MONTH
	(fecha), 
	MONTH(fecha)
ORDER BY
	COUNT(*) DESC
LIMIT 1
)
AND
DAYOFWEEK(fecha)=
(
SELECT 
    DAYOFWEEK(fecha) AS día_semana
FROM 
	reportes_911.incidencias_2026
WHERE  
	MONTH(fecha) = (
		SELECT 
		MONTH(fecha) AS mes
	FROM 
		reportes_911.incidencias_2026
	GROUP BY MONTH
		(fecha), 
		MONTH(fecha)
	ORDER BY
		COUNT(*) DESC
	LIMIT 1
	)
GROUP BY 
	DAYOFWEEK(fecha)
ORDER BY 
	COUNT(*) DESC
    LIMIT 1
)
GROUP BY 
	HOUR(HORA)
    WITH ROLLUP
ORDER BY
	incidentes_por_hora DESC
;
```

Resultado:

| Horario (Hora) | Incidentes por Hora |
| :---: | :---: |
| **Total General** | **342** |
| 13:00 | 30 |
| 17:00 | 27 |
| 10:00 | 24 |
| 14:00 | 23 |
| 21:00 | 22 |
| 18:00 | 18 |
| 05:00 | 17 |
| 00:00 | 16 |

*(Nota: Se muestran los horarios con mayor volumen de actividad para facilitar la lectura).*

**Hallazgos Clave del Comportamiento Horario:**
*   **Picos de Actividad Recreativa (13:00 y 17:00 h):** Las horas con mayor volumen coinciden directamente con el perfil turístico, comercial y de esparcimiento del estado. El repunte de las 13:00 horas se asocia fuertemente al flujo de llegada y movilidad hacia zonas de descanso, mientras que las 17:00 horas marca el clímax de las actividades recreativas vespertinas.
*   **Persistencia en Madrugada:** Se observa una actividad inusual entre las 00:00 y las 05:00 horas (alcanzando hasta 17 reportes a las 5:00 a.m.), superando los registros de la mañana (9:00 a 11:00 h). Este comportamiento es característico de los fines de semana, frecuentemente vinculado a incidentes derivados de la vida nocturna.

**Próxima Fase del Análisis Temporal (Validación de Anomalías):**
Para robustecer la propuesta de despliegue operativo, se procederá a ejecutar una consulta análoga para los **días Jueves**. Al representar el segundo día con mayor carga estacional, resulta indispensable evaluar si comparte esta naturaleza recreativa o si responde a factores laborales o escolares, garantizando así un diseño de patrullaje diferenciado y eficiente.


## 3. Distribución geográfica

Consulta utilizada:
03_analisis_geografico.sql

Resultado:
...

Hallazgo:
...
