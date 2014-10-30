select dim_estado.descripcion as categoria,
       dim_tiempo.anio as serie,
       dim_tiempo.id as serie_id,
       sum(dat_padron.cantidad) as valor
from dat_padron 
inner join dim_tiempo on dat_padron.tiempo_id = dim_tiempo.id 
inner join dim_estado on dat_padron.tipo_contribuyente_id = dim_estado.id
where  dim_tiempo.id in (:gestion - 3, :gestion - 2, :gestion - 1, :gestion) 
group by dim_estado.descripcion, dim_tiempo.anio

