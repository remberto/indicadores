SELECT descripcion as categoria,
contribuyente as serie,
contribuyente_id as serie_id,
sum(valor) as valor
FROM [Deuda_contribuyente]
WHERE anio = 2014
GROUP BY descripcion, contribuyente, contribuyente_id;
