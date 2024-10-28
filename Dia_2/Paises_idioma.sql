CREATE DATABASE Luis_Henao_Pais;
USE Luis_Henao_Pais;
-- crea tabla de pais
CREATE TABLE pais (
  id INT PRIMARY KEY NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  continente VARCHAR(50) NOT NULL,
  poblacion INT NOT NULL
);

-- crea tabla de ciudad
  CREATE TABLE ciudad (
  id INT PRIMARY KEY NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  id_pais INT NOT NULL,
  FOREIGN KEY (id_pais) REFERENCES pais(id)
);

-- crea tabla de idioma
CREATE TABLE Idioma (
  id INT PRIMARY KEY NOT NULL,
  Idioma VARCHAR(45) NOT NULL
  );

-- crea tabla de idioma pais
CREATE TABLE Idioma_Pais (
  id_idioma INT NOT NULL,
  id_pais INT NOT NULL,
  es_oficial TINYINT NULL,
  FOREIGN KEY (id_idioma) REFERENCES Idioma(id),
  FOREIGN KEY (id_pais) REFERENCES Pais (id)
  );

-- insertar datos en tabla idioma
INSERT INTO Idioma (id,Idioma) VALUES (1,'Español');

INSERT INTO Idioma (id,Idioma) VALUES (2,'Ingles'),(3,'Francés');

-- insertar datos en tabla pais
INSERT INTO Pais (id,nombre,continente,poblacion) VALUES 
	(1,'colombia','América',52216000),
	(2,'Estados Unidos','América',334914895),
	(3,'Francia','Europa',68035000);
    
INSERT INTO Pais (id,nombre,continente,poblacion) VALUES 
	(4,'Mexico','América',126000000),
	(5,'Canada','América',38000000);

-- insertar datos en tabla ciudad
INSERT INTO Ciudad (id,nombre,id_pais) VALUES 
	(1,'Bogotá','1'),
	(2,'Tibú','1');

INSERT INTO Ciudad (id,nombre,id_pais) VALUES 
	(3,'París','3'),
	(4,'Marsella','3'),
    (5,'Monterrey','4'),
	(6,'Cancún','4'),
    (7,'Nueva York','2'),
	(8,'MArsella','2'),
    (9,'Toronto','5'),
	(10,'Ontario','5');
    
-- insertar datos en tabla idioma_pais

INSERT INTO Idioma_Pais (id_idioma,id_pais,es_oficial) VALUES 
	-- español es oficial en colombia
	(1,1,1),
    -- ingles no es oficial en colombia
	(2,1,0),
    -- ingles es oficial en estados unidos
    (2,2,1),
    -- ingles es oficial en canada
	(2,5,1),
    -- frances es oficial en francia
    (3,3,1),
    -- frances no es oficial en canada
    (3,5,0),
    
    (2,2,0);
    
-- Consultas
-- Listar todos los idiomas

select idioma from Idioma;

-- listar todos los idiomas con id 1
select * from idioma where id=1;
select idioma from idioma where id=1;

-- consultar paises que esten en america
select nombre from pais where continente='América';
select * from pais where continente='América';

-- subconsultas

-- que encuentre los idiomas ficiales 
select idioma from idioma where id in (select id_idioma from idioma_pais where es_oficial=1);	
