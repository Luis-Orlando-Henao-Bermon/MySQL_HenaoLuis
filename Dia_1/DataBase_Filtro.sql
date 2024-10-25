CREATE DATABASE migrupoT2; -- crear base de datos

USE migrupoT2; -- Utilizar mi base de datos

Drop table Clientes;

CREATE TABLE Clientes(ID_cliente int PRIMARY KEY NOT NULL AUTO_INCREMENT,Correo_Electronico varchar(100) NOT NULL,Telefono int NOT NULL,Direccion varchar(50) not null ,Nombre varchar(45) not null);
describe Clientes;