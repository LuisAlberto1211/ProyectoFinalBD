--AGREGAR ESTATUS AL HISTORIAL CUANDO SE MODIFIQUE SU VALOR
CREATE OR REPLACE TRIGGER historico_status_trigger
AFTER UPDATE OR INSERT OF STATUS_ARTICULO_ID ON ARTICULO
FOR EACH ROW
DECLARE
  v_status_id     NUMBER(10,0);
  v_fecha_status  DATE;
  v_historico_id  NUMBER(10,0);
  v_articulo_id   NUMBER(10,0);
BEGIN
  SELECT historico_seq.NEXTVAL INTO v_historico_id FROM dual;

  v_status_id := :NEW.STATUS_ARTICULO_ID;
  v_fecha_status := :NEW.FECHA_STATUS;
  v_articulo_id := :NEW.ARTICULO_ID;

  DBMS_OUTPUT.PUT_LINE('STATUS ANTERIOR: ' || :OLD.STATUS_ARTICULO_ID);
  DBMS_OUTPUT.PUT_LINE('STATUS NUEVO: ' || :NEW.STATUS_ARTICULO_ID);

  INSERT INTO HISTORICO_STATUS_ARTICULO(
      HISTORICO_STATUS_ARTICULO_ID,
      ARTICULO_ID,
      STATUS_ARTICULO_ID,
      FECHA_STATUS)
    VALUES(
      v_historico_id,
      v_articulo_id,
      v_status_id,
      v_fecha_status
    );
END;

--Cambiar el STATUS de un articulo una vez que pasa a ser publicado
CREATE OR REPLACE TRIGGER articulo_publicado_trigger
BEFORE INSERT ON ARTICULO_PUBLICACION
FOR EACH ROW
DECLARE
  v_articulo_publicacion_id NUMBER(10,0);
  v_status_id               NUMBER(10,0);
  v_articulo_id             NUMBER(10,0);
  v_fecha_status            DATE;
BEGIN
  SELECT articulo_publicacion_seq.NEXTVAL INTO v_articulo_publicacion_id FROM dual;
  SELECT STATUS_ARTICULO_ID INTO v_status_id FROM STATUS_ARTICULO WHERE DESCRIPCION = 'PUBLICADO';

  v_fecha_status := sysdate;
  v_articulo_id := :NEW.ARTICULO_ID;

  DBMS_OUTPUT.PUT_LINE('ARTICULO: ' || :NEW.ARTICULO_ID || ' PUBLICADO');

  UPDATE ARTICULO SET FECHA_STATUS = v_fecha_status, STATUS_ARTICULO_ID = v_status_id WHERE ARTICULO_ID = v_articulo_id;

END;
