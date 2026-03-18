USE NBAv2

--Ejercicio 01: Muestra un listado con los jugadores que tienen una altura mayor a la media.
--Total de filas recuperadas: 860

SELECT *
FROM jugador
WHERE altura > (
	SELECT AVG(altura)
	FROM jugador)
ORDER BY altura 


--Ejercicio 02: Muestra un listado con los jugadores que han jugado en los partidos de la temporada 2020-21
--contra los Raptors. Ten en cuenta que los Raptos pueden jugar como local o como visitante.
--Total de filas recuperadas: 488

SELECT jugador.nombre AS jug_nom, equipo.nombre AS eq_nom, jugador_equipo.temporada
FROM jugador
INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
INNER JOIN equipo ON jugador_equipo.codigo_equipo = equipo.codigo
WHERE temporada = '2020-21' AND jugador.codigo IN (
	SELECT codigo_jugador
	FROM jugador_equipo
	WHERE codigo_equipo IN (
		SELECT DISTINCT equipo_local
		FROM partido
		WHERE equipo_visitante = (
			SELECT codigo
			FROM equipo
			WHERE nombre = 'Raptors')
		)
	)
		

--Ejercicio 03: Muestra un listado con los nombres de los jugadores que no hayan tenido una estadística de
--puntos por temporada superior a 15 en la temporada 2018-19. Total de filas recuperadas: 25.

SELECT *
FROM jugador 
WHERE codigo IN (
	SELECT id_jugador
	FROM estadistica_jugador_temporada
	WHERE temporada = '2018-19' AND promedio_puntos_partido_temporada < 15
	)
;

--Ejercicio 04: Muestra un listado con los jugadores que han jugado para equipos en la conferencia Este y que
--han registrado más de 700 puntos en la temporada 2017-18. Total de filas recuperadas: 77.

SELECT *
FROM jugador
INNER JOIN jugador_equipo ON codigo_jugador = jugador.codigo
WHERE jugador_equipo.codigo_equipo IN (
	SELECT codigo
	FROM equipo
	WHERE conferencia = 'este'
	)
AND codigo IN (
	SELECT id_jugador
	FROM estadistica_jugador_temporada
	WHERE promedio_puntos_partido_temporada >= 700 AND temporada = '2017-18'
	)
AND jugador_equipo.temporada = '2017-18'
;

--Ejercicio 05: Muestra un listado con los jugadores que han jugado en la temporada 2012-13 y tengan un
--promedio de más de 80 tapones por temporada. Total de filas recuperadas: 33.

SELECT *
FROM jugador
WHERE codigo IN (
	SELECT id_jugador
	FROM estadistica_jugador_temporada
	WHERE temporada = '2012-13' AND promedio_tapones_temporada > 80
	)
;

--Ejercicio 06: Muestra un listado con los jugadores cuya altura sea mayor al promedio de las alturas de los
--jugadores de los Timberwolves en la temporada 2021-22. Total de filas recuperadas: 1057

SELECT *
FROM jugador
WHERE altura > (
	SELECT AVG(altura)
	FROM jugador
	WHERE codigo IN (
		SELECT codigo_jugador
		FROM jugador_equipo
		WHERE temporada = '2021-22'
		AND codigo_equipo IN (
			SELECT codigo
			FROM equipo
			WHERE nombre = 'Timberwolves'
			)
		)
	)
;

--Ejercicio 07: Muestra un listado con los equipos cuyo nombre empieza con la letra 'C' y que tienen al menos
--un jugador con un peso superior a 100 kg en la temporada 2024-25. Total de filas recuperadas: 3.

SELECT *
FROM equipo
WHERE equipo.nombre LIKE 'C%' AND codigo IN (
	SELECT codigo_equipo
	FROM jugador_equipo
	WHERE temporada = '2024-25' AND codigo_jugador IN (
		SELECT codigo
		FROM jugador
		WHERE peso < 100
		)
	)
;


--Ejercicio 08: Muestra un listado con los jugadores que han tenido una media de puntos por temporada mayor
--que el promedio de puntos por temporada de todos los jugadores en la temporada 2017-18. Total de filas
--recuperadas: 207.


SELECT 
    jugador.nombre, 
    estadistica_jugador_temporada.promedio_puntos_partido_temporada
FROM jugador
-- Unimos la tabla de jugadores con sus estadísticas
JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
WHERE estadistica_jugador_temporada.temporada = '2017-18'
AND estadistica_jugador_temporada.promedio_puntos_partido_temporada > (
	-- SUBCONSULTA: Calculamos el "listón" (la media de todos)
	SELECT AVG(promedio_puntos_partido_temporada)
	FROM estadistica_jugador_temporada
	WHERE temporada = '2017-18'
	);





SELECT *
FROM jugador
WHERE altura > (
	SELECT AVG(altura)
	FROM jugador
	)
;


SELECT jugador.nombre, (
	SELECT MAX(promedio_puntos_partido_temporada)
	FROM estadistica_jugador_temporada
	WHERE id_jugador = jugador.codigo) AS record_personal
FROM jugador;






--Ejercicio 13: Muestra un listado con los jugadores que hayan jugado en la temporada 2023-24 para equipos
--de la conferencia Este como visitantes y cuyo promedio de puntos por partido en esa temporada sea 375 o
--más. Total de filas recuperadas: 173.

SELECT nombre 
FROM jugador
WHERE codigo IN (
    SELECT id_jugador 
    FROM estadistica_jugador_temporada 
    WHERE temporada = '2023-24' 
	AND promedio_puntos_partido_temporada >= 375
	AND id_equipo IN (
		SELECT codigo 
		FROM equipo 
		WHERE conferencia = 'Este'
		AND codigo IN (
			SELECT equipo_visitante 
			FROM partido 
			WHERE temporada = '2023-24'
            )
		)
	);



SELECT *
FROM equipo
WHERE anio_fundacion = (
	SELECT anio_fundacion
	FROM equipo
	WHERE codigo = '1610612739'
	)
;



SELECT anio_fundacion AS año, codigo, nombre
FROM equipo
WHERE codigo = '1610612739';



--Ejercicio 15: Muestra un listado con los jugadores que tienen un promedio de puntos por encima del promedio
--de su equipo en la misma temporada. Muestra el resultado ordenado por nombre de jugador y por nombre de
--equipo. Total de filas recuperadas: 2.924


SELECT 
    j.nombre AS nombre_jugador, 
    eq.nombre AS nombre_equipo
FROM jugador j
-- Pegamos las estadísticas (LA LLAMAMOS e1)
JOIN estadistica_jugador_temporada e1 ON j.codigo = e1.id_jugador
-- Pegamos el equipo para poder mostrar su nombre
JOIN equipo eq ON e1.id_equipo = eq.codigo

WHERE e1.promedio_puntos_partido_temporada > (

    -- SUBCONSULTA: Calculamos la media del equipo de ese jugador
    -- A esta copia de la tabla la llamamos e2
    SELECT AVG(e2.promedio_puntos_partido_temporada)
    FROM estadistica_jugador_temporada e2
    -- ¡LA MAGIA ESTÁ AQUÍ! Conectamos la tabla de dentro (e2) con la de fuera (e1)
    WHERE e2.id_equipo = e1.id_equipo 
      AND e2.temporada = e1.temporada
)
ORDER BY j.nombre, eq.nombre;


SELECT jugador.nombre AS nombreJ, equipo.nombre AS nombreEq
FROM jugador
JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
JOIN equipo ON estadistica_jugador_temporada.id_equipo = equipo.codigo
WHERE estadistica_jugador_temporada.promedio_puntos_partido_temporada > (
	SELECT AVG(sc.promedio_puntos_partido_temporada)
	FROM estadistica_jugador_temporada sc
	WHERE sc.id_equipo = estadistica_jugador_temporada.id_equipo
	AND sc.temporada = estadistica_jugador_temporada.temporada
)
ORDER BY jugador.nombre, equipo.nombre;


--Ejercicio 09: Muestra un listado con los jugadores que han tenido la mejor estadística de promedio de tiros
--libres en cada temporada junto al nombre del equipo en el que jugaron. Total de filas recuperadas: 16.


SELECT jugador.nombre, estadistica_jugador_temporada.promedio_tiros_libres_temporada AS promedioTiros, equipo.nombre AS equipo
FROM jugador
INNER JOIN estadistica_jugador_temporada ON estadistica_jugador_temporada.id_jugador = jugador.codigo
INNER JOIN equipo ON equipo.codigo = estadistica_jugador_temporada.id_equipo
WHERE estadistica_jugador_temporada.promedio_tiros_libres_temporada = (
	SELECT MAX(cs.promedio_tiros_libres_temporada)
	FROM estadistica_jugador_temporada cs
	WHERE cs.temporada = estadistica_jugador_temporada.temporada
	)
;


--Ejercicio 10: Muestra un listado con los nombres de los jugadores y su equipo que han jugado más de 36
--partidos en la temporada 2019-20. Total de filas recuperadas: 5.

SELECT jugador.nombre AS nomJugador, equipo.nombre AS nomEquipo
FROM jugador
INNER JOIN jugador_equipo ON jugador_equipo.codigo_jugador = jugador.codigo
INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo


















SELECT 
    jugador.nombre AS nombreJ, 
    equipo.nombre AS nombreEq
FROM jugador
-- Unimos todo para tener los nombres
JOIN estadistica_jugador_temporada ON jugador.codigo = estadistica_jugador_temporada.id_jugador
JOIN equipo ON estadistica_jugador_temporada.id_equipo = equipo.codigo

-- Filtramos: ¿El promedio del jugador es IGUAL AL MÁXIMO de su temporada?
WHERE estadistica_jugador_temporada.promedio_tiros_libres_temporada = (
    
    -- SUBCONSULTA: Busca el récord absoluto (MAX) de esa temporada concreta
    SELECT MAX(sc.promedio_tiros_libres_temporada)
    FROM estadistica_jugador_temporada sc
    -- Conectamos la temporada de la subconsulta con la de fuera
    WHERE sc.temporada = estadistica_jugador_temporada.temporada
);


















SELECT 
    j.nombre AS jugador, 
    eq.nombre AS equipo,
    e1.temporada,
    e1.promedio_tiros_libres_temporada
FROM jugador j
JOIN estadistica_jugador_temporada e1 ON j.codigo = e1.id_jugador
JOIN equipo eq ON e1.id_equipo = eq.codigo

WHERE e1.promedio_tiros_libres_temporada = (

    -- SUBCONSULTA: Buscamos la nota más alta de esa temporada específica
    SELECT MAX(e2.promedio_tiros_libres_temporada)
    FROM estadistica_jugador_temporada e2
    -- Conectamos la temporada de dentro con la de fuera
    WHERE e2.temporada = e1.temporada
);