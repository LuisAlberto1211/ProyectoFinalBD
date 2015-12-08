--AGREGAR ESTATUS AL HISTORIAL CUANDO SE MODIFIQUE SU VALOR
CREATE OR REPLACE TRIGGER historico_status_trigger
AFTER UPDATE OF STATUS_ARTICULO_ID ON ARTICULO
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
