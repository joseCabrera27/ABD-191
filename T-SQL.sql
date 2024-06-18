-- TSQL
/*
-- declarar variables
declare @idCliente int 

--inicializar o asignar valor
set @idcliente = 8

--if
--IF @idcliente = 8 
	--select * from Clientes where id_cliente = @idCliente

declare @edad int
set @idCliente = 8


IF @idCliente  = 8
	BEGIN
		set @edad = 25
		select * from Clientes where id_cliente = @idCliente
		print @edad

		IF EXISTS(select * from Clientes where id_cliente = 10 )
		print 'Si existe'
	END
ELSE
	print 'Id no autorizado por la consulta'
*/

--WHILE
/*
declare @contador int = 0 

WHILE @contador <= 10 
BEGIN
	print @contador
	set @contador = @contador + 1
END
	*/

declare @contador int = 0 

WHILE @contador <= 10 
BEGIN
	print @contador
	set @contador = @contador + 1
	IF @contador = 3
		break
	print('Hola')
END


	print('aqui continua el flujo')

BEGIN TRY
	set @contador = 'Ivan Isay'
END TRY
BEGIN CATCH
	print('La variable de contador solo acepta numeros enteros')
END CATCH

print('soy otra consulta')
print('yo tambien')