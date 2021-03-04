/*=============Ejercicio 1============*/

/*BORRADO DE TABLAS ANTERIORES*/

drop TABLE Entregan
drop TABLE Materiales
drop TABLE Proyectos
drop TABLE Proveedores


/*Creacion de tablas con llaves primarias*/

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Materiales')
	DROP TABLE Materiales

CREATE TABLE Materiales
(
  Clave numeric(5) not null,
  Descripcion varchar(50),
  Costo numeric (8,2)
)

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proveedores')
	DROP TABLE Proveedores

CREATE TABLE Proveedores
(
  RFC char(13) not null,
  RazonSocial varchar(50)
)
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proyectos')
	DROP TABLE Proyectos

CREATE TABLE Proyectos
(
  Numero numeric(5) not null,
  Denominacion varchar(50)
)
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Entregan')
	DROP TABLE Entregan

CREATE TABLE Entregan
(
  Clave numeric(5) not null,
  RFC char(13) not null,
  Numero numeric(5) not null,
  Fecha DateTime not null,
  Cantidad numeric (8,2)
)


/*Carga de archivos a la base de datos*/

BULK INSERT a1705998.a1705998.[Materiales]
   FROM 'e:\wwwroot\rcortese\materiales.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )


BULK INSERT a1705998.a1705998.[Proveedores]
   FROM 'e:\wwwroot\rcortese\proveedores.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )


BULK INSERT a1705998.a1705998.[Proyectos]
   FROM 'e:\wwwroot\rcortese\proyectos.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )

SET DATEFORMAT dmy/*se indica el formato de la fecha utilizada*/

BULK INSERT a1705998.a1705998.[Entregan]
   FROM 'e:\wwwroot\rcortese\entregan.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )

/*=============Ejercicio 2============*/

INSERT INTO Materiales values(1000, 'xxx', 1000)
SELECT * FROM Materiales

/* Pregunta
1 Revisa el contenido de la tabla materiales y determina si existe alguna inconsistencia en el contenido de la tabla. ¿Cuál es? ¿A qué se debe?
El error es que ya existe un registro con esta llave, por lo que se estan repitiendo las llaves y esto no debe pasar
*/

Delete from Materiales where Clave = 1000 and Costo = 1000 /*Se borra el error*/

/*Agregar llave foranea*/
ALTER TABLE Materiales add constraint llaveMateriales PRIMARY KEY (Clave) 
ALTER TABLE Proveedores add constraint llaveProveedores PRIMARY KEY (RFC)
ALTER TABLE Proyectos add constraint llaveProyectos PRIMARY KEY (Numero)
ALTER TABLE Entregan add constraint llaveEntregan PRIMARY KEY (Clave, RFC, Numero, Fecha)

INSERT INTO Materiales values(1000, 'xxx', 1000) /*Se inserta una llave repetida*/

sp_helpconstraint materiales

/* Pregunta
1 ¿Qué ocurrió?
No permite ingresar el dato ya que ya existe una clave con este valor

2 Verifica si la tabla de materiales tiene definido algún constraint (restricción):
llaveMateriales es una llave foranea, por lo cual no se puede repetir el valor

3 ¿Qué información muestra esta consulta?
Muestra que atrubuto es llave primaria

4 ¿Qué sentencias utilizaste para definir las llaves primarias?
PRIMARY KEY

5 ¿Qué sentencias utilizaste para definir este constrait?
ALTER TABLE
*/

/*=============Ejercicio 3============*/

select * from Materiales
select * from Proveedores
select * from Proyectos
select * from Entregan

INSERT INTO entregan values (0, 'xxx', 0, '1-jan-02', 0)/*Se inserta un registro experimental*/

/* Pregunta
1 ¿Qué particularidad observas en los valores para clave, rfc y numero?
Aunque son datos que no pueden ser reales, el sistema los toma como correctos, aunque solo los agrego en esta tabla, no considero las otras ya que no estan relacionadas

2 ¿Cómo responde el sistema a la inserción de este registro?
Acepto los datos sin problema

*/

Delete from Entregan where Clave = 0 /*Borramos el registro*/

/*Se crean las llaves foraneas en entregan*/
ALTER TABLE entregan add constraint cfentreganclave
foreign key (clave) references materiales(clave);

ALTER TABLE entregan add constraint cfentreganrfc
foreign key (RFC) references proveedores(RFC);

ALTER TABLE entregan add constraint cfentreganNumero
foreign key (Numero) references proyectos(Numero);


/* Pregunta
Intenta nuevamente la inserción del registro inconsistente.
1 ¿Qué significa el mensaje que emite el sistema?
Que no permite agregar estos datos a la tabla

2 ¿Qué significado tiene la sentencia anterior?
Se genera un error al no tener un registro existente en la tabla Materiales

3 ¿Qué significan las columnas de esas consultas? 'sp_helpconstraint entregan'
Nos da la informacion sobre cual es la llave primaria, cuales las foraneas y hacia donde estan referenciadas

*/

sp_helpconstraint entregan

/*=============Ejercicio 4============*/

INSERT INTO entregan values (1000, 'AAAA800101', 5000, GETDATE(), 0)

/* Pregunta
1 ¿Qué uso se le está dando a GETDATE()?
Se inserta la dfecha actual con hora

2 ¿Tiene sentido el valor del campo de cantidad?
No, ya que no tiene sentido agregar un valor de 0 en esta tabla, ya que es lo mismo que no haber registrado
*/

Delete from entregan where Cantidad = 0 /*Se elimina el registro*/

ALTER TABLE entregan add constraint cantidad check (cantidad > 0)

/* Pregunta
1 ¿Cómo responde el sistema?
Que no permite agregar estos datos a la tabla

2 ¿Qué significa el mensaje?
Ya que tenemnos un valor de 0 en cantidad, y est no es posible, genera un error

*/

sp_helpconstraint Entregan
sp_helpconstraint Materiales
sp_helpconstraint Proveedores
sp_helpconstraint Proyectos

/*
1 Nuevamente revisa los constraints de cada tabla y revisa las diferencias que existen entre cada uno de ellos
Tanto Materiales, como proveedores y Proyectos cuentan con practicamente la misma informacion, sus llaves primarias, el nombre de sus tablas y hacia donde se mandan las foraneas, 
la de Entregan cuenta con esta informacion y hacia donde se referencian 

2 explica el concepto de integridad referencial
Significa que la clave externa de una tabla de referencia siempre debe aludir a una fila válida de la tabla a la que se haga referencia

*/