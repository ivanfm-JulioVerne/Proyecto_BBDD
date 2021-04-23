CREATE OR REPLACE FUNCTION delPedido(cod_prv NUMBER) RETURN NUMBER IS
    --Varieble en la que se introducirán el numero de registros eliminados
    cant NUMBER;
BEGIN
    --Cursor que deposita el numero de registros eliminados
    SELECT COUNT(*) INTO cant 
        FROM pedido p 
        WHERE p.cod_proveedor=cod_prv 
        GROUP BY p.cod_proveedor;
    --Sentencia que elimina los registros cuyo cod_proveedor coincide con el pasado por parametros
    DELETE pedido p WHERE cod_proveedor=cod_prv;
    RETURN cant;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('ORA-01476: Está intentando dividir entre 0');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ORA-06502: Error aritmetico');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
END delPedido;
/
