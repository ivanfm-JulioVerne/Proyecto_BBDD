CREATE OR REPLACE TRIGGER auditoriaCliente
    BEFORE DELETE OR UPDATE OR INSERT ON cliente
    FOR EACH ROW
BEGIN
    --Condición para saber que tipo de sentencia estamos ejecutando
    IF INSERTING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'cliente',1,SYSDATE,:NEW.cod_cliente || '#' || :NEW.nombre || '#' || :NEW.vip || '#' || :NEW.telefono,'---');
    ELSIF UPDATING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'cliente',2,SYSDATE,:NEW.cod_cliente || '#' || :NEW.nombre || '#' || :NEW.vip || '#' || :NEW.telefono,
            :OLD.cod_cliente || '#' || :OLD.nombre || '#' || :OLD.vip || '#' || :OLD.telefono);
    ELSIF DELETING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'cliente',3,SYSDATE,'---',:OLD.cod_cliente || '#' || :OLD.nombre || '#' || :OLD.vip || '#' || :OLD.telefono);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
END;
/

CREATE OR REPLACE TRIGGER auditoriaEmpleado
    BEFORE DELETE OR UPDATE OR INSERT ON empleado
    FOR EACH ROW
BEGIN
    --Condición para saber que tipo de sentencia estamos ejecutando
    IF INSERTING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'empleado',1,SYSDATE,:NEW.cod_empleado || '#' || :NEW.nombre || '#' || :NEW.jefe || '#' || :NEW.telefono || '#' || :NEW.ultima_jornada,'---');
    ELSIF UPDATING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'empleado',2,SYSDATE,:NEW.cod_empleado || '#' || :NEW.nombre || '#' || :NEW.jefe || '#' || :NEW.telefono || '#' || :NEW.ultima_jornada,
            :OLD.cod_empleado || '#' || :OLD.nombre || '#' || :OLD.jefe || '#' || :OLD.telefono || '#' || :OLD.ultima_jornada);
    ELSIF DELETING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'empleado',3,SYSDATE,'---',:OLD.cod_empleado || '#' || :OLD.nombre || '#' || :OLD.jefe || '#' || :OLD.telefono || '#' || :OLD.ultima_jornada);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
END;
/

CREATE OR REPLACE TRIGGER auditoriaProducto
    BEFORE DELETE OR UPDATE OR INSERT ON producto
    FOR EACH ROW
BEGIN
    --Condición para saber que tipo de sentencia estamos ejecutando
    IF INSERTING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'producto',1,SYSDATE,:NEW.cod_producto || '#' || :NEW.nombre || '#' || :NEW.gama || '#' || :NEW.precio_venta || '#' || :NEW.precio_proveedor,'---');
    ELSIF UPDATING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'producto',2,SYSDATE,:NEW.cod_producto || '#' || :NEW.nombre || '#' || :NEW.gama || '#' || :NEW.precio_venta || '#' || :NEW.precio_proveedor,
            :OLD.cod_producto || '#' || :OLD.nombre || '#' || :OLD.gama || '#' || :OLD.precio_venta || '#' || :OLD.precio_proveedor);
    ELSIF DELETING THEN
        --Se añaden un registro con los datos que de la sentencia
        INSERT INTO auditoria VALUES (USER,'producto',3,SYSDATE,'---',:OLD.cod_producto || '#' || :OLD.nombre || '#' || :OLD.gama || '#' || :OLD.precio_venta || '#' || :OLD.precio_proveedor);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
END;
/
