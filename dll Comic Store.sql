CREATE TABLE Clientes (
    id_cliente bigint identity(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_compra DATE,
    total DECIMAL(10, 2)
);

CREATE TABLE comics (
    id_comic bigint identity(10,2) PRIMARY KEY,
    nombre VARCHAR(100),
    año tinyint,
    precio  DECIMAL(10,2)
);

CREATE TABLE compras (
    id_compra bigint identity(100,3) PRIMARY KEY,
    id_cliente bigint,
    fecha_compra DATE,
    año tinyint,
    total  DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);
CREATE TABLE Inventario (
    id_inventario bigint identity(200,1) PRIMARY KEY,
    id_comic bigint,
    cantidad binary,
    disponibilidad INT,
    FOREIGN KEY (id_comic) REFERENCES comics(id_comic)
);

CREATE TABLE Comic_compras (
    id_cc bigint identity(1,1) PRIMARY KEY,
    id_compra bigint,
    id_comic bigint,
    cantidad tinyint,
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (id_comic) REFERENCES comics(id_comic)
);