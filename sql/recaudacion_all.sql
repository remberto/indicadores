select 'Recuadado' as descripcion,
        dim_tiempo.anio,
       sum(dat_recaudacion.emitido) as valor 
from dat_recaudacion 
inner join dim_tiempo on dat_recaudacion.tiempo_id = dim_tiempo.id 
group by dim_tiempo.anio
UNION ALL
select 'Pagado' as descripcion,
        dim_tiempo.anio,
       sum(dat_recaudacion.pagado) as valor 
from dat_recaudacion 
inner join dim_tiempo on dat_recaudacion.tiempo_id = dim_tiempo.id 
group by dim_tiempo.anio
UNION ALL
select 'Deuda' as descripcion,
        dim_tiempo.anio,
       sum(dat_recaudacion.deuda) as valor 
from dat_recaudacion 
inner join dim_tiempo on dat_recaudacion.tiempo_id = dim_tiempo.id 
group by dim_tiempo.anio;
         
