/*Parte 1 - consultas con funciones agregadas

Materiales(Clave, Descripción, Costo, PorcentajeImpuesto)
Proveedores(RFC, RazonSocial)
Proyectos(Numero, Denominacion)
Entregan(Clave, RFC, Numero, Fecha, Cantidad)*/

/*La suma de las cantidades e importe total de todas las entregas realizadas durante el 97.*/

select sum(cantidad) as 'total unidades', sum(cantidad * ( costo + ( costo * porcentajeimpuesto / 100))) as 'ingresos totales'
from entregan as e
inner join  materiales as m
on e.clave=m.clave
where fecha between '19970101' and '19980101'
/*Resultado:
546.00	44789.4720000000*/


-- Para cada proveedor, obtener la razón social del proveedor, número de entregas e importe total de las entregas realizadas.

select razonsocial, count(e.rfc) as 'numero de entregas', sum(cantidad * ( costo + ( costo * porcentajeimpuesto / 100))) as 'ingresos totales'
from materiales as m, proveedores as p, entregan as e
where e.clave=m.clave and p.rfc=e.rfc
group by RazonSocial
/*Resultado:
Alvin					15	794295.2064000000
Berel					9	1017477.8830000000
Cecoferre				18	860441.9770000000
Comex					15	801930.5980000000
La Ferre				18	919531.4300000000
La fragua				18	2301675.6920000000
Oviedo					18	1059888.7370000000
Tabiquera del centro	15	1937798.7240000000
Tubasa					15	2278398.9930000000*/


/*Por cada material obtener la clave y descripción del material, la cantidad total entregada, la mínima cantidad entregada, la máxima cantidad entregada, 
el importe total de las entregas de aquellos materiales en los que la cantidad promedio entregada sea mayor a 400.*/

select m.clave, descripcion, sum(cantidad) as 'total entregado',  min(cantidad) as 'minimo entregado', max(cantidad) as 'maximo entregado', sum(cantidad * ( costo + ( costo * porcentajeimpuesto / 100))) as 'ingresos totales'
from entregan as e
inner join  materiales as m
on e.clave=m.clave
group by m.clave, descripcion
having avg(cantidad) > 400

/*Resultado:
1010	Varilla 4/32		1718.00	523.00	667.00	201560.9140000000
1040	Varilla 3/18		1349.00	263.00	546.00	220329.4720000000
1050	Varilla 4/34	    1216.00	90.00	623.00	217268.8000000000
1080	Ladrillos rojos	    1214.00	86.00	699.00	62011.1200000000
1100	Block	            1688.00	466.00	699.00	51754.0800000000
1130	Sillar gris	        1298.00	63.00	673.00	146006.8280000000
1140	Cantera blanca	    1453.00	219.00	651.00	297225.6800000000
1200	Recubrimiento P1019	1415.00	177.00	653.00	347750.4000000000
1220	Recubrimiento P1037	1335.00	24.00	658.00	382920.7200000000
1250	Grava				1452.00	71.00	691.00	148830.0000000000
1270	Tezontle			1376.00	324.00	546.00	112876.0320000000
1320	Tubería 4.4			1274.00	163.00	698.00	300755.7280000000
1330	Tubería 3.7			1205.00	93.00	558.00	296892.7200000000
1410	Pintura B1021		1529.00	461.00	601.00	196514.7250000000
1420	Pintura C1012		1325.00	278.00	603.00	170328.7500000000*/


/*Para cada proveedor, indicar su razón social y mostrar la cantidad promedio de cada material entregado, 
detallando la clave y descripción del material, excluyendo aquellos proveedores para los que la cantidad promedio sea menor a 500.*/

select RazonSocial, avg(cantidad) as 'prom material entregado', m.clave, descripcion
from entregan as e, materiales as m, Proveedores as p
where e.clave=m.clave and e.rfc=p.rfc
group by RazonSocial, m.clave, descripcion
having avg(cantidad) > 500
order by razonsocial 

/*Resultado:
La Ferre	562.666666	1100	Block
Oviedo	    572.666666	1010	Varilla 4/32
Oviedo		509.666666	1410	Pintura B1021*/


/*Mostrar en una solo consulta los mismos datos que en la consulta anterior pero para dos grupos de proveedores: 
aquellos para los que la cantidad promedio entregada es menor a 370 y aquellos para los que la cantidad promedio entregada sea mayor a 450.*/

select RazonSocial, avg(cantidad) as 'prom material entregado', m.clave, descripcion
from entregan as e, materiales as m, Proveedores as p
where e.clave=m.clave and e.rfc=p.rfc
group by RazonSocial, m.clave, descripcion
having avg(cantidad) not between 370 and 450
order by razonsocial

/*Resultados:
Alvin					358.000000	1120	Sillar rosa
Alvin					471.666666	1200	Recubrimiento P1019
Alvin					295.333333	1280	Tepetate
Alvin					222.000000	1360	Pintura C1010
Cecoferre				212.000000	1030	Varilla 4/33
Cecoferre				332.333333	1110	Megablock
Cecoferre				357.333333	1190	Recubrimiento P1010
Cecoferre				458.666666	1270	Tezontle
Cecoferre				287.666666	1350	Tubería 3.8
Cecoferre				365.000000	1430	Pintura B1022
Comex					197.333333	1210	Recubrimiento P1028
Comex					249.000000	1290	Tubería 3.5
Comex					347.333333	1370	Pintura B1020
La Ferre				356.000000	1020	Varilla 3/17
La Ferre				562.666666	1100	Block
La Ferre				319.000000	1180	Recubrimiento P1001
La Ferre				364.333333	1260	Gravilla
La Ferre				336.333333	1340	Tubería 4.5
La fragua				142.000000	1000	Varilla 3/16
La fragua				357.000000	1160	Cantera rosa
La fragua				355.666666	1240	Arena
La fragua				313.000000	1400	Pintura C1011
Oviedo					572.666666	1010	Varilla 4/32
Oviedo					368.666666	1090	Ladrillos grises
Oviedo					250.000000	1170	Cantera amarilla
Oviedo					484.000000	1250	Grava
Oviedo					509.666666	1410	Pintura B1021
Tabiquera del centro	354.333333	1060	Varilla 3/19
Tabiquera del centro	484.333333	1140	Cantera blanca
Tabiquera del centro	365.666666	1300	Tubería 4.3
Tabiquera del centro	364.666666	1380	Pintura C1011
Tubasa					340.333333	1070	Varilla 4/35
Tubasa					319.000000	1230	Cemento 
Tubasa					244.666666	1310	Tubería 3.6*/


/*Parte 2 */

INSERT INTO materiales VALUES (1440, 'varilla 1/2', 450, 2.88) ;
INSERT INTO materiales VALUES (1450, 'varilla 1/3', 470, 2.90) ;
INSERT INTO materiales VALUES (1460, 'varilla 2/3', 390, 2.92) ;
INSERT INTO materiales VALUES (1470, 'varilla 3/4', 500, 2.94) ;
INSERT INTO materiales VALUES (1480, 'varilla 3/5', 520, 2.96) ;

/*Clave y descripción de los materiales que nunca han sido entregados.*/

select clave, Descripcion 
from materiales 
where clave not in
(select clave
from entregan )

/*Resultados:
1440	varilla 1/2
1450	varilla 1/3
1460	varilla 2/3
1470	varilla 3/4
1480	varilla 3/5*/


/*Razón social de los proveedores que han realizado entregas tanto al proyecto 'Vamos México' como al proyecto 'Querétaro Limpio'.*/

SELECT RAZONSOCIAL
FROM Proveedores
WHERE RFC IN (SELECT RFC FROM ENTREGAN WHERE Numero IN (SELECT NUMERO FROM Proyectos 
WHERE Denominacion = 'Queretaro Limpio'))
AND RFC IN (SELECT RFC FROM ENTREGAN WHERE Numero IN (SELECT NUMERO FROM Proyectos 
WHERE Denominacion = 'Vamos Mexico'))

/*Resultados:
La fragua*/


/*Descripción de los materiales que nunca han sido entregados al proyecto 'CIT Yucatán'.*/

select m.Descripcion
from Materiales as m
where m.clave not in (select e.clave
from  Entregan as e, Proyectos as p
where p.Numero = e.Numero
and Denominacion like 'CIT Yucatan')

/*Resultado:
Varilla 3/16
Varilla 4/32
Varilla 3/17
Varilla 4/33
Varilla 4/34
Varilla 3/19
Varilla 4/35
Ladrillos rojos
Ladrillos grises
Block
Megablock
Sillar rosa
Sillar gris
Cantera blanca
Cantera rosa
Cantera amarilla
Recubrimiento P1001
Recubrimiento P1010
Recubrimiento P1028
Recubrimiento P1037
Cemento 
Arena
Grava
Gravilla
Tezontle
Tepetate
Tubería 3.5
Tubería 3.6
Tubería 4.4
Tubería 3.7
Tubería 4.5
Pintura C1010
Pintura B1020
Pintura C1011
Pintura B1021
Pintura C1011
Pintura B1021
Pintura C1012
Pintura B1022
varilla 1/2
varilla 1/3
varilla 2/3
varilla 3/4
varilla 3/5*/


/*Razón social y promedio de cantidad entregada de los proveedores cuyo promedio de cantidad entregada
es mayor al promedio de la cantidad entregada por el proveedor con el RFC 'VAGO780901'.*/

--Creacion del rfc VAGO780901
INSERT INTO Proveedores VALUES ('VAGO780901', 'Berel');
INSERT INTO Entregan VALUES (1030, 'VAGO780901', 5004, GETDATE(), 325);
INSERT INTO Entregan VALUES (1130, 'VAGO780901', 5002, GETDATE(), 178);
INSERT INTO Entregan VALUES (1230, 'VAGO780901', 5007, GETDATE(), 84);
INSERT INTO Entregan VALUES (1260, 'VAGO780901', 5005, GETDATE(), 75);
INSERT INTO Entregan VALUES (1420, 'VAGO780901', 5011, GETDATE(), 102);
INSERT INTO Entregan VALUES (1300, 'VAGO780901', 5015, GETDATE(), 200);
INSERT INTO Entregan VALUES (1150, 'VAGO780901', 5018, GETDATE(), 370);
INSERT INTO Entregan VALUES (1220, 'VAGO780901', 5010, GETDATE(), 390);
INSERT INTO Entregan VALUES (1380, 'VAGO780901', 5012, GETDATE(), 390);

select razonsocial, avg(cantidad)
from proveedores as p, entregan as e
where p.rfc=e.rfc
group by razonsocial
having avg(cantidad)>(select avg(cantidad) from entregan where rfc like 'VAGO780901')

/*Resultado:
Alvin					359.333333
Cecoferre				335.500000
Comex					326.333333
La Ferre				396.666666
La fragua				332.833333
Oviedo					431.111111
Tabiquera del centro	402.800000
Tubasa					333.666666*/


/*RFC, razón social de los proveedores que participaron en el proyecto 'Infonavit Durango' y
cuyas cantidades totales entregadas en el 2000 fueron mayores a las cantidades totales entregadas en el 2001.*/

CREATE VIEW aux1 AS
select Cantidad from Entregan where fecha between '20000101' and '20010101'

CREATE VIEW aux2 AS
select cantidad from entregan where fecha between '20010101' and '20020101'

Select distinct pr.RFC, RazonSocial
from Proveedores as pr, entregan as e, Proyectos as p, aux1, aux2
Where pr.RFC = e.RFC
and p.Numero = e.Numero
and Denominacion = 'Infonavit Durango'
and aux1.Cantidad > aux2.Cantidad

/*Resultados:
BBBB800101   	Oviedo
FFFF800101   	Comex
GGGG800101   	Tabiquera del centro
VAGO780901   	Berel*/