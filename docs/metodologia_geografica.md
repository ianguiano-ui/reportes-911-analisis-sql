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

## 8. Nomenclatura y reglas de asignación de cuadrantes

Se definieron 16 cuadrantes identificados como Q01 a Q16, organizados en una cuadrícula regular de cuatro columnas y cuatro filas.

La numeración comienza en la esquina suroeste (Q01) y avanza de oeste a este. Posteriormente continúa de sur a norte hasta alcanzar Q16 en la esquina noreste.

Cada cuadrante se delimita mediante un intervalo de longitud y otro de latitud.

Para evitar que un incidente situado exactamente sobre una frontera sea asignado a dos cuadrantes, se utilizará una convención de intervalos semiabiertos: se incluye el límite inferior y se excluye el superior en las divisiones interiores. El límite máximo global se incluirá en la última columna o fila, según corresponda.

Esta regla permite que cada registro válido pertenezca a un único cuadrante y facilita la validación de la clasificación.

La cuadrícula representa una división analítica del conjunto de datos sintético, no zonas operativas oficiales.


Próximas actividades

1. Definir la metodología de división del área en cuadrantes.
2. Asignar cada registro a un cuadrante mediante SQL.
3. Validar que la clasificación cubra los registros esperados.
4. Calcular frecuencias y porcentajes por cuadrante.
5. Comparar la distribución por tipo de incidente, prioridad y horario.
6. Preparar los resultados para su visualización en Power BI.

## 7. Clasificación de registros mediante SQL

Objetivo
Asignar cada registro del dataset a un cuadrante de acuerdo con su longitud y latitud, utilizando los límites calculados para la cuadrícula regular de 4 × 4.

Método
Se implementó una expresión `CASE WHEN` para evaluar las coordenadas de cada incidente y asignarle una etiqueta.

Se utilizó una subconsulta para extraer las coordenadas del campo espacial `POINT` mediante las funciones `ST_X()` y `ST_Y()`. La consulta exterior utiliza los alias `longitud` y `latitud` para evaluar las condiciones de pertenencia.

Cada cuadrante se define mediante dos condiciones:

- La longitud debe encontrarse dentro de los límites oeste y este.
- La latitud debe encontrarse dentro de los límites sur y norte.

Ambas condiciones deben cumplirse para asignar el registro al cuadrante.

Se estableció una convención de intervalos semiabiertos: el límite inferior se incluye y el superior se excluye en las divisiones interiores. Esta regla evita que un punto situado exactamente en una frontera sea asignado a dos cuadrantes.

Validación inicial: Q01 y Q02
La lógica se probó inicialmente con los dos primeros cuadrantes, ubicados en la fila sur de la cuadrícula.

| Clasificación | Número de registros | Porcentaje del total |
|---|---:|---:|
| Q01 | 511 | 2.56% |
| Q02 | 1,175 | 5.88% |
| Sin clasificar en esta etapa | 18,314 | 91.57% |
| Total | 20,000 | 100.00% |

Los resultados corresponden al conjunto de datos sintético utilizado en el proyecto.

Interpretación
Los 511 registros clasificados en Q01 y los 1,175 clasificados en Q02 cumplen las condiciones geográficas definidas para sus respectivas celdas.

Los 18,314 registros restantes no pertenecen a ninguno de estos dos cuadrantes. No deben interpretarse como puntos fuera del área total, ya que todavía faltan por evaluar los otros 14 cuadrantes.

La suma de los tres grupos es de 20,000 registros, lo que confirma que la consulta de validación considera todos los registros de la tabla.


## 7. Limitaciones

- Los registros y las coordenadas son sintéticos.
- Los límites calculados describen la extensión de los puntos, no las fronteras oficiales de los municipios.
- La pertenencia a un cuadrante no implica que exista una zona operativa oficial con esos límites.
- Antes de calcular distancias físicas será necesario verificar el sistema de referencia espacial y utilizar un método de medición adecuado.

Las conclusiones se limitarán a lo que permitan demostrar los datos y las consultas realizadas.
