select Descripcion || "  " || Contribuyente as Descripcion, 
sum("2011") as '2011',
sum("2012") as '2012',
sum("2013") as '2013',
sum("2014") as '2014'
from [tabla_deuda_contribuyente]
group by Descripcion, Contribuyente
