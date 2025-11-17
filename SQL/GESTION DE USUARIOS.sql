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
CONSTRAINT ch_libro_anioPublicacion CHECK(anioPublicacion > 1500 AND anioPublicacion < GETDATE())