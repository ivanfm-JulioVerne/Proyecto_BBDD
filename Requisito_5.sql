CREATE OR REPLACE FUNCTION numVenta (cod VARCHAR2,anno1 VARCHAR2,anno2 VARCHAR2) RETURN NUMBER IS 
    --Variable que sera la que recoja todas las ventas de los diferentes años
    v_numVenta NUMBER;
    --Variable que sera la que recoja las ventas de un año
    v_numVentaAnno NUMBER;
BEGIN
    --Se inicializa a 0 para que si no hay ninguna venta no devuelva nulo o salte un error
    v_numVenta:=0;
    --Bucle en el que esta el rango de años que se quiere ejecutar
    FOR v_anno IN anno1..anno2 LOOP
            --Cursor implicito para recoger las ventas de los años
            SELECT COUNT(v.fecha) INTO v_numVentaAnno 
                FROM venta v, detalle_venta dev
                WHERE v.cod_venta=dev.cod_venta AND dev.cod_producto=cod AND (TO_CHAR(v.fecha,'YYYY')=v_anno OR TO_CHAR(v.fecha,'YYYY')=v_anno);
            --Formula con la que se incrementa v_numVenta
            v_numVenta:=v_numVenta+v_numVentaAnno;
    END LOOP;
    RETURN v_numVenta;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
END numVenta;
/
