SELECT 'a' as serie, sum(pagado) as valor 
FROM dat_recaudacion 
INNER JOIN dim_tiempo ON dat_recaudacion.tiempo_id = dim_tiempo.id WHERE dim_tiempo.anio = :gestion
