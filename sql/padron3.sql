select Descripcion, 
sum(Alta) as 'Alta',
sum(Baja) as 'Baja',
sum(Alta) - sum(Baja) as 'Gestion'
from [padron_anio]
group by Descripcion
