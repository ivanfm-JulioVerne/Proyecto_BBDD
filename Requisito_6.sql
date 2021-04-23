CREATE OR REPLACE TRIGGER editDetalle_venta
    AFTER INSERT OR UPDATE OR DELETE ON detalle_venta
BEGIN
    --Condición para saber que tipo de sentencia estamos ejecutando
    CASE
        
        WHEN INSERTING THEN
            --Se escribe por pantalla el texto de acontinuación
            DBMS_OUTPUT.PUT_LINE('Se han insertado correctamente datos en la tabla venta');
        WHEN UPDATING THEN
            --Se escribe por pantalla el texto de acontinuación
            DBMS_OUTPUT.PUT_LINE('Se han actulizado correctamente datos en la tabla venta');
        WHEN DELETING THEN
            --Se escribe por pantalla el texto de acontinuación
            DBMS_OUTPUT.PUT_LINE('Se han borrado correctamente datos en la tabla venta');
    END CASE;
EXCEPTION
    WHEN CASE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Lo que ha intentado hacer no es un UPDATE, DELETE o INSERT');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo ha salido mal');
END;
/
