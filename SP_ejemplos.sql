--Explorar las propiedades de las BD
EXEC sp_helpdb --Todas las bases de datos
EXEC sp_helpdb 'comic store' -- Una base de datos especifica


--Explorar las propiedades de un objeto de la BD

EXEC sp_help 'peliculas'

--Llaves primarias de una tabla
EXEC sp_helpindex 'peliculas'

--Información de los usuarios y procesos actuales
EXEC sp_who

--rendimiento del servidor 

EXEC sp_monitor

--Espacio Usado por la BD

EXEC sp_spaceused  --Te da la que estas usando en el momento

--Puerto de escucha del SQL SERVER

EXEC sp_readerrorlog 0,1

--Nuestros procedimientos

CREATE PROCEDURE sp_ObtenerHistorial
	@usuarioId INT 
AS
BEGIN
	
SELECT 
	h.HistorialID , p.Titulo, h.FechaVisualizacion
FROM 
	HistorialVisualizacion h 
JOIN
	Peliculas p ON h.PeliculaID = p.PeliculaID
WHERE 
	H.UsuarioID= @usuarioId
ORDER BY 
	h.FechaVisualizacion DESC
END;

--Ejecucion 
EXEC sp_ObtenerHistorial 10;

CREATE PROCEDURE sp_InsertarPelicula
@titulo NVARCHAR (100),
@genero NVARCHAR (50),
@FechaEstreno DATE
AS
BEGIN
	INSERT INTO Peliculas(Titulo,Genero,FechaEstreno) VALUES(@titulo,@genero,@FechaEstreno)
END;

EXEC sp_InsertarPelicula @titulo = 'Intensamente2', @genero = 'infantil', @FechaEstreno = '2024-06-13';
