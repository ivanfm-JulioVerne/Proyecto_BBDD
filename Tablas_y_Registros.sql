--Eliminar tablas
DROP TABLE auditoria;
DROP TABLE pedido;
DROP TABLE detalle_venta;
DROP TABLE venta;
DROP TABLE proveedor;
DROP TABLE producto;
DROP TABLE cliente;
DROP TABLE empleado;

--Borrado de tablas
DELETE auditoria;
DELETE pedido;
DELETE detalle_venta;
DELETE venta;
DELETE proveedor;
DELETE producto;
DELETE cliente;
DELETE empleado;

--Eliminación de Secuencias
DROP SEQUENCE cod_empleado;
DROP SEQUENCE cod_cliente;
DROP SEQUENCE cod_proveedor;
DROP SEQUENCE cod_venta;


--Creación de tablas
CREATE TABLE empleado
(
    cod_empleado NUMBER CONSTRAINT coe_emp_pk PRIMARY KEY,
    nombre VARCHAR2(60) CONSTRAINT nom_emp_nn NOT NULL CONSTRAINT nom_emp_un UNIQUE,
    jefe NUMBER,
    telefono NUMBER(9),
    ultima_jornada DATE,
    
    CONSTRAINT coj_emp_fk FOREIGN KEY (jefe) REFERENCES empleado
);

CREATE TABLE cliente
(
    cod_cliente NUMBER CONSTRAINT coc_cli_pk PRIMARY KEY,
    nombre VARCHAR(60) CONSTRAINT nom_cli_nn NOT NULL CONSTRAINT nom_cli_un UNIQUE,
    vip CHAR(2) CONSTRAINT vip_cli_ck CHECK (vip IN ('SI','NO')) CONSTRAINT vip_cli_nn NOT NULL,
    telefono NUMBER(9)
);

CREATE TABLE producto
(
    cod_producto VARCHAR2(7) CONSTRAINT cop_pro_pk PRIMARY KEY,
    nombre VARCHAR2(60) CONSTRAINT nom_pro_nn NOT NULL CONSTRAINT nom_pro_un UNIQUE,
    gama VARCHAR2(11) CONSTRAINT gam_pro_ck CHECK (UPPER(gama) IN ('DEPORTIVO','TURISMO','TODOTERRENO','MONOVOLUMEN')) CONSTRAINT gam_pro_nn NOT NULL,
    precio_venta NUMBER,
    precio_proveedor NUMBER
);

CREATE TABLE proveedor
(
    cod_proveedor NUMBER CONSTRAINT cpv_pro_pk PRIMARY KEY,
    nombre VARCHAR2(60) CONSTRAINT nom_prv_nn NOT NULL CONSTRAINT nom_prv_un UNIQUE,
    nombre_contacto VARCHAR2(60) CONSTRAINT noc_prv_nn NOT NULL CONSTRAINT noc_prv_un UNIQUE,
    telefono NUMBER(9)
);

CREATE TABLE venta
(
    cod_venta NUMBER CONSTRAINT cov_ven_pk PRIMARY KEY,
    fecha DATE,
    cod_cliente NUMBER,
    cod_empleado NUMBER,
    
    CONSTRAINT coc_ven_fk FOREIGN KEY (cod_cliente) REFERENCES cliente,
    CONSTRAINT coe_ven_fk FOREIGN KEY (cod_empleado) REFERENCES empleado
);

CREATE TABLE detalle_venta
(
    cod_venta NUMBER,
    cod_producto VARCHAR2(7),
    cantidad NUMBER,
    total NUMBER,
    
    CONSTRAINT cov_dev_fk FOREIGN KEY (cod_venta) REFERENCES venta,
    CONSTRAINT cop_dev_fk FOREIGN KEY (cod_producto) REFERENCES producto,
    
    CONSTRAINT dev_pk PRIMARY KEY (cod_venta,cod_producto)
);

CREATE TABLE pedido
(
    cod_proveedor NUMBER,
    cod_producto VARCHAR2(7),
    cantidad NUMBER,
    fecha DATE,
    
    CONSTRAINT cpv_ped_fk FOREIGN KEY (cod_proveedor) REFERENCES proveedor,
    CONSTRAINT cop_ped_fk FOREIGN KEY (cod_producto) REFERENCES producto,
    
    CONSTRAINT ped_pk PRIMARY KEY (cod_proveedor,cod_producto)
);

CREATE TABLE auditoria
(
    usuario VARCHAR2(60),
    tabla VARCHAR2(60),
    tipo NUMBER,
    fecha DATE,
    reg_nuevo VARCHAR2(60),
    reg_viejo VARCHAR2(60),
    
    CONSTRAINT aud_pk PRIMARY KEY (usuario,tabla,tipo,fecha,reg_nuevo,reg_viejo)
);

--Creación de Secuencias
CREATE SEQUENCE cod_empleado;
CREATE SEQUENCE cod_cliente;
CREATE SEQUENCE cod_proveedor;
CREATE SEQUENCE cod_venta;

ALTER SESSION SET nls_date_format='dd/mm/yyyy';
--Datos
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Iván Fernández Méndez',null,684351987,'19/04/2021');
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'María Carmen Pérez Ruiz',1,123456789,'19/04/2021');
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Ana Fernández Méndez',1,952476119,'19/04/2021');
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Antonio Alonso Gimenez',2,751325498,'19/04/2021');
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Adrián García Miguel',2,299368745,'18/04/2021');
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Ángel María Ramírez Esteban',2,984651456,null);
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Isabel Gonzalez Prieto',2,887245484,null);
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Pablo López Sánchez',3,987315171,'01/03/2021');
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Armando Torres Ramos',3,894631548,'19/042021');
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Cristina Navarro Gil',3,756239764,'19/04/2021');
INSERT INTO empleado VALUES (cod_empleado.NEXTVAL,'Pedro Mendez Fresco',3,823674562,null);

INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Antonio García Rodriguez','SI',123456789);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Ana María Gonzalez Fernández','NO',865845274);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Manuel López Martínez','NO',765124986);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'María Sánchez Pérez','SI',124965874);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'José Gómez Martín','NO',123578946);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Carmen Jiménez Ruiz','NO',856360123);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Francisco Hernández Díaz','NO',123498765);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'David Campos Magro','SI',997123658);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Juan Moreno Muñoz','NO',123123123);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Isabel Álvarez Romero','NO',159357258);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Daniel Alonso Gutiérrez','NO',456951654);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Laura Navarro Torres','NO',741236985);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'José Luis Espadas Martín','SI',145896521);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Ana Domínguez Vazquez','NO',741236928);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Miguel Ramos Gil','NO',456123351);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'María Isabel Ramírez Serrano','NO',426153426);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Sergio Molina Blanco','NO',624895137);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Sara Morales Suárez','NO',663355998);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Fernándo Ortega Delgado','SI',986123678);
INSERT INTO cliente VALUES (cod_cliente.NEXTVAL,'Elena Castro Ortiz','SI',254213854);

INSERT INTO producto VALUES ('DEP-001','Toyota GR Yaris','Deportivo',15000,12500);
INSERT INTO producto VALUES ('DEP-002','Cupra León Sportstourer','Deportivo',16000,14500);
INSERT INTO producto VALUES ('DEP-003','DS 5','Deportivo',25000,21000);
INSERT INTO producto VALUES ('DEP-004','Mazda MX-5 RF','Deportivo',13000,10000);
INSERT INTO producto VALUES ('DEP-005','Ford Mustang','Deportivo',15500,13000);
INSERT INTO producto VALUES ('TUR-001','BMW Serie 3','Turismo',15000,13500);
INSERT INTO producto VALUES ('TUR-002','Ford Focus','Turismo',14000,11000);
INSERT INTO producto VALUES ('TUR-003','Hyundai Nexo Fuel Cell','Turismo',14500,12000);
INSERT INTO producto VALUES ('TUR-004','Jaguar I-Pace','Turismo',12750,9000);
INSERT INTO producto VALUES ('TUR-005','Mercedes Clase A','Turismo',17000,15000);
INSERT INTO producto VALUES ('TUR-006','Citroën C3','Turismo',10000,8500);
INSERT INTO producto VALUES ('TOD-001','Suzuki Jimny','Todoterreno',15000,14000);
INSERT INTO producto VALUES ('TOD-002','Land Rover Discovery','Todoterreno',14000,11000);
INSERT INTO producto VALUES ('TOD-003','Dacia Duster','Todoterreno',16000,14000);
INSERT INTO producto VALUES ('MON-001','Volkswagen California','Monovolumen',18000,15000);
INSERT INTO producto VALUES ('MON-002','SEAT Alhambra','Monovolumen',19000,15500);

INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Toyota','Mateo Gallardo Bravo',257898579);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'León','Vicente Sánchez Iglesias',777123214);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'DS','Alberto Delgado Castro',741268842);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Ford','Carlos Castillo Santos',987415874);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'BMW','Oscar Cordero Frito',745825635);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Hyundai','Paula Prieto Cruz',741563979);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Jaguar','Florentino Herrera Gallego',789521153);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Mercedes','Cristian Peña León',147858963);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Citroën','Pablo Calvo Vidal',987412398);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Suzuki','Consuelo Reyes Santos',987456321);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Land Rover','Nuria Perez Lorenzo',147896523);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Dacia','Pablo Ferrer Sanz',741268153);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Volkswagen','Fatima Cano Mora',742698426);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'Mazda','María José Nieto Caballero',145256379);
INSERT INTO proveedor VALUES (cod_proveedor.NEXTVAL,'SEAT','Lorenzo Vargas Duran',874521963);

INSERT INTO venta VALUES (cod_venta.NEXTVAL,'05/08/2019',1,1);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'26/01/2020',10,2);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'14/02/2021',8,3);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'05/04/2019',9,4);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'09/03/2020',3,5);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'01/04/2021',7,7);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'04/06/2019',4,6);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'07/11/2020',3,8);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'12/04/2021',7,9);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'15/07/2019',2,10);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'18/04/2020',2,11);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'23/4/2021',3,2);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'26/09/2019',10,3);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'29/02/2020',9,4);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'17/04/2021',7,5);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'15/08/2019',8,6);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'13/07/2020',4,7);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'02/04/2021',2,8);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'04/03/2019',3,9);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'08/11/2020',7,2);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'06/3/2021',8,1);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'13/10/2019',9,2);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'25/08/2020',10,3);
INSERT INTO venta VALUES (cod_venta.NEXTVAL,'28/01/2021',9,7);

INSERT INTO detalle_venta SELECT 1,'DEP-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='DEP-001';
INSERT INTO detalle_venta SELECT 1,'TUR-001',2,2*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-001';
INSERT INTO detalle_venta SELECT 2,'TOD-003',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-003';
INSERT INTO detalle_venta SELECT 3,'DEP-003',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='DEP-003';
INSERT INTO detalle_venta SELECT 4,'TOD-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-001';
INSERT INTO detalle_venta SELECT 5,'DEP-004',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='DEP-004';
INSERT INTO detalle_venta SELECT 5,'DEP-005',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='DEP-005';
INSERT INTO detalle_venta SELECT 5,'TOD-001',10,10*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-001';
INSERT INTO detalle_venta SELECT 6,'TUR-002',2,2*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-002';
INSERT INTO detalle_venta SELECT 7,'DEP-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='DEP-001';
INSERT INTO detalle_venta SELECT 8,'TOD-003',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-003';
INSERT INTO detalle_venta SELECT 9,'TUR-004',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-004';
INSERT INTO detalle_venta SELECT 10,'TUR-004',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-004';
INSERT INTO detalle_venta SELECT 11,'TUR-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-001';
INSERT INTO detalle_venta SELECT 12,'TUR-005',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-005';
INSERT INTO detalle_venta SELECT 13,'TOD-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-001';
INSERT INTO detalle_venta SELECT 14,'TUR-006',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-006';
INSERT INTO detalle_venta SELECT 15,'DEP-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='DEP-001';
INSERT INTO detalle_venta SELECT 16,'TOD-002',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-002';
INSERT INTO detalle_venta SELECT 17,'MON-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='MON-001';
INSERT INTO detalle_venta SELECT 18,'MON-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='MON-001';
INSERT INTO detalle_venta SELECT 19,'TUR-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-001';
INSERT INTO detalle_venta SELECT 20,'TUR-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-001';
INSERT INTO detalle_venta SELECT 20,'TUR-002',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TUR-001';
INSERT INTO detalle_venta SELECT 20,'DEP-003',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='DEP-001';
INSERT INTO detalle_venta SELECT 21,'TOD-003',6,6*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-003';
INSERT INTO detalle_venta SELECT 22,'TOD-003',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-003';
INSERT INTO detalle_venta SELECT 23,'TOD-003',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-003';
INSERT INTO detalle_venta SELECT 24,'DEP-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='DEP-001';
INSERT INTO detalle_venta SELECT 22,'TOD-001',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-003';
INSERT INTO detalle_venta SELECT 7,'TOD-003',1,1*p.precio_venta FROM producto p WHERE p.cod_producto='TOD-003';

INSERT INTO pedido VALUES (1,'DEP-001',5,'26/01/2018');
INSERT INTO pedido VALUES (2,'DEP-002',5,'14/02/2018');
INSERT INTO pedido VALUES (3,'DEP-003',5,'09/03/2018');
INSERT INTO pedido VALUES (14,'DEP-004',5,'05/04/2018');
INSERT INTO pedido VALUES (4,'DEP-005',5,'01/05/2018');
INSERT INTO pedido VALUES (5,'TUR-001',7,'20/06/2018');
INSERT INTO pedido VALUES (4,'TUR-002',7,'21/07/2018');
INSERT INTO pedido VALUES (6,'TUR-003',7,'11/08/2018');
INSERT INTO pedido VALUES (7,'TUR-004',7,'30/09/2018');
INSERT INTO pedido VALUES (8,'TUR-005',7,'31/10/2018');
INSERT INTO pedido VALUES (9,'TUR-006',7,'19/11/2018');
INSERT INTO pedido VALUES (10,'TOD-001',10,'23/12/2018');
INSERT INTO pedido VALUES (11,'TOD-002',10,'05/01/2018');
INSERT INTO pedido VALUES (12,'TOD-003',10,'06/02/2018');
INSERT INTO pedido VALUES (13,'MON-001',5,'03/03/2018');
INSERT INTO pedido VALUES (15,'MON-002',5,'09/04/2018');

COMMIT;
