-- Inserts 12 clientes --
INSERT INTO Clientes (nombre, correo_electronico, contraseña) 
VALUES
    ('Axel Ramirez', 'ana.garcia@example.com', 'contraseña1'),
    ('Jose Cabrera', 'juan.lopez@example.com', '1234567'),
    ('Ivan Martínez', 'maria.martinez@example.com', 'contraseña03'),
    ('Pedro Rodríguez', 'pedro.rodriguez@example.com', 'contraseña4'),
    ('Laura González', 'laura.gonzalez@example.com', 'contraseña5'),
    ('Carlos Sánchez', 'carlos.sanchez@example.com', 'contraseña6'),
    ('Lucía Pérez', 'lucia.perez@example.com', 'contraseña7'),
    ('David Fernández', 'david.fernandez@example.com', 'contraseña8'),
    ('Sofía Gómez', 'sofia.gomez@example.com', 'contraseña9'),
    ('Javier Díaz', 'javier.diaz@example.com', 'contraseña10'),
    ('Elena Ruiz', 'elena.ruiz@example.com', 'contraseña11'),
    ('Mario Herrera', 'mario.herrera@example.com', 'contraseña12');

--Inserts 15 comics ---
INSERT INTO Comics (titulo, anio, precio) 
VALUES
    ('Spider-Man: Far From Home', 19, 199),
    ('Avengers: Endgame', 19, 249),
    ('The Dark Knight Returns', 86, 149),
    ('Watchmen', 87, 170),
    ('Batman: The Killing Joke', 88, 120),
    ('Saga', 12, 110),
    ('Sandman', 89, 115),
    ('Maus', 80, 155),
    ('The Walking Dead', 03, 130),
    ('Preacher', 95, 110),
    ('Y: The Last Man', 02, 120),
    ('Deadpool', 97, 75),
    ('Hellboy', 93, 125),
    ('Wonder Woman: The Hiketeia', 02, 125),
    ('Superman: Red Son', 03, 110);

-- Inserts Inventario ---
INSERT INTO Inventario (id_comic, cantidad_disponible, disponibilidad) 
VALUES
    (10, 5, 1),
    (12, 3, 1),
    (14, 10, 1),
    (16, 7, 1),
    (18, 4, 1),
    (20, 6, 1),
    (22, 8, 1),
    (24, 15, 1),
    (26, 7, 1),
    (28, 9, 1),
    (30, 7, 1),
    (32, 12, 1),
    (34, 6, 1),
    (36, 0, 0),
    (38, 0, 0);

----- Inserts Compras ----------------------

INSERT INTO Compras (id_cliente, fecha_compra, total)
VALUES
-- Clientes con una sola compra
    (1, '2023-01-15', 50.25),
    (2, '2023-02-28', 75.50),
    (3, '2023-03-10', 100.00),
    (4, '2023-04-05', 45.75),
    (5, '2023-05-20', 120.00),
    (6, '2023-06-12', 90.30),
    (7, '2023-07-18', 150.50),
-- Clientes recurrentes
	(8, '2023-01-05', 25.50),
    (8, '2023-03-15', 30.75),
    (8, '2023-05-20', 40.00),
    (9, '2023-02-10', 15.25),
    (9, '2023-04-18', 20.50),
    (9, '2023-06-25', 35.80),
    (10, '2023-01-12', 10.50),
    (10, '2023-03-28', 15.25),
    (10, '2023-05-30', 25.00);
--Los demás usuarios no llevan inserts

-------- Inserts Comic_compras ------------------s
INSERT INTO Comic_Compras (id_compra, id_comic, cantidad)
VALUES
    (103, 10, 2),  
    (106, 12, 1),   
    (109, 14, 3),  
    (112, 16, 2),  
    (115, 18, 1),   
    (118, 20, 4),   
    (121, 22, 2),   
    (124, 24, 3),   
    (127, 26, 1),   
    (130, 28, 2), 
    (133, 30, 1),  
    (136, 32, 3),  
    (139, 34, 2), 
    (142, 36, 1),  
    (145, 38, 1);  