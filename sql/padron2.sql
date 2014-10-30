SELECT 'Alta' as categoria,
Descripcion as serie, 
Descripcion as serie_id,
Sum(Alta) as Valor
FROM [Padron_Anio]
GROUP BY Descripcion
UNION ALL
SELECT 'Baja' as categoria,
Descripcion as serie, 
Descripcion as serie_id,
Sum(Baja) as Valor
FROM [Padron_Anio]
GROUP BY Descripcion
UNION ALL
SELECT 'Gestion' as categoria,
Descripcion as serie, 
Descripcion as serie_id,
Sum(Alta)-sum(Baja) as Valor
FROM [Padron_Anio]
GROUP BY Descripcion

