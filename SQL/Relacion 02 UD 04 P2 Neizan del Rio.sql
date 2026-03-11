USE Jardineriav2

-- Ejercicio 01: Muestra un listado con la ciudad y el teléfono de las oficinas de España. Total de filas recuperadas: 3 --

SELECT ciudad, telefono, pais
FROM oficina
WHERE pais = 'España';


-- Ejercicio 02: Muestra un listado con el nombre, apellidos y puesto de aquellos empleados 
-- que no sean representantes de ventas. Total de filas recuperadas: 12. --

SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto != 'Representante Ventas'


-- Ejercicio 03: Muestra un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega --
-- de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada. --
-- Investiga para ello la función DATEDIFF de SQL Server. Total de filas recuperadas: 7. --

SELECT codigo_pedido, cliente.codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
INNER JOIN cliente ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE DATEDIFF(DAY,fecha_entrega,fecha_esperada) >= 2;


-- Ejercicio 04: Muestra un listado con todos los pedidos que fueron rechazados en 2025. --
-- Total de filas recuperadas: 12. -

SELECT codigo_pedido, codigo_cliente, fecha_pedido, estado
FROM pedido
WHERE estado = 'Rechazado' AND fecha_pedido BETWEEN '2025-01-01' AND '2025-12-31';


-- Ejercicio 05: Muestra un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen
-- más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer
-- lugar los de mayor precio. Total de filas recuperadas: 15. 

SELECT codigo_producto, nombre, gama, cantidad_en_stock, precio_venta
FROM producto
WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;


-- Ejercicio 06: Muestra un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante
-- de ventas tenga el código de empleado 11 o 30. Total de filas recuperadas: 7.

SELECT codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas
FROM cliente
WHERE ciudad = 'Madrid' AND (codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30);


--Ejercicio 07: Muestra un listado con el nombre de los clientes y el nombre completo de sus representantes
-- junto con la ciudad de la oficina a la que pertenece el representante. Total de filas recuperadas: 29.

SELECT cliente.nombre_cliente, CONCAT(nombre,' ',apellido1,' ',apellido2) AS nombre_completo_empleado, oficina.ciudad AS ciudad_oficina
FROM empleado
INNER JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina
WHERE empleado.puesto LIKE 'Representante%';


-- Ejercicio 08: Muestra un listado con el nombre de los clientes a los que no se les ha entregado a tiempo un
-- pedido. Total de filas recuperadas: 33

SELECT cliente.nombre_cliente, pedido.fecha_esperada, pedido.fecha_entrega
FROM pedido
INNER JOIN cliente ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pedido.fecha_entrega > fecha_esperada;


-- Ejercicio 09: Muestra la dirección de las oficinas que tengan clientes en Fuenlabrada. 
-- Total de filas recuperadas: 6

SELECT oficina.linea_direccion1, oficina.linea_direccion2, oficina.ciudad, cliente.ciudad
FROM oficina
INNER JOIN empleado ON empleado.codigo_oficina = oficina.codigo_oficina
INNER JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
WHERE cliente.ciudad = 'Fuenlabrada';


-- Ejercicio 10: Muestra un listado con las diferentes gamas de producto que ha comprado cada cliente. 
-- Total de filas recuperadas: 53.

SELECT DISTINCT cliente.nombre_cliente, producto.gama
FROM cliente
INNER JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
INNER JOIN linea_pedido ON linea_pedido.codigo_pedido = pedido.codigo_pedido
INNER JOIN producto ON producto.codigo_producto = linea_pedido.codigo_producto
ORDER BY producto.gama ASC; -- Pongo esto porque en la foto esta ordenado pero no haria falta por lo que pide el enunciado


-- Ejercicio 11: Muestra un listado con las oficinas donde trabajan los empleados que hayan sido los
-- representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
-- Total de filas recuperadas: 6

SELECT DISTINCT oficina.codigo_oficina, oficina.ciudad, oficina.pais
FROM oficina
INNER JOIN empleado ON empleado.codigo_oficina = oficina.codigo_oficina
INNER JOIN cliente ON  cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
INNER JOIN linea_pedido ON linea_pedido.codigo_pedido = pedido.codigo_pedido
INNER JOIN producto ON producto.codigo_producto = linea_pedido.codigo_producto
WHERE empleado.puesto = 'Representante Ventas' AND producto.gama = 'Frutales';


-- Ejercicio 12: Muestra un listado que muestre solamente los empleados que no tienen un cliente asociado.
-- Total de filas recuperadas: 20.

SELECT codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto, cliente.codigo_cliente
FROM empleado
LEFT JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
WHERE cliente.codigo_cliente IS NULL;


-- Ejercicio 13: Muestra un listado con el nombre de cada empleado, el nombre de su jefe y el nombre del jefe
-- de su jefe. Solo deberás mostrar 3 columnas, una con el nombre completo del empleado, otra con el nombre
-- completo del jefe y otra con el nombre completo del jefe del jefe. Total de filas recuperadas: 31


SELECT CONCAT(original.nombre,', ',original.apellido1,', ',original.apellido2) AS nombre_empleado, 
CONCAT(jefe.nombre,', ',jefe.apellido1,', ',jefe.apellido2) AS nombre_jefe,
CONCAT(jefe2.nombre,', ',jefe2.apellido1,', ',jefe2.apellido2) AS nombre_jefe_jefe
FROM empleado original
LEFT JOIN empleado jefe ON original.codigo_jefe = jefe.codigo_empleado
LEFT JOIN empleado jefe2 ON jefe.codigo_jefe = jefe2.codigo_empleado

