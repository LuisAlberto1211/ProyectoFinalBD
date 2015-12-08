DELETE FROM EMPLEADO CASCADE;
DELETE FROM EMPLEADO_EDITOR CASCADE;
DELETE FROM EMPLEADO_REVISOR CASCADE;
DELETE FROM ESCRITOR CASCADE;
DELETE FROM HISTORICO_STATUS_ARTICULO CASCADE;
DELETE FROM ARTICULO CASCADE;
DELETE FROM STATUS_ARTICULO CASCADE;
DELETE FROM AREA_INTERES CASCADE;
DELETE FROM SUSCRIPTOR CASCADE;
DELETE FROM DIRECCION CASCADE;

DROP SEQUENCE articulo_seq;
DROP SEQUENCE empleado_seq;
DROP SEQUENCE publicacion_seq;
DROP SEQUENCE suscriptor_seq;
DROP SEQUENCE escritor_seq;
DROP SEQUENCE historico_seq;
DROP SEQUENCE archivo_seq;
DROP SEQUENCE revisor_area_interes_seq;
DROP SEQUENCE escritor_articulo_seq;
DROP SEQUENCE publicacion_suscriptor_seq;
DROP SEQUENCE articulo_publicacion_seq;
