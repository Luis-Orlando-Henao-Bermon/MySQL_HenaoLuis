CREATE DATABASE DiagramaJardineria;

USE DiagramaJardineria;
CREATE TABLE gama_producto(
	gama VARCHAR(50) NOT NULL PRIMARY KEY ,
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256)
);
	
CREATE TABLE oficina(
	codigo_oficina VARCHAR(10) PRIMARY KEY NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    region VARCHAR(50),
    codigo_postal VARCHAR(10) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50)
);
    
CREATE TABLE pago(
	codigo_cliente
);