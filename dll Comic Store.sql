CREATE TABLE Clientes (
id_cliente bigint identity (1,1) PRIMARY KEY,
nombre VARCHAR(100),
correo_electronico VARCHAR(255),
contraseña VARCHAR(255)
);

CREATE TABLE Comics(
id_comic bigint identity (10,2) PRIMARY KEY,
titulo VARCHAR(100),
anio tinyint,
precio DECIMAL(10,2)
);

CREATE TABLE Compras (
id_compra bigint identity (100,3) PRIMARY KEY,
id_cliente bigint,
fecha_compra DATE,
total DECIMAL(10,2),
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Inventario(
id_inventario bigint identity(200,1) PRIMARY KEY,
id_comic bigint,
cantidad_disponible INT,
disponibilidad binary,
FOREIGN KEY (id_comic) REFERENCES Comics(id_comic)
);

CREATE TABLE Comic_Compras(
id_CC bigint identity (1000,2) PRIMARY KEY,
cantidad tinyint,
id_compra bigint,
id_comic bigint,
FOREIGN KEY (id_compra) REFERENCES Compras(id_compra),
FOREIGN KEY (id_comic) REFERENCES Comics(id_comic)
);