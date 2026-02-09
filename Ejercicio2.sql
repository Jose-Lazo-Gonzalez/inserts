CREATE TABLE CAMPUS (
    CodCampus NUMBER(14) PRIMARY KEY,
    Nombre    VARCHAR2(30) NOT NULL,
    Nombre_Facultades VARCHAR2(30),
    Calle     VARCHAR2(40)NOT NULL,
    Numero    NUMBER(3),
    Localidad VARCHAR2(30)NOT NULL,
    Director  VARCHAR2(30)
    );

CREATE TABLE PRESTAMO (
    CodPrestamo    NUMBER(14) PRIMARY KEY,
    Fecha_Inicio   DATE,
    Fecha_Fin      DATE,
    /*AQUI IRIA DURACION PERO POR RECOMENDACION DEL PROFESOR LO HE DEJADO PARA MAS ADELANTE CUANDO IMPLEMENTEMOS LA LOGICA, NO LO HE CAMBIADO EN EL MODELO LOGICO DE MOMENTO PERO ESTA MARCADO*/
    Num_Avisos     NUMBER(2),
    Fecha_Bloqueo  DATE,
    CodAlumno      NUMBER(14),
    CONSTRAINT fk_PRESTAMO_ALUMNO FOREIGN KEY (CodAlumno)REFERENCES ALUMNO (CodAlumno)
);

CREATE TABLE PERSONAL (
    CodPersonal  NUMBER(14) PRIMARY KEY,
    Nombre       VARCHAR2(30) NOT NULL ,
    Ap1          VARCHAR2(30) NOT NULL,
    Ap2          VARCHAR2(30),
    DNI          VARCHAR2(9)UNIQUE NOT NULL,
    Numero_Banco VARCHAR2(30)NOT NULL,
    Banco        VARCHAR2(30),
    CodCampus    NUMBER(14),
    CONSTRAINT fk_PERSONAL_CAMPUS FOREIGN KEY (CodCampus) REFERENCES CAMPUS (CodCampus)
);

CREATE TABLE LIBRO (
    CodLibro       NUMBER(14) PRIMARY KEY,
    Nombre_Libro   VARCHAR2(30)NOT NULL,
    Identificador  VARCHAR2(13),
    Genero         VARCHAR2(30),
    Autor          VARCHAR2(30),
    Estado         VARCHAR2(30),
    Existencias    NUMBER(4),
    CodPrestamo    NUMBER(14),
    CONSTRAINT ck_genero CHECK (Genero IN('Narrativo','Lírico', 'Dramático', 'Didáctico')),
    CONSTRAINT ck_estado CHECK (Estado IN('Mal estado','Regular', 'Bueno', 'Nuevo')),
    CONSTRAINT fk_LIBRO_PRESTAMO FOREIGN KEY (CodPrestamo)REFERENCES PRESTAMO (CodPrestamo)
);

CREATE TABLE CAMARA (
    CodCamara    NUMBER(14) PRIMARY KEY,
    Modelo       VARCHAR2(30) NOT NULL,
    Marca        VARCHAR2(30) NOT NULL,
    Estado       VARCHAR2(30)NOT NULL,
    Accesorios   VARCHAR2(100),
    Existencias  NUMBER(4),
    CodPrestamo  NUMBER(14),
    CONSTRAINT ck_estado CHECK (Estado IN('Mal estado','Regular', 'Bueno', 'Nuevo')),
    CONSTRAINT fk_CAMARA_PRESTAMO FOREIGN KEY (CodPrestamo)REFERENCES PRESTAMO (CodPrestamo)
);

CREATE TABLE ALUMNO (/*Cambio total en el diseño tras repasarlo, lo antiguo es lo comentado*/
    CodAlumno      NUMBER(14) PRIMARY KEY,
    Nombre         VARCHAR2(30) NOT NULL,
    Ap1            VARCHAR2(30) NOT NULL,
    Ap2            VARCHAR2(30),
    DNI            VARCHAR2(9)UNIQUE NOT NULL,
    Calle          VARCHAR2(50),
    Numero         VARCHAR2(10),
    Localidad      VARCHAR2(50),
    Telefono       NUMBER(9)NOT NULL,
    Correo         VARCHAR2(50)NOT NULL,
    Edad           NUMBER(3)NOT NULL,
    Estudia_ahora  VARCHAR2(20)NOT NULL,      
    /*Grado_Superior VARCHAR2(50),
    Universidad    VARCHAR2(50),
    Master_         VARCHAR2(50),
    CodCampus      NUMBER(14),*/
    CONSTRAINT ck_estudia_ahora CHECK (Estudia_ahora IN('Grado Superior','Universidad', 'Master'))
    CONSTRAINT fk_ALUMNO_CAMPUS FOREIGN KEY (CodCampus)REFERENCES CAMPUS (CodCampus)
);

CREATE TABLE ESTUDIOS_OFERTADOS (
    CodEstudios NUMBER(14) PRIMARY KEY,
    CodCampus   NUMBER(14),
    CONSTRAINT fk_ESTUDIOS_CAMPUS FOREIGN KEY (CodCampus)REFERENCES CAMPUS (CodCampus)
);

CREATE TABLE BIBLIOTECA (
    CodBiblioteca  NUMBER(14) PRIMARY KEY,
    Nombre         VARCHAR2(30),
    Encargado     VARCHAR2(30),/*ERROR EN EL MODELO LOGICO, YA CAMBIADO*/
    Cantidad_Libros NUMBER(5),
);

CREATE TABLE GESTIONA (
    CodPersonal  NUMBER(14),
    CodPrestamo  NUMBER(14),
    CONSTRAINT pk_GESTIONA PRIMARY KEY (CodPersonal, CodPrestamo),
    CONSTRAINT fk_GESTIONA_PERSONAL FOREIGN KEY (CodPersonal)REFERENCES PERSONAL (CodPersonal),
    CONSTRAINT fk_GESTIONA_PRESTAMO FOREIGN KEY (CodPrestamo)REFERENCES PRESTAMO (CodPrestamo)
);

CREATE TABLE SEDE (
    CodSede        NUMBER(14) PRIMARY KEY,
    Nombre         VARCHAR2(30) NOT NULL,
    Calle          VARCHAR2(30)NOT NULL,
    Numero         NUMBER(3),
    Localidad      VARCHAR2(50)NOT NULL,
    Encargado      VARCHAR2(30),
    CodServicio    NUMBER(14),
    CodBiblioteca  NUMBER(14),
    CONSTRAINT fk_SEDE_SERVICIO FOREIGN KEY (CodServicio)REFERENCES SERVICIO_TECNICO (CodServicio),
    CONSTRAINT fk_SEDE_BIBLIOTECA FOREIGN KEY (CodBiblioteca)REFERENCES BIBLIOTECA (CodBiblioteca)
);

CREATE TABLE ATIENDE (
    CodPersonal NUMBER(14),
    CodAlumno   NUMBER(14),
    CONSTRAINT pk_ATIENDE PRIMARY KEY (CodPersonal, CodAlumno),
    CONSTRAINT fk_ATIENDE_PERSONAL FOREIGN KEY (CodPersonal)REFERENCES PERSONAL (CodPersonal),
    CONSTRAINT fk_ATIENDE_ALUMNO FOREIGN KEY (CodAlumno)REFERENCES ALUMNO (CodAlumno)
);

CREATE TABLE SERVICIO_TECNICO (
    CodServicio     NUMBER(14) PRIMARY KEY,
    Nombre          VARCHAR2(50) NOT NULL,
    Encargado       VARCHAR2(50),
    Cantidad_Camaras NUMBER(4)
);

CREATE TABLE ESTA_CAMARA (
    CodCamara   NUMBER(14),
    CodServicio NUMBER(14),
    CONSTRAINT pk_ESTA_CAMARA PRIMARY KEY (CodCamara, CodServicio),
    CONSTRAINT fk_ESTA_CAMARA_CAMARA FOREIGN KEY (CodCamara)REFERENCES CAMARA (CodCamara),        
    CONSTRAINT fk_ESTA_CAMARA_SERVICIO FOREIGN KEY (CodServicio)REFERENCES SERVICIO_TECNICO (CodServicio)        
);

CREATE TABLE ESTA_LIBRO (
    CodLibro      NUMBER(14),
    CodBiblioteca NUMBER(14),
    CONSTRAINT pk_ESTA_LIBRO PRIMARY KEY (CodLibro, CodBiblioteca),
    CONSTRAINT fk_ESTA_LIBRO_LIBRO FOREIGN KEY (CodLibro)REFERENCES LIBRO (CodLibro),
    CONSTRAINT fk_ESTA_LIBRO_BIBLIOTECA FOREIGN KEY (CodBiblioteca)REFERENCES BIBLIOTECA (CodBiblioteca)
);
/*He implementado algun atributo y algun codificado mas, nada con demasiada importancia a parte del cambio comentado anteriormente, nose muy bien que mas puedo añadir o mejorarlo*/