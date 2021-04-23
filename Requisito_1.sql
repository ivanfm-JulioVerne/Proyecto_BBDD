--Procedimiento que devuelve una entrada por pantalla de los datos de un Empleado
CREATE OR REPLACE PROCEDURE listaEmpleado (cod NUMBER) IS
    -- Tipo compuesto para el cursor implicito
    TYPE c_empleado IS RECORD(
        r_cod_empleado NUMBER,
        r_nombre VARCHAR2(60),
        r_jefe NUMBER,
        r_telefono NUMBER,
        r_ultimaJornada VARCHAR2(60),
        r_numVenta NUMBER
    );
    --El tipo anterior mente creado se asigna a una variable
    empleado c_empleado;
    --Cursor que recoje los datos de las ventas que han hecho los empleados
    CURSOR c_venta IS SELECT DISTINCT v.cod_empleado,v.cod_cliente,v.cod_venta,TO_CHAR(v.fecha, 'DD/MM/YYYY') AS FECHA,
        (SELECT SUM(dev.total) FROM detalle_venta dev WHERE dev.cod_venta=v.cod_venta) AS TOTAL,
        (SELECT COUNT(dev.cod_venta || dev.cod_producto) FROM detalle_venta dev WHERE dev.cod_venta=v.cod_venta) AS CONCEPTOS
            FROM venta v
            ORDER BY v.cod_venta;
    --Cursor que recoje los datos de los conceptos que tiene cada venta
    CURSOR c_producto IS SELECT DISTINCT dev.cod_venta,pro.cod_producto,pro.nombre,pro.precio_venta,pro.precio_proveedor,ped.cod_proveedor
            FROM producto pro, detalle_venta dev,pedido ped
            WHERE pro.cod_producto=dev.cod_producto AND pro.cod_producto=ped.cod_producto
            ORDER BY dev.cod_venta;
BEGIN
    --Cursor implicito que recoje los datos de un empleado concreto
    SELECT DISTINCT e.cod_empleado,e.nombre,e.jefe,e.telefono,NVL (TO_CHAR(e.ultima_jornada, 'DD/MM/YYYY'),'No encontrado') AS ULTIMAJORNADA,
        (SELECT COUNT(v.cod_venta) FROM venta v WHERE e.cod_empleado=v.cod_empleado) AS NUMVENTA
            INTO empleado.r_cod_empleado,empleado.r_nombre,empleado.r_jefe,
            empleado.r_telefono,empleado.r_ultimaJornada,empleado.r_numVenta
            FROM empleado e
            WHERE e.cod_empleado=cod;
    --Bucle que recorre el cursor c_empleado
    DBMS_OUTPUT.PUT_LINE('************************************************************');
    DBMS_OUTPUT.PUT_LINE('Empleado: ' || empleado.r_cod_empleado);
    DBMS_OUTPUT.PUT_LINE('  -Nombre: ' || empleado.r_nombre);
    --Condición para que cuando el jefe sea nulo no aparezca como un registro vacio
    IF empleado.r_jefe IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('  -Jefe: No tiene');
    ELSE
        DBMS_OUTPUT.PUT_LINE('  -Jefe: ' || empleado.r_jefe);
    END IF;
    DBMS_OUTPUT.PUT_LINE('  -Telf.: ' || empleado.r_telefono);
    DBMS_OUTPUT.PUT_LINE('  -Ultima Jornada: ' || empleado.r_ultimaJornada);
    DBMS_OUTPUT.PUT_LINE('  -Número de Ventas: ' || empleado.r_numVenta);
    DBMS_OUTPUT.PUT_LINE('------------Ventas------------');
    --Bucle que recorre el cursor c_venta
    FOR regVen IN c_venta LOOP
        --Condición que busca cuales son las ventas del empleado
        IF regVen.cod_empleado=empleado.r_cod_empleado THEN
            DBMS_OUTPUT.PUT_LINE('  Venta: ' || regVen.cod_venta);
            DBMS_OUTPUT.PUT_LINE('      -Cliente: ' || regVen.cod_cliente);
            DBMS_OUTPUT.PUT_LINE('      -Fecha: ' || regVen.fecha);
            DBMS_OUTPUT.PUT_LINE('      -Conceptos: ' || regVen.conceptos);
            DBMS_OUTPUT.PUT_LINE('      ------------Conceptos------------');
                --Bucle que recorre el cursor c_producto
                FOR regPro IN c_producto LOOP
                    --Condición que busca cuales son conceptos de las ventas de los empleados
                    IF regVen.cod_venta=regPro.cod_venta THEN
                        DBMS_OUTPUT.PUT_LINE('      Producto: ' || regPro.cod_producto);
                        DBMS_OUTPUT.PUT_LINE('          -Nombre: ' || regPro.nombre);
                        DBMS_OUTPUT.PUT_LINE('          -Proveedor: ' || regPro.cod_proveedor);
                        DBMS_OUTPUT.PUT_LINE('          -Precio de Venta: ' || regPro.precio_venta);
                        DBMS_OUTPUT.PUT_LINE('          -Precio de Proveedor: ' || regPro.precio_proveedor);
                        DBMS_OUTPUT.PUT_LINE('      ---------------------------------');
                    END IF;
                END LOOP;
            DBMS_OUTPUT.PUT_LINE('      -Total: ' || regVen.total);
            DBMS_OUTPUT.PUT_LINE('------------------------------');
        END IF;
    END LOOP;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('ORA-01476: Está intentando dividir entre 0');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ORA-06502: Error aritmetico');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ORA-01403: Error aritmetico');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('ORA-01422: Error aritmetico');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
END;
/

--Procedimiento con el que podemos elegir el empleado que queremos ver con 
--pantalla con el procedimiento listaEmpleado ó si queremos podemos ver todos los empleados
CREATE OR REPLACE PROCEDURE tipoLista (codigo NUMBER) IS
    --Definición de variables
    c_empleado NUMBER;
    v_num NUMBER;
BEGIN
    --Cursor para saber cuantos registros tiene la tabala empleado
    SELECT COUNT(*) INTO c_empleado FROM empleado;
    --Condición para sabler que tipo de lista quiere
    --Lista completa de todos los empleados
    IF codigo=0 THEN
        v_num:=1;
        --Bucle que recorre todos los registros de la tabla empleado
        FOR v_num IN 1..c_empleado LOOP
            --Ejecución del proceso listaEmpleado pasandole por parametros v_num
            listaEmpleado(v_num);
        END LOOP;
    --Lista de un solo empleado
    ELSE
        --Ejecución del proceso listaEmpleado pasandole por parametros codigo
        listaEmpleado(codigo);
    END IF;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('ORA-01476: Está intentando dividir entre 0');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ORA-06502: Error aritmetico');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ORA-01403: Error aritmetico');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('ORA-01422: Error aritmetico');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
END;
/
