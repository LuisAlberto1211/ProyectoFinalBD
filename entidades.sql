--TABLA EMPLEADO
CREATE TABLE EMPLEADO (
  EMPLEADO_ID       NUMBER(10,0) CONSTRAINT EMPLEADO_ID_PK PRIMARY KEY,
  NOMBRE            VARCHAR2(80) NOT NULL,
  APELLIDO_PATERNO  VARCHAR2(80) NOT NULL,
  APELLIDO_MATERNO  VARCHAR2(80) NOT NULL,
  EMAIL             VARCHAR2(80) NULL,
  FECHA_INGRESO     DATE NOT NULL,
  TIPO_EDITOR       INT NOT NULL,
  TIPO_REVISOR      INT NOT NULL
);

--TABLA SUBTIPO REVISOR
CREATE TABLE EMPLEADO_REVISOR(
  EMPLEADO_ID   NUMBER(10,0) NOT NULL CONSTRAINT REVISOR_ID_FK REFERENCES EMPLEADO(EMPLEADO_ID),
  CONTRATO      NUMBER(10,0) NOT NULL CONSTRAINT REVISOR_CONTRATO_UNIQUE UNIQUE, --?
  FECHA_FIN     DATE NOT NULL,
  CONSTRAINT REVISOR_ID_PK PRIMARY KEY (EMPLEADO_ID)
);

--TABLA SUBTIPO EDITOR
CREATE TABLE EMPLEADO_EDITOR(
  EMPLEADO_ID   NUMBER(10,0) NOT NULL CONSTRAINT EDITOR_ID_FK REFERENCES EMPLEADO(EMPLEADO_ID),
  CEDULA        VARCHAR2(20) NOT NULL CONSTRAINT EDITOR_CEDULA_UNIQUE UNIQUE,
  NOMBRE_GRADO  VARCHAR2(60) NOT NULL,
  CONSTRAINT EDITOR_ID_PK PRIMARY KEY (EMPLEADO_ID)
);

--TABLA AREA DE INTERES
CREATE TABLE AREA_INTERES(
  AREA_INTERES_ID NUMBER(4,0) CONSTRAINT AREA_INTERES_ID_PK PRIMARY KEY,
  NOMBRE          VARCHAR2(60) NOT NULL,
  CLAVE           VARCHAR2(60) NOT NULL CONSTRAINT AREA_INTERES_CLAVE_UNIQUE UNIQUE
);


--TABLA EDITOR_AREA
CREATE TABLE REVISOR_AREA_INTERES(
  REVISOR_AREA_INTERES_ID  NUMBER(10,0) CONSTRAINT REVISOR_AREA_INTERES_ID_PK PRIMARY KEY,
  EMPLEADO_ID             NUMBER(10,0) NOT NULL,
  AREA_INTERES_ID         NUMBER(10,0) NOT NULL,
  EXPERIENCIA             NUMBER(4,0) NOT NULL,
  CONSTRAINT EDITOR_INTERES_EMP_ID_FK FOREIGN KEY (EMPLEADO_ID) REFERENCES EMPLEADO_REVISOR(EMPLEADO_ID),
  CONSTRAINT EDITOR_INTERES_AREA_ID_FK FOREIGN KEY (AREA_INTERES_ID) REFERENCES AREA_INTERES(AREA_INTERES_ID)
);

--TABLA ESCRITOR
CREATE TABLE ESCRITOR(
  ESCRITOR_ID         NUMBER(10,0) CONSTRAINT ESCRITOR_ID_PK PRIMARY KEY,
  NOMBRE              VARCHAR2(80) NOT NULL,
  APELLIDO_PATERNO    VARCHAR2(80) NOT NULL,
  APELLIDO_MATERNO    VARCHAR2(80) NOT NULL,
  OCUPACION           VARCHAR2(80) NOT NULL,
  EMAIL               VARCHAR2(80) NULL,
  EMPRESA_ESCUELA     VARCHAR2(80) NULL
);

--TABLA STATUS_ARTICULO
CREATE TABLE STATUS_ARTICULO(
  STATUS_ARTICULO_ID  NUMBER(10,0) CONSTRAINT STATUS_ID_PK PRIMARY KEY,
  CLAVE               VARCHAR2(20) NOT NULL CONSTRAINT STATUS_ARTICULO_CLAVE_UK UNIQUE,
  DESCRIPCION         VARCHAR2(180) NOT NULL,
  ACTIVO              NUMBER(1,0) DEFAULT 1 NOT NULL,
  CONSTRAINT STATUS_ARTICULO_ACTIVO_CHK CHECK (ACTIVO IN (0,1))
);

--TABLA ARTICULO
CREATE TABLE ARTICULO(
  ARTICULO_ID         NUMBER(10,0) CONSTRAINT ARTICULO_ID_PK PRIMARY KEY,
  TITULO              VARCHAR2(120) NOT NULL,
  SINOPSIS            VARCHAR2(240) NOT NULL,
  FOLIO               VARCHAR2(18)  NOT NULL,
  FECHA_STATUS        DATE NOT NULL,
  CALIFICACION        NUMBER(3,1) CONSTRAINT ARTICULO_CALIFICACION_CHECK CHECK (CALIFICACION BETWEEN 0.0 AND 10.0),
  AREA_INTERES_ID     NUMBER(10,0) NOT NULL CONSTRAINT ARTICULO_AREA_INTERES_ID_FK REFERENCES AREA_INTERES(AREA_INTERES_ID),
  STATUS_ARTICULO_ID  NUMBER(10,0) NOT NULL CONSTRAINT ARTICULO_STATUS_ID_FK REFERENCES STATUS_ARTICULO(STATUS_ARTICULO_ID),
  REVISOR_ID          NUMBER(10,0) CONSTRAINT ARTICULO_REVISOR_ID_FK REFERENCES EMPLEADO_REVISOR(EMPLEADO_ID),
  EDITOR_ID           NUMBER(10,0) CONSTRAINT ARTICULO_EDITOR_ID_FK REFERENCES EMPLEADO_EDITOR(EMPLEADO_ID)
);

--TABLA HISTORICO_ARTICULO
CREATE TABLE HISTORICO_STATUS_ARTICULO(
  HISTORICO_STATUS_ARTICULO_ID  NUMBER(10,0) CONSTRAINT HISTORICO_ARTICULO_ID_PK PRIMARY KEY,
  ARTICULO_ID                   NUMBER(10,0) NOT NULL CONSTRAINT HISTORICO_STATUS_ART_ART_ID_FK REFERENCES ARTICULO(ARTICULO_ID),
  STATUS_ARTICULO_ID            NUMBER(10,0) NOT NULL CONSTRAINT HISTORICO_STATUS_ART_ST_ID_FK REFERENCES STATUS_ARTICULO(STATUS_ARTICULO_ID),
  FECHA_STATUS                  DATE NOT NULL
);

--TABLA ARCHIVO
CREATE TABLE ARCHIVO(
  ARCHIVO_ID    NUMBER(10,0) CONSTRAINT ARCHIVO_ID_PK PRIMARY KEY,
  CLAVE         VARCHAR2(2) NOT NULL,
  ARTICULO_ID   NUMBER(10,0) NOT NULL CONSTRAINT ARCHIVO_ARTICULO_ID_FK REFERENCES ARTICULO(ARTICULO_ID)
  ARCHIVO_PDF   BLOB NOT NULL
);


--TABLA ESCRITOR_ARTICULO
CREATE TABLE ESCRITOR_ARTICULO(
  ESCRITOR_ARTICULO_ID  NUMBER(10,0) CONSTRAINT ESCRITOR_ARTICULO_ID_PK PRIMARY KEY,
  ARTICULO_ID           NUMBER(10,0) NOT NULL CONSTRAINT ESCRITOR_ARTICULO_ART_ID_FK REFERENCES ARTICULO(ARTICULO_ID),
  ESCRITOR_ID           NUMBER(10,0) NOT NULL CONSTRAINT ESCRITOR_ARTICULO_ESC_ID_FK REFERENCES ESCRITOR(ESCRITOR_ID)
);

--TABLA SUSCRIPTOR
CREATE TABLE SUSCRIPTOR(
  SUSCRIPTOR_ID             NUMBER(10,0) CONSTRAINT SUSCRIPTOR_ID_PK PRIMARY KEY,
  NOMBRE                    VARCHAR2(80) NOT NULL,
  APELLIDO_PATERNO          VARCHAR2(80) NOT NULL,
  APELLIDO_MATERNO          VARCHAR2(80) NOT NULL,
  EMAIL                     VARCHAR2(80) NOT NULL,
  FECHA_INICIO_SUSCRIPCION  DATE NOT NULL DEFAULT sysdate,
  FECHA_FIN_SUSCRIPCION     DATE NOT NULL,
  VIGENCIA_MESES AS ( MONTHS_BETWEEN(FECHA_FIN_SUSCRIPCION, FECHA_INICIO_SUSCRIPCION) ) AS VIRTUAL
);

--TABLA DIRECCION
CREATE TABLE DIRECCION(
  SUSCRIPTOR_ID   NUMBER(10,0) NOT NULL CONSTRAINT DIRECCION_SUSCRIPTOR_ID_FK REFERENCES SUSCRIPTOR(SUSCRIPTOR_ID),
  CALLE           VARCHAR2(80) NOT NULL,
  NUMERO          NUMBER(6,0) NOT NULL,
  COLONIA         VARCHAR2(80) NOT NULL,
  CP              NUMBER(5,0) NOT NULL,
  DELEGACION_MUN  VARCHAR2(80) NOT NULL,
  ESTADO          VARCHAR2(80) NOT NULL,
  CONSTRAINT DIRECCION_SUSCRIPTOR_ID_PK PRIMARY KEY (SUSCRIPTOR_ID)
);

--TABLA PUBLICACION
CREATE TABLE PUBLICACION(
  PUBLICACION_ID  NUMBER(10,0) CONSTRAINT PUBLICACION_ID_PK PRIMARY KEY,
  TITULO          VARCHAR2(110) NOT NULL,
  FECHA           DATE NOT NULL DEFAULT sysdate,
  BIMESTRE        NUMBER(1,0) NOT NULL CONSTRAINT PUBLICACION_BIMESTRE_CHECK CHECK (BIMESTRE BETWEEN 1 AND 6),
  GENERADOS       NUMBER(10,0) NOT NULL,
  VENDIDOS        NUMBER(10,0) NOT NULL,
  ANIO            AS ( TO_NUMBER(FECHA, 'YYYY') ),
  RESTANTES AS (GENERADOS - VENDIDOS) VIRTUAL
);

--TABLA PUBLICACION_SUSCRIPTOR
CREATE TABLE PUBLICACION_SUSCRIPTOR(
  PUBLICACION_SUSCRIPTOR_ID NUMBER(10,0) CONSTRAINT PUBLICACION_SUSCRIPTOR_ID_PK PRIMARY KEY,
  PUBLICACION_ID            NUMBER(10,0) NOT NULL CONSTRAINT PUBLICACION_SUS_PUB_ID_FK REFERENCES PUBLICACION(PUBLICACION_ID),
  SUSCRIPTOR_ID             NUMBER(10,0) NOT NULL CONSTRAINT PUBLICACION_SUS_SUS_ID_FK REFERENCES SUSCRIPTOR(SUSCRIPTOR_ID),
  FECHA                     DATE NOT NULL
);

--TABLA ARTICULO_PUBLICACION
CREATE TABLE ARTICULO_PUBLICACION (
  ARTICULO_PUBLICACION_ID NUMBER(10,0) CONSTRAINT ARTICULO_PUBLICACION_ID_PK PRIMARY KEY,
  ARTICULO_ID             NUMBER(10,0) NOT NULL CONSTRAINT ARTICULO_PUBLICACION_ART_ID_FK REFERENCES ARTICULO(ARTICULO_ID),
  PUBLICACION_ID          NUMBER(10,0) NOT NULL CONSTRAINT ARTICULO_PUBLICACION_PUB_ID_FK REFERENCES PUBLICACION(PUBLICACION_ID),
  PAGINA                  NUMBER(4,0) NOT NULL
);

CREATE GLOBAL TEMPORARY TABLE TABLA_TEMPORAL_ARTICULOS(
  ARTICULO_ID     NUMBER(10,0);
  NOMBRE_ESCRITOR VARCHAR2(80);
  EMAIL           VARCHAR2(80);
  AREA_INTERES_ID NUMBER(10,0);
)ON COMMIT DELETE ROWS;
