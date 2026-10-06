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
│
└── data/
    └── Reportes_911_2026_20000.sql
```

## Objetivo de aprendizaje

Este proyecto forma parte de mi formación como analista de datos.

A través del proyecto se practicarán:

* Consultas SQL
* Agrupaciones y agregaciones
* Filtrado y limpieza de datos
* Análisis temporal
* Análisis geográfico
* Generación de indicadores
* Interpretación de resultados

Posteriormente, el proyecto podrá ampliarse con herramientas de análisis y visualización.

## Nota sobre los datos

Los datos utilizados en este proyecto son **ficticios y fueron generados exclusivamente con fines educativos**.

Las personas, folios, calles y ubicaciones representadas no corresponden a registros reales. Las coordenadas son aproximaciones sintéticas utilizadas para realizar ejercicios de análisis geográfico.
