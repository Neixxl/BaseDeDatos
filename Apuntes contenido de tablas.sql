SELECT * FROM cliente;

 -- BORRAR CONTENIDO DENTRO DE LA BASE DE DATOS
DELETE FROM cliente 
WHERE apellido2 IS NOT NULL AND apellido1 IS NOT NULL;

DELETE FROM cliente WHERE (ciudad = 'Almería' OR ciudad = 'Granada') AND categoria < 300;

-- Insertar datos en la tabla cliente
INSERT INTO 
cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES 
('Aarón', 'Rivero', 'Gómez','Almería', 100),
('Adela', 'Salas', 'Díaz','Granada', 200),
('Adolfo', 'Rubio', 'Flores','Sevilla', NULL),
('Adrián', 'Suárez', NULL,'Jaén', 300),
('Marcos', 'Loyola', 'Méndez','Almería', 200),
('María', 'Santana', 'Moreno','Cádiz', 100),
('Pilar', 'Ruiz', NULL, 'Sevilla',300),
('Pepe', 'Ruiz', 'Santana','Huelva', 200),
('Guillermo', 'López', 'Gómez','Granada', 225),
('Daniel', 'Santana', 'Loyola','Sevilla', 125);
GO