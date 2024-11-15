drop database if exists AutoRenta;

create database AutoRenta;

use AutoRenta;

create table cliente(
	id int primary key not null,
	celula int(15) not null,
	nombre1 varchar(50) not null,
	nombre2 varchar(50),
	apellido1 varchar(50) not null,
	apellido2 varchar(50),
	direccion varchar(150) not null,
	ciudad_residencia varchar(40) not null,
	telefono_celular bigint not null,
	correo_electronico varchar(80) not null
);
create table sucursal(
	id int primary key not null,
	direccion varchar(150) not null,
	ciudad varchar(40) not null,
	telefono_fijo bigint not null,
	telefono_celular bigint not null,
	correo_electronico varchar(80) not null
);

create table empleado(
	id int primary key not null,
	id_sucursal int not null,
	cedula int(15) not null,
	nombre1 varchar(50)not null,
	nombre2 varchar(50),
	apellido1 varchar(50) not null,
	apellido2 varchar(50),
	direccion varchar(150) not null,
	ciudad_residencia varchar(40) not null,
	telefono_celular bigint not null,
	correo_electronico varchar(80) not null,
	foreign key (id_sucursal) references sucursal(id)
);

create table descuento(
	id int primary key not null,
	fecha_inicio date not null,
	fecha_fin date not null,
	porcentaje int not null
);

create table tipo_vehiculo(
	id int primary key not null,
	nombre varchar(50) not null,
	id_descuento int not null,
	precio_semana decimal(10,2) not null,
	precio_dia decimal(10,2) not null,
    foreign key (id_descuento) references descuento(id)
);

create table vehiculo(
	id int primary key not null,
	id_tipo int not null,
	id_sucursal int,
	placa varchar(6) not null,
	referencia varchar(50) not null,
	modelo varchar(30) not null,
	puertas int not null,
	capacidad int not null,
	sunroof boolean not null,
	motor varchar(45) not null,
	color varchar(30) not null,
	foreign key (id_tipo) references tipo_vehiculo(id),
	foreign key (id_sucursal) references sucursal(id)
);

create table alquiler (
	id int primary key not null,
	id_vehiculo int not null,
	id_cliente int not null,
	id_empleado  int not null,
	id_sucursal_salida int not null,
	fecha_salida date not null,
	id_sucursal_llegada int ,
	fecha_llegada date,
	fecha_esperada date not null,
	valor_cotizado decimal(10,2),
	valor_pagado decimal(10,2),
    foreign key (id_vehiculo) references vehiculo(id),
    foreign key (id_cliente) references cliente(id),
    foreign key (id_empleado) references empleado(id),
    foreign key (id_sucursal_salida) references sucursal(id),
    foreign key (id_sucursal_llegada) references sucursal(id)
);

