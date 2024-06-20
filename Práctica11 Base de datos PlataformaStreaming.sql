CREATE TABLE Usuarios (
	UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) NOT NULL UNIQUE,
	Pass NVARCHAR(100) NOT NULL,
	FechaRegistro DATE NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Peliculas (
	PeliculaID INT IDENTITY(1,1) PRIMARY KEY,
	Titulo NVARCHAR(100) NOT NULL,
	Genero NVARCHAR(50),
	FechaEstreno DATE
);

CREATE TABLE Suscripciones (
	SuscripcionID INT IDENTITY(1,1) PRIMARY KEY,
	UsuarioID INT NOT NULL,
	FechaInicio DATE NOT NULL,
	FechaFin DATE,
	Tipo NVARCHAR(50),
	FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

CREATE TABLE HistorialVisualizacion (
	HistorialID INT IDENTITY(1,1) PRIMARY KEY,
	UsuarioID INT NOT NULL,
	PeliculaID INT NOT NULL,
	FechaVisualizacion DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
	FOREIGN KEY (PeliculaID) REFERENCES Peliculas(PeliculaID)
);

--INSERTS

--TABLA Usuarios
INSERT INTO Usuarios (Nombre, Email, Pass)
VALUES
('Jose Cabrera', 'jose.cabrera@example.com', 'password123'),
('Alan Flores', 'alan.flores@example.com', 'password456'),
('Axel Gabriel', 'axel.gabriel@example.com', 'password789'),
('Abraham Navor', 'abraham.navor@example.com', 'password012'),
('Samuel Veytia', 'samuel.veytia@example.com', 'password345'),
('Amisaday Roman', 'amisaday.roman@example.com', 'password678'),
('Miguel Torres', 'miguel.torres@example.com', 'password901'),
('Laura Ruiz', 'laura.ruiz@example.com', 'password234'),
('Andrés Ramírez', 'andres.ramirez@example.com', 'password567'),
('Patricia Flores', 'patricia.flores@example.com', 'password890');

--Tabla Peliculas
INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
VALUES
('Inception', 'Ciencia ficción', '2010-07-16'),
('The Godfather', 'Crimen', '1972-03-24'),
('Pulp Fiction', 'Crimen', '1994-10-14'),
('The Shawshank Redemption', 'Drama', '1994-09-23'),
('The Dark Knight', 'Acción', '2008-07-18'),
('Forrest Gump', 'Drama', '1994-07-06'),
('The Matrix', 'Ciencia ficción', '1999-03-31'),
('Gladiator', 'Acción', '2000-05-05'),
('Titanic', 'Romance', '1997-12-19'),
('Blade Runner','Acción','1993-12-15'),
('Avatar', 'Ciencia ficción', '2009-12-18');

--Tabla Suscripciones

INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
VALUES
(1, '2023-01-01', '2023-06-01', 'Mensual'),
(2, '2023-02-01', '2023-07-01', 'Anual'),
(3, '2023-03-01', NULL, NULL),
(4, '2023-04-01', NULL, NULL),
(5, '2023-05-01', '2023-12-01', 'Semestral'),
(6, '2023-06-01', '2023-11-01', 'Anual'),
(7, '2023-07-01', '2024-01-01', 'Mensual');

--Tabla HistorialVisualizacion

INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID)
VALUES
(1, 1),
(1, 3),
(1, 5),
(2, 2),
(2, 4),
(2, 6),
(3, 3),
(4, 7),
(5, 2),
(5, 9),
(6, 5),
(6, 10),
(7, 6),
(7, 11),
(8, 8),
(8, 7),
(9, 8),
(10, 4),
(10, 9),
(10, 1);

--Tabla completa
SELECT	
	u.UsuarioID,
	u.Nombre,
	u.Email,
	u.FechaRegistro,
	p.PeliculaID,
	p.Titulo,
	p.Genero,
	p.FechaEstreno,
	h.FechaVisualizacion,
	s.Tipo as TipoSuscripcion,
	s.FechaInicio,
	s.FechaFin
FROM
	Usuarios u
join
	HistorialVisualizacion h ON u.UsuarioID = h.UsuarioID
right Join
	Peliculas p ON h.PeliculaID = p.PeliculaID
right join
	Suscripciones s ON u.UsuarioID = s.UsuarioID
