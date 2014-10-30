select dim_tipo_contribuyente.descripcion as categoria,
       dim_tiempo.anio as serie,
       dim_tiempo.id as serie_id,
       sum(dat_recaudacion.pagado) as valor 
from dat_recaudacion 
inner join dim_tiempo on dat_recaudacion.tiempo_id = dim_tiempo.id 
inner join dim_tipo_contribuyente on dat_recaudacion.tipo_contribuyente_id = dim_tipo_contribuyente.id 
where dim_tiempo.anio = 2014
group by dim_tipo_contribuyente.descripcion, 
	 dim_tiempo.anio, 
         dim_tiempo.id;



