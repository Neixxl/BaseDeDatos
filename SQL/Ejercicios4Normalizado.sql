CREATE DATABASE Ejercicio4Normalizado;
USE Ejercicio4Normalizado;


CREATE TABLE Cliente(
DNI NVARCHAR(9), --Primary--
nombre NVARCHAR(150) NOT NULL,
direccion NVARCHAR(250) NOT NULL,
telefono INT NOT NULL, --unique--
email NVARCHAR(100) NOT NULL, --unique--

CONSTRAINT PK_Cliente_DNI PRIMARY KEY(DNI),
CONSTRAINT UQ_Cliente_telefono UNIQUE(telefono),
CONSTRAINT UQ_Cliente_email UNIQUE(email)
);

CREATE TABLE Banner(
codigo INT IDENTITY(1,1), --PRIMARY
nombre NVARCHAR(150) NOT NULL,
descripcion NVARCHAR(500) NOT NULL,
PVP DECIMAL(5,2) NOT NULL, --CHECK
marca NVARCHAR(100) NOT NULL,

CONSTRAINT PK_Banner_codigo PRIMARY KEY(codigo),
CONSTRAINT CH_Banner_PVP CHECK(PVP > 0)
);