use reto_dia_9;

-- 1. obtener el total de pedidos hechos por un cliente 
drop function if exists pedidos_cliente;
delimiter //
create function pedidos_cliente(id_clienteF int)
returns int deterministic
begin 
		
	declare cantidad int;
    
    set cantidad= (select count(*) from pedido where id_cliente=id_clienteF);
    
    return cantidad;
    
end // delimiter ;

select pedidos_cliente(1) ;

-- 2. calcular la comision total ganada por un comercial

drop function if exists comision_total;


delimiter //
create function comision_total(id_comercialF int)
returns float deterministic
begin 
		
	declare comision_total_comercial float;
	declare comicion_comercial float;
	declare suma_pedidos double;
	
	set suma_pedidos =(select sum(total) from pedido where id_comercial=id_comercialF);
	
	set comicion_comercial =(select comision from comercial where id=id_comercialF);
	
	set comision_total_comercial =comicion_comercial*suma_pedidos;
	
	return comision_total_comercial;
	
end // delimiter ;

select comision_total(1);


-- 3. obtener el cliente con mayor total de pedidos
drop function if exists cliente_mayor_total;
delimiter //
create function cliente_mayor_total()
returns int deterministic
begin 
		
	declare cliente_mayor int;
    
    set cliente_mayor =(select id from (select sum(total),id from pedido group by 2 order by 1 desc limit 1)as cliente_mayor_total);
        
	return cliente_mayor;
end // delimiter ;

select cliente_mayor_total();


-- 4. contar la cantidad de pedidos realizado en un año en especifico

drop function if exists pedidos_año;
delimiter //
create function pedidos_año(año int)
returns int deterministic
begin 
		
	declare cant_año int;
    
    set cant_año=(select count(*) from pedido where year(fecha)=año);
        
	return cant_año;
end // delimiter ;

select pedidos_año(2023) as cantida_pedidos;

-- 5. obtener el promedio de total de pedidos por cliente

drop function if exists promedio_cliente;
delimiter //
create function promedio_cliente(id_clienteF int)
returns decimal(10,2) deterministic
begin 
		
        
	return (select avg(total) from pedido where id_cliente=id_clienteF);
end // delimiter ;

select promedio_cliente(4) as promedio_cliente;
