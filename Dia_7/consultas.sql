use autorenta;

-- FUNCIONES

-- lista los alquileres junto con el valor cotizado, para ello se debe calcular el tiempo de alquiler y separarlo en semanas y dias despues ver el coste semanal y diario del vehiculo y con eso calcular el valor cotizado

drop function if exists valor_cotizado ;
DELIMITER //
CREATE FUNCTION valor_cotizado (id_vehiculoF int, fecha_salida date, fecha_esperada date)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	DECLARE valor_cotizado DECIMAL(10,2); -- Crear una variable interna
    DECLARE valor_semanal DECIMAL(10,2);
    DECLARE valor_diario DECIMAL(10,2);
    DECLARE dias_alquiler INT;
    DECLARE dias int;
    declare semanas int;
    declare valor_dias decimal(10,2);
    declare valor_semanas decimal(10,2);
    
    SET valor_semanal=(SELECT distinct tv.precio_semana from alquiler inner join vehiculo on alquiler.id_vehiculo=vehiculo.id inner join tipo_vehiculo tv on vehiculo.id_tipo=tv.id where alquiler.id_vehiculo=id_vehiculoF);
    SET valor_diario=(SELECT distinct tv.precio_dia from alquiler inner join vehiculo on alquiler.id_vehiculo=vehiculo.id inner join tipo_vehiculo tv on vehiculo.id_tipo=tv.id where alquiler.id_vehiculo=id_vehiculoF);
    SET dias_alquiler= timestampdiff(day,fecha_salida,fecha_esperada);
    set dias=dias_alquiler % 7;
    set semanas= floor(dias_alquiler/7);
    set valor_dias= dias*valor_diario;
    set valor_semanas=semanas*valor_semanal;
    set valor_cotizado= valor_dias+valor_semanas;
    
    RETURN semanas;
END // 
DELIMITER ;

select id as id_alquiler, valor_cotizado(id_vehiculo,fecha_salida,fecha_esperada) as valor_cotizado from alquiler;

-- calcula el numero de dias que el cliente tuvo el vehiculo 

DELIMITER //
CREATE FUNCTION tiempo_alquiler (fecha_salida date, fecha_llegada date)
RETURNS varchar(200) DETERMINISTIC
BEGIN
	
    declare tiempo_alquiler varchar(200);
    declare dias_alquiler INT;
    declare dias int;
    declare semanas int;
    

    SET dias_alquiler= timestampdiff(day,fecha_salida,fecha_llegada);
    set dias=dias_alquiler % 7;
    set semanas= floor(dias_alquiler/7);
    set tiempo_alquiler= concat('dias: ',dias,' semanas: ',semanas);
    
    RETURN tiempo_alquiler;
END // 
DELIMITER ;

select id,tiempo_alquiler (fecha_salida, fecha_llegada) as tiempo_alquiler from alquiler;





-- CONSULTAS






-- 1. Obtener todos los vehículos que tienen sunroof.

select * from vehiculo where sunroof=1;

-- 2. Listar los empleados que trabajan la sucursal de Bogotá.

select e.* from empleado e inner join sucursal s on e.id_sucursal = s.id where s.ciudad='Bogotá';

-- 3. Consultar todos los vehículos disponibles la sucursal de Cali.

select v.* from vehiculo v inner join sucursal s on v.id_sucursal = s.id where s.ciudad='Cali';

-- 4. Contar la cantidad de vehículos que tiene cada tipo de vehiculo.

select tv.nombre, count(v.id_tipo) as cantidad_vehiculos from tipo_vehiculo tv inner join vehiculo v on tv.id = v.id_tipo group by 1;

-- 5. Obtener los nombre y correo de todos los clientes.

select nombre1,nombre2,correo_electronico from cliente;

-- 6. Consultar el total de ingresos generados por los alquileres.

select sum(valor_pagado) from alquiler;

-- 7. Listar las sucursales que no tienen empleados asignados.

select s.* from sucursal s where s.id not in (select id_sucursal from empleado);

-- 8.  Consultar el valor total pagado en alquileres por cliente .

select c.nombre1,c.nombre2,sum(a.valor_pagado) as Total_pagos from cliente c inner join alquiler a on c.id = a.id_cliente group by 1,2;

-- 9. Listar todos los vehículos que superan la capacidad de 4 pasajeros.

select * from vehiculo where capacidad>4;

-- 10. Listar la sucursal con el mayor número de vehículos registrados.

select s.*,count(v.id_sucursal) as cantidad_vehiculos from sucursal s inner join vehiculo v on s.id=v.id_sucursal group by 1 order by 2 desc limit 1;

-- 11. Mostrar los empleados asignados a una sucursal específica.



-- 12. Consultar el promedio de valor cotizado en los alquileres.



-- 13. Listar todos los clientes que han alquilado un vehículo en una sucursal específica.



-- 14. Obtener los datos de los vehículos alquilados en un periodo de tiempo específico.



-- 15. Contar cuántos vehículos hay de cada color en el sistema.



-- 16. Consultar el historial de alquileres de un cliente específico.



-- 17. Obtener los nombres y correos electrónicos de empleados con teléfono fijo.



-- 18. Listar todos los tipos de vehículos y sus precios por día y por semana.



-- 19. Mostrar el porcentaje de descuento activo para una fecha específica.



-- 20. Listar los empleados que comparten la misma ciudad de residencia.



-- 21. Consultar las fechas de salida y llegada de alquileres realizados por un cliente específico.



-- 22. Verificar qué vehículos fueron alquilados en más de una ocasión.



-- 23. .



-- 24. .



-- 25. Lista los nombres de los clientes junto con cuantos alquileres ha realizado
select count(a.id_cliente) as cantidad_alquileres,c.nombre1,c.nombre2 from cliente c inner join alquiler a on c.id=a.id_cliente group by 2,3;
