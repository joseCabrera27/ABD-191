--- Inner Join

select c.id_compra, cl.nombre AS CLIENTE, c.fecha_compra , c.total
from compras c
JOIN Clientes cl on c.id_cliente = cl.id_cliente

--- LEFT Join

select c.id_compra, cl.nombre AS CLIENTE, c.fecha_compra , c.total
from compras c
left JOIN Clientes cl on c.id_cliente = cl.id_cliente

--- RIGHT Join

select c.id_compra, cl.nombre AS CLIENTE, c.fecha_compra , c.total
from compras c
right JOIN Clientes cl on c.id_cliente = cl.id_cliente

---Full Join
SELECT *
FROM clientes cl
FULL JOIN compras c
On c.id_cliente = cl.id_cliente;