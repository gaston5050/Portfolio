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

	select distinct *  from clientes c 
	where c.id not in (
	select p.idCliente from Pedidos p
	inner join productos pro on pro.id =p.IDProducto
	inner join Materiales_x_Producto mxp on pro.id = mxp.IDProducto
	inner join materiales mat on mat.ID = mxp.IDMaterial
	where year(p.FechaSolicitud) = 2022 and mat.Nombre ='Pino' and p.IDCliente= c.id)


SELECT * FROM Clientes C
WHERE Not Exists (
    SELECT DISTINCT P.IDCLIENTE FROM Pedidos P
    INNER JOIN Productos PRO ON PRO.ID = P.IDProducto
    INNER JOIN Materiales_x_Producto MxP ON MxP.IDProducto = PRO.ID
    INNER JOIN Materiales MAT ON MAT.ID = MxP.IDMaterial
    WHERE MAT.Nombre = 'Pino' AND YEAR(P.FechaSolicitud) = 2022 AND P.IDCliente = C.ID
)



--4
--Los colaboradores que no hayan realizado ninguna tarea de Lijado en
--pedidos que se solicitaron en el año 2021.
select c.* from colaboradores c where not exists (
select p.* from pedidos p
inner join Tareas_x_Pedido txp on p.ID= txp.IDPedido
inner join tareas t on txp.IDTarea = t.id
where t.Nombre <> 'Lizado' and year(p.FechaSolicitud) = 2021 and c.Legajo = txp.Legajo)



select * from colaboradores

 
--5
--Los clientes a los que les hayan enviado (no necesariamente entregado) al menos un tercio de sus pedidos.

select * from (select c.apellidos, c.nombres,
(select count(*) from pedidos p where p.idCliente=c.id) cantPedidos,
(select count(*) from pedidos p inner join envios e on e.IDPedido = p.id
where p.IDCliente = c.id) cantEnviados from clientes c) tabla
where tabla.cantEnviados >= tabla.cantPedidos/3.0






--6
--Los colaboradores que hayan realizado todas las tareas (no necesariamente en un mismo pedido).


	Select * From (
    Select Cli.Apellidos, Cli.Nombres,
    (
        Select count(*) From Pedidos PE Where PE.IDCliente = Cli.ID
    ) as CantPedidos,
    (
        Select count(*) From Pedidos PE 
        Inner Join Envios E ON E.IDPedido = PE.ID
        Where PE.IDCliente = Cli.ID
    ) as CantEnviados
    From Clientes Cli
) As Tabla
Where Tabla.CantEnviados >= Tabla.CantPedidos/3.0

--7
--Por cada producto, la descripción y la cantidad de colaboradores
--fulltime que hayan trabajado en él y la cantidad de colaboradores parttime.

	SELECT Pro.DESCRIPCION, (
		select count(distinct txp.legajo) from Tareas_x_Pedido txp
		inner join colaboradores c on c.Legajo = txp.Legajo
		inner join pedidos p on p.id = txp.IDPedido
		where c.ModalidadTrabajo = 'p' and p.id = txp.IDPedido

	)

	FROM PRODUCTOS Pro
	select * from Tareas_x_Pedido order by Tareas_x_Pedido.IDPedido


	SELECT PR.Descripcion, (
SELECT COUNT(DISTINCT CO.Legajo) FROM Pedidos PE
INNER JOIN Tareas_x_Pedido TXP ON TXP.IDPedido = PE.ID
INNER JOIN Colaboradores CO ON CO.Legajo = TXP.Legajo
WHERE CO.ModalidadTrabajo = 'F' AND PR.ID = PE.IDProducto
) AS 'FULLTIME', (
SELECT COUNT(DISTINCT CO.Legajo) FROM Pedidos PE
INNER JOIN Tareas_x_Pedido TXP ON TXP.IDPedido = PE.ID
INNER JOIN Colaboradores CO ON CO.Legajo = TXP.Legajo
WHERE CO.ModalidadTrabajo = 'P' AND PR.ID = PE.IDProducto
) AS 'PARTTIME'
FROM Productos PR


 select pro.Descripcion , (
 select count(distinct c.legajo) from pedidos p
 inner join tareas_x_pedido txp on p.id = txp.IDPedido
 inner join colaboradores c on txp.Legajo = c.Legajo
where c.ModalidadTrabajo = 'P' and pro.id = p.IDProducto) PARTIME,
 (
 select count(distinct c.legajo) from pedidos p
 inner join tareas_x_pedido txp on p.id = txp.IDPedido
 inner join colaboradores c on txp.Legajo = c.Legajo
where c.ModalidadTrabajo = 'F' and pro.id = p.IDProducto) FULLTIME

from productos pro


--8
--Por cada producto, la descripción y la cantidad de pedidos enviados y
--la cantidad de pedidos sin envío.

SELECT PRO.DESCRIPCION,( select count(distinct p.id) from envios e
inner join pedidos p on e.IDPedido = p.ID
where p.IDProducto = pro.id ) enviado,


(select count(distinct pe.id) from pedidos pe
--inner join envios env on env.IDPedido =  pe.id
where pe.IDProducto = pro. id and pe.id not in(select idPedido from envios))

from productos pro 

FROM PRODUCTOS


select p.id from pedidos p
inner join envios e on p.id = e.IDPedido
where p.id in ( select pe.id from pedidos pe
inner join envios e on pe.id = e.IDPedido)





--9
--Por cada cliente, apellidos y nombres y la cantidad de pedidos
--solicitados en los años 2020, 2021 y 2022. (Cada año debe mostrarse en una columna separada)
select c.nombres , c.apellidos,
( select count(distinct pe.id) from pedidos pe

where year(pe.FechaSolicitud) = 2022 andN  = pe.IDClientE
 )



from clientes c






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

