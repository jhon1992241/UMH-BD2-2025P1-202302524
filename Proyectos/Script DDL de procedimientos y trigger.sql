use proyecto2;
#Creacion del procedimiento para agregar una nueva reserva
delimiter //
create procedure sp_new_reserva (
    in p_fechaArribo date,
    in p_fechaSalida date,
	in p_vueloArribo date, 
	in p_vueloSalida date,
	IN p_early_check_in varchar(45),
	in p_id_cliente int,
	in p_id_tarjeta int,
	in p_id_habitacion int
)
begin

	# Declaración de variables 
	declare v_fechaArribo date;
	declare v_fechaSalida date;
	declare v_numNoches int;
	declare v_vueloArribo date;
	declare v_vueloSalida date;
	declare v_early_check_in varchar(45);
	declare v_id_cliente int;
	declare v_id_tarjeta int;
	declare v_id_habitacion int;
    declare v_cExiste int;
    declare v_tExiste int;
    declare v_hExiste int;
    
    # Asignación de los parámetros de entrada
    set v_fechaArribo = p_fechaArribo;
    set v_fechaSalida = p_fechaSalida;
    set v_vueloArribo = p_vueloArribo;
    set v_vueloSalida = p_vueloSalida;
    set v_early_check_in = p_early_check_in;
    set v_id_cliente = p_id_cliente;
    set v_id_tarjeta = p_id_tarjeta;
    set v_id_habitacion = p_id_habitacion;
    
    #calcular de forma automatica el numero de noches
    set v_numNoches = datediff (p_fechaSalida, v_fechaArribo);
    
    #Consultas para verrificar que las llaves foraneas existen
    select count(*) into v_cExiste from cliente where id_cliente = p_id_cliente;
    select count(*) into v_tExiste from tarjeta where id_tarjeta = p_id_tarjeta;
    select count(*) into v_hExiste from habitacion where id_habitacion = p_id_habitacion;
    
    #Condicion para verificar que el registro de noches sea correcto
    if p_fechaSalida <= p_fechaArribo then
		select "La fecha de salida debe de ser posterior a la hora de llegada" as Resultado;
	
    #Condicion para verificar que el cliente no llegue antes de la fecha sin confirmacion
    elseif p_vueloArribo < p_fechaArribo and p_early_check_in = "No" then
		select "El cliente no puede llegar antes de la fecha sin confirmar antes" as Resultado;
     
	#Condicion para verificar que la hora de salida del vuelo coincida con la del hotel
	elseif p_vueloSalida <= p_fechaSalida then
		select "La fecha de salida del vuelo debe de ser mayor a la fecha de salida del hotel" as Resultado;
     
	#Condicion para verificar si el cliente existe
    elseif v_cExiste = 0 then
		SELECT "El cliente no existe, no se puede realizar el registro de reserva" AS Resultado;
        
    #Condicion para verificar si la tarjeta existe  
	elseif v_tExiste = 0 then
		select "La tarjeta no existe, no se puede realizar el registro de reserva" AS Resultado;
        
    #Condicion para verificar si la habitacion existe
    elseif v_hExiste = 0 then
		select "La habitacion no existe, no se puede realizar el registro de reserva" AS Resultado;
    
    else 
		# Inserción de datos en la tabla reserva
		insert into proyecto2.reserva 
			(fechaArribo, fechaSalida, numNoches, vueloArribo, vueloSalida, 
			early_check_in, id_cliente, id_tarjeta, id_habitacion)
			values 
				(v_fechaArribo, v_fechaSalida, v_numNoches, v_vueloArribo, v_vueloSalida, 
				v_early_check_in, v_id_cliente, v_id_tarjeta, v_id_habitacion);
	end if;

end // DELIMITER ;

# Llamada al procedimiento para agregar datos a la tabla reserva
call sp_new_reserva (
					 "2023-11-30", #fechaArrivo
					 "2023-12-5", #fechaSalida
                     "2023-11-30", #vueloArrivo
                     "2023-12-6", #vueloSalida
                     "Si", #early_check_in
                     3, #id_cliente
                     2, #id_tarjeta
                     4 #id_habitacion
                     );

select * from reserva;


/* truncate table loginsercion; */ 

#Creacion de la tabla para las inserciones
create table logInsercion (
	id_log int auto_increment primary key, 
	fecha datetime, 
	evento varchar (45),
    datos varchar (4500)
);

/*
delimiter //
drop trigger tgr_logInsercion // DELIMITER ; 
*/

#Creacion del trigger
delimiter //
create trigger tgr_logInsercion after insert on reserva
for each row
begin 
	declare v_datos varchar (4500);
    
    set v_datos = concat(
		new.id_reserva, ", ", 
		new.fechaArribo, ", ",
		new.fechaSalida, ", ",
		new.numNoches, ", ",
		new.vueloArribo, ", ",
		new.vueloSalida, ", ",
		new.early_check_in, ", ",
		new.id_cliente, ", ",
		new.id_tarjeta, ", ",
		new.id_habitacion
        );

	insert into logInsercion (fecha, evento, datos)
		values (now(), "Insercion", v_datos);

end // DELIMITER ;

select * from logInsercion; 