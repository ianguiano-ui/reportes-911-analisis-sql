# Hallazgos

## 1. Distribución municipal

Consulta utilizada:
```sql
SELECT 
	municipio, 
	COUNT(*) AS núm_incidentes
FROM 
	reportes_911.incidencias_2026
GROUP BY 
	municipio
ORDER BY 
	núm_incidentes DESC
;
```

Resultado:

| municipio       | núm_incidentes |
| :--- | :---: |
| Cuernavaca      | 7754           |
| Jiutepec        | 4412           |
| Temixco         | 2505           |
| Emiliano Zapata | 2193           |
| Xochitepec      | 1507           |
| Tepoztlán       | 1127           |
| Huitzilac       | 502            |

[tabla / referencia al CSV]

Hallazgo:
...

Interpretación:
...

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
