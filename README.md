Análisis de datos de reportes de emergencia 911 mediante SQL y MySQL.
# Análisis de Reportes de Emergencia 911

## Descripción

Proyecto de análisis de datos basado en un conjunto de datos sintético de reportes de emergencia 911 correspondiente al año 2026.

El objetivo del proyecto es practicar y demostrar el uso de SQL para explorar, transformar y analizar información relacionada con incidentes de emergencia.

Así como lograr estrategias que ayuden a mejorar el desempeño del servicio de emergencias incluyendo la parte de videovigilancia.

## Datos

El conjunto de datos contiene **20,000 registros sintéticos** de reportes de emergencia, basados en la norma técnica del 911 y catálogo nacional de incidentes de emergencia, para México.

Incluye información como:

* Municipio
* Tipo de incidente
* Código de incidente
* Fecha y hora
* Incidente
* Prioridad
* Sexo de la persona afectada
* Colonia
* Calle
* Coordenadas geográficas

Las categorías principales de los incidentes son:

* Médico
* Protección Civil
* Seguridad
* Servicio Públicos
* Asistencia
* Otros Servicios
* Improcedentes

### Distribución municipal

La distribución de incidentes del conjunto de datos sintético fue
ponderada proporcionalmente con base en la población municipal utilizada
como referencia.

Esta ponderación tiene fines exclusivamente educativos y no representa
estadísticas reales de incidencia delictiva o de emergencias.

## Herramientas

* MySQL
* MySQL Workbench
* SQL
* GitHub

## Estructura del proyecto

```text
reportes-911-analisis-sql/
│
├── README.md
├── data/
│   └── Reportes_911_2026_20000.sql
│
├── sql/
│   ├── 01_exploracion.sql
│   ├── 02_analisis_temporal.sql
│   └── 03_analisis_geografico.sql
│
├── docs/
│   ├── metodologia_geografica.md
│   └── hallazgos.md
│
├── results/
│   ├── README.md
│   ├── incidentes_por_municipio.csv
│   └── incidentes_por_cuadrante.csv
│
└── powerbi/
    └── README.md
```

## Objetivo de aprendizaje

Este proyecto forma parte de mi formación como analista de datos.

A través del proyecto se realizan:

* Consultas SQL
* Agrupaciones y agregaciones
* Filtrado y limpieza de datos
* Análisis temporal
* Análisis geográfico
* Generación de indicadores
* Interpretación de resultados


## Preguntas de análisis

El objetivo de este proyecto es explorar y analizar la distribución temporal y geográfica de los incidentes registrados en una base de datos sintética de reportes de emergencia 9-1-1, utilizando SQL y Power BI para identificar patrones, comparar categorías y comunicar resultados.

Las preguntas se organizan en cuatro dimensiones:

### 1. Exploración general
- ¿Cuántos incidentes contiene la base de datos?
- ¿Cómo se distribuyen los incidentes entre los municipios incluidos en el conjunto de datos?
- ¿Qué tipos de incidentes se presentan con mayor frecuencia?
- ¿Qué proporción representa cada tipo de incidente dentro de cada municipio?
- ¿Cómo se distribuyen los incidentes según su prioridad?

### 2. Análisis temporal
- ¿Cómo se distribuyen los incidentes por mes?
- ¿Qué días de la semana presentan mayor volumen de registros?
- ¿En qué horas se registra el mayor número de incidentes?
- ¿Cómo cambia la distribución de los tipos de incidentes según la hora del día?
- ¿Qué diferencias se observan al comparar el tipo de incidente, la prioridad y el horario?

### 3. Análisis geográfico
- ¿Cómo se distribuyen geográficamente los incidentes según sus coordenadas?
- ¿Cómo se distribuyen los registros entre los 16 cuadrantes de una cuadrícula regular de 4 × 4?
- ¿Qué cuadrantes concentran el mayor número de incidentes?
- ¿Qué tipos de incidentes predominan en cada cuadrante?
- ¿Cómo varía la distribución geográfica al considerar el tipo de incidente y su prioridad?

### 4. Análisis operativo y visualización
- ¿Qué combinaciones de cuadrante, tipo de incidente, prioridad y horario presentan patrones relevantes dentro del conjunto de datos?
- ¿Cómo pueden representarse estos patrones mediante tablas, gráficas e indicadores en Power BI?
- ¿Qué hallazgos pueden comunicarse a partir de los resultados obtenidos y validados mediante SQL?

**Alcance del análisis:** los resultados se utilizarán para demostrar técnicas de exploración, análisis temporal y geográfico, agregación de datos y visualización. Las conclusiones describirán exclusivamente el conjunto de datos sintético y no representan estadísticas reales de incidencia delictiva o de emergencias en Morelos.

Las recomendaciones operativas, si se desarrollan, se plantearán como ejercicios analíticos y no como instrucciones para la asignación real de recursos.

## Resultados 

## Instrucciones para cargar la base en MySQL Workbench y ejecutar los scripts

## Nota sobre los datos

Los datos utilizados en este proyecto son **ficticios y fueron generados exclusivamente con fines educativos**.

Las personas, folios, calles y ubicaciones representadas no corresponden a registros reales. Las coordenadas son aproximaciones sintéticas utilizadas para realizar ejercicios de análisis geográfico.
