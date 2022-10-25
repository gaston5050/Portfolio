--1
--Los pedidos que hayan sido finalizados en menor cantidad de días que la demora promedio0
	SELECT P.ID FROM PEDIDOS P
	WHERE DATEDIFF(DAY, P.FECHASOLICITUD,P.FECHAFINALIZACION) < (SELECT AVG(DATEDIFF(DAY, FECHASOLICITUD,FECHAFINALIZACION)) FROM PEDIDOS)

--2
--Los productos cuyo costo sea mayor que el costo del producto de Roble más caro.
	SELECT p.Descripcion FROM PRODUCTOS P
	WHERE P.Costo > (SELECT MAX(PRO.COSTO) FROM PRODUCTOS PRO
	INNER JOIN MATERIALES_X_PRODUCTO MXP ON PRO.ID = MXP.IDProducto
	INNER JOIN MATERIALES MAT ON MXP.IDMaterial = MAT.ID
	WHERE MAT.Nombre ='Roble')
	--3
--Los clientes que no hayan solicitado ningún producto de material Pino en el año 2022.
	
	Select distinct * from (select clientes  c

	inner join  pedidos p on c.id = p.IDCliente
	inner  join  productos pro on p.IDProducto =  pro.id
	inner join Materiales_x_Producto mxp on pro.ID = mxp.IDProducto
	inner join materiales mat on mxp.IDMaterial = mat.ID
	where  mat.Nombre <>'Pino' and (year(p.fechasolicitud) = 2022))
	order by c.id asc

	select distinct c.*, year(p.FechaSolicitud),mat.Nombre  from clientes c
	inner join pedidos p on c.ID = p.IDCliente
	inner join productos pro on pro.id =p.IDProducto
	inner join Materiales_x_Producto mxp on pro.id = mxp.IDProducto
	inner join materiales mat on mat.ID = mxp.IDMaterial
	where year(p.FechaSolicitud) = 2022 and mat.Nombre <>'Pino'




--4
--Los colaboradores que no hayan realizado ninguna tarea de Lijado en pedidos que se solicitaron en el año 2021.
--5
--Los clientes a los que les hayan enviado (no necesariamente entregado) al menos un tercio de sus pedidos.
--6
--Los colaboradores que hayan realizado todas las tareas (no necesariamente en un mismo pedido).
--7
--Por cada producto, la descripción y la cantidad de colaboradores fulltime que hayan trabajado en él y la cantidad de colaboradores parttime.
--8
--Por cada producto, la descripción y la cantidad de pedidos enviados y la cantidad de pedidos sin envío.
--9
--Por cada cliente, apellidos y nombres y la cantidad de pedidos solicitados en los años 2020, 2021 y 2022. (Cada año debe mostrarse en una columna separada)
--10
--Por cada producto, listar la descripción del producto, el costo y los materiales de construcción (en una celda separados por coma)
--11
--Por cada pedido, listar el ID, la fecha de solicitud, el nombre del producto, los apellidos y nombres de los colaboradores que trabajaron en el pedido y la/s tareas que el colaborador haya realizado (en una celda separados por coma)
--12
--Las descripciones de los productos que hayan requerido el doble de colaboradores fulltime que colaboradores partime.
--13
--Las descripciones de los productos que tuvieron más pedidos sin envíos que con envíos pero que al menos tuvieron un pedido enviado.
--14
--Los nombre y apellidos de los clientes que hayan realizado pedidos en los años 2020, 2021 y 2022 pero que la cantidad de pedidos haya decrecido en cada año. Añadirle al listado aquellos clientes que hayan realizado exactamente la misma cantidad de pedidos en todos los años y que dicha cantidad no sea cero.

