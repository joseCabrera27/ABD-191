-------------- tabla AUTORES ---------------------------------

CREATE TABLE Autores (
id_autor bigint identity(300,1)PRIMARY KEY,
nombre VARCHAR(100),
pais_origen VARCHAR(100)
);

----------------- Columna tabla comics ----------------------------
ALTER TABLE Comics
ADD id_autor bigint,
FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
-------------------  INSERTS ---------------------------------------
INSERT INTO Autores (nombre, pais_origen) VALUES ('Leo Tolstoy', 'Rusia');
INSERT INTO Autores (nombre, pais_origen) VALUES ('Ernest Hemingway', 'Estados Unidos');
INSERT INTO Autores (nombre, pais_origen) VALUES ('Jane Austen', 'Reino Unido');
INSERT INTO Autores (nombre, pais_origen) VALUES ('Mark Twain', 'Estados Unidos');


------------------- Inserts autores tabla comics ------------------------


UPDATE Comics SET id_autor = 301 WHERE id_comic = 10;
UPDATE Comics SET id_autor = 301 WHERE id_comic = 12;
UPDATE Comics SET id_autor = 302 WHERE id_comic = 14;
UPDATE Comics SET id_autor = 302 WHERE id_comic = 16;
UPDATE Comics SET id_autor = 303 WHERE id_comic = 18;
UPDATE Comics SET id_autor = 303 WHERE id_comic = 20;
UPDATE Comics SET id_autor = 302 WHERE id_comic = 22;
UPDATE Comics SET id_autor = 303 WHERE id_comic = 24;
UPDATE Comics SET id_autor = 301 WHERE id_comic = 26;
UPDATE Comics SET id_autor = 302 WHERE id_comic = 28;
UPDATE Comics SET id_autor = 300 WHERE id_comic = 30;

-- JOIN 1
SELECT 
	co.titulo as nombre,
	a.nombre,
	a.pais_origen
FROM	
	Comics co
FULL JOIN
	Autores a ON co.id_autor = a.id_autor

-- JOIN 2
SELECT 
	a.nombre AS nombre,
	cc.cantidad AS cantidad
FROM
	Compras c
JOIN
	Comic_Compras cc ON cc.id_compra = c.id_compra
JOIN
	Comics cs ON cs.id_comic = cc.id_comic
JOIN	
	Autores a ON a.id_autor = cs.id_autor
ORDER BY 
	A.nombre;