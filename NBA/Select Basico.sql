USE NBAv2;

-- EJERCICIO 01--
SELECT *
FROM jugador
WHERE peso > 100
ORDER BY nombre;

-- EJERCICIO 02 -- 
SELECT *
FROM jugador
WHERE altura >= 2.00 AND altura <= 2.10 AND peso < 105;

-- EJERCICIO 03 --
SELECT nombre, ciudad, anio_fundacion, conferencia
FROM equipo
WHERE anio_fundacion < 1970 AND conferencia = 'Este';

-- EJERCICIO 04 --
SELECT codigo, nombre, procedencia
FROM jugador
WHERE nombre LIKE 'J%'  AND procedencia != 'EE.UU';

-- EJERCICIO 05 -- 
SELECT codigo, equipo_local, equipo_visitante, puntos_local, puntos_visitante, temporada
FROM partido
WHERE temporada = '2024-25' AND (puntos_local > 120 OR equipo_visitante < 90);



