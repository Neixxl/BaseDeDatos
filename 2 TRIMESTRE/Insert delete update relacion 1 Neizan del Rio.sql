
USE jardineriav2;


--EJERCICIOS -- 

--Inserta una nueva oficina en Almería.--
INSERT INTO oficina(codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2) VALUES 
('ALM-ES', 'Almeria','España', 'Almeria', '29130', '+34611711811', 'Avenida Almeria, 41', '' );


--Inserta un empleado para la oficina de Almería que sea representante de ventas.--
INSERT INTO empleado(codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto) VALUES
(32,'Pedro','Pica','Piedra','4120','pedro@picapiedragardening.es','ALM-ES',1,'Representante Ventas');


--Inserta un cliente que tenga como representante de ventas el empleado que hemos creado en el paso anterior.--
INSERT INTO cliente(codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono,fax, linea_direccion1, linea_direccion2,
ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito) VALUES
(39,'Tercero Juancarlos', 'Juanca', 'Tercero','902374852','57823452','RandoTron Street 41B', NULL, 'Malaga', 'Andalucia','España', '29130', 32, 2500.00);


--Inserta un pedido para el cliente que acabamos de crear, que contenga al menos dos productos.--
INSERT INTO pedido(codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente) VALUES
(129,'2022-05-20', '2022-05-22', '2022-05-22', 'Entregado', NULL, 39);
INSERT INTO linea_pedido(codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) VALUES 
(129,'OR-127', 2, 4.00,1);
INSERT INTO pago_pedido (id_transaccion, codigo_pedido, codigo_pago, fecha_pago) VALUES
('ak-std-0000128', 129, 5, '2022-05-22');


--Actualiza el código del cliente que has creado en el paso anterior a 40. ¿Es posible actualizarlo?--
--Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?--

ALTER TABLE pedido
DROP CONSTRAINT fk_pedido_cliente;

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente 
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
ON UPDATE CASCADE;

UPDATE pedido SET codigo_cliente = 40 WHERE codigo_cliente = 39;


--Ejercicio 06: Borra el cliente que has creado en el paso anterior.--
--¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?--

ALTER TABLE pedido
DROP CONSTRAINT fk_pedido_cliente;

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente 
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
ON DELETE CASCADE;

ALTER TABLE pedido
DROP CONSTRAINT fk_pedido_cliente;

ALTER TABLE pedido
ADD CONSTRAINT fk_linea_pedido_pedido
FOREIGN KEY (codigo_pedido) REFERENCES pedido (codigo_pedido)
ON DELETE CASCADE;

DELETE FROM cliente WHERE codigo_cliente = 40;


--Modifica la tabla linea_pedido para incorporar un campo numérico llamado total_linea y--
--actualiza todos sus registros para calcular su valor mediante la fórmula:--

ALTER TABLE linea_pedido
ADD total_linea DECIMAL(15,2);

UPDATE linea_pedido SET total_linea = precio_unidad * cantidad * (1 + 0.21);


--Crea una transacción que inserte de forma segura una oficina con sede en Granada y tres
--empleados que sean representantes de ventas. En caso de producirse un error deberás deshacer la transacción
--y propagar el error producido.--

BEGIN TRY
	BEGIN TRAN;
	INSERT INTO oficina(codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2) VALUES 
('GRA-ES', 'Granada','España', 'Granada', '29131', '+34611712811', 'Avenida Granada, 42', '' );

INSERT INTO empleado(codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto) VALUES
(33,'Pablo','Fernandez','Sanchez','4120','pablo@jardonzuelos.es','GRA-ES',1,'Representante Ventas'),
(34,'Maria','Fernandez','Sanchez','4120','maria@jardonzuelos.es','GRA-ES',1,'Representante Ventas'),
(35,'Pedro','Delgado','Sanchez','4120','pedro@jardonzuelos.es','GRA-ES',1,'Representante Ventas');

	COMMIT TRAN;
END TRY
BEGIN CATCH
	IF XACT_STATE() != 0
		ROLLBACK TRAN;
		THROW;
END CATCH;


--Inserta tres clientes que tengan como representantes de ventas los empleados que hemos creado en el paso anterior--

INSERT INTO cliente(codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono,fax, linea_direccion1, linea_direccion2,
ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito) VALUES
(41,'Manchado Paco', 'Paquito', 'Manchado','902374822','57823252','RandoTron Street 42B', NULL, 'Malaga', 'Andalucia','España', '29130', 33, 3500.00),
(42,'Manchado Carlos', 'Carl', 'Manchado','902374832','57841252','RandoTron Street 43B', NULL, 'Malaga', 'Andalucia','España', '29130', 34, 4000.00),
(43,'Perez Enrique', 'Enrique', 'Perez','902372822','57826552','RandoTron Street 45C', NULL, 'Malaga', 'Andalucia','España', '29130', 35, 100.00);


--Borra uno de los clientes y comprueba si hubo cambios en las tablas relacionadas.
--¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?

DELETE FROM cliente WHERE codigo_cliente = 41;



SELECT * FROM gama_producto;
SELECT * FROM cliente;
SELECT * FROM empleado;
SELECT * FROM linea_pedido;
SELECT * FROM oficina;
SELECT * FROM pago;
SELECT * FROM pago_pedido;
SELECT * FROM pedido;
SELECT * FROM producto;


