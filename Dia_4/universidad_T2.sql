DROP DATABASE IF EXISTS universidad_T2;
CREATE DATABASE universidad_T2 CHARACTER SET utf8mb4;
USE universidad_T2;
 
CREATE TABLE departamento (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE alumno (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nif VARCHAR(9) UNIQUE,
    nombre VARCHAR(25) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    ciudad VARCHAR(25) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(9),
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM('H', 'M') NOT NULL
);
 
CREATE TABLE profesor (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nif VARCHAR(9) UNIQUE,
    nombre VARCHAR(25) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    ciudad VARCHAR(25) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(9),
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM('H', 'M') NOT NULL,
    id_departamento INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);
 
 CREATE TABLE grado (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
 
CREATE TABLE asignatura (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos FLOAT UNSIGNED NOT NULL,
    tipo ENUM('básica', 'obligatoria', 'optativa') NOT NULL,
    curso TINYINT UNSIGNED NOT NULL,
    cuatrimestre TINYINT UNSIGNED NOT NULL,
    id_profesor INT UNSIGNED,
    id_grado INT UNSIGNED NOT NULL,
    FOREIGN KEY(id_profesor) REFERENCES profesor(id),
    FOREIGN KEY(id_grado) REFERENCES grado(id)
);
 
CREATE TABLE curso_escolar (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    anyo_inicio YEAR NOT NULL,
    anyo_fin YEAR NOT NULL
);

CREATE TABLE alumno_se_matricula_asignatura (
    id_alumno INT UNSIGNED NOT NULL,
    id_asignatura INT UNSIGNED NOT NULL,
    id_curso_escolar INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    FOREIGN KEY (id_alumno) REFERENCES alumno(id),
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
    FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);
 
 /* Departamento */
INSERT INTO departamento VALUES (1, 'Informática');
INSERT INTO departamento VALUES (2, 'Matemáticas');
INSERT INTO departamento VALUES (3, 'Economía y Empresa');
INSERT INTO departamento VALUES (4, 'Educación');
INSERT INTO departamento VALUES (5, 'Agronomía');
INSERT INTO departamento VALUES (6, 'Química y Física');
INSERT INTO departamento VALUES (7, 'Filología');
INSERT INTO departamento VALUES (8, 'Derecho');
INSERT INTO departamento VALUES (9, 'Biología y Geología');
 
 /* Persona */
INSERT INTO alumno VALUES (1, '89542419S', 'Juan', 'Saez', 'Vega', 'Almería', 'C/ Mercurio', '618253876', '1992/08/08', 'H');
INSERT INTO alumno VALUES (2, '26902806M', 'Salvador', 'Sánchez', 'Pérez', 'Almería', 'C/ Real del barrio alto', '950254837', '1991/03/28', 'H');
INSERT INTO alumno VALUES (4, '17105885A', 'Pedro', 'Heller', 'Pagac', 'Almería', 'C/ Estrella fugaz', NULL, '2000/10/05', 'H');
INSERT INTO alumno VALUES (6, '04233869Y', 'José', 'Koss', 'Bayer', 'Almería', 'C/ Júpiter', '628349590', '1998/01/28', 'H');
INSERT INTO alumno VALUES (7, '97258166K', 'Ismael', 'Strosin', 'Turcotte', 'Almería', 'C/ Neptuno', NULL, '1999/05/24', 'H');
INSERT INTO alumno VALUES (9, '82842571K', 'Ramón', 'Herzog', 'Tremblay', 'Almería', 'C/ Urano', '626351429', '1996/11/21', 'H');
INSERT INTO alumno VALUES (11, '46900725E', 'Daniel', 'Herman', 'Pacocha', 'Almería', 'C/ Andarax', '679837625', '1997/04/26', 'H');
INSERT INTO alumno VALUES (19, '11578526G', 'Inma', 'Lakin', 'Yundt', 'Almería', 'C/ Picos de Europa', '678652431', '1998/09/01', 'M');
INSERT INTO alumno VALUES (21, '79089577Y', 'Juan', 'Gutiérrez', 'López', 'Almería', 'C/ Los pinos', '678652431', '1998/01/01', 'H');
INSERT INTO alumno VALUES (22, '41491230N', 'Antonio', 'Domínguez', 'Guerrero', 'Almería', 'C/ Cabo de Gata', '626652498', '1999/02/11', 'H');
INSERT INTO alumno VALUES (23, '64753215G', 'Irene', 'Hernández', 'Martínez', 'Almería', 'C/ Zapillo', '628452384', '1996/03/12', 'M');
INSERT INTO alumno VALUES (24, '85135690V', 'Sonia', 'Gea', 'Ruiz', 'Almería', 'C/ Mercurio', '678812017', '1995/04/13', 'M');


/* Profesor */
INSERT INTO profesor VALUES (3, '11105554G', 'Zoe', 'Ramirez', 'Gea', 'Almería', 'C/ Marte', '618223876', '1979/08/19', 'M', 1);
INSERT INTO profesor VALUES (5, '38223286T', 'David', 'Schmidt', 'Fisher', 'Almería', 'C/ Venus', '678516294', '1978/01/19', 'H', 2);
INSERT INTO profesor VALUES (8, '79503962T', 'Cristina', 'Lemke', 'Rutherford', 'Almería', 'C/ Saturno', '669162534', '1977/08/21', 'M', 3);
INSERT INTO profesor VALUES (10, '61142000L', 'Esther', 'Spencer', 'Lakin', 'Almería', 'C/ Plutón', NULL, '1977/05/19', 'M', 4);
INSERT INTO profesor VALUES (12, '85366986W', 'Carmen', 'Streich', 'Hirthe', 'Almería', 'C/ Almanzora', NULL, '1971-04-29', 'M', 4);
INSERT INTO profesor VALUES (13, '73571384L', 'Alfredo', 'Stiedemann', 'Morissette', 'Almería', 'C/ Guadalquivir', '950896725', '1980/02/01', 'H', 6);
INSERT INTO profesor VALUES (14, '82937751G', 'Manolo', 'Hamill', 'Kozey', 'Almería', 'C/ Duero', '950263514', '1977/01/02', 'H', 1);
INSERT INTO profesor VALUES (15, '80502866Z', 'Alejandro', 'Kohler', 'Schoen', 'Almería', 'C/ Tajo', '668726354', '1980/03/14', 'H', 2);
INSERT INTO profesor VALUES (16, '10485008K', 'Antonio', 'Fahey', 'Considine', 'Almería', 'C/ Sierra de los Filabres', NULL, '1982/03/18', 'H', 3);
INSERT INTO profesor VALUES (17, '85869555K', 'Guillermo', 'Ruecker', 'Upton', 'Almería', 'C/ Sierra de Gádor', NULL, '1973/05/05', 'H', 4);
INSERT INTO profesor VALUES (18, '04326833G', 'Micaela', 'Monahan', 'Murray', 'Almería', 'C/ Veleta', '662765413', '1976/02/25', 'H', 5);
INSERT INTO profesor VALUES (20, '79221403L', 'Francesca', 'Schowalter', 'Muller', 'Almería', 'C/ Quinto pino', NULL, '1980/10/31', 'H', 6);
INSERT INTO profesor VALUES (21, '13175769N', 'Pepe', 'Sánchez', 'Ruiz', 'Almería', 'C/ Quinto pino', NULL, '1980/10/16', 'H', 1);
INSERT INTO profesor VALUES (22, '98816696W', 'Juan', 'Guerrero', 'Martínez', 'Almería', 'C/ Quinto pino', NULL, '1980/11/21', 'H', 1);
INSERT INTO profesor VALUES (23, '77194445M', 'María', 'Domínguez', 'Hernández', 'Almería', 'C/ Quinto pino', NULL, '1980/12/13', 'M', 2);

/* Grado */
INSERT INTO grado VALUES (1, 'Grado en Ingeniería Agrícola (Plan 2015)');
INSERT INTO grado VALUES (2, 'Grado en Ingeniería Eléctrica (Plan 2014)');
INSERT INTO grado VALUES (3, 'Grado en Ingeniería Electrónica Industrial (Plan 2010)');
INSERT INTO grado VALUES (4, 'Grado en Ingeniería Informática (Plan 2015)');
INSERT INTO grado VALUES (5, 'Grado en Ingeniería Mecánica (Plan 2010)');
INSERT INTO grado VALUES (6, 'Grado en Ingeniería Química Industrial (Plan 2010)');
INSERT INTO grado VALUES (7, 'Grado en Biotecnología (Plan 2015)');
INSERT INTO grado VALUES (8, 'Grado en Ciencias Ambientales (Plan 2009)');
INSERT INTO grado VALUES (9, 'Grado en Matemáticas (Plan 2010)');
INSERT INTO grado VALUES (10, 'Grado en Química (Plan 2009)');
 
/* Asignatura */
INSERT INTO asignatura VALUES (1, 'Álgegra lineal y matemática discreta', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (2, 'Cálculo', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (3, 'Física para informática', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (4, 'Introducción a la programación', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (5, 'Organización y gestión de empresas', 6, 'básica', 1, 1, NULL, 4);
INSERT INTO asignatura VALUES (6, 'Estadística', 6, 'básica', 1, 2, NULL, 4);
INSERT INTO asignatura VALUES (7, 'Estructura y tecnología de computadores', 6, 'básica', 1, 2, NULL, 4);
INSERT INTO asignatura VALUES (8, 'Fundamentos de electrónica', 6, 'básica', 1, 2, NULL, 4);
INSERT INTO asignatura VALUES (9, 'Lógica y algorítmica', 6, 'básica', 1, 2, NULL, 4);
INSERT INTO asignatura VALUES (10, 'Metodología de la programación', 6, 'básica', 1, 2, NULL, 4);
INSERT INTO asignatura VALUES (11, 'Arquitectura de Computadores', 6, 'básica', 2, 1, 3, 4);
INSERT INTO asignatura VALUES (12, 'Estructura de Datos y Algoritmos I', 6, 'obligatoria', 2, 1, 3, 4);
INSERT INTO asignatura VALUES (13, 'Ingeniería del Software', 6, 'obligatoria', 2, 1, 14, 4);
INSERT INTO asignatura VALUES (14, 'Sistemas Inteligentes', 6, 'obligatoria', 2, 1, 3, 4);
INSERT INTO asignatura VALUES (15, 'Sistemas Operativos', 6, 'obligatoria', 2, 1, 14, 4);
INSERT INTO asignatura VALUES (16, 'Bases de Datos', 6, 'básica', 2, 2, 14, 4);
INSERT INTO asignatura VALUES (17, 'Estructura de Datos y Algoritmos II', 6, 'obligatoria', 2, 2, 14, 4);
INSERT INTO asignatura VALUES (18, 'Fundamentos de Redes de Computadores', 6 ,'obligatoria', 2, 2, 3, 4);
INSERT INTO asignatura VALUES (19, 'Planificación y Gestión de Proyectos Informáticos', 6, 'obligatoria', 2, 2, 3, 4);
INSERT INTO asignatura VALUES (20, 'Programación de Servicios Software', 6, 'obligatoria', 2, 2, 14, 4);
INSERT INTO asignatura VALUES (21, 'Desarrollo de interfaces de usuario', 6, 'obligatoria', 3, 1, 14, 4);
INSERT INTO asignatura VALUES (22, 'Ingeniería de Requisitos', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (23, 'Integración de las Tecnologías de la Información en las Organizaciones', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (24, 'Modelado y Diseño del Software 1', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (25, 'Multiprocesadores', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (26, 'Seguridad y cumplimiento normativo', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (27, 'Sistema de Información para las Organizaciones', 6, 'optativa', 3, 1, NULL, 4); 
INSERT INTO asignatura VALUES (28, 'Tecnologías web', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (29, 'Teoría de códigos y criptografía', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (30, 'Administración de bases de datos', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (31, 'Herramientas y Métodos de Ingeniería del Software', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (32, 'Informática industrial y robótica', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (33, 'Ingeniería de Sistemas de Información', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (34, 'Modelado y Diseño del Software 2', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (35, 'Negocio Electrónico', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (36, 'Periféricos e interfaces', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (37, 'Sistemas de tiempo real', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (38, 'Tecnologías de acceso a red', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (39, 'Tratamiento digital de imágenes', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (40, 'Administración de redes y sistemas operativos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (41, 'Almacenes de Datos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (42, 'Fiabilidad y Gestión de Riesgos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (43, 'Líneas de Productos Software', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (44, 'Procesos de Ingeniería del Software 1', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (45, 'Tecnologías multimedia', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (46, 'Análisis y planificación de las TI', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (47, 'Desarrollo Rápido de Aplicaciones', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (48, 'Gestión de la Calidad y de la Innovación Tecnológica', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (49, 'Inteligencia del Negocio', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (50, 'Procesos de Ingeniería del Software 2', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (51, 'Seguridad Informática', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (52, 'Biologia celular', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (53, 'Física', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (54, 'Matemáticas I', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (55, 'Química general', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (56, 'Química orgánica', 6, 'básica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (57, 'Biología vegetal y animal', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (58, 'Bioquímica', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (59, 'Genética', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (60, 'Matemáticas II', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (61, 'Microbiología', 6, 'básica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (62, 'Botánica agrícola', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (63, 'Fisiología vegetal', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (64, 'Genética molecular', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (65, 'Ingeniería bioquímica', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (66, 'Termodinámica y cinética química aplicada', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (67, 'Biorreactores', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (68, 'Biotecnología microbiana', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (69, 'Ingeniería genética', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (70, 'Inmunología', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (71, 'Virología', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (72, 'Bases moleculares del desarrollo vegetal', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (73, 'Fisiología animal', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (74, 'Metabolismo y biosíntesis de biomoléculas', 6, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (75, 'Operaciones de separación', 6, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (76, 'Patología molecular de plantas', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (77, 'Técnicas instrumentales básicas', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (78, 'Bioinformática', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (79, 'Biotecnología de los productos hortofrutículas', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (80, 'Biotecnología vegetal', 6, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (81, 'Genómica y proteómica', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (82, 'Procesos biotecnológicos', 6, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (83, 'Técnicas instrumentales avanzadas', 4.5, 'obligatoria', 3, 2, NULL, 7);

/* Curso escolar */
INSERT INTO curso_escolar VALUES (1, 2014, 2015);
INSERT INTO curso_escolar VALUES (2, 2015, 2016);
INSERT INTO curso_escolar VALUES (3, 2016, 2017);
INSERT INTO curso_escolar VALUES (4, 2017, 2018);

/* Alumno se matricula en asignatura */
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 3, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 4, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 5, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 6, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 7, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 8, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 9, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 10, 1);

INSERT INTO alumno_se_matricula_asignatura VALUES (1, 1, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 2, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 3, 2);

INSERT INTO alumno_se_matricula_asignatura VALUES (1, 1, 3);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 2, 3);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 3, 3);

INSERT INTO alumno_se_matricula_asignatura VALUES (1, 1, 4);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 2, 4);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 3, 4);

INSERT INTO alumno_se_matricula_asignatura VALUES (2, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 3, 1);

INSERT INTO alumno_se_matricula_asignatura VALUES (4, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 3, 1);

INSERT INTO alumno_se_matricula_asignatura VALUES (4, 1, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 2, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 3, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 4, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 5, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 6, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 7, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 8, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 9, 2);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 10, 2);


select * from asignatura where cuatrimestre=1 and id_grado=7 and curso=3;

select asignatura.* from asignatura inner join grado on asignatura.id_grado = grado.id where grado.nombre='Grado en Ingeniería Informática (Plan 2015)';



select alumno.*,asignatura.nombre as nombre_asignatura from curso_escolar 
inner join alumno_se_matricula_asignatura  on curso_escolar.id= alumno_se_matricula_asignatura.id_curso_escolar 
inner join alumno on alumno_se_matricula_asignatura.id_alumno = alumno.id
inner join asignatura on  alumno_se_matricula_asignatura.id_asignatura = asignatura.id
where  curso_escolar.anyo_inicio=2017 and curso_escolar.anyo_fin =2018;


/*Devuelve el número total de alumnas que hay.*/

select count(*) as numero_alumnas from alumno where sexo='M';

/*Calcula cuántos alumnos nacieron en 1999.*/

select count(id) as numero_alumnas from alumno where year(fecha_nacimiento)=1999;

/*Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento
 y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores
 asociados y deberá estar ordenado de mayor a menor por el número de profesores.*/
 
 select departamento.nombre,count(profesor.id_departamento) as 'Numero de profesores' from departamento 
 inner join profesor on departamento.id= profesor.id_departamento 
 group by departamento.nombre order by 2 desc; 

/*Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir
 departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.*/

 select departamento.id,departamento.nombre,count(profesor.id_departamento) as 'Numero de profesores' from departamento 
 left join profesor on departamento.id= profesor.id_departamento 
 group by departamento.id,departamento.nombre; 

/*Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. 
Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. 
El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.*/

select grado.nombre, count(asignatura.id_grado) as 'Numero de asignaturas' from grado 
left join asignatura on asignatura.id_grado=grado.id group by 1 order by 2 desc;

/*Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, 
de los grados que tengan más de 40 asignaturas asociadas.*/

select grado.nombre, count(asignatura.id_grado) as 'Numero de asignaturas' from grado 
inner join asignatura on asignatura.id_grado=grado.id group by 1 having count(asignatura.id_grado) >40 ;

/*Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura.
 El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. 
 Ordene el resultado de mayor a menor por el número total de crédidos.*/

select grado.nombre, asignatura.tipo, sum(asignatura.creditos), count(asignatura.tipo) as total_creditos from grado 
inner join asignatura on grado.id=asignatura.id_grado 
group by grado.nombre, asignatura.tipo;

/*Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. 
El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.*/
 
select count(*) from alumno_se_matricula_asignatura;
select curso_escolar.anyo_inicio,count(asm.id_curso_escolar) as nombre_asignatura from curso_escolar 
inner join alumno_se_matricula_asignatura asm on curso_escolar.id= asm.id_curso_escolar group by curso_escolar.anyo_inicio ;

/*Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no 
imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. 
El resultado estará ordenado de mayor a menor por el número de asignaturas.*/

select p.id, p.nombre, p.apellido1,p.apellido2, count(asignatura.id_profesor) from profesor p 
left join asignatura on p.id= asignatura.id_profesor 
group by p.id, p.nombre, p.apellido1,p.apellido2;
