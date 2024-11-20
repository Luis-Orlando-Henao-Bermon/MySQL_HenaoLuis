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


-- obtener el cliente con mayor total de pedidos

delimiter //
create function cliente_mayor_total()
returns int deterministic
begin 
		
	declare cliente_mayor int;
    
    set cliente_mayor =(select sum(total),id from pedido order by id limit 1);
        
	return cliente_mayor;
end // delimiter ;

select cliente_mayor_total();