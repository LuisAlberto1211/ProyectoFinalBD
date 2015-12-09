--Consulta 1
--Todos los articulos que hayan sido recibido antes de marzo del 2015
--y el articulo tenga como area de interes bases de datos tenga
SELECT a.articulo_id, a.titulo, a.sinopsis, a.folio, a.area_interes_id, e.nombre, e.apellido_paterno, e.apellido_materno, e.email
FROM articulo a
JOIN escritor_articulo ea ON a.articulo_id = ea.articulo_id
JOIN escritor e ON ea.escritor_id = e.escritor_id
WHERE a.fecha_status <= TO_DATE('01/03/2015','DD/MM/YYYY')
AND a.status_articulo_id = (SELECT sa.status_articulo_id FROM status_articulo sa WHERE sa.descripcion = 'RECIBIDO');

--Consulta 2
--Consulta que muestra por categoria el el articulo que tiene mayor calificacion
SELECT a.articulo_id, a.titulo, a.sinopsis, a.folio, a.calificacion, ai.nombre
FROM articulo a
JOIN area_interes ai ON a.area_interes_id = ai.area_interes_id
JOIN
(SELECT a1.area_interes_id AS area_id, MAX(a1.calificacion) AS calificacion
FROM articulo a1
GROUP BY a1.area_interes_id ) q1
ON a.calificacion = q1.calificacion
WHERE a.area_interes_id = q1.area_id;

--Consulta 3
--Consulta que muestra los datos de las publicaciones en las que aparece un
--articulo revisado por XYZ que vendieron más de 1100
SELECT p.publicacion_id, p.titulo, p.bimestre, p.anio, p.vendidos
FROM publicacion p
JOIN articulo_publicacion ap ON p.publicacion_id = ap.publicacion_id
JOIN articulo a ON ap.articulo_id = a.articulo_id
JOIN empleado_revisor er ON er.empleado_id = a.revisor_id;
JOIN empleado e ON er.empleado_id = e.empleado_id
WHERE e.nombre='Wanda' AND e.apellido_paterno ='Workman' AND e.apellido_materno ='Travis'
MINUS
SELECT p.publicacion_id, p.titulo, p.bimestre, p.anio, p.vendidos
FROM publicacion p
JOIN articulo_publicacion ap ON p.publicacion_id = ap.publicacion_id
JOIN articulo a ON ap.articulo_id = a.articulo_id
JOIN empleado_revisor er ON er.empleado_id = a.revisor_id;
JOIN empleado e ON er.empleado_id = e.empleado_id
WHERE e.nombre='Wanda' AND e.apellido_paterno ='Workman' AND e.apellido_materno ='Travis'
AND p.vendidos < 1100;
