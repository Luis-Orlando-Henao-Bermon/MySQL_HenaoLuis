drop database if exists taller_funciones;
create database taller_funciones;

use taller_funciones;

CREATE TABLE departamento (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DOUBLE UNSIGNED NOT NULL,
gastos DOUBLE UNSIGNED NOT NULL
); 


CREATE TABLE empleado (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nif VARCHAR(9) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
id_departamento INT UNSIGNED,
FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero',
NULL);

-- 1. Lista el primer apellido de todos los empleados.

select apellido1 from empleado;

-- 2. Lista el primer apellido de los empleados eliminando los apellidos que estén
-- repetidos.

select distinct apellido1 from empleado;

-- 3. Lista todas las columnas de la tabla empleado.

select * from empleado;

-- 4. Lista el nombre y los apellidos de todos los empleados.

select nombre, apellido1, apellido2 from empleado;

-- 5. Lista el identificador de los departamentos de los empleados que aparecen
-- en la tabla empleado.

select id_departamento from empleado;

-- 6. Lista el identificador de los departamentos de los empleados que aparecen
-- en la tabla empleado, eliminando los identificadores que aparecen repetidos.

select distinct id_departamento from empleado;

-- 7. Lista el nombre y apellidos de los empleados en una única columna.

select concat_ws('',nombre,' ', apellido1,' ', apellido2) as nombreCompleto from empleado;

-- 8. Lista el nombre y apellidos de los empleados en una única columna,
-- convirtiendo todos los caracteres en mayúscula.

select upper(concat_ws('',nombre,' ', apellido1,' ', apellido2)) as nombreCompleto from empleado;

-- 9. Lista el nombre y apellidos de los empleados en una única columna,
-- convirtiendo todos los caracteres en minúscula.

select lower(concat_ws('',nombre,' ', apellido1,' ', apellido2)) as nombreCompleto from empleado;

-- 10. Lista el identificador de los empleados junto al nif, pero el nif deberá
-- aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la
-- otra la letra.

select id, REGEXP_REPLACE(nif,'[A-Z]','') as 'numeros del nif',REGEXP_REPLACE(nif,'[0-9]','') as 'letras del nif' from empleado order by id asc;

-- 11. Lista el nombre de cada departamento y el valor del presupuesto actual del
-- que dispone. Para calcular este dato tendrá que restar al valor del
-- presupuesto inicial (columna presupuesto) los gastos que se han generado
-- (columna gastos). Tenga en cuenta que en algunos casos pueden existir
-- valores negativos. Utilice un alias apropiado para la nueva columna columna
-- que está calculando.

DELIMITER //
create function Presupuesto_departamento(presupuestoT double,gastosT double)
returns double deterministic
begin
declare presupuestoF double;
set presupuestoF = presupuestoT-gastosT;
return presupuestoF;
end // 
DELIMITER ;

select nombre,Presupuesto_departamento(presupuesto,gastos) as 'Presupuesto de departamento' from departamento;

-- 12. Lista el nombre de los departamentos y el valor del presupuesto actual
-- ordenado de forma ascendente.

select nombre,Presupuesto_departamento(presupuesto,gastos) as 'Presupuesto de departamento' from departamento order by 2 asc;

-- 13. Lista el nombre de todos los departamentos ordenados de forma
-- ascendente.

select nombre from departamento order by 1 asc;

-- 14. Lista el nombre de todos los departamentos ordenados de forma
-- descendente.

select nombre from departamento order by 1 desc;

-- 15. Lista los apellidos y el nombre de todos los empleados, ordenados de forma
-- alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su
-- nombre.

select apellido1,apellido2,nombre from empleado order by 1,2,3 asc; 

-- 16. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos
-- que tienen mayor presupuesto.

select nombre,Presupuesto_departamento(presupuesto,gastos) as 'Presupuesto de departamento' from departamento order by 2 desc limit 3;

-- 17. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos
-- que tienen menor presupuesto.

select nombre,Presupuesto_departamento(presupuesto,gastos) as 'Presupuesto de departamento' from departamento order by 2 asc limit 3;

-- 18. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que
-- tienen mayor gasto.

select nombre,gastos from departamento order by 2 desc limit 2;

-- 19. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que
-- tienen menor gasto.

select nombre,gastos from departamento order by 2 asc limit 2;

-- 20. Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La
-- tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las
-- columnas de la tabla empleado.  

select * from empleado where id!=1 and id!=2 limit 5; 

-- 21. Devuelve una lista con el nombre de los departamentos y el presupuesto, de
-- aquellos que tienen un presupuesto mayor o igual a 150000 euros.

select nombre,presupuesto from departamento where presupuesto>=150000;

-- 22. Devuelve una lista con el nombre de los departamentos y el gasto, de
-- aquellos que tienen menos de 5000 euros de gastos.

select nombre,gastos from departamento where gastos<5000;

-- 23. Devuelve una lista con el nombre de los departamentos y el presupuesto, de
-- aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin
-- utilizar el operador BETWEEN.

select nombre,presupuesto from departamento where presupuesto>=100000 and presupuesto<=200000;

-- 24. Devuelve una lista con el nombre de los departamentos que no tienen un
-- presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.

select nombre,presupuesto from departamento where presupuesto<=100000 or presupuesto>=200000;

-- 25. Devuelve una lista con el nombre de los departamentos que tienen un
-- presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.

select nombre,presupuesto from departamento where presupuesto between 100000 and 200000;

-- 26. Devuelve una lista con el nombre de los departamentos que no tienen un
-- presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.

select nombre,presupuesto from departamento where presupuesto not between 100000 and 200000;

-- 27. Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean mayores
-- que el presupuesto del que disponen.

select nombre,gastos,presupuesto from departamento where gastos>presupuesto;

-- 28. Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean menores
-- que el presupuesto del que disponen.

select nombre,gastos,presupuesto from departamento where gastos<presupuesto;

-- 29. Devuelve una lista con el nombre de los departamentos, gastos y
-- presupuesto, de aquellos departamentos donde los gastos sean iguales al
-- presupuesto del que disponen.

select nombre,gastos,presupuesto from departamento where gastos=presupuesto;

-- 30. Lista todos los datos de los empleados cuyo segundo apellido sea NULL.

select * from empleado where apellido2 is null;

-- 31. Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.

select * from empleado where apellido2 is not null;

-- 32. Lista todos los datos de los empleados cuyo segundo apellido sea López.

select * from empleado where apellido2 ='López';

-- 33. Lista todos los datos de los empleados cuyo segundo apellido
-- sea Díaz o Moreno. Sin utilizar el operador IN.

select * from empleado where apellido2 ='Díaz' or apellido2 ='Moreno';

-- 34. Lista todos los datos de los empleados cuyo segundo apellido
-- sea Díaz o Moreno. Utilizando el operador IN.

select * from empleado where apellido2 in ('Díaz','Moreno');

-- 35. Lista los nombres, apellidos y nif de los empleados que trabajan en el
-- departamento 3.

select nombre,apellido1,apellido2 from empleado where id_departamento=3;

-- 36. Lista los nombres, apellidos y nif de los empleados que trabajan en los
-- departamentos 2, 4 o 5.

select nombre,apellido1,apellido2 from empleado where id_departamento in (2,4,5);


-- consultas multitabla usando la sintaxis SQL1 y SQL2 ----------------------------------------------------------------------------------------------


-- 1. Devuelve un listado con la información de los empleados y de los departamentos donde trabaja cada uno.

select * from empleado,departamento where empleado.id_departamento=departamento.id;

-- 2. Devuelve un listado con la información de empleados y departamentos ordenado primero por nombre del 
-- departamento y luego por apellidos y nombre de los empleados.

select * from empleado e,departamento d where e.id_departamento=d.id order by d.nombre,e.nombre,e.apellido1,e.apellido2 ;

-- 3. Devuelve un listado con el identificador y el nombre de los departamentos que tienen empleados asignados.

select distinct d.id,d.nombre from departamento d,empleado e where d.id=id_departamento;

-- 4. Devuelve un listado con el identificador, nombre y presupuesto actual de departamentos con empleados,
--  calculando el presupuesto actual como el presupuesto inicial menos los gastos.

select distinct d.id,d.nombre,Presupuesto_departamento(d.presupuesto,d.gastos) as 'Presupuesto del departamento' from departamento d, empleado e where d.id=e.id_departamento;

-- 5. Devuelve el nombre del departamento donde trabaja el empleado con el NIF especificado (38382980M).

select d.nombre from departamento d, empleado e where d.id=e.id_departamento and e.nif='38382980M';

-- 6. Devuelve el nombre del departamento donde trabaja el empleado llamado Pepe Ruiz Santana.

select d.nombre from departamento d, empleado e where d.id=e.id_departamento and concat(e.nombre,' ',e.apellido1,' ',e.apellido2)='Pepe Ruiz Santana';

-- 7. Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D, ordenado alfabéticamente.

select e.* from departamento d, empleado e where d.id=e.id_departamento and d.nombre= 'I+D' order by e.nombre;

-- 8. Devuelve un listado de empleados que trabajan en los departamentos de Sistemas, Contabilidad o I+D, ordenado alfabéticamente.

select e.* from departamento d, empleado e where d.id=e.id_departamento and d.nombre in ('Sistemas','Contabilidad','I+D') order by e.nombre;

-- 9. Devuelve una lista con el nombre de los empleados cuyos departamentos tienen un presupuesto fuera del rango de 100000 a 200000 euros.

select concat_ws('',e.nombre,' ',e.apellido1,' ',e.apellido2) as nombre_empleado 
from empleado e,departamento d 
where d.id=e.id_departamento 
and d.presupuesto not between 100000 and 200000;

-- 10. Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo 
-- apellido sea NULL. No debe mostrar nombres de departamentos repetidos.

select distinct d.nombre from departamento d, empleado e where d.id=e.id_departamento and e.apellido2 is null;


-- consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.


-- 1. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
-- Este listado también debe incluir los empleados que no tienen ningún departamento asociado.

select * from empleado e left join  departamento d on d.id=e.id_departamento;

-- 2. Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.

select * from empleado where id_departamento is null;

-- 3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.

select d.* from empleado e right join  departamento d on d.id=e.id_departamento where e.id is null;

-- 4. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
-- El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no 
-- tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

select * from departamento 
left join empleado on departamento.id = empleado.id_departamento 
union
select * from departamento 
right join empleado on departamento.id = empleado.id_departamento
order by 2; -- (sql no soporta full join directamente por tanto hay que hacer left y right join )

-- 5. Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no 
-- tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

select * from departamento 
left join empleado on departamento.id = empleado.id_departamento
where empleado.id_departamento is null
union
select * from departamento 
right join empleado on departamento.id = empleado.id_departamento
where empleado.id_departamento is null
order by 2;


-- consultas resumen 

-- 1. Calcula la suma del presupuesto de todos los departamentos.

select sum(presupuesto) as 'Presupuesto de los departamentos' from departamento;

-- 2. Calcula la media del presupuesto de todos los departamentos.

select round(avg(presupuesto),2) as 'Media del presupuesto de los departamentos' from departamento;

-- 3. Calcula el valor mínimo del presupuesto de todos los departamentos.

select min(presupuesto) as 'Presupuesto' from departamento;

-- 4. Calcula el nombre del departamento y el presupuesto asignado del departamento con el menor presupuesto.

select nombre, presupuesto from departamento order by presupuesto asc limit 1 ;

-- 5. Calcula el valor máximo del presupuesto de todos los departamentos.

select max(presupuesto) as 'Presupuesto' from departamento;

-- 6. Calcula el nombre del departamento y el presupuesto asignado del departamento con el mayor presupuesto.

select nombre, presupuesto from departamento order by presupuesto desc limit 1 ;

-- 7. Calcula el número total de empleados en la tabla empleado.
select count(*) as 'Numero de empleados' from empleado;

-- 8. Calcula el número de empleados que no tienen NULL en su segundo apellido.

select count(*) as 'Numero de empleados' from empleado where apellido2 is not null;

-- 9. Calcula el número de empleados en cada departamento. Devuelve dos columnas: una con el nombre del 
-- departamento y otra con el número de empleados asignados.

select d.nombre, count(e.id_departamento) as 'Numero de empleados' from departamento d inner join empleado e on d.id=e.id_departamento group by d.nombre;

-- 10. Calcula el nombre de los departamentos con más de 2 empleados. El resultado debe tener dos columnas:
-- el nombre del departamento y el número de empleados asignados.

select d.nombre, count(e.id_departamento) as 'Numero de empleados' from departamento d 
inner join empleado e on d.id=e.id_departamento 
group by d.nombre 
having count(e.id_departamento)>2 ;

-- 11. Calcula el número de empleados en cada departamento, incluyendo aquellos departamentos sin ningún empleado asignado.

select d.nombre, count(e.id_departamento) as 'Numero de empleados' from departamento d 
left join empleado e on d.id=e.id_departamento 
group by d.nombre ;

-- 12. Calcula el número de empleados en cada departamento que tiene un presupuesto mayor a 200000 euros.
select d.nombre, count(e.id_departamento) as 'Numero de empleados',presupuesto from departamento d 
inner join empleado e on d.id=e.id_departamento 
where d.presupuesto>200000
group by 1,3; 
