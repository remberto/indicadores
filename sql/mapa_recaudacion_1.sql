SELECT 
  dim_zona."hc-key" as serie,
  SUM(dat_recaudacion.emitido) AS valor
FROM
  dim_zona
  INNER JOIN dat_recaudacion ON (dim_zona.id = dat_recaudacion.zona_id)
  INNER JOIN dim_tiempo ON (dat_recaudacion.tiempo_id = dim_tiempo.id)
WHERE
dim_tiempo.anio = 2013
GROUP BY
  dim_zona."hc-key",
  dim_tiempo.anio
