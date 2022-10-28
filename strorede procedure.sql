create view stock as select * from productos

select * from stock 

alter view stock as 
select id, descripcion from productos

alter view stock as 
select id, descripcion, precioventamayorista from productos

select * from productos

create  procedure sp_todosLosProductos as
begin 
select * from Productos
end

exec sp_todosLosProductos

alter procedure sp_todosLosProductos
as
begin 
	select p.* from productos p
	where p.ID < 10
end

exec sp_todosLosProductos

exec sp_todosLosProductos

drop procedure sp_todosLosProductos

create  procedure sp_todosLosProductos as
begin 
select id,Descripcion, Estado from Productos
end


create procedure tresYtres(@X int ,@descri varchar(50) )
as
begin 
select * from Productos where id = @X
select * from productos Where Descripcion = @descri

end

exec tresytres 3,'Silla Paris'

drop procedure tresYtres

select * from productos Where Descripcion ='Silla Paris'