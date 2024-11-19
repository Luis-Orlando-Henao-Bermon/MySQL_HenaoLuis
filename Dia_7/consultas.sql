use autorenta;

-- FUNCIONES

-- calcula el valor cotizado para ello debes saber cuantas semans y dias se alquilar el vehiculo y con eso
-- revisar el precio semanal y diario de ese vehiculo en el tipo de vehiculo

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
    
    RETURN valor_cotizado;
END // 
DELIMITER ;

select id as id_alquiler, valor_cotizado(id_vehiculo,fecha_salida,fecha_esperada) as valor_cotizado from alquiler;



-- calcula el numero de dias y semanas que el cliente tuvo el vehiculo 

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



-- calcular el valor final de pago añadiendo descuentos y cobros extra por retraso

DELIMITER //
CREATE FUNCTION valor_final (id_vehiculoF int, fecha_salida date, fecha_esperada date,fecha_llegada date)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	declare valor_cotizado decimal(10,2); -- Crear una variable interna
    declare valor_diario decimal(10,2);
    declare valor_diario_retraso decimal(10,2);
    declare dias_retraso int;
    declare valor_dias_retraso int;
    declare fecha_inicio_descuento date;
    declare fecha_fin_descuento date;
    declare descuento int;
    declare valor_final decimal(10,2);

	set valor_cotizado=valor_cotizado(id_vehiculoF,fecha_salida,fecha_esperada);
    
    set valor_diario=(SELECT distinct tv.precio_dia from alquiler 
    inner join vehiculo on alquiler.id_vehiculo=vehiculo.id 
    inner join tipo_vehiculo tv on vehiculo.id_tipo=tv.id where alquiler.id_vehiculo=id_vehiculoF);
    
    set valor_diario_retraso=valor_diario +(valor_diario*0.08);
    
    set dias_retraso=timestampdiff(day,fecha_esperada,fecha_llegada);
    
    
    if dias_retraso>=1 then 
		set valor_dias_retraso=dias_retraso*valor_diario_retraso;
    else
		set valor_dias_retraso=0;
	end if;
    
    set fecha_inicio_descuento=(select distinct d.fecha_inicio from descuento d 
    inner join tipo_vehiculo tv on d.id=tv.id_descuento inner join vehiculo v on tv.id=v.id_tipo where v.id=id_vehiculoF);
    
    set fecha_fin_descuento=(select distinct d.fecha_fin from descuento d 
    inner join tipo_vehiculo tv on d.id=tv.id_descuento inner join vehiculo v on tv.id=v.id_tipo where v.id=id_vehiculoF);
    
    set descuento=(select distinct d.porcentaje from descuento d 
    inner join tipo_vehiculo tv on d.id=tv.id_descuento inner join vehiculo v on tv.id=v.id_tipo where v.id=id_vehiculoF);
    
    if fecha_llegada>=fecha_inicio_descuento and fecha_llegada<=fecha_fin_descuento then
		set valor_cotizado = valor_cotizado - (valor_cotizado*descuento/100);
	else
		set valor_cotizado = valor_cotizado;
    end if;
    
    set valor_final= valor_cotizado + valor_dias_retraso;
    
    RETURN valor_final;
END // 
DELIMITER ;

select id as id_alquiler, valor_final(id_vehiculo,fecha_salida,fecha_esperada,fecha_llegada) as valor_a_pagar from alquiler;



--  funcion para concatenar el nombre completo en una sola columna 

DELIMITER //
CREATE FUNCTION nombre_completo (nombre1 varchar(50),nombre2 varchar(50),apellido1 varchar(50),apellido2 varchar(50))
RETURNS varchar(200) DETERMINISTIC
BEGIN
	
    declare nombre_completo varchar(200);

    set nombre_completo= concat_ws('',nombre1,' ',nombre2,' ',apellido1,' ',apellido2);
    
    RETURN nombre_completo;
END // 
DELIMITER ;

select id,nombre_completo(nombre1,nombre2,apellido1,apellido2) as nombre_completo from cliente;



-- funcion para saber si un vehiculo tiene descuento

DELIMITER //
CREATE FUNCTION saber_descuento (id_vehiculoF int, fecha_actual date)
RETURNS varchar(200) DETERMINISTIC
BEGIN
	
    declare fecha_inicio_descuento date;
    declare fecha_fin_descuento date;
    declare descuento int;
    declare info_descuento varchar(200);
    
    set fecha_inicio_descuento=(select distinct d.fecha_inicio from descuento d 
    inner join tipo_vehiculo tv on d.id=tv.id_descuento inner join vehiculo v on tv.id=v.id_tipo where v.id=id_vehiculoF);
    
    set fecha_fin_descuento=(select distinct d.fecha_fin from descuento d 
    inner join tipo_vehiculo tv on d.id=tv.id_descuento inner join vehiculo v on tv.id=v.id_tipo where v.id=id_vehiculoF);
    
    set descuento=(select distinct d.porcentaje from descuento d 
    inner join tipo_vehiculo tv on d.id=tv.id_descuento inner join vehiculo v on tv.id=v.id_tipo where v.id=id_vehiculoF);
    
    if fecha_actual>=fecha_inicio_descuento and fecha_actual<=fecha_fin_descuento then
		set info_descuento = concat('El vehiculo tiene ',descuento,'% de descuento');
	else
		set info_descuento = 'El vehiculo no tiene descuento actualmente';
    end if;
    
    RETURN info_descuento;
END // 
DELIMITER ;

select saber_descuento(7,'2024-11-15') as Descuento;




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

-- 11. Verificar qué vehículos fueron alquilados en más de una ocasión.

select v.referencia, count(a.id_vehiculo) as 'cantidad_alquilado' from vehiculo v inner join alquiler a on v.id=a.id_vehiculo group by 1 having cantidad_alquilado>1;

-- 12. Consultar el promedio de valor cotizado en los alquileres.

select round(avg(valor_cotizado)) as promedio_valor_cotizado from alquiler;

-- 13. Listar todos los clientes que han alquilado un vehículo en la sucursal con id 5.

select distinct c.* from cliente c inner join alquiler a on c.id=a.id_cliente where a.id_sucursal_salida=5;

-- 14. Obtener los datos de los vehículos alquilados en el mes de julio.

select  v.*,a.id as id_alquiler,a.fecha_salida from vehiculo v inner join alquiler a on v.id=a.id_vehiculo where month(a.fecha_salida)=7;

-- 15. Contar cuántos vehículos hay de cada color en el sistema.

select color,count(color) as cantidad_vehiculos from vehiculo group by 1 ;

-- 16. Consultar el historial de alquileres del cliente con el numero de cedula 1087654328.

select c.id,c.cedula,c.nombre1,c.apellido1,a.* from cliente c inner join alquiler a on c.id=a.id_cliente where c.cedula=1087654328; 

-- 17. Obtener los nombres y correos electrónicos de empleados con teléfono celular.

select nombre1,nombre2,correo_electronico,telefono_celular from empleado;

-- 18. Listar todos los tipos de vehículos y sus precios por día y por semana.

select nombre,precio_dia,precio_semana from tipo_vehiculo;

-- 19. Mostrar el porcentaje de descuento activo y tipo de vehiculo para el mes de diciembre.

select d.porcentaje,tv.nombre from descuento d inner join tipo_vehiculo tv on d.id = tv.id_descuento where month(d.fecha_inicio)=12;

-- 20. Listar los empleados que comparten la misma ciudad de residencia.

select ciudad_residencia,id,nombre1,apellido1 from empleado order by 1;

-- 21. Consultar las fechas de salida y llegada de alquileres realizados por el cliente de id 10.

select c.id,c.nombre1,c.apellido1,a.fecha_salida,a.fecha_llegada from cliente c inner join alquiler a on c.id= a.id_cliente where c.id=10;

-- 22. Lista los nombres de los clientes junto con el id y la ciudad de las sucursales en las cuales a alquilado vehiculos.

select distinct c.nombre1,c.nombre2,s.id,s.ciudad from cliente c inner join alquiler a on c.id=a.id_cliente inner join sucursal s on a.id_sucursal_salida=s.id order by 1;

-- 23. Lista los nombres de los empleados junto con los nombres del cliente al que le a realizado alquileres.

select distinct concat(e.nombre1,' ',e.apellido1) as nombres_empleado,concat(c.nombre1,' ',c.apellido1) as nombres_cliente 
from empleado e inner join alquiler a on e.id=a.id_empleado 
inner join cliente c on a.id_cliente=c.id;

-- 24. Lista el top 3 de empleados con mayor cantidad de alquileres realizados.

select e.*,count(a.id_empleado) as Cantidad_alquileres from empleado e inner join alquiler a on e.id=a.id_empleado group by 1 order by 12 desc limit 3;

-- 25. Lista los nombres de los clientes junto con cuantos alquileres ha realizado
select count(a.id_cliente) as cantidad_alquileres,c.nombre1,c.nombre2 from cliente c inner join alquiler a on c.id=a.id_cliente group by 2,3;


-- PROCEDIMIENTOS---------------------------------------------------------------------

-- asignar valor_cotizado a un alquiler 
delimiter // 
create procedure asignar_valor_cotizado(in id_alquiler int,in valor_cotizadoP decimal(10,2))
begin
   
	update alquiler	set valor_cotizado=valor_cotizadoP where id=id_alquiler;
end
// delimiter ;

call asignar_valor_cotizado(2,(select valor_cotizado(id_vehiculo,fecha_salida,fecha_esperada) from alquiler where id=2)) ;


-- corregir todos los valores cotizados de la tabla alquiler

delimiter // 
create procedure asignar_todos_valores_cotizados()
begin
	declare contador int default 1;

	while contador<(select count(*) from alquiler)+1 do

	   call asignar_valor_cotizado(contador,(select valor_cotizado(id_vehiculo,fecha_salida,fecha_esperada) from alquiler where id=contador));
	   set contador=contador+1;

	end while;
end
// delimiter ;

call asignar_todos_valores_cotizados();


-- asignar valor_pagado a un alquiler

delimiter //
create procedure asiganar_valor_pagado(in id_alquiler int,in valor_pagadoP decimal(10,2))
begin
	update alquiler	set valor_pagado=valor_pagadoP where id=id_alquiler;
end // delimiter ;

call asiganar_valor_pagado(1,(select valor_final(id_vehiculo,fecha_salida,fecha_esperada,fecha_llegada) from alquiler where id=1));


-- corregir todos los valores pagados de la tabla alquiler

delimiter // 
create procedure asignar_todos_valores_pagados()
begin
	declare contador int default 1;

	while contador<(select count(*) from alquiler)+1 do

	   call asiganar_valor_pagado(contador,(select valor_final(id_vehiculo,fecha_salida,fecha_esperada,fecha_llegada) from alquiler where id=contador));
	   set contador=contador+1;

	end while;
end
// delimiter ;

call asignar_todos_valores_pagados();

select * from alquiler;


-- registrar cliente 

delimiter //
create procedure registrar_cliente(
	in p_cedula int(15),
    in p_nombre1 varchar(50),
    in p_nombre2 varchar(50),
    in p_apellido1 varchar(50),
    in p_apellido2 varchar(50),
    in p_direccion varchar(150),
    in p_ciudad_residencia varchar(40),
    in p_telefono_celular bigint,
    in p_correo_electronico varchar(80),
    in p_user_cliente varchar(30),
    in p_password_cliente varchar(40))
begin 
	insert into cliente(cedula, nombre1, nombre2, apellido1, apellido2, direccion,ciudad_residencia, telefono_celular, correo_electronico,user_cliente, password_cliente) 
	values (p_cedula, p_nombre1, p_nombre2, p_apellido1, p_apellido2, p_direccion,p_ciudad_residencia, p_telefono_celular, p_correo_electronico,p_user_cliente, p_password_cliente);
end
// delimiter ;

call registrar_cliente(1093904929,'Luis','Orlando','Henao','Bermon','CR 3e #1-24','Tibú',3003426875,'luis_or2454@gmail.com','Lucho03','Luchin123');


-- registrar empleado
delimiter //
create procedure registrar_empleado(
	in p_id_sucursal int,
    in p_cedula int(15),
    in p_nombre1 varchar(50),
    in p_nombre2 varchar(50),
    in p_apellido1 varchar(50),
    in p_apellido2 varchar(50),
    in p_direccion varchar(150),
    in p_ciudad_residencia varchar(40),
    in p_telefono_celular bigint,
    in p_correo_electronico varchar(80),
    in p_user_empleado varchar(30),
    in p_password_empleado varchar(40))
begin 
	insert into empleado(id_sucursal,cedula,nombre1,nombre2,apellido1,apellido2,direccion,ciudad_residencia,telefono_celular,correo_electronico,user_empleado,password_empleado)
    values (p_id_sucursal,p_cedula,p_nombre1,p_nombre2,p_apellido1,p_apellido2,p_direccion,p_ciudad_residencia,p_telefono_celular,p_correo_electronico,p_user_empleado,p_password_empleado);
end // delimiter ;

call registrar_empleado(4,1093909,'Luis','Migel','Caicedo','Bermon','CR 3e #1-24','Tibú',30554861,'luis_m2454@gmail.com','Lucho03','Luchin456');


-- ingresar un nuevo alquiler 

delimiter // 
create procedure ingresar_alquiler(
	in r_id_vehiculo int,
    in r_id_cliente int,
    in r_id_empleado int,
    in r_id_sucursal_salida int,
    in r_fecha_salida date,
    in r_id_sucursal_llegada int,
    in r_fecha_llegada date,
    in r_fecha_esperada date,
    in r_valor_cotizado decimal(10,2),
    in r_valor_pagado decimal(10,2)
    )
begin

	insert into alquiler(id_vehiculo,id_cliente,id_empleado,id_sucursal_salida,fecha_salida,id_sucursal_llegada,fecha_llegada,fecha_esperada,valor_cotizado,valor_pagado)
    values (r_id_vehiculo,r_id_cliente,r_id_empleado,r_id_sucursal_salida,r_fecha_salida,r_id_sucursal_llegada,r_fecha_llegada,r_fecha_esperada,r_valor_cotizado,r_valor_pagado);
end
 // delimiter ;
 
call ingresar_alquiler(12,41,11,1,current_date(),3,null,current_date()+9,valor_cotizado(12,current_date(),current_date()+9),null);