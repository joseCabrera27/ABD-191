--PRÁCTICA 16

---- INSERTAR PELICULA E HISTORIAL
CREATE PROCEDURE InsertarPeliculaConHistorial
    @Titulo NVARCHAR(100),
    @Genero NVARCHAR(50),
    @FechaEstreno DATE,
    @UsuarioID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        DECLARE @PeliculaID INT;

        INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
        VALUES (@Titulo, @Genero, @FechaEstreno);

        SELECT @PeliculaID = PeliculaID
        FROM Peliculas
        WHERE Titulo = @Titulo;

        INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
        VALUES (@UsuarioID, @PeliculaID, GETDATE());


        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        PRINT ERROR_MESSAGE();
    END CATCH
END;

--- EXECUCIÓN DEL PROCESO ALMACENADO CON TRANSACCIÓN 1

EXEC InsertarPeliculaConHistorial @Titulo = 'Shrek 2', @Genero='Animada',@FechaEstreno='2004-06-16 00:00:00', @UsuarioID='3';
EXEC InsertarPeliculaConHistorial @Titulo = 'Transformers', @Genero='Acción',@FechaEstreno='2007-06-20 00:00:00', @UsuarioID='5';
EXEC InsertarPeliculaConHistorial @Titulo = 'Harry potter y la piedra filosofal', @Genero='Fantasía',@FechaEstreno='2001-11-01 00:00:00', @UsuarioID='7';

---Crea un procedimiento que permita insertar un usuario, con su respectiva suscripción y una visualización de cualquier película
CREATE PROCEDURE SP_IUsuarioSuscripcionVisualizacion
    @Nombre NVARCHAR(100),
    @Email NVARCHAR(100),
    @Pass NVARCHAR(100),
    @PeliculaID INT,
    @TipoSuscripcion NVARCHAR(50),
    @FechaInicioSuscripcion DATE,
    @FechaFinSuscripcion DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar el nuevo usuario
        INSERT INTO Usuarios (Nombre, Email, Pass)
        VALUES (@Nombre, @Email, @Pass);

        DECLARE @UsuarioID INT;
        SET @UsuarioID = SCOPE_IDENTITY();

        -- 2. Insertar la suscripción para el usuario
        INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
        VALUES (@UsuarioID, @FechaInicioSuscripcion, @FechaFinSuscripcion, @TipoSuscripcion);

        -- 3. Insertar la visualización de la película para el usuario
        INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
        VALUES (@UsuarioID, @PeliculaID, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- En caso de error, hacer rollback de la transacción
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Mostrar el mensaje de error
        PRINT ERROR_MESSAGE();
    END CATCH;
END;


--- Ejecución 
 EXEC SP_IUsuarioSuscripcionVisualizacion  @Nombre='Juan Pablo',@Email='juanp@gmail.com', @Pass='juan123',@PeliculaID='1', 
 @FechaInicioSuscripcion='03-07-2024', @FechaFinSuscripcion='03-07-2025', @TipoSuscripcion='Mensual';


----- EJERCICIO 3
CREATE PROCEDURE ActualizarCorreoYTipoSuscripcion
    @UsuarioID INT,
    @NuevoEmail NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Usuarios
        SET Email = @NuevoEmail
        WHERE UsuarioID = @UsuarioID;

        DECLARE @SuscripcionID INT;
        SELECT TOP 1 @SuscripcionID = SuscripcionID
        FROM Suscripciones
        WHERE UsuarioID = @UsuarioID
        ORDER BY SuscripcionID DESC;

        UPDATE Suscripciones
        SET Tipo = 'Anual'
        WHERE SuscripcionID = @SuscripcionID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
       
            ROLLBACK TRANSACTION;

        PRINT ERROR_MESSAGE();
    END CATCH;
END;
--- EJECUCIÓN EJERCICIO 3
EXEC ActualizarCorreoYTipoSuscripcion @UsuarioID = '2',@NuevoEmail = 'Alan69@gmail.com';

--------- EJERCICIO 4 
CREATE PROCEDURE EliminarPelicula
    @PeliculaID INT
AS
BEGIN

    BEGIN TRANSACTION;
    
    BEGIN TRY

        DELETE FROM HistorialVisualizacion
        WHERE PeliculaID = @PeliculaID;
        
        DELETE FROM Peliculas
        WHERE PeliculaID = @PeliculaID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        
    END CATCH
END;
-------- EJECUCIÓN EJERCICIO 5
EXEC EliminarPelicula @PeliculaID = '3';

--- EJERCICIO 5

	CREATE PROCEDURE EliminarUsuario
    @UsuarioID INT
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        
        DELETE FROM Suscripciones
        WHERE UsuarioID = @UsuarioID;
        
        DELETE FROM HistorialVisualizacion
        WHERE UsuarioID = @UsuarioID;

        DELETE FROM Usuarios
        WHERE UsuarioID = @UsuarioID;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
     
        ROLLBACK TRANSACTION;
        
    END CATCH
END;
---- EJECUCIÓN EJERCICIO 5
EXEC EliminarUsuario @UsuarioId = '3';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACCIONES-------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CALL sp_RegistrarUsuarioYAsignarRol('John', 'Doe', '', 'john.doe@example.com', 'password123', '1990-05-15', 2);
