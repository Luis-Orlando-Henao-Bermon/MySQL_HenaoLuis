create database funciones_t2;
use funciones_t2;

-- ¿Qué es una funcion deterministica y una funcion no deterministica?

-- Funcion Deterministica: Siempre devuelven el mismo resultado para un conjunto dado de parámetros de entrada.
-- Crear una funcion para calcular el area de un circulo 
DELIMITER //
CREATE FUNCTION areaCirculo (radio DOUBLE)
RETURNS DOUBLE DETERMINISTIC
BEGIN
	DECLARE area DOUBLE; -- Crear una variable interna
    SET area = 3.14 * radio*radio;
    RETURN area;
END // 
DELIMITER ;

-- Utilizar una funcion 
select areaCirculo(3);


-- TABLA E INSERCIONES DE EXPERIMENTOS
CREATE TABLE productos (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    PRIMARY KEY (id)
);

INSERT INTO productos (nombre, precio) VALUES
('Laptop', 899.99),
('Smartphone', 499.99),
('Tablet', 299.99),
('Smartwatch', 199.99),
('Auriculares', 59.99),
('Cámara digital', 349.99),
('Televisor', 749.99),
('Refrigerador', 599.99),
('Microondas', 99.99),
('Lavadora', 499.99),
('Secadora', 450.00),
('Cafetera', 69.99),
('Licuadora', 45.99),
('Batidora', 35.99),
('Estufa', 249.99),
('Plancha', 29.99),
('Ventilador', 39.99),
('Aspiradora', 120.00),
('Bicicleta', 220.00),
('Coche eléctrico', 15000.00),
('Mochila', 40.00),
('Maletín de viaje', 89.99),
('Reloj de pulsera', 120.00),
('Zapatos deportivos', 70.00),
('Camiseta', 19.99),
('Pantalón de mezclilla', 39.99),
('Chaqueta', 59.99),
('Gorra', 14.99),
('Bufanda', 18.99),
('Guantes', 12.99),
('Pantalones cortos', 24.99),
('Sombrero', 22.00),
('Botas', 80.00),
('Silla ergonómica', 150.00),
('Escritorio', 199.99),
('Estante para libros', 30.00),
('Lámpara de escritorio', 25.99),
('Espejo', 45.00),
('Cama', 350.00),
('Colchón', 250.00),
('Almohada', 19.99),
('Edredón', 60.00),
('Ropa de cama', 39.99),
('Toalla', 9.99),
('Jabón', 2.99),
('Champú', 4.99),
('Pasta de dientes', 1.99),
('Cepillo de dientes', 3.99),
('Desodorante', 3.49),
('Crema corporal', 6.99),
('Reloj despertador', 25.00),
('Termo', 14.99),
('Manta', 40.00),
('Cortinas', 29.99),
('Alfombra', 79.99),
('Papel higiénico', 1.99),
('Tetera', 29.00),
('Horno eléctrico', 99.99),
('Cuchillos de cocina', 39.99),
('Tenedor', 3.99),
('Cucharas', 2.99),
('Plato', 4.50),
('Vaso', 1.99),
('Copa de vino', 5.00),
('Set de té', 18.99),
('Reloj de pared', 45.00),
('Foto enmarcada', 19.99),
('Adorno de mesa', 15.00),
('Cuadro decorativo', 39.99),
('Planta artificial', 12.00),
('Vaso decorativo', 8.50),
('Cojín', 15.99),
('Lámpara de pie', 80.00),
('Sofá', 500.00),
('Mesa de comedor', 250.00),
('Sillas de comedor', 100.00),
('Cafetera espresso', 159.99),
('Freidora de aire', 99.99),
('Cocina de inducción', 129.00),
('Set de cuchillos', 75.00),
('Termómetro digital', 12.00),
('Báscula', 30.00),
('Secador de cabello', 24.99),
('Plancha de pelo', 19.99),
('Pañuelo', 6.99),
('Cinta métrica', 3.00),
('Destornillador', 5.00),
('Martillo', 10.00),
('Llave inglesa', 7.99),
('Alicate', 6.00),
('Caja de herramientas', 50.00),
('Pistola de silicona', 8.00),
('Pegamento', 1.50),
('Cinta adhesiva', 2.00),
('Gafas de sol', 15.00),
('Lentes de sol', 12.00),
('Mochila escolar', 30.00),
('Carpeta', 3.50),
('Lápiz', 1.00),
('Bolígrafo', 2.00),
('Marcador', 1.99),
('Resaltadores', 4.00),
('Agenda', 9.99),
('Cuaderno', 2.50),
('Papel para impresora', 3.99),
('Cartuchos de tinta', 20.00),
('Calculadora', 12.00),
('Impresora', 89.99),
('Escáner', 70.00),
('Webcam', 35.00),
('Microfono', 40.00),
('Parlantes', 50.00),
('Teclado inalámbrico', 25.00),
('Ratón inalámbrico', 18.00),
('Mochila para laptop', 40.00),
('Cargador portátil', 15.00),
('Cable USB', 3.00),
('Adaptador HDMI', 10.00),
('Alimentador para laptop', 25.00),
('Batería externa', 20.00),
('Funda para celular', 9.99),
('Pantalla táctil', 99.99),
('Soporte para celular', 7.99),
('Peluche', 15.00),
('Juguete para niños', 10.00),
('Puzzles', 8.00),
('Muñeca', 18.99),
('Triciclo', 40.00),
('Patinete', 60.00),
('Bicicross', 150.00),
('Pelota', 9.99),
('Raqueta de tenis', 29.99),
('Bola de fútbol', 19.99),
('Balón de baloncesto', 22.00),
('Equipo de golf', 99.00),
('Bate de béisbol', 19.99),
('Guantes de béisbol', 18.00),
('Pelota de béisbol', 5.00),
('Casco de ciclismo', 29.99),
('Guantes de ciclismo', 14.99),
('Chaleco reflectante', 19.00),
('Gafas de ciclismo', 9.99),
('Camiseta de ciclismo', 25.00),
('Pantalones de ciclismo', 30.00),
('Sillín de bicicleta', 45.00);


-- Función que calcule el IVA de los productos
DELIMITER //
CREATE FUNCTION totalIVA(precio DECIMAL(10,2),tasaIVA DECIMAL (5,2))
RETURNS DECIMAL (10,2) DETERMINISTIC
BEGIN
	RETURN precio+ (precio*tasaIVA);
END //
DELIMITER ;

-- Uso de función creada
Select nombre , totalIVA(precio,0.19) as precioConIVA from productos;

-- Eliminar una función existente 
Drop function if exists totalIVA;
-- Drop function if exists totalIVARand;
-- Función que calcule el IVA de los productos (No deterministico)
DELIMITER //
CREATE FUNCTION totalIVARand(precio DECIMAL(10,2))
RETURNS DECIMAL (10,2) DETERMINISTIC
BEGIN
	RETURN precio+ (precio* RAND());
END //
DELIMITER ;

select totalIVARand(12);

drop table ordenes;
CREATE TABLE ordenes (
    id INT auto_increment,
    cliente_id INT,
    precio DECIMAL(10,2),
    categoria_cliente VARCHAR(10),
    PRIMARY KEY (id)
);


INSERT INTO ordenes (cliente_id, precio, categoria_cliente) VALUES
(1, 120.99, 'Normal'),
(2, 540.50, 'Premium'),
(3, 320.75, 'Normal'),
(4, 15.99, 'Normal'),
(10, 799.90, 'Premium'),
(6, 29.99, 'Normal'),
(7, 45.50, 'Normal'),
(8, 1025.00, 'VIP'),
(9, 220.00, 'Normal'),
(10, 145.50, 'Premium'),
(11, 690.00, 'VIP'),
(10, 420.75, 'Premium'),
(13, 15.50, 'Normal'),
(14, 100.00, 'Normal'),
(15, 567.80, 'VIP'),
(16, 99.99, 'Normal'),
(17, 399.99, 'Premium'),
(18, 30.00, 'Normal'),
(19, 890.00, 'VIP'),
(20, 135.40, 'Premium'),
(21, 250.00, 'Normal'),
(22, 50.25, 'Normal'),
(23, 980.50, 'VIP'),
(24, 765.90, 'Premium'),
(25, 205.60, 'Normal'),
(26, 610.10, 'VIP'),
(27, 145.25, 'Normal'),
(28, 33.10, 'Normal'),
(29, 499.99, 'Premium'),
(30, 789.99, 'VIP'),
(31, 105.75, 'Normal'),
(32, 450.00, 'Premium'),
(33, 15.00, 'Normal'),
(34, 879.99, 'VIP'),
(35, 155.20, 'Normal'),
(36, 369.00, 'Premium'),
(37, 240.40, 'Normal'),
(38, 1325.50, 'VIP'),
(39, 67.89, 'Normal'),
(40, 799.95, 'Premium'),
(41, 215.75, 'Normal'),
(42, 940.80, 'VIP'),
(43, 55.00, 'Normal'),
(44, 520.00, 'Premium'),
(45, 820.60, 'VIP'),
(46, 80.99, 'Normal'),
(47, 275.45, 'Premium'),
(48, 1320.00, 'VIP'),
(49, 99.95, 'Normal'),
(50, 629.90, 'Premium'),
(51, 555.00, 'VIP'),
(52, 399.00, 'Normal'),
(53, 123.45, 'Premium'),
(54, 215.00, 'Normal'),
(55, 870.25, 'VIP'),
(56, 249.99, 'Normal'),
(57, 339.60, 'Premium'),
(58, 125.20, 'Normal'),
(59, 725.30, 'VIP'),
(60, 899.00, 'Premium'),
(61, 25.50, 'Normal'),
(62, 540.70, 'Premium'),
(63, 156.50, 'Normal'),
(64, 950.00, 'VIP'),
(65, 640.40, 'Premium'),
(66, 185.70, 'Normal'),
(67, 550.99, 'Premium'),
(68, 720.00, 'VIP'),
(69, 1000.00, 'Premium'),
(70, 400.00, 'Normal'),
(71, 705.10, 'VIP'),
(72, 110.50, 'Normal'),
(73, 890.25, 'Premium'),
(74, 167.99, 'Normal'),
(75, 315.80, 'Premium'),
(76, 120.00, 'VIP'),
(77, 630.50, 'Premium'),
(78, 50.00, 'Normal'),
(79, 300.00, 'Premium'),
(80, 755.00, 'VIP'),
(81, 130.20, 'Normal'),
(82, 430.00, 'Premium'),
(83, 175.60, 'Normal'),
(84, 325.90, 'Premium'),
(85, 950.50, 'VIP'),
(86, 255.75, 'Normal'),
(87, 550.20, 'Premium'),
(88, 770.00, 'VIP'),
(89, 300.00, 'Normal'),
(90, 400.00, 'Premium'),
(91, 580.00, 'VIP'),
(92, 670.00, 'Normal'),
(93, 745.00, 'Premium'),
(94, 890.90, 'VIP'),
(95, 270.50, 'Normal'),
(96, 369.80, 'Premium'),
(97, 455.60, 'Normal'),
(98, 510.00, 'VIP'),
(99, 165.00, 'Normal'),
(100, 720.00, 'Premium');


DELIMITER //
Create function ingreso_promedio_cliente (cliente_id_interno INT)
returns decimal(10,2)
deterministic
begin
	declare ingreso decimal (10,2);
    select avg(precio) into ingreso from ordenes where cliente_id_interno = cliente_id; -- AVERAGE
    return ingreso;
end //
DELIMITER ;

drop function ingreso_promedio_cliente;

select ingreso_promedio_cliente (10);

