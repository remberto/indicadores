SELECT descripcion as categoria,
persona as serie,
persona_id as serie_id,
sum(valor) as valor
FROM [Recaudacion2]
WHERE anio = 2014
GROUP BY descripcion, persona ;

