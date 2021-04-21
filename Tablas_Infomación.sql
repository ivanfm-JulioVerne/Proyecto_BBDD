--Eliminar tablas
DROP TABLE auditoria;
DROP TABLE detalle_pedido;
DROP TABLE detalle_venta;
DROP TABLE venta;
DROP TABLE proveedor;
DROP TABLE producto;
DROP TABLE cliente;
DROP TABLE empleado;

--Borrado de tablas
DELETE auditoria;
DELETE detalle_pedido;
DELETE detalle_venta;
DELETE venta;
DELETE proveedor;
DELETE producto;
DELETE cliente;
DELETE empleado;

--Creación de tablas
CREATE TABLE empleado
(
    cod_empleado NUMBER CONSTRAINT coe_emp_pk PRIMARY KEY,
    nombre VARCHAR2(60) CONSTRAINT nom_emp_nn NOT NULL CONSTRAINT nom_emp_un UNIQUE,
    jefe NUMBER,
    telefono NUMBER(9),
    ultima_jornada CHAR,
    
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
    gama VARCHAR2(2),
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
    CONSTRAINT coe_ven_fk FOREIGN KEY (cod_empleado) REFERENCES cliente
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

CREATE TABLE detalle_pedido
(
    cod_proveedor NUMBER,
    cod_producto VARCHAR2(7),
    cantidad NUMBER,
    fecha DATE,
    
    CONSTRAINT cpv_dep_fk FOREIGN KEY (cod_proveedor) REFERENCES proveedor,
    CONSTRAINT cop_dep_fk FOREIGN KEY (cod_producto) REFERENCES producto,
    
    CONSTRAINT dep_pk PRIMARY KEY (cod_proveedor,cod_producto)
);

CREATE TABLE auditoria
(
    usuario CHAR,
    fecha DATE,
    reg_nuevo CHAR,
    reg_viejo CHAR,
    
    CONSTRAINT aud_pk PRIMARY KEY (usuario,fecha,reg_nuevo,reg_viejo)
);

INSERT INTO empleado VALUES (1,'José',null,123456789,null);
INSERT INTO cliente VALUES (1,'José','SI',123456789);
INSERT INTO venta VALUES (1,SYSDATE,null);
