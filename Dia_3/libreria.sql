CREATE DATABASE tienda_libros;

USE tienda_libros;

CREATE TABLE clientes(
	id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL,
    correo_electronico varchar(80) NOT NULL,
    telefono INT,
    direccion VARCHAR(40) NOT NULL
);

CREATE TABLE transacciones(
	id_transaccion INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fecha_pago DATE NOT NULL,
    monto_pago FLOAT NOT NULL,
    metodo_pago VARCHAR(20)
);

CREATE TABLE pedidos(
	id_pedido INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_compra DATE NOT NULL,
    estado VARCHAR(20),
    id_transaccion INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_transaccion) REFERENCES transacciones(id_transaccion)
);
INSERT INTO pedidos VALUES(1,2024-10-20,,'Completado',)

CREATE TABLE autores (
	id_autor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    nacionalidad VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

CREATE TABLE libros(
	ISBN INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(80) NOT NULL,
    precio INT NOT NULL,
    editorial VARCHAR(40) NOT NULL,
    categoria VARCHAR(15) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE autores_libro(
	id_autor INT NOT NULL,
    ISBN_libro 	INT NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (ISBN_libro) REFERENCES libros(ISBN)
);

CREATE TABLE libros_comprados(
	id_pedido INT NOT NULL,
    ISBN_libro INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (ISBN_libro) REFERENCES libros(ISBN)
);

