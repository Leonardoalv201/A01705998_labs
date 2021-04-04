IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'creaMaterial' AND type = 'P')
                DROP PROCEDURE creaMaterial
            GO

            CREATE PROCEDURE creaMaterial
                @uclave NUMERIC(5,0),
                @udescripcion VARCHAR(50),
                @ucosto NUMERIC(8,2),
                @uimpuesto NUMERIC(6,2)
            AS
                INSERT INTO Materiales VALUES(@uclave, @udescripcion, @ucosto, @uimpuesto)
            GO

/*Preguntas:
¿Qué hace el primer bloque del código (bloque del IF)?
	Revisa si es que ya existe un proceso llamado 'creaMaterial', y si existe lo borra

¿Para qué sirve la instrucción GO?
	Una vez terminado el if indica que se continue hacia la siguiente linea

¿Explica que recibe como parámetro este Procedimiento y qué tabla modifica?
	Recibe los datos que van en Materia, recibe la clave, descripcion, costo e impuesto */

EXECUTE creaMaterial 5000,'Martillos Acme',250,15

select * from materiales
/*Resultado:
1000	Varilla 3/16	100.00	2.00
.		.				.		
.		.				.
.		.				.
5000	Martillos Acme	250.00	15.00*/


IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'modificaMaterial' AND type = 'P')
                DROP PROCEDURE modificaMaterial
            GO

            CREATE PROCEDURE modificaMaterial
                @uclave NUMERIC(5,0),
                @udescripcion VARCHAR(50),
                @ucosto NUMERIC(8,2),
                @uimpuesto NUMERIC(6,2)
            AS
                UPDATE materiales SET descripcion = @udescripcion , costo = @ucosto, porcentajeimpuesto = @uimpuesto WHERE clave=@uclave
            GO


IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'eliminaMaterial' AND type = 'P')
                DROP PROCEDURE eliminaMaterial
            GO

            CREATE PROCEDURE eliminaMaterial
                @uclave NUMERIC(5,0)
            AS
                DELETE FROM materiales WHERE clave=@uclave
            GO


/*procedimientos (almacenados) para tabla proyectos*/
select * from proyectos

IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'creaProyecto' AND type = 'P')
                DROP PROCEDURE creaProyecto
            GO

            CREATE PROCEDURE creaProyecto
                @unumero NUMERIC(5,0),
                @udenominacion VARCHAR(50)
            AS
                INSERT INTO Proyectos VALUES(@unumero, @udenominacion)
            GO


IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'modificaProyecto' AND type = 'P')
                DROP PROCEDURE modificaProyecto
            GO

            CREATE PROCEDURE modificaProyecto
                @unumero NUMERIC(5,0),
                @udenominacion VARCHAR(50)
            AS
                UPDATE proyectos SET denominacion = @udenominacion WHERE numero=@unumero
            GO


IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'eliminaProyecto' AND type = 'P')
                DROP PROCEDURE eliminaProyecto
            GO

            CREATE PROCEDURE eliminaProyecto
                @unumero NUMERIC(5,0)
            AS
                DELETE FROM Proyectos WHERE numero=@unumero
            GO

/*procedimientos (almacenados) para tabla entregan*/
select * from entregan

IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'creaEntrega' AND type = 'P')
                DROP PROCEDURE creaEntrega
            GO

            CREATE PROCEDURE creaEntrega
				@uclave NUMERIC(5,0),
				@urfc varchar(20),
                @unumero NUMERIC(5,0),
				@ufecha date,
                @ucantidad NUMERIC(5,0)
            AS
                INSERT INTO entregan VALUES(@uclave, @urfc, @unumero, @ufecha, @ucantidad)
            GO


IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'modificaEntrega' AND type = 'P')
                DROP PROCEDURE modificaEntrega
            GO

            CREATE PROCEDURE modificaEntrega
                @uclave NUMERIC(5,0),
				@urfc varchar(20),
                @unumero NUMERIC(5,0),
				@ufecha date,
                @ucantidad NUMERIC(5,0)
            AS
                UPDATE entregan SET fecha = @ufecha, cantidad = @ucantidad WHERE clave= @uclave and rfc= @urfc and numero=@unumero
            GO


IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'eliminaEntrega' AND type = 'P')
                DROP PROCEDURE eliminaEntrega
            GO

            CREATE PROCEDURE eliminaEntrega
                @uclave NUMERIC(5,0),
				@urfc varchar(20),
                @unumero NUMERIC(5,0)
            AS
                DELETE FROM entregan WHERE clave= @uclave and rfc= @urfc and numero=@unumero
            GO


/*procedimientos (almacenados) para tabla proveedores*/
select * from Proveedores

IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'creaProveedor' AND type = 'P')
                DROP PROCEDURE creaProveedor
            GO

            CREATE PROCEDURE creaProveedor
				@urfc varchar(20),
                @uRazonSocial varchar(50)
            AS
                INSERT INTO Proveedores VALUES(@urfc, @uRazonSocial)
            GO


IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'modificaProveedor' AND type = 'P')
                DROP PROCEDURE modificaProveedor
            GO

            CREATE PROCEDURE modificaProveedor
                @urfc varchar(20),
                @uRazonSocial varchar(50)
            AS
                UPDATE Proveedores SET razonsocial = @uRazonSocial WHERE rfc= @urfc
            GO


IF EXISTS (SELECT name FROM sysobjects
                       WHERE name = 'eliminaProveedor' AND type = 'P')
                DROP PROCEDURE eliminaProveedor
            GO

            CREATE PROCEDURE eliminaProveedor
                @urfc varchar(20)
            AS
                DELETE FROM Proveedores WHERE rfc= @urfc 
            GO

/*------------------------------------------------------Crear procedimientos para realizar consultas con parámetros-------------------------------------------------------------------*/
IF EXISTS (SELECT name FROM sysobjects
                        WHERE name = 'queryMaterial' AND type = 'P')
                DROP PROCEDURE queryMaterial
            GO

            CREATE PROCEDURE queryMaterial
                @udescripcion VARCHAR(50),
                @ucosto NUMERIC(8,2)

            AS
                SELECT * FROM Materiales WHERE descripcion
                LIKE '%'+@udescripcion+'%' AND costo > @ucosto
            GO

/*Pregunta:
Explica en tu reporte qué recibe como parámetro este procedimiento y qué hace.
Este procedimiento recibe la descripcion y el costo de un material, 
y te muestra todos los materiales con esa descripcion en su nombre, podiendo tener mas o menos datos en la descripcion,
y unicamente muestra los que tienen un costro mayor al dado*/
