SET SERVEROUTPUT ON
DECLARE
    v_elige NUMBER;
    --Variables y cursores del procedimiento actualizaJornada
    v_codigoActulizaJornada NUMBER;
    c_actualizaJornadaNuevo VARCHAR2(10);
    c_actualizaJornadaViejo VARCHAR2(10);
    --Variable del procedimento listaEmleado
    v_codListaEmpleado NUMBER;
    --Variable del procedimiento tipoLista
    v_codTipoLista NUMBER;
    --Variables de la función delPedido
    v_cod_prv_delPedido NUMBER;
    v_resDelPed NUMBER;
    --Variables de la función numVenta
    v_codNumVenta VARCHAR2(60);
    v_anno1 VARCHAR2(60);
    v_anno2 VARCHAR2(60);
    v_numVenta NUMBER;
    --Cursor del disparador
    c_auditoria auditoria%ROWTYPE;
    --Cursores del trigger delEmp
    c_delEmp NUMBER;
BEGIN
    --Con esta variable se pueden probar los diferentes bloques
    v_elige:=17;
    
    --Inicialización de variables y cursores
    v_codigoActulizaJornada:=1;
    v_codListaEmpleado:=2;
    v_codTipoLista:=0;
    v_cod_prv_delPedido:=1;
    v_codNumVenta := 'TUR-001';
    v_anno1 := '2019';
    v_anno2 := '2021';
    SELECT TO_CHAR(e.ultima_jornada,'DD/MM/YYYY') 
    INTO c_actualizaJornadaViejo 
    FROM empleado e 
    WHERE e.cod_empleado=v_codigoActulizaJornada;
    
    --Condición que ejecuta un codigo u otro
    CASE
        --Caso con el que se ejecuta actualizaJornada y se muestra por pantalla los resultados
        WHEN v_elige=1 THEN
            actualizaJornada(1);
            SELECT TO_CHAR(e.ultima_jornada,'DD/MM/YYYY') 
                INTO c_actualizaJornadaNuevo 
                FROM empleado e 
                WHERE e.cod_empleado=v_codigoActulizaJornada;
            DBMS_OUTPUT.PUT_LINE('Jornada antigua: ' || c_actualizaJornadaViejo);
            DBMS_OUTPUT.PUT_LINE('Jornada nueva: ' || c_actualizaJornadaNuevo);
            
        --Caso con el que se ejecuta listaempleado y se muestra por pantalla los resultados
        WHEN v_elige=2 THEN
            listaempleado(v_codListaEmpleado);
            
        --Caso con el que se ejecuta tipoLista y se muestra por pantalla los resultados
        WHEN v_elige=3 THEN
            tipoLista(v_codTipoLista);
            
        --Caso con el que se ejecuta delPedido y se muestra por pantalla los resultados
        WHEN v_elige=4 THEN
            v_resDelPed:=delPedido(v_cod_prv_delPedido);
            DBMS_OUTPUT.PUT_LINE('Pedidos eliminados: ' || v_resDelPed);
            
        --Caso con el que se ejecuta numVenta y se muestra por pantalla los resultados
        WHEN v_elige=5 THEN
            v_numVenta:=numVenta(v_codNumVenta,v_anno1,v_anno2);
            DBMS_OUTPUT.PUT_LINE('Número de ventas: ' || v_numVenta);
            
        --Caso con el que se ejecuta auditoriaCliente(INSERT) y se muestra por pantalla los resultados
        WHEN v_elige=6 THEN
            INSERT INTO cliente VALUES(90,'Miguel Correa Falcon','SI',987654321);
                SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_nuevo='90#Miguel Correa Falcon#SI#987654321';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
        --Caso con el que se ejecuta auditoriaCliente(UPDATE) y se muestra por pantalla los resultados
        WHEN v_elige=7 THEN
            UPDATE cliente SET nombre='Miguel Correa Falcon' WHERE cod_cliente=1;
                SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_nuevo LIKE '%#Miguel Correa Falcon#%';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
        --Caso con el que se ejecuta auditoriaCliente(DELETE) y se muestra por pantalla los resultados
        WHEN v_elige=8 THEN
            DELETE cliente WHERE cod_cliente=11;
            UPDATE venta SET cod_cliente=1 WHERE cod_cliente=11;
            SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_viejo LIKE '11#%';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
            
        --Caso con el que se ejecuta auditoriaEmpleado(INSERT) y se muestra por pantalla los resultados
        WHEN v_elige=9 THEN
            INSERT INTO empleado VALUES(90,'Miguel Correa Falcon',NULL,987654321,NULL);
            SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_nuevo LIKE '90#%';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
        --Caso con el que se ejecuta auditoriaEmpleado(UPDATE) y se muestra por pantalla los resultados
        WHEN v_elige=10 THEN
            UPDATE empleado SET nombre='Miguel Correa Falcon' WHERE cod_empleado=1;
            SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_nuevo LIKE '%#Miguel Correa Falcon#%';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
        --Caso con el que se ejecuta auditoriaEmpleado(DELETE) y se muestra por pantalla los resultados
        WHEN v_elige=11 THEN
            DELETE empleado WHERE cod_empleado=11;
            UPDATE venta SET cod_empleado=1 WHERE cod_cliente=11;
            SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_viejo LIKE '11#%';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
            
        --Caso con el que se ejecuta auditoriaProducto(INSERT) y se muestra por pantalla los resultados
        WHEN v_elige=12 THEN
            INSERT INTO producto VALUES('DEP-100','Ferrari','Deportivo',200000,199000);
            SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_nuevo LIKE 'DEP-100#%';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
         --Caso con el que se ejecuta auditoriaProducto(UPDATE) y se muestra por pantalla los resultados
        WHEN v_elige=13 THEN
            UPDATE producto SET nombre='SEAT' WHERE cod_producto='DEP-001';
            SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_nuevo LIKE '%#SEAT#%';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
         --Caso con el que se ejecuta auditoriaProducto(DELETE) y se muestra por pantalla los resultados
        WHEN v_elige=14 THEN
            UPDATE detalle_venta SET cod_producto='DEP-002' WHERE cod_producto='DEP-001';
            UPDATE pedido SET cod_producto='DEP-002' WHERE cod_producto='DEP-001';
            DELETE producto WHERE cod_producto='DEP-001';
            SELECT * INTO c_auditoria FROM auditoria
                WHERE reg_viejo LIKE 'DEP-001#%';
            DBMS_OUTPUT.PUT_LINE('AuditoriaCliente');
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || c_auditoria.usuario);
            DBMS_OUTPUT.PUT_LINE('Tabla: ' || c_auditoria.tabla);
            DBMS_OUTPUT.PUT_LINE('Tipo: ' || c_auditoria.tipo);
            DBMS_OUTPUT.PUT_LINE('Fecha: ' || c_auditoria.fecha);
            DBMS_OUTPUT.PUT_LINE('Registro antiguo: ' || c_auditoria.reg_viejo);
            DBMS_OUTPUT.PUT_LINE('Registro nuevo: ' || c_auditoria.reg_nuevo);
        
        --Caso con el que se ejecuta editDetalle_venta(INSERT) y se muestra por pantalla los resultados
        WHEN v_elige=15 THEN
            INSERT INTO detalle_venta VALUES (1,'MON-001',1,2000);
        
        --Caso con el que se ejecuta editDetalle_venta(UPDATE) y se muestra por pantalla los resultados
        WHEN v_elige=16 THEN
            UPDATE detalle_venta SET total=total-2000 WHERE cod_producto='MON-001';
        
        --Caso con el que se ejecuta editDetalle_venta(DELETE) y se muestra por pantalla los resultados
        WHEN v_elige=17 THEN
            DELETE detalle_venta WHERE cod_producto='MON-001';
    END CASE;
END;
/

ROLLBACK;
