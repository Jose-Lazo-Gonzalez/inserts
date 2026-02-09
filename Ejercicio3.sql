CREATE TABLE EMPRESA (
    CodEmpresa            NUMBER(14) PRIMARY KEY,
    Nombre                VARCHAR2(30)NOT NULL,
    Identificador_Fiscal  VARCHAR2(30)UNIQUE,
    Telefono              NUMBER(9)NOT NULL,
    Num_Empleados         NUMBER(6),
    Tipo                  VARCHAR2(30),
    Tamaño                VARCHAR2(30)/*Nuevo atributo añadido al diseño*/
    CONSTRAINT ck_numempl CHECK (Num_Empleados > 0),
    CONSTRAINT ck_Tipo CHECK('Tipo' IN ('Autónomo', 'Sociedad limitada', 'Sociedad anonima', 'Cooperativa')),
    CONSTRAINT ck_Tamaño CHECK(Tamaño IN('Micro','Pequeña', 'Mediana', 'Grande'))/*Tres Checks implementados nuevos en el diseño pues me parecian interesantes*/
);
CREATE TABLE CORREOS (
    CodCorreo  NUMBER(14) PRIMARY KEY,
    Correo     VARCHAR2(100),
    CodEmpresa NUMBER(14),
    CONSTRAINT fk_CORREOS_EMPRESA FOREIGN KEY (CodEmpresa)REFERENCES EMPRESA (CodEmpresa)     
);
CREATE TABLE TELEFONOS (
    CodTelefono NUMBER(14) PRIMARY KEY,
    Telefono    NUMBER(9),
    CodEmpresa  NUMBER(14),
    CONSTRAINT fk_TELEFONOS_EMPRESA FOREIGN KEY (CodEmpresa)REFERENCES EMPRESA (CodEmpresa)
        
);
CREATE TABLE SEDE (
    CodSede    NUMBER(14) PRIMARY KEY,
    Nombre     VARCHAR2(30)NOT NULL,
    Calle      VARCHAR2(30)NOT NULL,
    Numero     NUMBER(3),
    Localidad  VARCHAR2(30)NOT NULL,
    Encargado  VARCHAR2(30),
    CodEmpresa NUMBER(14),
    CONSTRAINT fk_SEDE_EMPRESA FOREIGN KEY (CodEmpresa)REFERENCES EMPRESA (CodEmpresa)
        
);
CREATE TABLE DEPARTAMENTO (
    CodDepartamento NUMBER(14) PRIMARY KEY,
    Nombre          VARCHAR2(30)NOT NULL,
    Presupuesto     NUMBER(10,2),
    Encargado       VARCHAR2(50),
    CodSede         NUMBER(14),
    CONSTRAINT fk_DEPARTAMENTO_SEDE FOREIGN KEY (CodSede)REFERENCES SEDE (CodSede),
    CONSTRAINT ck_presupuesto CHECK (presupuesto > 0) /*Nuevo codificado*/
        
);
CREATE TABLE FUNCION (/*Nuevo multievaluado añadido al proyecto*/
    CodFuncion      VARCHAR2(14)
    Funcion         VARCHAR2(20),
    CodDepartamento NUMBER(14),
    CONSTRAINT pk_FUNCION PRIMARY KEY (CodFuncion, CodDepartamento),
    CONSTRAINT fk_FUNCION_DEPARTAMENTO FOREIGN KEY (CodDepartamento)REFERENCES DEPARTAMENTO (CodDepartamento),
);
CREATE TABLE EQUIPO (
    CodEquipo       NUMBER(14) PRIMARY KEY,
    Nombre          VARCHAR2(30),
    Tamano          NUMBER(4),
    Especializacion VARCHAR2(20),
    Jefe            VARCHAR2(30),
    CONSTRAINT ck_especializacion CHECK(Especializacion IN('Backend','Frontend', 'Data', 'Sistemas','Seguridad'))
);
CREATE TABLE PROGRAMADOR (
    CodProgramador      NUMBER(14) PRIMARY KEY,
    Nombre              VARCHAR2(30)NOT NULL,
    Ap1                 VARCHAR2(30)NOT NULL,
    Ap2                 VARCHAR2(30),
    Correo              VARCHAR2(30)NOT NULL,
    Telefono            NUMBER(9)NOT NULL,
    Fecha_Contratacion  DATE,
    Fecha_Fin_Contrato  DATE,
    /*he omitido de nuevo la columna de duracion*/
    DNI                 VARCHAR2(9)UNIQUE NOT NULL,
    Rol                 VARCHAR2(30),
    CodDepartamento     NUMBER(14),
    CONSTRAINT ck_rol CHECK(Rol IN('Desarrollador','Analista','Ciberseguridad','Tecnico'))/*Nuevo check añadido al proyecto*/
    CONSTRAINT fk_PROGRAMADOR_DEPARTAMENTO FOREIGN KEY (CodDepartamento)REFERENCES DEPARTAMENTO (CodDepartamento)
        
);
CREATE TABLE SENIOR (
    CodProgramador     NUMBER(14)PRIMARY KEY,
    Anos_Senior        NUMBER(2)NOT NULL,
    Experiencia_Previa VARCHAR2(100),
    Calidad            VARCHAR2(30)NOT NULL,
    CONSTRAINT ck_calidad CHECK(Calidad IN('Baja','Media','Alta'))
    CONSTRAINT fk_SENIOR_PROGRAMADOR FOREIGN KEY (CodProgramador)REFERENCES PROGRAMADOR (CodProgramador)
        
);
CREATE TABLE JUNIOR (
    CodProgramador NUMBER(14) PRIMARY KEY,
    Anos_Junior    NUMBER(2)NOT NULL,
    Calidad        VARCHAR2(30)NOT NULL,
    CodSenior      NUMBER(14),
    CONSTRAINT ck_calidad CHECK(Calidad IN('Baja','Media','Alta'))
    CONSTRAINT fk_JUNIOR_PROGRAMADOR FOREIGN KEY (CodProgramador) REFERENCES PROGRAMADOR (CodProgramador), 
    CONSTRAINT fk_JUNIOR_SENIOR FOREIGN KEY (CodSenior)REFERENCES SENIOR (CodProgramador)
);
CREATE TABLE LENGUAJES_JUNIOR (
    CodProgramador NUMBER(14),
    Lenguaje       VARCHAR2(30),
    CONSTRAINT pk_LENGUAJES_JUNIOR PRIMARY KEY (CodProgramador, Lenguaje),
    CONSTRAINT fk_LENGUAJES_JUNIOR_JUNIOR FOREIGN KEY (CodProgramador)REFERENCES JUNIOR (CodProgramador)  /*he eliminado un check del diseño pues me parece que tiene poco sentido al verlo en el diseño fisico, estaba tanto en este como en el de junior */
);
CREATE TABLE LENGUAJES_SENIOR (
    CodProgramador NUMBER(14),
    Lenguaje       VARCHAR2(30),
    CONSTRAINT pk_LENGUAJES_SENIOR PRIMARY KEY (CodProgramador, Lenguaje),
    CONSTRAINT fk_LENGUAJES_SENIOR_SENIOR FOREIGN KEY (CodProgramador)REFERENCES SENIOR (CodProgramador)
);
CREATE TABLE PROYECTO (
    CodProyecto        NUMBER(14)PRIMARY KEY,
    Nombre             VARCHAR2(30)NOT NULL,
    Descripcion        VARCHAR2(200),
    Fecha_Inicio       DATE,
    Fecha_Fin          DATE,
    /*OTRA DURACION OMITIDA*/
    Estado             VARCHAR2(30),
    CodProyecto_Padre  NUMBER(14),
    CONSTRAINT ck_estado CHECK(Estado IN('Inicio','Mitad','Finalizando','Terminado'))/*Nuevo check añadido al proyecto*/
    CONSTRAINT fk_PROYECTO_PADRE FOREIGN KEY (CodProyecto_Padre) REFERENCES PROYECTO (CodProyecto)
       
);
CREATE TABLE DESARROLLA (
    CodProyecto NUMBER(14),
    CodEquipo   NUMBER(14),
    CONSTRAINT pk_DESARROLLA PRIMARY KEY (CodProyecto, CodEquipo),
    CONSTRAINT fk_DESARROLLA_PROYECTO FOREIGN KEY (CodProyecto)REFERENCES PROYECTO (CodProyecto),        
    CONSTRAINT fk_DESARROLLA_EQUIPO FOREIGN KEY (CodEquipo)REFERENCES EQUIPO (CodEquipo)        
);
CREATE TABLE COOPERAN (
    CodProgramador1 NUMBER(14),
    CodProgramador2 NUMBER(14),
    CONSTRAINT pk_COOPERAN PRIMARY KEY (CodProgramador1, CodProgramador2),
    CONSTRAINT fk_COOPERAN_PROG1 FOREIGN KEY (CodProgramador1)REFERENCES PROGRAMADOR (CodProgramador),
    CONSTRAINT fk_COOPERAN_PROG2 FOREIGN KEY (CodProgramador2)REFERENCES PROGRAMADOR (CodProgramador)        
);
/*Bastantes codificados y atributos añadidos al diseño, creo que en este ejercicio he mejorado bastante, hare los demas para practicar cuando tenga algo mas de tiempo*/