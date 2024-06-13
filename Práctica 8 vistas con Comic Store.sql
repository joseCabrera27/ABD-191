------ Vista_ComprasComic --------------------------
CREATE VIEW Vista_ComprasComic AS
	Select 
		cc.id_CC,
		cc.cantidad,
		cs.titulo AS nombre_comic,
		cc.id_compra,
		c.fecha_compra,
		c.total
	FROM
		Comic_Compras cc
	JOIN
		Comics cs ON cc.id_comic = cs.id_comic
	JOIN
		Compras c ON cc.id_compra = c.id_compra

------ Vista_ComicComprados --------------------------
CREATE VIEW Vista_ComicsComprados AS 
	SELECT 
		c.id_cliente,
		c.nombre AS nombre_cliente,
		SUM(cc.cantidad) AS cantidad_comics_comprados
	FROM
		Clientes c 
	RIGHT JOIN
		Compras co ON co.id_cliente = c.id_cliente
	JOIN	
		Comic_Compras cc ON cc.id_compra = co.id_compra
	GROUP BY
		c.id_cliente,
		c.nombre;


