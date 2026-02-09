CREATE TABLE SEDE (/*Ejercicio 1 de prueba sencillo, preguntar dudas de checks, intervalos y restricciones de las pk el lunes*//*Ya preguntadas, corregir y hacer mas ejercicios*/
    codsede        NUMBER(14), PRIMARY KEY
    nombre         VARCHAR2(30) NOT NULL,
    calle          VARCHAR2(30) NOT NULL,
    numero         NUMBER(3) NOT NULL,
    telefono       NUMBER(9) NOT NULL,
    CONSTRAINT pk_SEDE PRIMARY KEY (CodSede)
);

CREATE TABLE DOCENTE (
    CodDocente  NUMBER(14), PRIMARY KEY,
    DNI         VARCHAR2(9) NOT NULL UNIQUE,
    NSS         VARCHAR2(15) NOT NULL UNIQUE,
    Nombre      VARCHAR2(30)NOT NULL,
    Ap1         VARCHAR2(30)NOT NULL,
    Ap2         VARCHAR2(30),
    Telefono    NUMBER(9)NOT NULL,
    CodSede     NUMBER(14),
    CONSTRAINT fk_DOCENTE_SEDE FOREIGN KEY (CodSede) REFERENCES SEDE (CodSede)
        
);
CREATE TABLE CICLO_FORMATIVO (
    CodCiclo     NUMBER(14)PRIMARY KEY,
    Nombre       VARCHAR2(30)NOT NULL,
    Curso        VARCHAR2(30)NOT NULL,
    Fecha_Inicio DATE,
    Fecha_Final  DATE,
    /*Duracion     INTERVAL YEAR(4) TO MONTH (2),*//*Omitir intervalos por ahora*/
    CodSede      NUMBER(14),
    CONSTRAINT ck_curso CHECK (Curso IN('Primero' OR 'Segundo')),
    CONSTRAINT pk_CICLO_FORMATIVO PRIMARY KEY (CodCiclo),
    CONSTRAINT fk_CICLO_SEDE FOREIGN KEY (CodSede) REFERENCES SEDE (CodSede)
        
);
CREATE TABLE MODULO (
    CodModulo   NUMBER(14) PRIMARY KEY,
    Nombre      VARCHAR2(30)NOT NULL,
    Ciclo       VARCHAR2(30)NOT NULL,
    Descripcion VARCHAR2(1000),
    Num_Horas   NUMBER(4)NOT NULL,
    CodDocente  NUMBER(14),
    CONSTRAINT pk_MODULO PRIMARY KEY (CodModulo),
    CONSTRAINT fk_MODULO_DOCENTE FOREIGN KEY (CodDocente) REFERENCES DOCENTE (CodDocente)       
);
CREATE TABLE CONTIENE (
    CodCiclo   NUMBER(6),
    CodModulo  NUMBER(6),
    CONSTRAINT pk_CONTIENE PRIMARY KEY (CodCiclo, CodModulo),
    CONSTRAINT fk_CONTIENE_CICLO FOREIGN KEY (CodCiclo) REFERENCES CICLO_FORMATIVO (CodCiclo),       
    CONSTRAINT fk_CONTIENE_MODULO FOREIGN KEY (CodModulo) REFERENCES MODULO (CodModulo)        
);
CREATE TABLE ESTUDIANTE (
    CodEstudiante NUMBER(6) PRIMARY KEY,
    Nombre        VARCHAR2(30) NOT NULL,
    Ap1           VARCHAR2(30) NOT NULL,
    Ap2           VARCHAR2(30),
    DNI           VARCHAR2(9) NOT NULL UNIQUE,
    CONSTRAINT pk_ESTUDIANTE PRIMARY KEY (CodEstudiante)
);
CREATE TABLE MATRICULA (
    CodMatricula    NUMBER(14) PRIMARY KEY,
    Curso           VARCHAR2(30) NOT NULL,
    Fecha_Matricula DATE,
    Observaciones   VARCHAR2(2000) NOT NULL,
    CodEstudiante   NUMBER(14),
    CodCiclo        NUMBER(14),
    CONSTRAINT pk_MATRICULA PRIMARY KEY (CodMatricula),
    CONSTRAINT fk_MATRICULA_ESTUDIANTE FOREIGN KEY (CodEstudiante)REFERENCES ESTUDIANTE (CodEstudiante),
    CONSTRAINT fk_MATRICULA_CICLO FOREIGN KEY (CodCiclo)REFERENCES CICLO_FORMATIVO (CodCiclo)
);

CREATE TABLE CURSA (
    CodEstudiante NUMBER(14),
    CodModulo     NUMBER(14),
    CONSTRAINT pk_CURSA PRIMARY KEY (CodEstudiante, CodModulo),
    CONSTRAINT fk_CURSA_ESTUDIANTE FOREIGN KEY (CodEstudiante) REFERENCES ESTUDIANTE (CodEstudiante),        
    CONSTRAINT fk_CURSA_MODULO FOREIGN KEY (CodModulo) REFERENCES MODULO (CodModulo)
);
CREATE TABLE ADHIERE (
    CodModulo    NUMBER(14),
    CodMatricula NUMBER(14),
    CONSTRAINT pk_ADHIERE PRIMARY KEY (CodModulo, CodMatricula),
    CONSTRAINT fk_ADHIERE_MODULO FOREIGN KEY (CodModulo) REFERENCES MODULO (CodModulo),
    CONSTRAINT fk_ADHIERE_MATRICULA FOREIGN KEY (CodMatricula) REFERENCES MATRICULA (CodMatricula)
);
CREATE TABLE NOTAS (
    CodMatricula  NUMBER(14),
    NumEvaluacion NUMBER(2),
    Nota          NUMBER(4,2),
    CONSTRAINT pk_NOTAS PRIMARY KEY (CodMatricula, NumEvaluacion),
    CONSTRAINT fk_NOTAS_MATRICULA FOREIGN KEY (CodMatricula) REFERENCES MATRICULA (CodMatricula)
);
CREATE TABLE DEPENDE (
    CodModulo         NUMBER(14),
    CodModulo_Depende NUMBER(6),
    CONSTRAINT pk_DEPENDE PRIMARY KEY (CodModulo, CodModulo_Depende),
    CONSTRAINT fk_DEPENDE_MODULO FOREIGN KEY (CodModulo)  REFERENCES MODULO (CodModulo),
    CONSTRAINT fk_DEPENDE_MODULO2 FOREIGN KEY (CodModulo_Depende) REFERENCES MODULO (CodModulo)
);



