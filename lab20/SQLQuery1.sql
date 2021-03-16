/*Lab 20*/

/*Consulta de un tabla completa*/
select * 
from Materiales
/*
1000	Varilla 3/16	100.00
1010	Varilla 4/32	115.00
1020	Varilla 3/17	130.00
1030	Varilla 4/33	145.00
44 rows-----------------------------------------------------------------------------*/


/*Selección*/
select * 
from materiales
where clave=1000
/*
1000	Varilla 3/16	100.00
1 row------------------------------------------------------------------------------*/


/*Proyección*/
select clave,rfc,fecha 
from entregan
/*
1000	AAAA800101   	1998-07-08 00:00:00.000
1000	AAAA800101   	1999-08-08 00:00:00.000
1000	AAAA800101   	2000-04-06 00:00:00.000
1010	BBBB800101   	2000-05-03 00:00:00.000
132 rows------------------------------------------------------------------------------*/


/*Reunión Natural*/
select * 
from materiales,entregan
where materiales.clave = entregan.clave
/*
1000	Varilla 3/16	100.00	1000	AAAA800101   	5000	1998-07-08 00:00:00.000	165.00
1000	Varilla 3/16	100.00	1000	AAAA800101   	5019	1999-08-08 00:00:00.000	254.00
1000	Varilla 3/16	100.00	1000	AAAA800101   	5019	2000-04-06 00:00:00.000	7.00
1010	Varilla 4/32	115.00	1010	BBBB800101   	5001	2000-05-03 00:00:00.000	528.00
132 rows

Si algún material no ha se ha entregado ¿Aparecería en el resultado de esta consulta?
Este material no apareceria en la tabla------------------------------------------------------------------------------*/


/*Reunión con criterio específico*/
select * 
from entregan,proyectos
where entregan.numero < = proyectos.numero
/*
1000	AAAA800101   	5000	1998-07-08 00:00:00.000	165.00	5000	Vamos Mexico
1200	EEEE800101   	5000	2000-03-05 00:00:00.000	177.00	5000	Vamos Mexico
1400	AAAA800101   	5000	2002-03-12 00:00:00.000	382.00	5000	Vamos Mexico
1000	AAAA800101   	5000	1998-07-08 00:00:00.000	165.00	5001	Aztecón
1188 rows------------------------------------------------------------------------------*/


/*Unión (se ilustra junto con selección)*/
select * 
from entregan 
where clave=1450
union
(select * 
from entregan 
where clave=1300)
/*
1300	GGGG800101   	5005	2002-06-10 00:00:00.000	521.00
1300	GGGG800101   	5005	2003-02-02 00:00:00.000	457.00
1300	GGGG800101   	5010	2003-01-08 00:00:00.000	119.00
3 rows

¿Cuál sería una consulta que obtuviera el mismo resultado sin usar el operador Unión? Compruébalo.
select * from entregan where clave=1300 or clave = 1450
------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Intersección (se ilustra junto con selección y proyección)*/
select clave 
from entregan 
where numero=5001
intersect
(select clave 
from entregan 
where numero=5018)
/*
1010
1 row------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Diferencia (se ilustra con selección )*/
select * 
from entregan
except
(select * 
from entregan 
where clave=1000)
/*
1010	BBBB800101   	5001	2000-05-03 00:00:00.000	528.00
1010	BBBB800101   	5018	2000-11-10 00:00:00.000	667.00
1010	BBBB800101   	5018	2002-03-29 00:00:00.000	523.00
1020	CCCC800101   	5002	2001-07-29 00:00:00.000	582.00
129 rows------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Producto cartesiano*/
select * 
from entregan, materiales
/*
1000	AAAA800101   	5000	1998-07-08 00:00:00.000	165.00	1000	Varilla 3/16	100.00
1000	AAAA800101   	5019	1999-08-08 00:00:00.000	254.00	1000	Varilla 3/16	100.00
1000	AAAA800101   	5019	2000-04-06 00:00:00.000	7.00	1000	Varilla 3/16	100.00
1010	BBBB800101   	5001	2000-05-03 00:00:00.000	528.00	1000	Varilla 3/16	100.00
5808 rows

¿Cómo está definido el número de tuplas de este resultado en términos del número de tuplas de entregan y de materiales?
El numero de tuplas es debido a que hay 132 tuplas en la tabla de entregan y 44 en la de materiales por lo que 44x132=5808
------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Construcción de consultas a partir de una especificación*/
set dateformat dmy
select materiales.descripcion
from entregan, materiales
where entregan.clave=materiales.clave 
and entregan.fecha between '20000101' and '20010101'
/*
Varilla 3/16
Varilla 4/32
Varilla 4/32
Varilla 4/33
28 rows

¿Por qué aparecen varias veces algunas descripciones de material?
Porque estas se entregaron mas de una vez en el año
------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Uso del calificador distinct*/
select distinct materiales.descripcion
from entregan, materiales
where entregan.clave=materiales.clave 
and entregan.fecha between '20000101' and '20010101'
/*
Arena
Block
Cantera rosa
Ladrillos grises
22 rows

¿Qué resultado obtienes en esta ocasión?
Las descripciones se ordenaron alfabeticamente y ya no se repiten
------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Ordenamientos.*/
select p.numero, denominacion, fecha, cantidad
from proyectos as p, entregan as e
where p.numero=e.numero
order by numero ,fecha desc
/*
5000	Vamos Mexico	2002-03-12 00:00:00.000	382.00
5000	Vamos Mexico	2000-03-05 00:00:00.000	177.00
5000	Vamos Mexico	1998-07-08 00:00:00.000	165.00
5001	Aztecón	2000-05-03 00:00:00.000	528.00
132 rows*/


/*Uso de expresiones
En álgebra relacional los argumentos de una proyección deben ser columnas. 
Sin embargo en una sentencia SELECT es posible incluir expresiones aritméticas o funciones que usen como argumentos de las columnas de las tablas involucradas o bien constantes. Los operadores son:

+ Suma
- Resta
* Producto
/ División

Las columnas con expresiones pueden renombrarse escribiendo después de la expresión un alias que puede ser un nombre arbitrario; 
si el alias contiene caracteres que no sean números o letras (espacios, puntos etc.) debe encerrarse entre comillas dobles (" nuevo nombre" ). Para SQL Server también pueden utilizarse comillas simples.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Operadores de cadena*/
select * 
from materiales 
where Descripcion like 'Si%'
/*
2 rows

¿Qué resultado obtienes?
Los materiales que inician con "Si"

Explica que hace el símbolo '%'.
Indica que puede haber algo antes o despues de el "Si" dependiendo de donde se coloque

¿Qué sucede si la consulta fuera : LIKE 'Si' ?
Unicamente buscaria descripciones con nombre "Si"

¿Qué resultado obtienes?
En la primer busqueda con %:
1120	Sillar rosa	100.00
1130	Sillar gris	110.00

En la segunda sin %:
Vacio

Explica a qué se debe este comportamiento.
A que en la primera indicamos que puede haber algo despues del "Si" y en la segunda solo se puede llamar "Si"*/


/*
Otro operador de cadenas es el de concatenación, (+, +=) este operador concatena dos o más cadenas de caracteres.
Su sintaxis es : Expresión + Expresión.
Un ejemplo de su uso, puede ser: Un ejemplo de su uso, puede ser:
SELECT (Apellido + ', ' + Nombre) as Nombre FROM Personas;*/
DECLARE @foo varchar(40);
DECLARE @bar varchar(40);
SET @foo = '¿Que resultado';
SET @bar = ' ¿¿¿??? '
SET @foo += ' obtienes?';
PRINT @foo + @bar;
/*
¿Qué resultado obtienes de ejecutar el siguiente código?
¿Que resultado obtienes? ¿¿¿??? 

¿Para qué sirve DECLARE?
Para declarar atributos sin tabla

¿Cuál es la función de @foo?
En este caso es un atributo que guardar una cadena de caracteres

¿Que realiza el operador SET?
Asigna valores a los atributos declarados
*/

select RFC from Entregan where RFC LIKE '[A-D]%';
/*
AAAA800101   
AAAA800101   
AAAA800101   
BBBB800101   
BBBB800101   
Selecciona todos los rfc que comienzen por A,B,C o D*/
select RFC from Entregan where RFC LIKE '[^A]%';
/*
BBBB800101   
BBBB800101   
BBBB800101   
CCCC800101   
CCCC800101   
Selecciona todos los rfc que no comienzen por A*/
select Numero from Entregan where Numero LIKE '___6';
/*
5016
5016
5006
5006
Selecciona todos los numero que tengan 4 digitos y terminen en 6*/
/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Operadores compuestos
Los operadores compuestos ejecutan una operación y establecen un valor.
+ = (Suma igual)
- = (Restar igual)
* = (Multiplicar igual)
/ = (Dividir igual)
% = (Módulo igual)
------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Operadores Lógicos*/
select Clave,RFC,Numero,Fecha,Cantidad
from Entregan
where Numero Between 5000 and 5010;
/*
1000	AAAA800101   	5000	1998-07-08 00:00:00.000	165.00
1010	BBBB800101   	5001	2000-05-03 00:00:00.000	528.00
1020	CCCC800101   	5002	2001-07-29 00:00:00.000	582.00
1030	DDDD800101   	5003	1998-02-21 00:00:00.000	202.00
60 rows
¿Cómo filtrarías rangos de fechas?
select Clave,RFC,Numero,Fecha,Cantidad
from Entregan
where fecha Between '20000101' and '20010101';
*/

select RFC,Cantidad, Fecha,Numero
from Entregan
where Numero Between 5000 and 5010 AND
Exists 
( select RFC
from Proveedores
where RazonSocial LIKE 'La%' and Entregan.RFC = Proveedores.RFC )
/*
AAAA800101   	165.00	1998-07-08 00:00:00.000	5000
CCCC800101   	582.00	2001-07-29 00:00:00.000	5002
AAAA800101   	86.00	1999-01-12 00:00:00.000	5008
CCCC800101   	466.00	2000-08-06 00:00:00.000	5009
16 rows
¿Qué hace la consulta?
selecciona el rfc, cantidad, fecha y numero de la tabla entregan donde numero esta entre 5000 y 5010,  y que la razon social de los proveedores empieze por "La"

¿Qué función tiene el paréntesis ( ) después de EXISTS?
Para tomar toda la siguiente query como una sola, y realizar esta primero para despues poder realizar la segunda
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Tomando de base la consulta anterior del EXISTS, realiza el query que devuelva el mismo resultado, pero usando el operador IN*/
select RFC,Cantidad, Fecha,Numero
from Entregan
where Numero Between 5000 and 5010 AND
rfc IN 
( select RFC
from Proveedores
where RazonSocial LIKE 'La%' and Entregan.RFC = Proveedores.RFC )
/*
AAAA800101   	165.00	1998-07-08 00:00:00.000	5000
CCCC800101   	582.00	2001-07-29 00:00:00.000	5002
AAAA800101   	86.00	1999-01-12 00:00:00.000	5008
CCCC800101   	466.00	2000-08-06 00:00:00.000	5009
16 rows*/

/*Tomando de base la consulta anterior del EXISTS, realiza el query que devuelva el mismo resultado, pero usando el operador NOT IN Realiza un ejemplo donde apliques algún operador : ALL, SOME o ANY.*/
select RFC,Cantidad, Fecha,Numero
from Entregan
where Numero Between 5000 and 5010 AND 
rfc not IN 
( select RFC
from Proveedores
where RazonSocial not LIKE 'La%' and Entregan.RFC = Proveedores.RFC )
/*
AAAA800101   	165.00	1998-07-08 00:00:00.000	5000
CCCC800101   	582.00	2001-07-29 00:00:00.000	5002
AAAA800101   	86.00	1999-01-12 00:00:00.000	5008
CCCC800101   	466.00	2000-08-06 00:00:00.000	5009
16 rows*/





/*========================================================================ALL SOME O ANY===================================================================================================*/





/*¿Qué hace la siguiente sentencia? Explica por qué.
Selecciona los primeros 2 registros de la tabla proyectos*/
select TOP 2 * 
from Proyectos
/*
5000	Vamos Mexico
5001	Aztecón
2 rows*/

/*¿Qué sucede con la siguiente consulta? Explica por qué.
Marca error, ya que no se especifican cuantos valores se quieren mostrar*/
select TOP Numero 
from Proyectos
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*Modificando la estructura de un tabla existente.*/
alter table materiales add PorcentajeImpuesto NUMERIC(6,2);
update materiales set PorcentajeImpuesto = 2*clave/1000;
select * from Materiales


/*¿Qué consulta usarías para obtener el importe de las entregas es decir, el total en dinero de lo entregado, basado en la cantidad de la entrega y el precio del material y el impuesto asignado?*/
select sum(cantidad*(costo+(costo*(porcentajeimpuesto/100)))) as importe
from entregan, materiales
where entregan.clave=materiales.clave
/*
10953961.3574000000
1 row*/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Creación de vistas*/
create view clave_descripcion as select clave, descripcion from materiales
select * from clave_descripcion
/*
1000	Varilla 3/16
1010	Varilla 4/32
1020	Varilla 3/17
1030	Varilla 4/33
44 rows*/

create view materiales_descripcion_empieza_si as
select * 
from materiales 
where Descripcion like 'Si%'
select * from materiales_descripcion_empieza_si
/*
1120	Sillar rosa	100.00	2.24
1130	Sillar gris	110.00	2.26
2 rows*/

create view primeros_proyectos as
select TOP 2 * 
from Proyectos
select * from primeros_proyectos
/*
5000	Vamos Mexico
5001	Aztecón
2 rows*/

create view entregan_rfc_sin_A as
select RFC from Entregan where RFC LIKE '[^A]%'
select * from entregan_rfc_sin_A
/*
BBBB800101   
BBBB800101   
BBBB800101   
CCCC800101   
CCCC800101   
114 rows*/

create view entregan_materiales_2000 as
select distinct e.clave, RFC, Numero, fecha, cantidad, descripcion, costo
from entregan as e, materiales as m
where e.clave=m.clave 
and e.fecha between '20000101' and '20010101'
select * from entregan_materiales_2000
/*
1000	AAAA800101   	5019	2000-04-06 00:00:00.000	7.00	Varilla 3/16	100.00
1010	BBBB800101   	5001	2000-05-03 00:00:00.000	528.00	Varilla 4/32	115.00
1010	BBBB800101   	5018	2000-11-10 00:00:00.000	667.00	Varilla 4/32	115.00
1030	DDDD800101   	5016	2000-11-05 00:00:00.000	295.00	Varilla 4/33	145.00
28 rows*/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*Ejercicios*/
/*Los materiales (clave y descripción) entregados al proyecto "México sin ti no estamos completos".*/
select m.clave, descripcion
from materiales as m, (select clave from proyectos as p, entregan as e
where p.numero=e.numero and p.denominacion like 'Mexico sin ti no estamos completos') as t
where m.clave=t.clave
/*
1030	Varilla 4/33
1230	Cemento 
1430	Pintura B1022
3 rows*/


/*Los materiales (clave y descripción) que han sido proporcionados por el proveedor "Acme tools".*/
select m.clave, descripcion
from materiales as m, (select clave from proveedores as p, entregan as e
where p.rfc=e.rfc and p.razonsocial like 'Acme tools') as tabla
where m.clave=tabla.clave
/*0 rows*/


/*El RFC de los proveedores que durante el 2000 entregaron en promedio cuando menos 300 materiales.*/
select rfc, avg(cantidad) as cantidad
from entregan as e 
where fecha between '20000101' and ' 20010101'
group by rfc
having avg(cantidad)>300
/*
BBBB800101   	392.400000
CCCC800101   	372.000000
DDDD800101   	314.333333
EEEE800101   	442.666666
7 rows*/


/*El Total entregado por cada material en el año 2000.*/
select clave, sum(cantidad) as total_entregado
from entregan as e 
where fecha between '20000101' and ' 20010101'
group by clave
/*
1000	7.00
1010	1195.00
1030	295.00
1040	546.00
1050	503.00
22 rows*/


/*La Clave del material más vendido durante el 2001. (se recomienda usar una vista intermedia para su solución)*/
select r.clave, r.total
from (select clave, sum(cantidad) as total
from entregan as e 
where fecha between '20010101' and ' 20020101'
group by clave) as r, 
(select  max(t.total_entregado) as can
from materiales as m,
(select clave, sum(cantidad) as total_entregado
from entregan as e 
where fecha between '20010101' and ' 20020101'
group by clave) as t
where m.clave=t.clave) as d
where d.can=r.total
/*1020	1060.00
1 row*/


/*Productos que contienen el patrón 'ub' en su nombre.*/
select *
from materiales
where Descripcion like '%ub%'
/*
1180	Recubrimiento P1001	200.00	2.36
1190	Recubrimiento P1010	220.00	2.38
1200	Recubrimiento P1019	240.00	2.40
1210	Recubrimiento P1028	250.00	2.42
12 rows*/


/*Denominación y suma del total a pagar para todos los proyectos.*/
select numero, sum(cantidad) total_a_pagar
from entregan
group by Numero
/*
5000	724.00
5001	1172.00
5002	1209.00
5003	1308.00
20 rows*/


/*Denominación, RFC y RazonSocial de los proveedores que se suministran materiales al proyecto Televisa en acción que no se encuentran apoyando al proyecto Educando en Coahuila (Solo usando vistas).*/
select p.rfc, p.razonsocial, pr.Denominacion
from Proveedores as p, entregan as e, Proyectos as pr,
((select p.rfc
from Proveedores as p, entregan as e, Proyectos as pr
where e.Numero=pr.Numero and p.rfc=e.rfc
and pr.Denominacion like 'Televisa en acción') 
except
(select p.rfc
from Proveedores as p, entregan as e, Proyectos as pr
where e.Numero=pr.Numero and p.rfc=e.rfc
and pr.Denominacion like 'Educando en Coahuila')) as tabla
where tabla.rfc=p.rfc and pr.Denominacion like 'Televisa en acción'
group by p.RazonSocial , p.rfc , pr.Denominacion
/*
CCCC800101   	La Ferre	Televisa en acción
DDDD800101   	Cecoferre	Televisa en acción
2 rows*/


/*Denominación, RFC y RazonSocial de los proveedores que se suministran materiales al proyecto Televisa en acción que no se encuentran apoyando al proyecto Educando en Coahuila (Sin usar vistas, utiliza not in, in o exists).*/
select p.rfc, p.razonsocial, pr.Denominacion
from Proveedores as p, entregan as e, Proyectos as pr
where e.Numero=pr.Numero and p.rfc=e.rfc
and pr.Denominacion like 'Televisa en acción'
and p.rfc not in
(select p.rfc
from Proveedores as p, entregan as e, Proyectos as pr
where e.Numero=pr.Numero and p.rfc=e.rfc
and pr.Denominacion like 'Educando en Coahuila')
group by p.RazonSocial , p.rfc , pr.Denominacion
/*
CCCC800101   	La Ferre	Televisa en acción
DDDD800101   	Cecoferre	Televisa en acción
2 rows*/


/*Costo de los materiales y los Materiales que son entregados al proyecto Televisa en acción cuyos proveedores también suministran materiales al proyecto Educando en Coahuila.*/
select m.descripcion, sum(cantidad*(costo+(costo*(porcentajeimpuesto/100)))) 
from entregan as e, materiales as m, Proyectos as p
where e.clave=m.clave and p.Numero=e.numero and 
p.Denominacion like 'Educando en Coahuila' or p.Denominacion like 'Televisa en acción'
group by m.descripcion
/*
Arena	9922933.4400000000
Block	1479712.9200000000
Cantera amarilla	11360006.0840000000
Cantera blanca	9872474.7200000000
42 rows*/


/*Nombre del material, cantidad de veces entregados y total del costo de dichas entregas por material de todos los proyectos.*/
select m.descripcion, count(m.clave) as veces_entregado, sum(cantidad*(costo+(costo*(porcentajeimpuesto/100)))) as importe
from entregan, materiales as m
where entregan.clave=m.clave
group by m.descripcion
/*
Arena	3	218692.3200000000
Block	3	51754.0800000000
Cantera amarilla	3	176536.5000000000
Cantera blanca	3	297225.6800000000
42 rows*/

