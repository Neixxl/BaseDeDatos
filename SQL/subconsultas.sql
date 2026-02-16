--Ejercicio 01: Muestra un listado con todos los productos del fabricante Sony. Sin utilizar INNER JOIN.
-- Total de filas recuperadas: 3.

USE tienda_informatica;

SELECT *
FROM producto
WHERE producto.cod_fabricante = (
	SELECT fabricante.codigo
	FROM fabricante
	WHERE fabricante.nombre ='Sony'
);


-- Ejercicio 02: Muestra un listado con todos los datos de los productos que tienen el mismo precio que el
-- producto más caro del fabricante Samsung. Sin utilizar INNER JOIN. Total de filas recuperadas: 1.

SELECT *
FROM producto
WHERE precio = (
	SELECT MAX(producto.precio)
	FROM producto
	WHERE producto.cod_fabricante = (
		SELECT fabricante.codigo
		FROM fabricante
		WHERE fabricante.nombre = 'Samsung'
		)
	);