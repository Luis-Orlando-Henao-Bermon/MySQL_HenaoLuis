use triggers_eventos;

-- 1. Listar todos los paises

select * from countries;

-- 2. obtener todos los departamentos

select * from dependents;

-- 3. Mostrar titulo y salario minimo de todos los trabajadores

select job_title,min_salary from jobs;

-- 4. listar los dependientes junto con los datos de los empleados a los que dependen

select * from dependents d inner join  employees e on d.employee_id=e.employee_id;

-- 5. salario promedio por departamento y ciudad

select avg(e.salary) as promedio,d.department_name,l.city from employees e 
inner join departments d  on e.department_id=d.department_id
inner join locations l on d.location_id=l.location_id group by 2,3;

-- 6. Lista de empleos con su trabajo, departamento y ubicacion

select e.first_name,e.last_name,j.job_title,d.department_name,l.street_address from jobs j 
inner join employees e on e.job_id=j.job_id 
inner join departments d  on e.department_id=d.department_id
inner join locations l on d.location_id=l.location_id ;

-- funcion 

-- 1. obtener el nombre de un pais por el id

DELIMITER //
CREATE FUNCTION nombre_pais (id_pais char(2))
RETURNS varchar(100) DETERMINISTIC
BEGIN
	
    declare nombre_pais varchar(100);   

    SET nombre_pais= (select country_name from countries where id_pais=country_id);
    
    RETURN nombre_pais;
END // 
DELIMITER ;

select nombre_pais('JP') as nombre_pais;


-- PROCEDIMIENTO

-- 1. ISERTAR REGION

DELIMITER //
create procedure nombre_pais (in nombre_region varchar(50))
BEGIN

	insert into regions(region_name) values (nombre_region);
    
END // 
DELIMITER ;

call nombre_pais('Africa');
select * from regions;