--
DROP TABLE empleado;
DROP TABLE cliente;

CREATE TABLE empleado
(
    cod_empleado NUMBER CONSTRAINT coe_emp_pk PRIMARY KEY,
    nombre VARCHAR2(60) CONSTRAINT nom_emp_nn NOT NULL CONSTRAINT nom_emp_un UNIQUE,
    jefe NUMBER,
    telefono NUMBER(9),
    ultima_jornada CHAR,
    
    CONSTRAINT coj_emp_fk FOREIGN KEY (jefe) REFERENCES empleado
);
DROP TABLE empleado;
CREATE TABLE cliente
(
    cod_cliente NUMBER CONSTRAINT coc_cli_pk PRIMARY KEY,
    nombre VARCHAR(60) CONSTRAINT nom_cli_nn NOT NULL CONSTRAINT nom_cli_un UNIQUE,
    vip CHAR(2) CONSTRAINT vip_cli_ck CHECK (vip IN ('SI' || 'NO')) CONSTRAINT vip_cli_nn NOT NULL,
    telefono NUMBER(9)
);
DELETE empleado;

INSERT INTO cliente VALUES (1,'José','SI',123456789);
