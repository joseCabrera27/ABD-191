--Trigger para creación de cliente
CREATE TRIGGER InsertarClente
ON Clientes 
AFTER INSERT
AS
BEGIN
	PRINT 'El Cliente se ha ingresado correctamente.'
END;

--Ejemplo de ejecución trigger cliente
INSERT INTO Clientes (Nombre,Direccion,Telefono,Email)
VALUES
	('Isaac Martínez','Arboledas #13','4423568721','isaac@example.com');	


--Trigger para eliminación del cliente
CREATE TRIGGER EliminarCliente
ON Clientes
AFTER DELETE
AS
BEGIN
	PRINT 'El cliente se ha eliminado correctamente'
END;

--Ejecucíón de Trigger 2
DELETE FROM Clientes where ClienteID = 1005;


--CREACIÓN DEL TERCER TRIGGER
CREATE TRIGGER InsertarCuentas
ON Cuentas
INSTEAD OF INSERT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE ClienteID IN (SELECT ClienteID FROM inserted))
    BEGIN
        RAISERROR('El cliente no existe. No se puede crear una cuenta.', 16, 1);
    END
    ELSE
    BEGIN
       
        INSERT INTO Cuentas (ClienteID, TipoCuenta, Saldo, FechaApertura)
        SELECT ClienteID, TipoCuenta, Saldo, FechaApertura
        FROM inserted;

		 RAISERROR('La cuenta se regstró correctamente.', 16, 1);
    END
END;

--Ejemplo de ejecución
INSERT INTO Cuentas (ClienteID, TipoCuenta, Saldo, FechaApertura)
VALUES (1, 'Cuenta Corriente', 1500.00, '2024-08-02');



-- CREACION DEL CUARTO TRIGGER
CREATE TRIGGER SaldoNoNegativo
ON Cuentas
INSTEAD OF UPDATE
AS
BEGIN
    
    IF EXISTS (SELECT 1 FROM inserted WHERE Saldo < 0)
    BEGIN
     
        RAISERROR('No se puede actualizar el saldo a un valor negativo.', 16, 1);
    END
    ELSE
    BEGIN
        
        UPDATE Cuentas
        SET ClienteID = i.ClienteID,
            TipoCuenta = i.TipoCuenta,
            Saldo = i.Saldo,
            FechaApertura = i.FechaApertura
        FROM inserted i
        WHERE Cuentas.CuentaID = i.CuentaID;
    END
END;

-- EJECUCION CUARTO TRIGGER
UPDATE Cuentas
SET Saldo = 2000.00
WHERE CuentaID = 1;

UPDATE Cuentas
SET Saldo = -500.00
WHERE CuentaID = 1;

--CREACION DEL QUINTO TRIGGER
CREATE TRIGGER NoBorrarPrestamosConPagos
ON Prestamos
INSTEAD OF DELETE
AS
BEGIN
    
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        JOIN PagosPrestamos p ON d.PrestamoID = p.PrestamoID
    )
    BEGIN
        
        RAISERROR('No se puede eliminar el préstamo porque tiene pagos asociados.', 16, 1);
    END
    ELSE
    BEGIN
        
        DELETE FROM Prestamos
        WHERE PrestamoID IN (SELECT PrestamoID FROM deleted);
    END
END;

--EJECUCION QUINTO TRIGGER
DELETE FROM Prestamos
WHERE PrestamoID = 1;

-- Creacion de la tabla
CREATE TABLE logClientes (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    Operacion NVARCHAR(10),
    FechaHora DATETIME DEFAULT GETDATE()
);

--creacion del 7mo trigger
CREATE TRIGGER RegistrarOperacionesClientes
ON Clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @Operacion NVARCHAR(10);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @Operacion = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM deleted)
        SET @Operacion = 'DELETE';

    INSERT INTO logClientes (Operacion)
    VALUES (@Operacion);
END;

--ejecucion del 7mo trigger
INSERT INTO Clientes (Nombre, Direccion, Telefono, Email) VALUES
('Jose Cabrera', 'San Angel', '555-2345', 'jose@example.com');

UPDATE Clientes
SET Nombre = 'Juan Dominguez'
WHERE ClienteID = 9;


DELETE FROM Clientes
WHERE ClienteID = 9;