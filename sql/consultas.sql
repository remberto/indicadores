UPDATE querys SET query = "select dim_tiempo.anio as categoria,
       dim_tipo_contribuyente.descripcion as serie,
       dim_tipo_contribuyente.id as serie_id,
       sum(dat_padron.cantidad) as valor 
from dat_padron 
inner join dim_tiempo on dat_padron.tiempo_id = dim_tiempo.id 
inner join dim_tipo_contribuyente on dat_padron.tipo_contribuyente_id = dim_tipo_contribuyente.id 
where dim_tiempo.anio in (2013,2014) 
group by dim_tiempo.anio, 
         dim_tipo_contribuyente.descripcion, 
         dim_tipo_contribuyente.id;" WHERE id = 1;


INSERT INTO querys (query,titulo, subtitulo, x_titulo, y_titulo, tipo_grafico, ayuda, tipo_query, descripcion, panel_id) VALUES
("select dim_tipo_contribuyente.descripcion as categoria
       dim_tiempo.anio as serie,
       dim_tiempo.id as serie_id,
       sum(dat_padron.cantidad) as valor 
from dat_padron 
inner join dim_tiempo on dat_padron.tiempo_id = dim_tiempo.id 
inner join dim_tipo_contribuyente on dat_padron.tipo_contribuyente_id = dim_tipo_contribuyente.id 
where dim_tiempo.anio in (:gestion - 2,:gestion - 1,:gestion) 
group by dim_tipo_contribuyente.descripcion, 
	 dim_tiempo.anio, 
         dim_tiempo.id;",
"Evolucion del Padron", 
"(Ultimas 3 gestiones)",
"Cantidad",
"Contribuyentes",
"column",
"$us",
1,
"Evolucion de Padron de las Ultimas 3 gestiones",
1);

INSERT INTO query_parametros (parametro, query_id, orden, tipo)
VALUES ('gestion',3,1,'int');

UPDATE querys SET query = "select dim_tipo_contribuyente.descripcion as categoria,
       dim_tiempo.anio as serie,
       dim_tiempo.id as serie_id,
       sum(dat_padron.cantidad) as valor 
from dat_padron 
inner join dim_tiempo on dat_padron.tiempo_id = dim_tiempo.id 
inner join dim_tipo_contribuyente on dat_padron.tipo_contribuyente_id = dim_tipo_contribuyente.id 
where dim_tiempo.anio in (:gestion - 2,:gestion - 1,:gestion) 
group by dim_tipo_contribuyente.descripcion, 
	 dim_tiempo.anio, 
         dim_tiempo.id;" WHERE id = 3;


SELECT 'a' as serie, sum(cantidad) as valor FROM dat_padron INNER JOIN dim_tiempo ON dat_padron.tiempo_id = dim_tiempo.id WHERE dim_tiempo.anio = 2014;

INSERT INTO querys (query,titulo, subtitulo, x_titulo, y_titulo, tipo_grafico, ayuda, tipo_query, descripcion, panel_id) VALUES ("SELECT sum(cantidad) as serie FROM dat_padron INNER JOIN dim_tiempo ON dat_padron.tiempo_id = dim_tiempo.id WHERE dim_tiempo.anio = :gestion",
"Nro. Contribuyentes",
"",
"",
"",
"cuadro",
"",
1,
"Numero de Contribuyentes",
4);

INSERT INTO query_parametros (parametro, query_id, orden, tipo)
VALUES ('gestion',4,1,'int');

UPDATE querys SET query = "SELECT 'a' as serie, sum(cantidad) as valor FROM dat_padron INNER JOIN dim_tiempo ON dat_padron.tiempo_id = dim_tiempo.id WHERE dim_tiempo.anio = :gestion" WHERE id = 4;

CREATE TABLE tables(
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
query TEXT,
query_id INTEGER,
CONSTRAINT fk_tables_querys FOREIGN KEY (query_id) REFERENCES querys(id)
);


// Propiedades

INSERT INTO querys (query,titulo, subtitulo, x_titulo, y_titulo, tipo_grafico, ayuda, tipo_query, descripcion, panel_id) VALUES ("SELECT 'a' as serie, sum(cantidad) as valor FROM dat_padron INNER JOIN dim_tiempo ON dat_padron.tiempo_id = dim_tiempo.id WHERE dim_tiempo.anio = :gestion",
"Nro. Propiedades",
"",
"",
"",
"cuadro",
"",
1,
"Numero de Propiedades",
4);

INSERT INTO query_parametros (parametro, query_id, orden, tipo)
VALUES ('gestion',5,1,'int');

-- Recaudacion

INSERT INTO querys (query,titulo, subtitulo, x_titulo, y_titulo, tipo_grafico, ayuda, tipo_query, descripcion, panel_id) VALUES ("SELECT 'a' as serie, sum(pagado) as valor 
FROM dat_recaudacion 
INNER JOIN dim_tiempo ON dat_recaudacion.tiempo_id = dim_tiempo.id WHERE dim_tiempo.anio = :gestion",
"Nro. Propiedades",
"",
"",
"",
"cuadro",
"",
1,
"Numero de Propiedades",
4);


INSERT INTO query_parametros (parametro, query_id, orden, tipo)
VALUES ('gestion',6,1,'int');

-- deuda

INSERT INTO querys (query,titulo, subtitulo, x_titulo, y_titulo, tipo_grafico, ayuda, tipo_query, descripcion, panel_id) VALUES ("SELECT 'a' as serie, sum(cantidad_deuda) as valor 
FROM dat_recaudacion 
INNER JOIN dim_tiempo ON dat_recaudacion.tiempo_id = dim_tiempo.id WHERE dim_tiempo.anio = :gestion",
"Nro de Deudores",
"",
"",
"",
"cuadro",
"",
1,
"Numero de Deudores",
4);

INSERT INTO query_parametros (parametro, query_id, orden, tipo)
VALUES ('gestion',7,1,'int');


INSERT INTO query_parametros (parametro, query_id, orden, tipo)
VALUES ('gestion',6,1,'int');


INSERT INTO querys (query,titulo, subtitulo, x_titulo, y_titulo, tipo_grafico, ayuda, tipo_query, descripcion, panel_id) VALUES
("SELECT descripcion as categoria,
anio as serie,
cast(anio as integer) as serie_id,
sum(valor)
FROM [Recaudacion]
WHERE anio in  (:gestion-3, :gestion-2, :gestion-1, :gestion)
GROUP BY descripcion, anio;",
"Evolucion del Recaudacion", 
"(Pesos Argentinos)",
"Gestiones",
"Pesos Argentinos",
"column",
"$us",
1,
"Evolucion de Recaudacion en Pesos Argentinos",
1);

INSERT INTO query_parametros (parametro, query_id, orden, tipo)
VALUES ('gestion',8,1,'int');


-- tabla

INSERT INTO tables (query, query_id) VALUES ('select Descripcion, 
sum("2011") as ''2011'',
sum("2012") as ''2012'',
sum("2013") as ''2013'',
sum("2014") as ''2014''
from [tabla_recaudacion]
group by Descripcion',8);


INSERT INTO querys (query,titulo, subtitulo, x_titulo, y_titulo, tipo_grafico, ayuda, tipo_query, descripcion, panel_id) VALUES
("SELECT descripcion as categoria,
anio as serie,
anio as serie_id,
sum(valor) as valor
FROM [Deuda]
WHERE anio in  (:gestion-3, :gestion-2, :gestion-1, :gestion)
GROUP BY descripcion, anio;",
"Evolucion de la Deuda", 
"(Pesos Argentinos)",
"Gestiones",
"Pesos Argentinos",
"column",
"$us",
1,
"Evolucion de Deuda en Pesos Argentinos",
1);

INSERT INTO query_parametros (parametro, query_id, orden, tipo)
VALUES ('gestion',8,1,'int');

INSERT INTO tables (query, query_id) VALUES ('select Descripcion, 
sum("2011") as ''2011'',
sum("2012") as ''2012'',
sum("2013") as ''2013'',
sum("2014") as ''2014''
from [tabla_deuda]
group by Descripcion',9);

INSERT INTO tables (query, query_id) VALUES ('select Descripcion, 
sum("2011") as ''2011'',
sum("2012") as ''2012'',
sum("2013") as ''2013'',
sum("2014") as ''2014''
from [padron_estado]
group by Descripcion',1);


select Descripcion, 
sum("2011") as '2011',
sum("2012") as '2012',
sum("2013") as '2013',
sum("2014") as '2014'
from [tabla_recaudacion_contribuyente]
group by Descripcion
