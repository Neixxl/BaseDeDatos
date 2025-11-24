CREATE DATABASE GestionEntradas;
USE GestionEntradas;


--TABLA ESPECTACULO--
CREATE TABLE Espectaculo(
codEspectaculo INT IDENTITY(1,1), --Primary--
nomEspectaculo NVARCHAR(250) NOT NULL,
tipoEspectaculo NVARCHAR(100) NOT NULL,
fechainicioEspectaculo DATE NOT NULL,
fechafinalEspectaculo DATE NOT NULL,
interpreteEspectaculo NVARCHAR(150) NOT NULL,
codRecinto INT NOT NULL,

CONSTRAINT PK_Espectaculo_codEspectaculo PRIMARY KEY(codEspectaculo),
CONSTRAINT CH_Espectaculo_tipoEspectaculo CHECK (tipoEspectaculo IN ('Circo' , 'Concierto' , 'Futbol' , 'Otro'))
);


--TABLA RECINTO--
CREATE TABLE Recinto(
codRecinto INT NOT NULL, --PRIMARY--
nomRecinto NVARCHAR(250) NOT NULL, --NVARCHAR PORQUE ES UN STRING
dirRecinto NVARCHAR(250) NOT NULL,
ciuRecinto NVARCHAR(100) NOT NULL,
telRecinto INT NOT NULL,
horRecinto TIME NOT NULL,

CONSTRAINT PK_Recinto_codRecinto PRIMARY KEY(codRecinto)
);


--TABLA REPRESENTACION--
CREATE TABLE Representacion(
codRepresentacion INT IDENTITY(1,1), --PRIMARY--
codEspectaculo INT, --FOREIGN--
fechaRepresentacion DATE NOT NULL,
horeRepresentacion TIME NOT NULL,

CONSTRAINT PK_Representacion_codRepresentacion PRIMARY KEY(codRepresentacion),
CONSTRAINT FK_Representacion_codEspectaculo FOREIGN KEY(codEspectaculo) REFERENCES Espectaculo(codEspectaculo)
);



--TABLA PRECIO-REPRESENTACION--
CREATE TABLE Precio_Representacion(
codEspectaculo INT, --FOREIGN KEY--
codRepresentacion INT, --FOREIGN KEY--
pvpRepresentacion DECIMAL(5,2) NOT NULL DEFAULT 19.99,

CONSTRAINT PK_Precio_Representacion PRIMARY KEY(codEspectaculo, codRepresentacion),
CONSTRAINT FK_Precio_Representacion_codEsp FOREIGN KEY (codEspectaculo) REFERENCES Espectaculo(codEspectaculo),
CONSTRAINT FK_Precio_Representacion_codRep FOREIGN KEY (codRepresentacion) REFERENCES Representacion(codRepresentacion),
);


--TABLA ESPECTADOR--
CREATE TABLE Espectador(
dniEspectador VARCHAR(9), --PRIMARY--
nomEspectador NVARCHAR(100) NOT NULL,
dirEspectador NVARCHAR(250) NOT NULL,
telEspectador INT NOT NULL, --UNIQUE--
ciuEspectador NVARCHAR(150) NOT NULL,
numeroTarjeta INT NOT NULL, --UNIQUE--

CONSTRAINT PK_Espectador_dniEspectador PRIMARY KEY(dniEspectador),
CONSTRAINT UQ_Espectaor_telEspectaor UNIQUE (telEspectador),
CONSTRAINT UQ_Espectaor_numTarjeta UNIQUE (numeroTarjeta)
);



--TABLA ENTRADA--
CREATE TABLE Entrada(
codEntrada INT, --PRIMARY--
codRepresentacion INT, --FOREIGN KEY--
codRecinto INT, --FOREIGN KEY--
numAsiento INT NOT NULL,
filaAsiento INT NOT NULL,
dniEspectador VARCHAR(9) NOT NULL, --FOREIGN KEY--

CONSTRAINT PK_Entrada_codEntrada PRIMARY KEY (codEntrada),
CONSTRAINT FK_Entrada_codRepresentacion FOREIGN KEY (codRepresentacion) REFERENCES Representacion(codRepresentacion),
CONSTRAINT FK_Entrada_codRecinto FOREIGN KEY (codRecinto) REFERENCES Recinto(codRecinto),
CONSTRAINT FK_Entrada_dniEspectador FOREIGN KEY (dniEspectador) REFERENCES Espectador(dniEspectador)
);

--GESTION DE USUARIOS

--APARTADO1
CREATE LOGIN adminEntradasLogin
WITH PASSWORD = 'qUEcontraMasDificil13';

CREATE USER adminEntradas
FOR LOGIN adminEntradasLogin;

--APARTADO2
CREATE USER consultaPublica WITHOUT LOGIN;

--APARTADO3	
GRANT SELECT ON Recinto TO consultaPublica;
GRANT SELECT ON Espectaculo TO consultaPublica;
GRANT SELECT ON Representacion TO consultaPublica;

--APARTADO4
CREATE LOGIN gestorEspectaculosLogin
WITH PASSWORD = 'cONTRAsuuPERdIFICIL32';

CREATE USER gestorEspectaculos
FOR LOGIN gestorEspectaculosLogin;

GRANT SELECT, INSERT, UPDATE ON Espectaculo TO gestorEspectaculos;
DENY DELETE ON Espectaculo TO gestorEspectaculos;

--APARTADO5
CREATE LOGIN gestorRecintosLogin
WITH PASSWORD = 'GESTORrecintosCONTRA001';

CREATE USER gestorRecintos
FOR LOGIN gestorRecintosLogin;

GRANT SELECT, INSERT, UPDATE ON Recinto TO gestorRecintos;
DENY ALL ON Espectador TO gestorRecintos;

--APARTADO6
CREATE LOGIN usuarioEspectadorLogin
WITH PASSWORD = 'coNtraMala31111';

CREATE USER usuarioEspectador
FOR LOGIN usuarioEspectadorLogin;

GRANT SELECT ON Espectaculo TO usuarioEspectador;
GRANT SELECT ON Representacion TO usuarioEspectador;
GRANT SELECT ON Precio_Representacion TO usuarioEspectador;

DENY UPDATE ON Espectaculo TO usuarioEspectador;
DENY UPDATE ON Representacion TO usuarioEspectador;
DENY UPDATE ON Precio_Representacion TO usuarioEspectador;

--APARTADO7
GRANT INSERT,UPDATE,DELETE,SELECT ON Entrada TO adminEntradas WITH GRANT OPTION;

--APARTADO8
DENY UPDATE ON Espectaculo TO gestorEspectaculos;

--APARTADO9
DENY ALL ON Espectador TO consultaPublica;

--APARTADO10
ALTER USER gestorRecintos WITH NAME = coordinadorRecintos;
ALTER LOGIN gestorRecintosLogin WITH NAME = coordinadorRecintosLogin;
ALTER USER coordinadorRecintos WITH LOGIN = coordinadorRecintosLogin;

--APARTADO11
GRANT ALL ON Representacion TO adminEntradas;

--APARTADO12
DROP USER consultaPublica;
