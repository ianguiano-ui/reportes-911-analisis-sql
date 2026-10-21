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

https://github.com/ianguiano-ui/reportes-911-analisis-sql/blob/1f1f6fce1de15696fc127ca29322edbe39f9f508/sql/03_analisis_geografico.sql

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

https://github.com/ianguiano-ui/reportes-911-analisis-sql/blob/1f1f6fce1de15696fc127ca29322edbe39f9f508/sql/03_analisis_geografico.sql

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

| | | | | |
|---|---|---|---|---|
| Norte | Q13 | Q14 | Q15 | Q16 |
| | Q09 | Q10 | Q11 | Q12 |
| | Q05 | Q06 | Q07 | Q08 |
| Sur | Q01 | Q02 | Q03 | Q04 |
| | Oeste | → | → | Este |

Cada cuadrante se delimita mediante un intervalo de longitud y otro de latitud.

Para evitar que un incidente situado exactamente sobre una frontera sea asignado a dos cuadrantes, se utilizará una convención de intervalos semiabiertos: se incluye el límite inferior y se excluye el superior en las divisiones interiores. El límite máximo global se incluirá en la última columna o fila, según corresponda.

Esta regla permite que cada registro válido pertenezca a un único cuadrante y facilita la validación de la clasificación.

La cuadrícula representa una división analítica del conjunto de datos sintético, no zonas operativas oficiales.

## 9. Regla de asignación

Cada incidente se asigna a un cuadrante mediante una expresión `CASE WHEN`.

Para pertenecer a un cuadrante deben cumplirse simultáneamente dos condiciones:

1. La longitud debe encontrarse dentro del intervalo correspondiente a la columna.
2. La latitud debe encontrarse dentro del intervalo correspondiente a la fila.

Las condiciones se unen mediante `AND`.

Ejemplo conceptual:

`longitud dentro del intervalo correspondiente`

AND

`latitud dentro del intervalo correspondiente`

→ `Cuadrante`

https://github.com/ianguiano-ui/reportes-911-analisis-sql/blob/1f1f6fce1de15696fc127ca29322edbe39f9f508/sql/03_analisis_geografico.sql
---

## 10. Tratamiento de las fronteras

Para evitar que un incidente situado exactamente sobre una frontera sea asignado a dos cuadrantes, se utilizó una regla de intervalos semiabiertos.

En las fronteras interiores:

- Se incluye el límite inferior mediante `>=`.
- Se excluye el límite superior mediante `<`.

Por ejemplo

``longitud >= límite_inferior
AND longitud < límite_superior``

---

## 11. Límites máximos

Durante la validación se detectó que dos registros quedaban clasificados como Fuera de Rango.

Al revisar sus coordenadas se encontró que coincidían exactamente con los límites máximos de la cuadrícula:
- Un registro tenía la longitud máxima -99.084018.
- Otro registro tenía la latitud máxima 19.043807.

La causa fue que los límites máximos estaban siendo evaluados con <, por lo que un valor exactamente igual al máximo quedaba excluido.
Se corrigió la lógica para que los cuadrantes situados en los bordes máximos acepten también el límite superior mediante <=.

Esto aplica a:
- Q04, Q08, Q12 y Q16 para la longitud máxima.
- Q13, Q14, Q15 y Q16 para la latitud máxima.
- Q16 utiliza <= en ambos límites máximos.

## 12. Validación de los 16 cuadrantes

Una vez construida la clasificación Q01-Q16 se realizó una validación mediante COUNT(*) y GROUP BY Cuadrante.
El resultado fue:

| Cuadrantes | Incidentes |
|---|---:|
| Q01 | 511 |
| Q02 | 1,175 |
| Q03 | 178 |
| Q04 | 0|
| Q05 | 495 |
| Q06 | 4,439 |
| Q07 | 3,819 |
| Q08 | 0 |
| Q09 | 3,630 |
| Q10 | 4,124 |
| Q11 | 0 |
| Q12 | 163|
| Q13 | 502 |
| Q14 | 0 |
| Q15 | 0 |
| Q16 | 964 |
| FUERA DE RANGO | 0 |
| TOTAL | 20,000 |


https://github.com/ianguiano-ui/reportes-911-analisis-sql/blob/1f1f6fce1de15696fc127ca29322edbe39f9f508/sql/03_analisis_geografico.sql


## Próximas actividades

1. Definir la metodología de división del área en cuadrantes.
2. Asignar cada registro a un cuadrante mediante SQL.
3. Validar que la clasificación cubra los registros esperados.
4. Calcular frecuencias y porcentajes por cuadrante.
5. Comparar la distribución por tipo de incidente, prioridad y horario.
6. Preparar los resultados para su visualización en Power BI.

