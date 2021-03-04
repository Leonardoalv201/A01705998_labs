/* Creacion de las tablas */

CREATE TABLE Materiales
(
  Clave numeric(5),
  Descripcion varchar(50),
  Costo numeric(8,2)
)

CREATE TABLE Proveedores
(
  RFC char(13),
  RazonSocial varchar(50)
)

CREATE TABLE Proyectos
(
  Numero numeric(5),
  Denominacion varchar(50)
)

CREATE TABLE Entregan
(
  Clave numeric(5),
  RFC char(13),
  Numero numeric(5),
  Fecha datetime,
  Cantidad numeric(8,2)
)

/*------------------------------------------------------------------------*/

SET DATEFORMAT dmy/*se indica el formato de la fecha utilizada*/

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


BULK INSERT a1705998.a1705998.[Entregan]
   FROM 'e:\wwwroot\rcortese\entregan.csv'
   WITH
      (
         CODEPAGE = 'ACP',
         FIELDTERMINATOR = ',',
         ROWTERMINATOR = '\n'
      )

/*------------------------------------------------------------------------*/

/*Busquedas para comprovar la carga correcta de archivos*/
select * from Materiales
select * from Proveedores
select * from Proyectos
select * from Entregan

/*------------------------------------------------------------------------*/

/*Preguntas*/
/*
1 ¿Que muestra la instrucción 'sp_help materiales'?
Muestra la informacion de la tabla, sus atributos, que tipo de atrub uto son, si puene datos, entre otras cosas

2 Ejecuta las instrucciones que contiene el archivo crear.sql ¿Qué efecto tuvo esta acción?


3 ¿Qué utilidad tiene esta manera de ejecutar los comandos de SQL?


4 ¿Qué relación tienen con las tablas de la base de datos?
Son de los mismos datos, las tablas son con lo que llenaremos nuestra base de datos

5 ¿Qué relación tiene el contenido de este archivo (materiales.sql) con el formato en que se encuentran los datos en el archivo materiales.csv?
Cuentan con los mismos datos, el archivo 'materiales.csv' es de donde obtenemos los datos para llenar la base de datos

6 Después de la ejecución del comando, 'SELECT  * FROM Materiales' ¿Qué sucedió?
Ya se muestran los valores del archivo csv en la base de datos

*/

sp_help Materiales