CREATE PROCEDURE sp_agregarsuscripcion
    @idusuario INT,
    @fechainicio DATE,
    @fechafin DATE,
    @tipo NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
        VALUES (@idusuario, @fechainicio, @fechafin, @tipo);

        UPDATE Usuarios
        SET FechaRegistro = @fechainicio
        WHERE UsuarioID = @idusuario;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT @ErrorMessage;
    END CATCH;
END;

EXEC sp_agregarsuscripcion @idusuario = 99, @fechainicio = '2021-01-01', @fechafin = '2022-01-01', @tipo ='Anual';