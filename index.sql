--1- Importar la base de datos 
-- C:\Program Files\PostgreSQL\10\bin>psql -U postgres unidad2 < C:\Users\m_didi\Desktop\unidad2.sql

--2-  El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9.
-- ● cantidad: 5.
-- ● fecha: fecha del sistema

BEGIN;
INSERT INTO compra (cliente_id, fecha) VALUES (1,'2020-02-02');
UPDATE producto SET stock = stock - 5 WHERE id = 9;
COMMIT;
--compruebo con el comando  // Reviso que el stock fue descontado.
SELECT * FROM producto

-- El cliente usuario02 ha realizado la siguiente compra:
-- ● producto: producto1, producto 2, producto 8.
-- ● cantidad: 3 de cada producto.
-- ● fecha: fecha del sistema

BEGIN;
INSERT INTO compra (cliente_id, fecha) VALUES (2,'2020-02-02');
UPDATE producto SET stock = stock - 3 WHERE id = 1;
UPDATE producto SET stock = stock - 3 WHERE id = 2;
UPDATE producto SET stock = stock - 3 WHERE id = 8;-- Error por no haber Stock, se hace Rollback
COMMIT;

-- . Deshabilitar el AUTOCOMMIT .
\set AUTOCOMMIT off

-- b. Insertar un nuevo cliente.
BEGIN;
SAVEPOINT nuevo_cliente;
INSERT INTO cliente ( nombre, email) VALUES ('usuario11', 'usuario11@yahoo.com');
-- c. Confirmar que fue agregado en la tabla cliente.
SELECT * FROM cliente;
-- d. Realizar un ROLLBACK.
ROLLBACK TO nuevo_cliente;
COMMIT;
-- e. Confirmar que se restauró la información, sin considerar la inserción del
-- punto b.
SELECT * FROM cliente;
-- f. Habilitar de nuevo el AUTOCOMMIT
\set AUTOCOMMIT on