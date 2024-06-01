--Joins

-- JOIN 1
SELECT
	c.titulo as nombre,
	i.cantidad_disponible as cantidad_disponible
FROM 
	Comics as c
JOIN
	Inventario as i on i.id_comic = c.id_comic

-- JOIN 2

SELECT 
	c.nombre,
	co.id_compra,
	cs.titulo as nombre_comic,
	i.cantidad_disponible as cantidad
FROM
	Clientes c
RIGHT JOIN
	compras co on co.id_cliente = c.id_cliente
JOIN 
	Comic_Compras cc on co.id_compra = cc.id_compra
JOIN	
	Comics cs on cs.id_comic = cc.id_comic
JOIN
	Inventario i on i.id_comic = cs.id_comic

--JOIN 3
SELECT
	cc.id_compra,
	cs.titulo as nombre_comic,
	i.cantidad_disponible
FROM	
	Comics cs
join
	Inventario i on i.id_comic = cs.id_comic
FULL join
	Comic_Compras cc on cc.id_comic = cs.id_comic

--JOIN 4

SELECT 
	c.titulo as nombre_comic,
	i.cantidad_disponible
FROM 
	Comics c
JOIN
	Inventario i on c.id_comic = i.id_comic

--JOIN 5
SELECT 
	*
FROM
	Comics
FULL JOIN
	Inventario i on Comics.id_comic = i.id_comic
FULL JOIN
	Comic_Compras on Comic_Compras.id_comic = Comics.id_comic

-- JOIN 6

SELECT 
	c.nombre as nombre,
	co.id_compra as compra,
	cs.titulo as COMIC,
	co.total as cantidad,
	i.cantidad_disponible as EN_INVENTARIO
FROM
	Clientes c
JOIN
	Compras co ON  co.id_cliente = c.id_cliente
JOIN
	Comic_Compras cc ON co.id_compra =  cc.id_compra
JOIN
	Comics cs ON cs.id_comic = cc.id_comic
JOIN 
	Inventario i ON i.id_comic = cs.id_comic

	