select dim_tipo_contribuyente.descripcion as serie,
       round(cast(sum(dat_recaudacion.pagado) AS FLOAT) / (
       select sum(dat_recaudacion.pagado) as valor 
from dat_recaudacion 
inner join dim_tiempo on dat_recaudacion.tiempo_id = dim_tiempo.id 
inner join dim_tipo_contribuyente on dat_recaudacion.tipo_contribuyente_id = dim_tipo_contribuyente.id 
where dim_tiempo.anio = 2014),3) as valor 
from dat_recaudacion 
inner join dim_tiempo on dat_recaudacion.tiempo_id = dim_tiempo.id 
inner join dim_tipo_contribuyente on dat_recaudacion.tipo_contribuyente_id = dim_tipo_contribuyente.id 
where dim_tiempo.anio = 2014
group by dim_tipo_contribuyente.descripcion



