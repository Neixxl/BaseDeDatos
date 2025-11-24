CREATE DATABASE GetsionUsuarios
USE GestionUsuarios;


CREATE TABLE Autor(
idAutor INT IDENTITY(1,1), --PRIMARY KEY--
nombreAutor NVARCHAR(150) NOT NULL,
nacionalidad NVARCHAR(100) NOT NULL,

CONSTRAINT PK_Autor_idAutor PRIMARY KEY idAutor
);
