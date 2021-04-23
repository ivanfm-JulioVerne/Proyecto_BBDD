--Procedimiento que actualiza la ultima jornada de un empleado pasado por paramentros en la fecha de las ejecución del proceso
CREATE OR REPLACE PROCEDURE actualizaJornada(codigo NUMBER)IS
    --Excepción que aparecerá cuando se ejecute este proceso el Sábado o el Domingo
    e_diaIncorrecto EXCEPTION;
BEGIN
    --Condición para que cuando sea Sábado o Domingo aparezca un error
    IF TO_CHAR(SYSDATE,'D')='6' OR TO_CHAR(SYSDATE,'D')='7' THEN
        RAISE e_diaIncorrecto;
    END IF;
    --Sentencia que acutaliza el registro
    UPDATE empleado e SET ultima_jornada=SYSDATE WHERE e.cod_empleado=codigo;
    
EXCEPTION
    WHEN e_diaIncorrecto THEN
        DBMS_OUTPUT.PUT_LINE('Está intentando actualizar ultimaJornada en el sabado o domingo');
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('ORA-01476: Está intentando dividir entre 0');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ORA-06502: Error aritmetico');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
END;
/
