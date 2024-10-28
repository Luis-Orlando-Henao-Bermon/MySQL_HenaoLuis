CREATE DATABASE migrupoT2; -- crear base de datos

USE migrupoT2; -- Utilizar mi base de datos

CREATE TABLE Clientes(
	ID_cliente int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	Correo_Electronico varchar(100) NOT NULL,Telefono int NOT NULL,
	Direccion varchar(50) not null ,
	Nombre varchar(45) not null);

CREATE TABLE Transacciones(
	ID_Transacciones INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    Fecha_Pago DATE NOT NULL, Monto_Total FLOAT NOT NULL, 
    Metodo_Pago VARCHAR(20));

CREATE TABLE Autores(
	ID_Autor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30) NOT NULL,
    Nacionalidad VARCHAR(20)NOT NULL, 
    Fecha_Nacimiento DATE NOT NULL);

CREATE TABLE Libro(
	ISBN INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
	Titulo VARCHAR(80) NOT NULL, 
	Precio FLOAT NOT NULL, 
	Editorial VARCHAR(20) NOT NULL, 
    Categoria VARCHAR(15) NOT NULL, 
    Fecha_Publicacion DATE NOT NULL, 
    Stock INT NOT NULL );

CREATE TABLE Libros_Comprados(
	ID_Pedido INT NOT NULL, 
    ISBN_Libro INT NOT NULL, 
    Cantidad INT NOT NULL, 
    FOREIGN KEY(ID_Pedido) REFERENCES Pedidos(ID_Pedido), 
    FOREIGN KEY (ISBN_Libro) REFERENCES Libro(ISBN));

CREATE TABLE Pedidos(
	ID_Pedido INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ID_Cliente INT NOT NULL, 
    ID_Transaccion INT NOT NULL, 
    Fecha_Compra DATE NOT NULL, 
    Estado VARCHAR(20) NOT NULL, 
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_cliente), 
    FOREIGN KEY (ID_Transaccion) REFERENCES Transacciones(ID_Transacciones));

CREATE TABLE Autores_Libros(
	ID_Autor INT NOT NULL, 
	ISBN_Libro INT NOT NULL, 
	FOREIGN KEY (ID_Autor) REFERENCES Autores(ID_Autor), 
	FOREIGN KEY (ISBN_Libro) REFERENCES Libro(ISBN));



