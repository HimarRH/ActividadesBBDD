-- Utilizado MySQL

create DATABASE IF NOT EXISTS EMPRESA;
use EMPRESA;
-- CREACIÓN DE LAS TABLAS
CREATE table `CENTROS` (
`NUMCE` INT (4) NOT NULL,
`NOMCE` VARCHAR(25),
`DIRCE` VARCHAR(25));



CREATE TABLE `DEPARTAMENTOS` (
`NUMDE` INT(3) NOT NULL,
`NUMCE` INT(4),
`DIREC` INT(3),
`TIDIR` CHAR(1),
`PRESU` DOUBLE(3,1),
`DEPDE` INT(3),
`NOMDE` VARCHAR(20)
);

CREATE TABLE `EMPLEADOS`(
`NUMEM` INT(3) NOT NULL,
`EXTEL` INT(3),
`FECNA` DATE,
`FECIN` DATE,
`SALAR` INT (5),
`COMIS` INT(3),
`NUMHI` INT(1),
`NOMEM` VARCHAR(10),
`NUMDE` INT(3)
);



-- INTRODUCCIÓN DE DATOS
-- 1.INSERTA LOS SIEGUIENTES DATOS EN LA TABLA DEPARTAMENTOS


INSERT INTO `departamentos`(`NUMDE`,`NUMCE`,`DIREC`,`TIDIR`,`PRESU`,`DEPDE`,`NOMDE`) VALUES
(100,10,260,'P',72, NULL,'DIRECCIÓN GENERAL'),
(110,20,180,'P',90,100,'DIRECC.COMERCIAL'),
(111,20,180,'F',66,110,'SECTOR INDUSTRIAL'),
(112,20,270,'P',54,110,'SECTOR SERVICIOS'),
(120,10,150,'F',18,'100','ORGANIZACIÓN'),
('121','10','150','P','12','120','PERSONAL'),
('122','10','350','P','36','120','PROCESO DE DATOS'),
('130','10','310','P','12','100','FINANZAS');

-- 1.INSERTA LOS SIGUIENTES DATOS EN LA TABLA CENTROS

INSERT INTO `CENTROS` (`NUMCE`,`NOMCE`,`DIRCE`) VALUES
('10','SEDE CENTRAL','C/ ATOCHA, 820, MADRID'),
('20','RELACIÓN CON CLIENTES','C/ ATOCHA, 405, MADRID');

-- 1.INSERTA LOS SIGUIENTES DATOS EN LA TABLA EMPLEADOS CON UN BULK INSERT

INSERT INTO `EMPLEADOS` (`NUMEM`,`EXTEL`,`FECNA`,`FECIN`,`SALAR`,`COMIS`,`NUMHI`,`NOMEM`,`NUMDE`) VALUES
('110','350','1970-11-10','1985-02-15','1800',NULL,'3','CESAR','121'),
('120','840','1968-06-09','1988-10-01','1900','110','1','MARIO','112'),
('130','810','1965-09-09','1981-02-01','1500','110','2','LUCIANO','112'),
('150','340','1972-08-10','1997-01-15','2600',NULL,'0','JULIO','121'),
('160','740','1980-07-09','2005-11-11','1800','110','2','AUREO','111'),
('180','508','1974-10-18','1996-03-18','2800','50','2','MARCOS','110'),
('190','350','1972-05-12','1992-02-11','1750',NULL,'4','JULIANA','121'),
('210','200','1970-09-28','1999-01-22','1910',NULL,'2','PILAR','100'),
('240','760','1967-02-26','1989-02-24','1700','100','3','LAVINIA','111'),
('250','250','1976-10-27','1997-03-01','2700',NULL,'0','ADRIANA','100'),
('260','220','1973-12-03','2001-07-12','720',NULL,'6','ANTONIO','100'),
('270','800','1975-05-21','2003-09-10','1910','80','3','OCTAVIO','112'),
('280','410','1978-01-10','2010-10-08','1500',NULL,'5','DOROTEA','130'),
('285','620','1979-10-25','2011-02-15','1910',NULL,'0','OTILIA','122'),
('290','910','1967-11-30','1988-02-14','1790',NULL,'3','GLORIA','120'),
('310','480','1976-11-21','2001-01-15','1950',NULL,'0','AUGUSTO','130'),
('320','620','1977-25-12','2003-02-05','2400',NULL,'2','CORNELIO','122'),
('330','850','1958-08-19','1980-03-01','1700','90','0','AMELIA','112'),
('350','610','1979-04-03','1999-09-10','2700',NULL,'1','AURELIO','122'),
('360','750','1978-10-29','1998-10-10','1800','100','2','DORINDA','111'),
('370','360','1977-06-22','2000-01-20','1860',NULL,'1','FABIOLA','121'),
('380','880','1978-03-30','1999-01-01','1100',NULL,'1','MICAELA','112'),
('390','500','1976-02-19','2010-10-08','1290',NULL,'1','CARMEN','110'),
('400','780','1979-08-18','2011-11-01','1150',NULL,'0','LUCRECIA','111'),
('410','660','1968-07-14','1989-10-13','1010',NULL,'0','AZUCENA','122'),
('420','450','1966-10-22','1988-11-19','2400',NULL,'0','CLAUDIA','130'),
('430','650','1967-10-26','1988-11-19','1260',NULL,'1','VALERIANA','122'),
('440','760','1966-09-26','1986-02-28','1260','100','0','LIVIA','111'),
('450','880','1966-10-21','1986-02-28','1260','100','0','SABINA','112'),
('480','760','1965-04-04','1986-02-28','1260','100','1','DIANA','111'),
('490','880','1964-06-06','1988-01-01','1090','100','0','HORACIO','112'),
('500','750','1965-10-08','1987-01-01','1200','100','0','HONORIA','111'),
('510','550','1966-05-04','1986-11-01','1200',NULL,'1','ROMULO','110'),
('550','780','1970-01-10','1998-01-21','600','120','0','SANCHO','111');

ALTER TABLE `CENTROS`
 ADD PRIMARY KEY (`NUMCE`),
 ADD KEY (`NUMCE`);
ALTER TABLE `DEPARTAMENTOS`
 ADD PRIMARY KEY (`NUMDE`),
 ADD KEY (`NUMDE`);
 ALTER TABLE `DEPARTAMENTOS`
 ADD CONSTRAINT departamentos_ibf_k1 FOREIGN KEY (`NUMCE`) REFERENCES `CENTROS`(`NUMCE`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT departamentos_ibfk_2 FOREIGN KEY (`DEPDE`) REFERENCES `DEPARTAMENTOS`(`NUMDE`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `EMPLEADOS`
 ADD PRIMARY KEY (`NUMEM`),
 ADD KEY (`NUMEM`);
 ALTER TABLE `EMPLEADOS` 
 ADD CONSTRAINT empleados_ibfk_3 FOREIGN KEY (`NUMDE`) REFERENCES `DEPARTAMENTOS`(`NUMDE`) ON DELETE CASCADE ON UPDATE CASCADE;
/** 1.Para cada departamento con presupuesto inferior a 35.000 €,
hallar el nombre del Centro donde está ubicado y el máximo salario de sus empleados 
 (si dicho máximo excede de 1.500 €). Clasificar alfabéticamente por nombre de departamento.
**/

select departamentos.nomde as Nombre_Departamento, centros.NOMCE as Nombre_del_centro, max(empleados.salar) as maximo_salario
from departamentos
join empleados on empleados.numde=departamentos.numde
join centros on departamentos.numce=centros.numce
where departamentos.presu<35
group by departamentos.nomde
having maximo_salario>1500
order by departamentos.nomde asc;


/** 2.Hallar por orden alfabético los nombres de los departamentos que dependen de 
los que tienen un presupuesto inferior a 30.000 €.
También queremos conocer el nombre del departamento del que dependen y su presupuesto.
**/
SELECT dep2.nomde as Nombre_Departamento, dep1.nomde as Departamento_Depende, dep1.presu as Presupuesto
FROM departamentos dep1, departamentos dep2
WHERE dep1.numde = dep2.depde AND dep1.presu < 30
ORDER BY Nombre_Departamento;


/**3. Obtener los nombres y los salarios medios de los departamentos cuyo 
salario medio supera al salario medio de la empresa.
**/                    
select departamentos.nomde as Nombre_departamento, avg(salar) as Salario_Medio
from departamentos
join empleados on  departamentos.numde = empleados.numde
group by departamentos.numde
having avg(salar)>(select avg(salar)
					from empleados);

/** 4.Para los departamentos cuyo director lo sea en funciones, 
hallar el número de empleados y la suma de sus salarios, 
comisiones y número de hijos.
**/
select departamentos.nomde as Nombre_departamento,count(empleados.numem) as Numero_empleados, sum(empleados.salar) as Suma_salarios, sum(empleados.comis) as Suma_comisiones, sum(empleados.numhi) as Numero_hijos
from departamentos 
join empleados on empleados.numde = departamentos.numde
where departamentos.tidir = 'F'
group by Nombre_departamento;

/**5.Para los departamentos cuyo presupuesto anual supera los 35.000 €,
 hallar cuantos empleados hay por cada extensión telefónica.**/

select E.extel as Extension_telefonica, D.nomde as Nombre_departamento, count(E.numem) as numEmpleados
from departamentos D join empleados E on D.numde = E.numde
where D.presu > 35
group by E.extel;


/** 6. Hallar por orden alfabético los nombres de los empleados y 
su número de hijos para aquellos que son directores en funciones.**/
select departamentos.nomde as Nombre_departamentos, empleados.nomem as Nombre_empleados, empleados.numhi as Numero_hijos
from departamentos
join empleados on empleados.numem=departamentos.direc
where departamentos.tidir = 'F'
group by Nombre_empleados asc;
                                         
/** 7.Hallar si hay algún departamento (suponemos que sería de reciente creación) 
que aún no tenga empleados asignados ni director en propiedad.**/
select departamentos.nomde as Nombre_departamentos,count(empleados.numem)as Numero_empleados, empleados.nomem as Nombre_Empleados, departamentos.direc as Director
from departamentos
join empleados on empleados.numde = departamentos.numde
where departamentos.tidir='F'
having count(empleados.numem)=0;

select departamentos.nomde as Nombre_departamento, count(empleados.numem) as num_empl
from departamentos  left join empleados  on departamentos.numde = empleados.numde
where departamentos.tidir='F'
group by Nombre_departamento
having count(empleados.numem)=0;

/**8.Añadir un nuevo departamento de nombre NUEVO y con director en funciones.**/
INSERT INTO `departamentos`(`NUMDE`,`NUMCE`,`DIREC`,`TIDIR`,`PRESU`,`DEPDE`,`NOMDE`) VALUES
(null,NULL,NULL,'F',NULL,null,'NUEVO');

INSERT INTO `departamentos`(`NUMDE`,`NUMCE`,`DIREC`,`TIDIR`,`PRESU`,`DEPDE`,`NOMDE`) VALUES
('131',NULL,NULL,'F',NULL,null,'NUEVO');
 
/**9.Añadir un nuevo empleado de nombre NORBERTO y sin departamento asignado. Inventar el resto de datos.**/
INSERT INTO `EMPLEADOS` (`NUMEM`,`EXTEL`,`FECNA`,`FECIN`,`SALAR`,`COMIS`,`NUMHI`,`NOMEM`,`NUMDE`) VALUES
('555','350','1973-12-08','1990-05-07','1970',NULL,'1','NORBERTO',NULL);

/**10.Muestra los departamentos que no tienen empleados.**/
select *
from departamentos
where numde not in (select numde from empleados where numde is not null);

/**11.Muestra los nombres de departamentos que no tienen empleados haciendo uso la combinación externa LEFT JOIN. 
Muestra una segunda columna con los nombres de empleados para asegurarnos que realmente está a NULL.**/
select departamentos.nomde as Nombre_departamento, count(empleados.numem) as num_empl, empleados.nomem as Nombres_empleados
from departamentos  left join empleados  on departamentos.numde = empleados.numde
group by Nombre_departamento
having count(empleados.numem)=0;

/**12.Muestra los nombres de departamentos que no tienen empleados haciendo uso la combinación externa RIGHT JOIN. 
Muestra una segunda columna con los nombres de empleados para asegurarnos que realmente está a NULL.**/

select departamentos.nomde as Nombre_departamento, count(empleados.numem) as num_empl, empleados.nomem as Nombres_empleados
from empleados  right join departamentos  on empleados.numde = departamentos.numde
group by Nombre_departamento
having count(empleados.numem)=0;

/**13.Muestra los nombres de empleados que no tienen departamento haciendo uso la combinación externa LEFT JOIN. 
Muestra una segunda columna con los nombres de departamentos para asegurarnos que realmente esta a NULL.**/

select empleados.nomem as Nombres_empleados, departamentos.nomde as Nombre_departamento
from empleados left join departamentos  on empleados.numde = departamentos.numde
where empleados.numde is null;

/**14.Muestra los nombres de empleados que no tienen departamento haciendo uso la combinación externa LEFT JOIN. 
Muestra una segunda columna con los nombres de departamentos para asegurarnos que realmente esta a NULL.**/

select empleados.nomem as Nombres_empleados, departamentos.nomde as Nombre_departamento
from departamentos right join empleados  on departamentos.numde = empleados.numde
where empleados.numde is null;

/**15.Muestra los departamentos que no tienen empleados y
 los empleados que no tiene departamento haciendo uso la combinación externa FULL JOIN.**/
 
select empleados.nomem as Nombres_empleados, departamentos.nomde as Nombre_departamento
from empleados right join departamentos  on empleados.numde = departamentos.numde
group by Nombre_departamento
having count(empleados.numem)=0
UNION
select empleados.nomem as Nombres_empleados, departamentos.nomde as Nombre_departamento
from empleados left join departamentos  on empleados.numde = departamentos.numde
where empleados.numde is null;

/**16.Muestra los empleados y sus respectivos departamentos haciendo uso de la combinación interna INNER JOIN. 
¿Aparecen el departamento NUEVO y el empleado NORBERTO?¿Por qué?**/
select empleados.nomem as Nombres_empleados, departamentos.nomde as Nombre_departamento
from empleados join departamentos on empleados.numde=departamentos.numde;

-- Pendiento de explicación 
/**17.Realiza la misma consulta anterior donde se cumpla la condición que NUMDE está a NULL. 
¿Aparece algún resultado?¿Por qué?**/
select empleados.nomem as Nombres_empleados, departamentos.nomde as Nombre_departamento
from empleados join departamentos on empleados.numde=departamentos.numde
WHERE EMPLEADOS.NUMDE IS NULL;

-- No aparece nada.

/**18.Muestra los empleados y sus respectivos departamentos haciendo uso de la combinación interna NATURAL JOIN.**/
select empleados.nomem as Nombres_empleados, departamentos.nomde as Nombre_departamento
from empleados
natural join departamentos;

/**19.Muestra la combinación de las 3 tablas CENTROS, DEPARTAMENTOS y EMPLEADOS haciendo uso de NATURAL JOIN.**/
select empleados.nomem as Nombres_empleados, departamentos.nomde as Nombre_departamento, centros.nomce as Nombre_centro
from empleados
natural join departamentos
natural join centros;

/**20.Borra los registros dados de alta para el departamento NUEVO y el empleado introducido en el apartado anterior.**/
delete from departamentos where numde = (select numde
										from departamentos
                                        where nomde = 'NUEVO');

DELETE FROM empleados WHERE numem = (select numem
									from empleados
                                    where nomem ='Norberto') and empleados.numde is null;

