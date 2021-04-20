CREATE TABLE empleado
(
    cod_empleado NUMBER CONSTRAINT coe_emp_pk PRIMARY KEY,
    nombre CHAR CONSTRAINT nom_emp_nn NOT NULL CONSTRAINT nom_emp_un UNIQUE,
    jefe NUMBER,
    telefono NUMBER(9),
    ultima_jornada CHAR,
    
    CONSTRAINT emp_fk FOREIGN KEY (jefe) REFERENCES empleado
);

CREATE TABLE cliente
(
    cod_cliente NUMBER,
    nombre
);

INSERT INTO empleado (cod_empleado, nombre, jefe, telefono, ultima_jornada) VALUE (1,José,null,123456789,null);
