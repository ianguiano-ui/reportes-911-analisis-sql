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

Hallazgo: Se identifica que la carga operativa se concentra principalmente en la zona metropolitana del estado. **Cuernavaca** registra el mayor volumen de actividad con **7,754 incidentes (38.77%)**, seguido por **Jiutepec** con **4,412 reportes (22.06%)**. En conjunto, ambos municipios absorben más del 60% de la inicidencia total, una tendencia que se alinea directamente con la densidad poblacional y la concentración urbana características del estado de Morelos.

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

Hallazgo: A nivel general, la naturaleza de los reportes recibidos en los servicios de emergencia muestra que las **emergencias de tipo Médico** constituyen la principal demanda operativa con **5,965 incidentes**, seguidas por los eventos de **Seguridad** con **4,739 registros**. 

Este hallazgo inicial es clave, ya que establece el preludio para un desglose posterior más exhaustivo, donde se evaluará el impacto porcentual de cada tipología a nivel municipal. Identificar que el rubro médico lidera la estadística abre una oportunidad crítica para profundizar en los subtipos de incidentes específicos, proporcionando bases sólidas para la optimización de protocolos de despacho y la asignación eficiente de recursos médicos en campo.



## 2. Comportamiento temporal

Consulta utilizada:
02_analisis_temporal.sql

Resultado:
...

Hallazgo:
...

## 3. Distribución geográfica

Consulta utilizada:
03_analisis_geografico.sql

Resultado:
...

Hallazgo:
...
