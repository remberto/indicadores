SELECT descripcion as categoria,
anio as serie,
cast(anio as integer) as serie_id,
sum(valor)
FROM [Recaudacion]
WHERE anio in  (:gestion-3, :gestion-2, :gestion-1, :gestion)
GROUP BY descripcion, anio;

