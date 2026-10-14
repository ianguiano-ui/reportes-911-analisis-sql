# Metodología del análisis geográfico

## 1. Objetivo

Analizar la distribución espacial de los registros del conjunto sintético de incidencias 911 de 2026, establecer sus límites geográficos y desarrollar una metodología reproducible para clasificar los registros en cuadrantes.

El objetivo posterior es comparar la distribución de los incidentes por zona, tipo, prioridad y horario, y preparar los resultados para su visualización en Power BI.

## 2. Naturaleza de los datos

El proyecto utiliza un conjunto de datos sintético de 20,000 registros. Las coordenadas tienen fines educativos y analíticos; no deben interpretarse como ubicaciones verificadas de incidentes reales.

Por lo tanto, las concentraciones identificadas describen únicamente la distribución de los registros simulados.

## 3. Extracción de coordenadas

Se utilizaron las funciones espaciales `ST_X()` y `ST_Y()` de MySQL para extraer los componentes numéricos del campo `coordenadas`, de tipo `POINT`.

- `ST_X(coordenadas)`: obtiene el valor X, interpretado como longitud para este análisis.
- `ST_Y(coordenadas)`: obtiene el valor Y, interpretado como latitud para este análisis.

Esta consulta permite inspeccionar las coordenadas individuales y preparar los datos para su análisis geográfico.

## 4. Determinación de los límites

Se utilizaron las funciones de agregación `MIN()` y `MAX()` para identificar los extremos de longitud y latitud de todos los registros.

Los resultados obtenidos fueron:

| Límite | Valor |
|---|---:|
| Longitud mínima | -99.285889 |
| Longitud máxima | -99.084018 |
| Latitud mínima | 18.767031 |
| Latitud máxima | 19.043807 |

Estos cuatro valores delimitan un rectángulo geográfico que contiene los puntos del conjunto de datos.

## 5. Cálculo de los rangos

Se calculó la diferencia entre los valores máximos y mínimos de cada coordenada:

- Rango de longitud = longitud máxima - longitud mínima.
- Rango de latitud = latitud máxima - latitud mínima.

Los rangos representan diferencias angulares en grados, no distancias físicas en metros o kilómetros.

Se utilizarán como base para definir una cuadrícula reproducible.

## 6.Cálculo de la extensión de la cuadrícula

Una vez identificados los límites geográficos, se calculó la diferencia entre el valor máximo y mínimo de longitud y latitud.

Esto permite determinar la extensión total del área en grados.

Posteriormente, cada rango se divide entre 4 para obtener el tamaño de cada celda de una cuadrícula regular de 4 × 4.

La lógica utilizada es:

- Extensión longitudinal = longitud máxima − longitud mínima
- Extensión latitudinal = latitud máxima − latitud mínima
- Ancho de cada columna = extensión longitudinal ÷ 4
- Alto de cada fila = extensión latitudinal ÷ 4

Los valores representan grados de longitud y latitud, no kilómetros o metros.

Se seleccionó una cuadrícula regular de 4 × 4, generando 16 cuadrantes.

La selección responde a un criterio de simplicidad y reproducibilidad para el análisis exploratorio.

Cada incidente será asignado posteriormente a un único cuadrante de acuerdo con su longitud y latitud.

La clasificación permitirá agregar los registros por zona y posteriormente cruzarlos con:

- Tipo de incidente
- Prioridad
- Municipio
- Fecha
- Día de la semana
- Hora

## 7.Determinación de las fronteras de la cuadrícula

A partir de los límites y del tamaño calculado para cada celda, se determinaron las fronteras de las cuatro columnas y las cuatro filas.

Para cada eje se utilizan incrementos iguales:

- Límite mínimo
- Primer límite
- Segundo límite
- Tercer límite
- Límite máximo

Las fronteras se obtienen sumando sucesivamente el ancho o alto de cada cuadrante al límite mínimo.

Esto permite construir una cuadrícula reproducible, en lugar de asignar las zonas de manera arbitraria.

Resultado / entregable
Una consulta SQL que calcula las fronteras longitudinales y latitudinales de la cuadrícula 4 × 4.



Próximas actividades

1. Definir la metodología de división del área en cuadrantes.
2. Asignar cada registro a un cuadrante mediante SQL.
3. Validar que la clasificación cubra los registros esperados.
4. Calcular frecuencias y porcentajes por cuadrante.
5. Comparar la distribución por tipo de incidente, prioridad y horario.
6. Preparar los resultados para su visualización en Power BI.

## 7. Limitaciones

- Los registros y las coordenadas son sintéticos.
- Los límites calculados describen la extensión de los puntos, no las fronteras oficiales de los municipios.
- La pertenencia a un cuadrante no implica que exista una zona operativa oficial con esos límites.
- Antes de calcular distancias físicas será necesario verificar el sistema de referencia espacial y utilizar un método de medición adecuado.

Las conclusiones se limitarán a lo que permitan demostrar los datos y las consultas realizadas.
