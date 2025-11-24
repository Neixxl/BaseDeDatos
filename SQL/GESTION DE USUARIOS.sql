CREATE DATABASE biblioteca
USE biblioteca;

CREATE TABLE Autor(
idAutor INT IDENTITY(1,1), --Primary--
nombreAutor NVARCHAR(150) NOT NULL,
nacionalidad NVARCHAR(100) NOT NULL,

CONSTRAINT pk_Autor_idAutor PRIMARY KEY(idAutor)
);

CREATE TABLE Libro(
idLibro INT IDENTITY(1,1), --Primary--
titulo NVARCHAR(200) NOT NULL,
anioPublicacion INT,
idAutor INT,
stock INT,

CONSTRAINT pk_libro_idLibro PRIMARY KEY(idLibro),
CONSTRAINT ch_libro_anioPublicacion CHECK(anioPublicacion > 1500 AND anioPublicacion < YEAR(GETDATE())),
CONSTRAINT ch_libro_stock CHECK(stock > 0)
);

CREATE TABLE Usuario(
idUsuario INT IDENTITY(1,1), --Primary--
nombreUsuario NVARCHAR(100) NOT NULL,
correoElectronico NVARCHAR(200) NOT NULL, --Unique--
fechaRegistro DATE DEFAULT(GETDATE()),

CONSTRAINT pk_Usuario_idUsuario PRIMARY KEY(idUsuario),
CONSTRAINT uq_Usuario_correoElectronico UNIQUE(correoElectronico)
);

CREATE TABLE Prestamo(
idPrestamo INT IDENTITY(1,1), --Primary--
idUsuario INT, --Foreign--
idLibro INT, --Foreign--
fechaInicio DATE NOT NULL,
fechaFin DATE NOT NULL,

CONSTRAINT pk_Prestamo_idPrestamo PRIMARY KEY(idPrestamo),
CONSTRAINT fk_Prestamo_idUsuario FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario),
CONSTRAINT fk_Prestamo_idLibro FOREIGN KEY(idLibro) references Libro(idLibro),
CONSTRAINT ch_Prestamo_fecha CHECK(fechaFin>fechaInicio)
);

--EJERCICIO 1
CREATE LOGIN  bibliotecario1login
WITH PASSWORD = 'testtest13';

CREATE USER bibliotecario1
FOR LOGIN bibliotecario1login;

--EJERCICIO2
CREATE USER lector1 WITHOUT LOGIN;

--EJERCICIO3
ALTER USER bibliotecario1 WITH NAME = gestorBiblioteca;

--EJERCICIO4
GRANT SELECT, UPDATE ON Libro TO gestorBiblioteca;

--EJERCICIO5
DENY DELETE ON Libro TO gestorBiblioteca;

--EJERCICIO6
GRANT SELECT ON Prestamo TO lector1;

--EJERCICIO7
CREATE LOGIN bilbliotecario2login
WITH PASSWORD = 'testtest13';

CREATE USER bilbliotecario2
FOR LOGIN bibliotecario2login;

DENY UPDATE ON Libro TO bibliotecario2;

--EJERCICIO8
GRANT INSERT, DELETE, UPDATE ON Prestamo TO gestorBiblioteca WITH GRANT OPTION;

--EJERCICIO9
GRANT ALL ON Usuario TO gestorBiblioteca;

--EJERCICIO10
DENY SELECT ON Prestamo TO lector1;

--EJERCICIO11
ALTER USER bibliotecario2 WITH NAME = asistenteBiblioteca;
ALTER USER asistenteBiblioteca WITH LOGIN = bibliotecario2login;

--EJERCICIO12	
CREATE LOGIN revisorLibrosLogin
WITH PASSWORD = 'testtest13';

CREATE USER revisorLibros
FOR LOGIN revisorLibrosLogin;

GRANT SELECT, UPDATE ON Libro TO revisorLibros;

--EJERCICIO13
DROP USER lector1; 

--EJERCICIO14
DENY ALL ON Libro TO asistenteBiblioteca;