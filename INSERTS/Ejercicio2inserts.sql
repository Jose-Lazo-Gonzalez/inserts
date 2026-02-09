/*secuencias*/
CREATE SEQUENCE seq_campus START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_personal START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_alumno START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_prestamo START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_libro START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_camara START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_biblioteca START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_servicio START WITH 1 INCREMENT BY 1 NOCACHE;

/*campus*/
INSERT INTO CAMPUS VALUES (seq_campus.NEXTVAL, 'Campus Central', 'Ingenierías', 'Gran Via', 10, 'Madrid', 'Dr. García');
INSERT INTO CAMPUS VALUES (seq_campus.NEXTVAL, 'Campus Norte', 'Ciencias', 'Alcala', 25, 'Madrid', 'Dra. López');
INSERT INTO CAMPUS VALUES (seq_campus.NEXTVAL, 'Campus Sur', 'Humanidades', 'Av. Andalucía', 50, 'Sevilla', 'Dr. Pérez');

/*personal*/
INSERT INTO PERSONAL VALUES (seq_personal.NEXTVAL,'Juan','Pérez','López','12345678A','ES12345678901234567890','Santander',1);
INSERT INTO PERSONAL VALUES (seq_personal.NEXTVAL,'Ana','Gómez',NULL,'87654321B','ES98765432109876543210','BBVA',2);
INSERT INTO PERSONAL VALUES (seq_personal.NEXTVAL,'Carlos','Ruiz','Molina','33445566C','ES11223344556677889900','CaixaBank',1);

/*alumno*/
INSERT INTO ALUMNO VALUES (seq_alumno.NEXTVAL,'Luis','Martínez','Ruiz','11111111C','Calle Falsa',5,'Madrid',600111222,'luis@mail.com',20,'Grado Superior',1);
INSERT INTO ALUMNO VALUES (seq_alumno.NEXTVAL,'María','Sánchez',NULL,'22222222D','Calle Luna',12,'Madrid',600333444,'maria@mail.com',22,'Universidad',2);
INSERT INTO ALUMNO VALUES (seq_alumno.NEXTVAL,'Pedro','Lopez','García','33333333E','Av. Sol',8,'Sevilla',600555666,'pedro@mail.com',21,'Master',1);

/*prestamo, sysdate aprendidos en la documentacion referida en el ejercicio anterior con explicacion de gemini*/
INSERT INTO PRESTAMO VALUES (seq_prestamo.NEXTVAL,SYSDATE,ADD_MONTHS(SYSDATE,1),0,NULL,1);
INSERT INTO PRESTAMO VALUES (seq_prestamo.NEXTVAL,SYSDATE,ADD_MONTHS(SYSDATE,2),1,NULL,2);
INSERT INTO PRESTAMO VALUES (seq_prestamo.NEXTVAL,SYSDATE,ADD_MONTHS(SYSDATE,1),2,NULL,3);

/*libro*/
INSERT INTO LIBRO VALUES (seq_libro.NEXTVAL,'Programación Java','9781234567890','Didáctico','J. Doe','Nuevo',5,1);
INSERT INTO LIBRO VALUES (seq_libro.NEXTVAL,'Matemáticas Avanzadas','9780987654321','Narrativo','A. Smith','Bueno',3,2);

/*camara*/
INSERT INTO CAMARA VALUES (seq_camara.NEXTVAL,'Alpha 7','Sony','Nuevo','Lente 24-70mm',2,1);
INSERT INTO CAMARA VALUES (seq_camara.NEXTVAL,'EOS R6','Canon','Bueno','Kit completo',1,2);

/*biblioteca*/
INSERT INTO BIBLIOTECA VALUES (seq_biblioteca.NEXTVAL,'Biblioteca Central','Doña Fernández',200);
INSERT INTO BIBLIOTECA VALUES (seq_biblioteca.NEXTVAL,'Biblioteca Norte','Don Ruiz',150);

/*servicio tecnico*/
INSERT INTO SERVICIO_TECNICO VALUES (seq_servicio.NEXTVAL,'Servicio Principal','Inge López',10);

/*gestiona*/
INSERT INTO GESTIONA VALUES (1,1);
INSERT INTO GESTIONA VALUES (2,2);
INSERT INTO GESTIONA VALUES (3,3);

/*atiende*/
INSERT INTO ATIENDE VALUES (1,1);
INSERT INTO ATIENDE VALUES (2,2);
INSERT INTO ATIENDE VALUES (3,3);

/*esta (de camara)*/
INSERT INTO ESTA_CAMARA VALUES (1,1);
INSERT INTO ESTA_CAMARA VALUES (2,1);

/*esta (de libro)*/
INSERT INTO ESTA_LIBRO VALUES (1,1);
INSERT INTO ESTA_LIBRO VALUES (2,1);
