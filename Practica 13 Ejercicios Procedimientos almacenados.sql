--EJERCICIO 1 procedimientos para insertar usuarios
CREATE PROCEDURE sp_AgregarUsuario
    @Nombre NVARCHAR(100),
    @Email NVARCHAR(100),
    @Pass NVARCHAR(100)
AS
BEGIN
    INSERT INTO Usuarios (Nombre, Email, Pass)
    VALUES (@Nombre, @Email, @Pass);
END;
--ejecución proceso almacenado 1
exec sp_AgregarUsuario @Nombre = 'Jose Martínez', @Email ='josecab2003@gmail.com', @Pass='contra123';
exec sp_AgregarUsuario @Nombre = 'Axel Ramirez', @Email ='ramirez2002@gmail.com', @Pass='contrasena123';
exec sp_AgregarUsuario @Nombre = 'Ivon Morales', @Email ='golosa69@gmail.com', @Pass='junio123';

---EJERCICIO 2 
CREATE PROCEDURE sp_EditarSuscripcion
    @SuscripcionID INT,
    @FechaInicio DATE,
    @FechaFin DATE,
    @Tipo NVARCHAR(50)
AS
BEGIN
    UPDATE Suscripciones
    SET FechaInicio = @FechaInicio,
        FechaFin = @FechaFin,
        Tipo = @Tipo
    WHERE SuscripcionID = @SuscripcionID;
END;

---ejecucion proceso almacenado2
exec sp_EditarSuscripcion @SuscripcionID = 1, @FechaInicio = '2021-01-25', @FechaFin = '2022-07-21', @Tipo = 'Anual';
exec sp_EditarSuscripcion @SuscripcionID = 2, @FechaInicio = '2001-01-01', @FechaFin = '2013-04-21', @Tipo = 'Semestral';
exec sp_EditarSuscripcion @SuscripcionID = 5, @FechaInicio = '2000-01-25', @FechaFin = '2012-09-21', @Tipo = 'Mensual';

--Ejercicio 3 eliminar registros tablas historialVisualización
CREATE PROCEDURE sp_EliminarHistorialVisualizacion
    @HistorialID INT
AS
BEGIN
    DELETE FROM HistorialVisualizacion
    WHERE HistorialID = @HistorialID;
END;

--Ejecución proceso almacenado 3
EXEC sp_EliminarHistorialVisualizacion @HistorialID = '18';
EXEC sp_EliminarHistorialVisualizacion @HistorialID = '19';
EXEC sp_EliminarHistorialVisualizacion @HistorialID = '20';

--Ejercicio 4 Consulta usuario con su suscripcion
CREATE PROCEDURE sp_UsuarioSuscripcion
    @Tipo NVARCHAR(50)
AS
BEGIN
    SELECT U.UsuarioID, U.Nombre, U.Email, S.Tipo
    FROM Usuarios U
    INNER JOIN Suscripciones S ON U.UsuarioID = S.UsuarioID
    WHERE S.Tipo = @Tipo;
END;
---ejeucion sp_UsuarioSuscripcion
EXEC sp_UsuarioSuscripcion @Tipo='Anual';
EXEC sp_UsuarioSuscripcion @Tipo='Mensual';
EXEC sp_UsuarioSuscripcion @Tipo='Semestral';

--Ejercicio 5 
CREATE PROCEDURE sp_ReproduccionPeliculaGenero
	@genero NVARCHAR(50)
AS
BEGIN
SELECT 
	u.Nombre,
	p.Titulo,
	p.Genero

FROM	
	Usuarios u 
INNER JOIN	
	HistorialVisualizacion hv ON u.UsuarioID = hv.UsuarioID
INNER JOIN
	Peliculas p ON p.PeliculaID = HV.PeliculaID
WHERE
	p.Genero = @genero ;
END;

--Ejemplos del Proceso 5
EXEC sp_ReproduccionPeliculaGenero @genero = 'Crimen';
EXEC sp_ReproduccionPeliculaGenero @genero = 'Drama';
EXEC sp_ReproduccionPeliculaGenero @genero = 'Acción';
