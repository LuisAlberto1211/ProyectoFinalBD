--Procedimiento que imprime en consola la informacion referente a sus articulos de un autor
CREATE OR REPLACE PROCEDURE consultaArticulos(
v_escritor_id IN NUMBER) AS
  CURSOR cur_datos_escritor IS
  SELECT ea.articulo_id, a.titulo, a.folio, a.calificacion,
  ai.nombre
  FROM escritor_articulo ea
  JOIN articulo a ON ea.articulo_id = a.articulo_id
  JOIN area_interes ai ON a.area_interes_id = ai.area_interes_id
  WHERE ea.escritor_id = v_escritor_id;
  --Variables
  v_id articulo.articulo_id%TYPE;
  v_titulo articulo.titulo%TYPE;
  v_folio articulo.folio%TYPE;
  v_calificacion  articulo.calificacion%TYPE;
  v_nombreArea  area_interes.nombre%TYPE;
  --Escritor
  v_nombreEsc escritor.nombre%TYPE;
  v_apellido_paterno escritor.apellido_paterno%TYPE;
  v_apellido_materno escritor.apellido_materno%TYPE;
BEGIN
  OPEN cur_datos_escritor;
  SELECT nombre, apellido_paterno, apellido_materno
  INTO v_nombreEsc, v_apellido_paterno, v_apellido_materno
  FROM escritor
  WHERE escritor_id = v_escritor_id;
  dbms_output.put_line('Articulos del Escritor: '||v_nombreEsc||' '||v_apellido_paterno||' '|| v_apellido_paterno);
  dbms_output.put_line('ID Titulo Folio Calificacion Area Interes');
  LOOP
    FETCH cur_datos_escritor INTO v_id, v_titulo, v_folio, v_calificacion, v_nombreArea;
    EXIT WHEN cur_datos_escritor%NOTFOUND;
    dbms_output.put_line(v_id ||' '|| v_titulo ||' '|| v_folio|| ' ' || v_calificacion || ' ' || v_nombreArea );
  END LOOP;
  CLOSE cur_datos_escritor;
END;
