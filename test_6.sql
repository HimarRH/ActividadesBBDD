/* ----------- CREACION BBDD ----------*/
CREATE DATABASE IF NOT EXISTS prueba6;

use prueba6;

/* ----- CREACION TABLAS -----*/

/*--- ParqueNatural --- */
CREATE TABLE `ParqueNatural`(
	`codPN` int(15),
	`nombre` varchar(25),
	`fechaDeclaracion` date
);

/*Indices parqueNatural*/
ALTER TABLE `ParqueNatural`
	ADD PRIMARY KEY(`codPN`),
	ADD KEY(`codPN`);

ALTER TABLE`ParqueNatural` modify `codPN` int(15) not null;

/* --- ComunidadAutonoma ---*/
CREATE TABLE `ComunidadAutonoma`(
	`codCA` int(15),
	`nombre` varchar(25),
	`orgResponsable` varchar(25)
);

/*Indices ComunidadAutonoma*/
ALTER TABLE `ComunidadAutonoma`
	ADD PRIMARY KEY(`codCA`),
	ADD KEY(`codCA`);

alter table `ComunidadAutonoma` modify `codCA` int(15) not null;


/* --- CA-PN ---*/
CREATE TABLE `CA-PN`(
	`codCA` int(15),
	`codPN` int(15),
	`superficie` int(15)
);

/*Indices CA-PN*/
ALTER TABLE `CA-PN`
	ADD KEY(`codCA`),
	ADD KEY(`codPN`);

ALTER TABLE `CA-PN`
	ADD CONSTRAINT ca_pn_ibf_k1 FOREIGN KEY(`codCA`) REFERENCES `ComunidadAutonoma`(`codCA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	ADD CONSTRAINT ca_pn_ibf_k2 FOREIGN KEY(`codPN`) REFERENCES `ParqueNatural`(`codPN`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/* --- Visitante ---*/
CREATE TABLE `Visitante`(
	`DNI` varchar(25),
	`nombre` varchar(25),
	`domicilio` varchar(25),
	`profesion` varchar(25)
);

/*Indices Visitante*/
ALTER TABLE `Visitante`
	ADD PRIMARY KEY(`DNI`),
	ADD KEY(`DNI`);

alter table `Visitante` modify `DNI` varchar(25) not null;

/* --- Alojamiento ---*/
create table `Alojamiento`(
	`codAlojamiento` int(15),
    `categoria` varchar(25),
    `capacidad` int(15),
    `codPN` int(15)
);

/*PK - FK - Index*/
alter table `Alojamiento`
	add primary key(`codAlojamiento`),
    add key(`codAlojamiento`);

alter table `Alojamiento`
	add constraint alojamiento_ibf_k1 foreign key(`codPN`) references `ParqueNatural`(`codPN`) on delete no action on update no action;

/*Restriccion not null*/
alter table `Alojamiento` modify `codAlojamiento` int(15) not null;

/* --- Excursion --- */
create table `Excursion`(
	`codExcursion` int(15),
    `fecha` date,
    `hora` time,
    `aPie` char(2),
    `codAlojamiento` int(15)
);

/*PK - FK - Index*/
alter table `Excursion`
	add primary key(`codExcursion`),
    add key(`codExcursion`);

alter table `Excursion`
	add constraint excursion_ibf_k1 foreign key(`codAlojamiento`) references `Alojamiento`(`codAlojamiento`) on delete no action on update no action;
    
/*Restriccion not null*/
alter table `Excursion` modify `codExcursion` int(15) not null;

/* --- E-V ---*/
create table `E_V`(
	`codExcursion` int(15),
    `DNI` varchar(25)
);

/*PK - FK - Index*/
alter table `E_V`
	add key(`codExcursion`),
    add key(`DNI`);

alter table `E_V`
	add constraint ev_ibf_k1 foreign key(`codExcursion`) references `Excursion`(`codExcursion`) on delete no action on update no action,
	add constraint ev_ibf_k2 foreign key(`DNI`) references `Visitante`(`DNI`) on delete no action on update no action;

    
/* --- A-V --- */
create table `A_V`(
	`codAlojamiento` int(15),
    `DNI` varchar(25),
    `fechaInicio` date,
    `fechaFin` date
);

/*PK - FK - Index*/
alter table `A_V`
	add primary key(`fechaInicio`),
	add key(`fechaInicio`);

alter table `A_V`
	add key(`codAlojamiento`),
    add key(`DNI`);

alter table `A_V`
	add constraint av_ibf_k1 foreign key(`codAlojamiento`) references `Alojamiento`(`codAlojamiento`) on delete no action on update no action,
    add constraint av_ibf_k2 foreign key(`DNI`) references `Visitante`(`DNI`) on delete no action on update no action;

/*Restriccion not null*/
alter table `A_V` modify `fechaInicio` date not null;

/* -- Entrada -- */
create table `Entrada`(
	`codEntrada` int(15),
    `codPN` int(15)
);

/*PK - FK - Index*/
alter table `Entrada`
	add primary key(`codEntrada`),
    add key(`codEntrada`);

alter table `Entrada`
	add constraint entrada_ibf_k1 foreign key(`codPN`) references `ParqueNatural`(`codPN`) on delete no action on update no action;

/*Restriccion not null*/
alter table `Entrada` modify `codEntrada` int(15) not null;

/* -- Especie -- */
create table `Especie`(
	`codEspecie` int(15),
    `nombreCientifico` varchar(25),
    `nombreVulgar` varchar(25)
);

/*PK - FK - Index*/
alter table `Especie`
	add primary key(`codEspecie`),
    add key(`codEspecie`);
    
/*Restriccion not null*/
alter table `Especie` modify `codEspecie` int(15) not null;

/* --- Area ---*/
create table `Area`(
	`nombreA` varchar(25),
    `extension` int(15),
    `codPN` int(15)
);

/*PK - FK - Index*/
alter table `Area`
	add primary key(`nombreA`),
    add key(`nombreA`);

alter table `Area`
	add constraint area_ibf_k1 foreign key(`codPN`) references `ParqueNatural`(`codPN`) on delete no action on update no action;

/*Restriccion not null*/
alter table `Area` modify `nombreA` varchar(25) not null;

/* --- E-A --- */
create table `E_A`(
	`codEspecie` int(15),
    `nombreA` varchar(25),
    `cantidadIndividuos` int(15)
);

/*PK - FK - Index*/
alter table `E_A`
	add key(`codEspecie`),
    add key(`nombreA`);

alter table `E_A`
	add constraint ea_ibf_k1 foreign key(`codEspecie`) references `Especie`(`codEspecie`) on delete no action on update no action,
    add constraint ea_ibf_k2 foreign key(`nombreA`) references `Area`(`nombreA`) on delete no action on update no action;


/* --- Animal --- */
create table `Animal`(
	`codEspecie` int(15),
    `alimentacion` varchar(25),
    `periodoCelo` varchar(25)
);

/*PK - FK - Index*/
alter table `Animal`
	add key(`codEspecie`);

alter table `Animal`
	add constraint animal_ibf_k1 foreign key(`codEspecie`) references `Especie`(`codEspecie`) on delete no action on update no action;


/* --- Vegetal --- */
create table `Vegetal`(
	`codEspecie` int(15),
    `floracion` varchar(25),
    `periodoFloracion` varchar(25)
);

/*PK - FK - Index*/
alter table `Vegetal`
	add key(`codEspecie`);

alter table `Vegetal`
	add constraint vegetal_ibf_k1 foreign key(`codEspecie`) references `Especie`(`codEspecie`) on delete no action on update no action;


/* --- Mineral --- */
create table `Mineral`(
	`codEspecie` int(15),
    `tipo` varchar(25)
);

/*PK - FK - Index*/
alter table `Mineral`
	add key(`codEspecie`);

alter table `Mineral`
	add constraint mineral_ibf_k1 foreign key(`codEspecie`) references `Especie`(`codEspecie`) on delete no action on update no action;

/* --- Personal --- */
create table `Personal`(
	`DNI` varchar(25),
    `NSS` int(15),
    `nombre` varchar(25),
    `direccion` varchar(25),
    `tfnoDomicilio` int(15),
    `tfnoMovil` int(15),
    `sueldo` int(15),
    `codPN` int(15)
);

/*PK - FK - Index*/
alter table `Personal`
	add primary key(`DNI`),
    add key(`DNI`),
    add unique(`NSS`);

alter table `Personal`
	add constraint personal_ibf_k1 foreign key(`codPN`) references `ParqueNatural`(`codPN`) on delete no action on update no action;

alter table `Personal` modify `DNI` varchar(25) not null;

/* --- Conservador ---*/
create table `Conservador`(
	`DNI` varchar(25),
    `tarea` varchar(25),
    `nombreA` varchar(25)
);

/*PK - FK - Index*/
alter table `Conservador`
	add primary key(`DNI`),
	add key(`DNI`);

alter table `Conservador`
	add constraint conservador_ibf_k1 foreign key(`DNI`) references `Personal`(`DNI`) on delete no action on update no action,
    add constraint conservador_ibf_k2 foreign key(`nombreA`) references `Area`(`nombreA`) on delete no action on update no action;

alter table `Conservador` modify `DNI` varchar(25) not null;

/* --- Vigilante --- */
create table `Vigilante`(
	`DNI` varchar(25),
    `nombreA` varchar(25)
);

/*PK - FK - Index*/
alter table `Vigilante`
	add primary key(`DNI`),
	add key(`DNI`);

alter table `Vigilante`
	add constraint vigilante_ibf_k1 foreign key(`DNI`) references `Personal`(`DNI`) on delete no action on update no action,
    add constraint vigilante_ibf_k2 foreign key(`nombreA`) references `Area`(`nombreA`) on delete no action on update no action;

/*Restriccion not null*/
alter table `Vigilante` modify `DNI` varchar(25) not null;

/* --- Vehiculo -- */
create table `Vehiculo`(
	`matricula` varchar(15),
    `tipo` varchar(25),
    `DNI` varchar(15)
);

/*PK - FK - Index*/
alter table `Vehiculo`
	add primary key(`matricula`),
    add key(`matricula`),
    add unique(`DNI`),
    add key(`DNI`);

alter table `Vehiculo`
	add constraint vehiculo_ibf_k1 foreign key(`DNI`) references `Vigilante`(`DNI`) on delete no action on update no action;

alter table `Vehiculo` modify `matricula` varchar(15) not null;

/* --- Investigador --- */
create table `Investigador`(
	`DNI` varchar(25),
    `titulacion` varchar(25)
);

/*PK - FK - Index*/
alter table `Investigador`
	add primary key(`DNI`),
    add key(`DNI`);

alter table `Investigador`
	add constraint investigador_ibf_k1 foreign key(`DNI`) references `Personal`(`DNI`) on delete no action on update no action;

alter table `Investigador` modify `DNI` varchar(25) not null;

/* --- Proyecto --- */
create table `Proyecto`(
	`codProy` int(15),
    `presupuesto` int(15),
    `fechaInicio` date,
    `fechaFin` date,
    `codEspecie` int(15)
);

/*PK - FK - Index*/
alter table `Proyecto`
	add primary key(`codProy`),
    add key(`codProy`);

alter table `Proyecto`
	add constraint proyecto_ibf_k1 foreign key(`codEspecie`) references `Especie`(`codEspecie`) on delete no action on update no action;

/*Restriccion not null*/
alter table `Proyecto` modify `codProy` int(15) not null;

/* --- I-P --- */
create table `I_P`(
	`codProy` int(15),
    `DNI` varchar(25)
);

/*PK - FK - Index*/
alter table `I_P`
	add key(`codProy`),
    add key(`DNI`);

alter table `I_P`
	add constraint ip_ibf_k1 foreign key(`codProy`) references `Proyecto`(`codProy`) on delete no action on update no action,
    add constraint ip_ibf_k2 foreign key(`DNI`) references `Investigador`(`DNI`) on delete no action on update no action;


/* --- Gestor --- */
create table `Gestor`(
	`DNI` varchar(25),
    `codEntrada` int(15) 
);

/*PK - FK - Index*/
alter table `Gestor`
	add primary key(`DNI`),
    add key(`DNI`);

alter table `Gestor`
	add constraint gestor_ibf_k1 foreign key(`DNI`) references `Personal`(`DNI`) on delete no action on update no action,
    add constraint gestor_ibf_k2 foreign key(`codEntrada`) references `Entrada`(`codEntrada`) on delete no action on update no action;

/*Restriccion not null*/
alter table `Gestor` modify `DNI` varchar(25) not null;

/* --- Carga Datos --- */

insert into `ParqueNatural`(`codPn`, `nombre`, `fechaDeclaracion`) values
(215,'ORDESA','1969-03-06'),
(217,'AIGÜESTORTES','1977-05-11'),
(223,'EL VIÑEDO','2000-09-12'),
(242,'URDABAI','1984-01-01');

insert into `ComunidadAutonoma`(`codCA`, `nombre`, `orgResponsable`) values
(117,'ARAGON','MEDIO AMBIENTE'),
(118,'CATALUNYA','TURISMO'),
(119,'LA RIOJA','INTERIO'),
(120,'PAIS VASCO','TURISMO');

insert into `CA-PN`(`codCA`, `codPN`, `superficie`) values
(117,215,15696),
(118,217,15681),
(119,223,9347),
(120,242,11247);

insert into `Visitante`(`DNI`, `nombre`, `domicilio`, `profesion`) values
('56712367K','ALMUDENA','C/ TORTOSA 1','MEDICA'),
('45698610P','MANUEL','C/ AMERICA 27','MECANICO'),
('85903261Q','PABLO','C/ DEL RAYO 59','BIOLOGO'),
('67823956C','RUTH','C/ BARCELONA 92','COMERCIAL'),
('91758124R','MARTA','C/ BRUNETE 44','FISIOTERAPEUTA');

insert into `Alojamiento`(`codAlojamiento`, `categoria`, `capacidad`, `codPN`) values
(011,'HOTEL',45,215),
(012,'CAMPING',155,223),
(013,'ALBERGUE',76,242);

insert into `Excursion`(`codExcursion`, `fecha`, `hora`, `Apie`, `codAlojamiento`)values
(34567,'2022-11-25','09:10:00','SI',011),
(57849,'2020-02-11','13:22:00','NO',012),
(63892,'2023-01-07','08:03:00','SI',013),
(89506,'2018-04-20','10:22:03','SI',011),
(35768,'2021-03-19','19:35:55','NO',012);

insert into `E_V`(`codExcursion`, `DNI`) values
(34567,'56712367K'),
(57849,'45698610P'),
(63892,'85903261Q'),
(89506,'67823956C'),
(35768,'91758124R');

insert into `A_V`(`codAlojamiento`, `DNI`, `fechaInicio`, `fechaFin`) values
(011,'56712367K','2022-11-24','2022-11-27'),
(012,'45698610P','2020-02-10','2020-02-16'),
(013,'85903261Q','2023-01-06','2023-01-11'),
(011,'67823956C','2018-04-19','2018-04-23'),
(012,'91758124R','2021-03-18','2021-03-26');

insert into `Entrada`(`codEntrada`, `codPN`) values
(345,215),
(346,217),
(347,223),
(348,215),
(349,242);

insert into `Especie`(`codEspecie`, `nombreCientifico`, `nombreVulgar`) values
(01125,'Gyps fulvus','BUITRE LEONADO'),
(00746,'Galemys pyrenaicus','DESMAN IBERICO'),
(01139,'Falco peregrinus','HALCÓN PEREGRINO'),
(01065,'Anser anser','OCA COMÚN'),
(11012,'Vitis viniferas','VID'),
(11327,'Quercus robur','ROBLE COMÚN'),
(11389,'Fagus sylvatica','HAYA COMÚN'),
(11332,'Quercus suber','ALCORNOQUE COMÚN'),
(20347,'GRANITO','GRANITO'),
(20498,'ARCILLA','ARCILLA'),
(20579,'Cinabrio','CINABRIO'),
(20368,'PIZARRA','PIZARRA');

insert into `Area`(`nombreA`, `extension`, `codPN`) values
('PIRINEICA ORIENTAL',32300,215),
('PIRINEICA OCCIDENTAL',47200,217),
('ALTA RIOJA',35678,223),
('VEGA INTERIOR',36792,242);

insert into `E_A`(`codEspecie`, `nombreA`, `cantidadIndividuos`) values
(01125,'PIRINEICA ORIENTAL','943'),
(00746,'PIRINEICA OCCIDENTAL','34598'),
(01139,'VEGA INTERIOR','1875'),
(01065,'ALTA RIOJA','2554'),
(11012,'ALTA RIOJA','110762'),
(11327,'PIRINEICA OCCIDENTAL','14582'),
(11389,'PIRINEICA ORIENTAL','23796'),
(11332,'VEGA INTERIOR','24867'),
(20347,'PIRINEICA OCCIDENTAL',null),
(20498,'ALTA RIOJA',null),
(20579,'VEGA INTERIOR',null),
(20368,'PIRINEICA ORIENTAL',null);

insert into `Animal`(`codEspecie`, `alimentacion`, `periodoCelo`) values
(01125,'CARROÑERO','20 DIAS'),
(00746,'INSECTOS','7 DIAS'),
(01139,'PEQUEÑOS MAMIFEROS','15 DIAS'),
(01065,'HIERBAS Y BULBOS','5 DIAS');

insert into `Vegetal`(`codEspecie`, `floracion`, `periodoFloracion`) values
(11012,'VERANO','45 DIAS'),
(11327,'PRIMAVERA','15 DIAS'),
(11389,'PRIMAVERA','67 DÍAS'),
(11332,'PRIMAVERA','36 DIAS');

insert into `Mineral`(`codEspecie`, `tipo`) values
(20347,'IGNEA'),
(20498,'SEDIMENTARIA'),
(20579,'SULFUROS'),
(20368,'IGNEA Y ARCILLOSA');

insert into `Personal`(`DNI`, `NSS`, `nombre`, `direccion`, `tfnoDomicilio`, `tfnoMovil`, `sueldo`, `codPN`) values
('46873691L',577491994,'JOAQUIN','C/ ALMORAVÍ 32',NULL,768936748,45000,215),
('56729412J',136761604,'RAQUEL','C/ CALVARIO 15',956758105,675891248,39500,217),
('28758901T',545821204,'AREVALO','C/ ESTUARDO 117',972364756,622875934,48937,223),
('38857611T',303263777,'ALMA','C/ DEL SUSPIRO 65',946273911,729857365,43765,242),
('37581958Y',036483611,'DIONISIO','C/ BOLADORDO 75 B',938754829,768467124,31000,215),
('42858105H',002588599,'GERARDO','C/ VALENCIA 34',955758914,675891243,28300,217),
('47919587F',525893929,'AMAIA','C/ LOGROÑO 34',NULL,622875937,33000,223),
('34657878V',585429948,'UNAI','C/ GASTEIZ 85',944758195,729857363,30900,242),
('43678131H',527982932,'LAIA','C/ MONTSERRAT 32',930581275,768467122,34879,215),
('45678124C',426944728,'JULIA','C/ HAYA 35',955188176,675891241,33467,217),
('39816580Z',545261093,'MONICA','C/ ARITZA 55',978957291,622875936,31876,223),
('47891839M',417929708,'ARANTXA','C/ BILBO 62',null,729857368,32567,242),
('41857195K',319682377,'CLARA','C/ ASTURIAS 56',936492863,768467127,56700,215),
('39867285T',387449789,'AGUSTIN','C/ EBRO 21',NULL,675891246,54890,217),
('37986928V',262424168,'ROBERTO','C/ BADAJOZ 65',978758931,622875936,57500,223),
('46382958R',585179183,'MIREIA','C/ GETXO 15',null,729857361,55400,242);

insert into `Conservador`(`DNI`, `tarea`, `nombreA`) values
('46873691L','MANTENMIENTO DE ANIMALES','PIRINEICA ORIENTAL'),
('56729412J','CONSERVACIÓN VEGETAL','PIRINEICA OCCIDENTAL'),
('28758901T','SUPERVISION DE ESPECIES','ALTA RIOJA'),
('38857611T','ALIMENTACION','VEGA INTERIOR');

insert into `Vigilante`(`DNI`, `nombreA`) values
('37581958Y','PIRINEICA ORIENTAL'),
('42858105H','PIRINEICA OCCIDENTAL'),
('47919587F','ALTA RIOJA'),
('34657878V','VEGA INTERIOR');

insert into `Vehiculo`(`matricula`, `tipo`, `DNI`) values
('2756MNN','RANGE ROVER','37581958Y'),
('3678KLM','PEUGEOT RIFTER','42858105H'),
('2875LFG','RENAULT CAPTUR','47919587F'),
('6572KHY','HYUNDAI STONIC','34657878V');

insert into `Investigador`(`DNI`, `titulacion`) values
('43678131H','BIOLOGA'),
('45678124C','GEOLOGA'),
('39816580Z','ENOLOGA'),
('47891839M','FORESTAL');

insert into `Proyecto`(`codProy`, `presupuesto`, `fechaInicio`, `fechaFin`, `codEspecie`) values
(1567,110345,'2020-04-04','2024-12-31',01125),
(1687,98765,'2022-06-18','2024-10-10',20347),
(1611,205879,'2021-02-28','2025-11-09',11012),
(1700,154679,'2023-01-01','2023-01-01',11332);

insert into `I_P`(`codProy`, `DNI`) values
(1567,'43678131H'),
(1687,'45678124C'),
(1611,'39816580Z'),
(1611,'47891839M');

insert into `Gestor`(`DNI`, `codEntrada`) values
('41857195K',345),
('39867285T',346),
('37986928V',347),
('46382958R',349);

commit;

/* -- VISTA -- */
/* Crear una vista que saque los DNI y la fecha
 * de las personas que han realizado una excursión a pie y ejecútala.*/
 
 create view visitantes_pie as (
	select v.dni, e.fecha
    from visitante v join e_v on v.dni = e_v.dni
    join excursion e on e_v.codExcursion = e.codExcursion
    where e.aPie = 'SI');

select * from prueba6.visitantes_pie;