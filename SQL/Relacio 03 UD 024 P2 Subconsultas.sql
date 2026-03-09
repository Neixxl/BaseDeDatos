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
