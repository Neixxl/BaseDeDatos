USE Ejercicio1;

--EJERCICIO 1--
CREATE TABLE Pais(
	idPais INT IDENTITY (1,1) PRIMARY KEY,
	nombrePais NVARCHAR(100) NOT NULL
);

--EJERCICIO 2--
CREATE TABLE Region(
	idRegion INT IDENTITY(1,1),
	nombreRegion NVARCHAR(300),
	hemisferioRegion NVARCHAR(100),

	CONSTRAINT pk_Region_idRegion PRIMARY KEY(idRegion),
	CONSTRAINT ch_Region_hemisferioRegion CHECK (hemisferioRegion IN('NORTE', 'SUR'))
);

--EJERCICIO 3--
ALTER TABLE Pais
ADD idRegion INT;

ALTER TABLE Pais
ADD CONSTRAINT fk_region_pais FOREIGN KEY (idRegion) REFERENCES Region(idRegion);

--EJERCICIO 4--
ALTER TABLE Pais
ADD CONSTRAINT ch_Pais_nombrePai CHECK (nombrePais IN('Italia' , 'India' , 'China'));

--EJERCICIO 5--
CREATE TABLE Trabajo(
idTrabajo NVARCHAR(10),
nombreTrabajo NVARCHAR(35) NOT NULL,
salarioMin DECIMAL(10,2),
salarioMAX DECIMAL(10,2) 

CONSTRAINT pk_Trabajo_idTrabajo PRIMARY KEY(idTrabajo),
CONSTRAINT ch_Trabajo_salarioMAX CHECK (salarioMAX <= 25000)
);

--EJERCICIO 6--
CREATE TABLE Trabajador(
idTrabajador NVARCHAR(9), --primary--
nombreTrabajador NVARCHAR(100) NOT NULL,
apellido1Trabajdor NVARCHAR(100) NOT NULL,
apellido2Trabajador NVARCHAR(100) NOT NULL,
fechaNacTrabajador DATE NOT NULL,

CONSTRAINT pk_Trabajador_idTrabajador PRIMARY KEY(idTrabajador)
);

--EJERCICIO 7--
CREATE TABLE Historial_trabajo(
idTrabajador NVARCHAR(9),
idTrabajo NVARCHAR(10),
fecha_comienzo DATE NOT NULL,
fecha_finalizacion DATE NOT NULL,

CONSTRAINT fk_Historial_trabajo_idTrabajador FOREIGN KEY (idTrabajador) REFERENCES Trabajador(idTrabajador),
CONSTRAINT fk_Historial_trabajo_idTrabajo FOREIGN KEY (idTrabajo) REFERENCES Trabajo(idTrabajo)
);

--EJERCICIO 8--
ALTER TABLE Pais
ADD CONSTRAINT UQ_Pais_nombrePais UNIQUE (nombrePais);

--EJERCICIO 9--
ALTER TABLE Trabajo
ADD CONSTRAINT DE_Trabajo_salarioMIN DEFAULT(1500.00) FOR salarioMIN;

