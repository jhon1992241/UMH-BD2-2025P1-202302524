#activar base de datos
use proyecto2;

# ------------- Actualizar tabla Tarjeta -----------------------------------------  

DELIMITER //
CREATE PROCEDURE proyecto2.sp_tarjeta_upd (
    IN p_id_tarjeta INT,             
    IN p_id_cliente INT,              
    IN p_tipoTarjeta INT,              
    IN p_numTarjeta VARCHAR(45),      
    IN p_fechaVencimiento DATE,        
    IN p_nombreTitular VARCHAR(45)     
)
BEGIN
    DECLARE v_idExiste INT;

    # Verifica si la tarjeta existe
    SELECT COUNT(*) INTO v_idExiste
    FROM tarjeta
    WHERE id_tarjeta = p_id_tarjeta;

    # Condición para realizar el update de la tabla tarjeta
    IF v_idExiste > 0 THEN
        UPDATE tarjeta
        SET numTarjeta = p_numTarjeta,
            fechaVencimiento = p_fechaVencimiento,
            nombreTitular = p_nombreTitular,
            id_cliente = p_id_cliente,
            id_tipoTarjeta = p_tipoTarjeta
        WHERE id_tarjeta = p_id_tarjeta;
    ELSE
        SELECT 'No se puede realizar el proceso' AS Resultado;
    END IF;
END // DELIMITER ;

/* Llamada al procedimiento para actualizar la tarjeta.
 Parametros (p_id_tarjeta, p_id_cliente, p_tipoTarjeta, 
p_numTarjeta, p_fechaVencimiento, p_nombreTitular); */

CALL proyecto2.sp_tarjeta_upd(1, 1, 1, '8888-8888-8888-8888', '2025/02/24', 'Carlos Gonzales');

# Consulta para verificar la actualización de la tarjeta
SELECT * FROM tarjeta;

# ----------------- Actualizar tabla de habitacion --------------------------

DELIMITER //
CREATE PROCEDURE proyecto2.sp_habitacion_upd (
    IN p_id_habitacion INT,            
    IN p_precio DECIMAL(10, 2),       
    IN p_id_hotel INT,                 
    IN p_id_tipoHabitacion INT,        
    IN p_id_acomodacion INT            
)
BEGIN
    DECLARE v_idExiste INT;

    # Verifica si la habitación existe
    SELECT COUNT(*) INTO v_idExiste
    FROM habitacion
    WHERE id_habitacion = p_id_habitacion;

    # Condición para realizar el update de la tabla habitacion
    IF v_idExiste > 0 THEN
        UPDATE habitacion
        SET precio = p_precio,
            id_hotel = p_id_hotel,
            id_tipoHabitacion = p_id_tipoHabitacion,
            id_acomodacion = p_id_acomodacion
        WHERE id_habitacion = p_id_habitacion;
    ELSE
        SELECT 'No se puede realizar el proceso' AS Resultado;
    END IF;
END // DELIMITER ;

/* Llamada al procedimiento para actualizar la habitación.
Parametros (p_id_habitacion, p_precio, p_id_hotel, p_id_tipoHabitacion, p_id_acomodacion); */

CALL sp_habitacion_upd(
	1, 
    190.00, 
    3, 
    2, 
    2
    );

# Consulta para verificar la actualización de la habitación
SELECT * FROM habitacion;

# ------------------------- Actualizar tabla de cliente -----------------------------------------

DELIMITER //
CREATE PROCEDURE proyecto2.sp_cliente_upd (
    IN p_id_cliente INT,               
    IN p_nombre VARCHAR(45),          
    IN p_apellido VARCHAR(45),        
    IN p_organizacion VARCHAR(45),    
    IN p_cargo VARCHAR(45),            
    IN p_numPasaporte VARCHAR(45),     
    IN p_fechaNacimiento DATE,         
    IN p_nacionalidad VARCHAR(45),   
    IN p_telefono VARCHAR(45),        
    IN p_fax VARCHAR(45),            
    IN p_email VARCHAR(45),           
    IN p_id_domicilio INT              
)
BEGIN
    DECLARE v_idExiste INT;

    # Verifica si el cliente existe
    SELECT COUNT(*) INTO v_idExiste
    FROM cliente
    WHERE id_cliente = p_id_cliente;

    # Condición para realizar el update de la tabla cliente
    IF v_idExiste > 0 THEN
        UPDATE cliente
        SET id_cliente = p_id_cliente,
            nombre = p_nombre,
            apellido = p_apellido,
            organizacion = p_organizacion,
            cargo = p_cargo,
            numPasaporte = p_numPasaporte,
            fechaNacimiento = p_fechaNacimiento,
            nacionalidad = p_nacionalidad,
            telefono = p_telefono,
            fax = p_fax,
            email = p_email,
            id_domicilio = p_id_domicilio
        WHERE id_cliente = p_id_cliente;
    ELSE
        SELECT 'No se puede realizar el proceso' AS Resultado;
    END IF;
END // DELIMITER ;

/* Llamada al procedimiento para actualizar el cliente.
parametros (p_id_cliente, p_nombre, p_apellido, p_organizacion, p_cargo, 
p_numPasaporte, p_fechaNacimiento, p_nacionalidad, p_telefono, 
p_fax, p_email, p_id_domicilio); */

CALL proyecto2.sp_cliente_upd(
	1, 
    'Gustavo', 
    'Ferrufino', 
    'Empresa B', 
    'Gerente General', 
    'Z123456', 
    '1990/05/30', 
    'Americano', '
    9885-2587', 
    '9885-2588', 
    'gferrufino@email.com', 
    1
    );

# Consulta para verificar la actualización del cliente
SELECT * FROM cliente;
