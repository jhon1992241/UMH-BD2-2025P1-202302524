#activar base de datos
use proyecto2;

# ------------------ Función Total a pagar ----------------------------------

DELIMITER //
CREATE FUNCTION proyecto2.fn_get_total (
    p_precio DOUBLE,       # Precio por noche de la habitación
    p_numNoches DOUBLE     # Número de noches de la reserva
)
RETURNS DOUBLE DETERMINISTIC
BEGIN 
    DECLARE total DOUBLE;  # Variable para almacenar el total a pagar

    # Calcular el total a pagar
    SET total = p_precio * p_numNoches; 
    RETURN total;
END // DELIMITER ;

# Llamada a la función para calcular el total a pagar
# Orden para ingresar los parametros (p_precio, p_numNoches) 
SELECT fn_get_total(142, 3) AS Total;

# ---------------------- Función Cantidad de Reservaciones -------------------

DELIMITER //
CREATE FUNCTION proyecto2.fn_get_reservaciones (
    p_id_cliente INT       # ID del cliente para contar sus reservas
)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_count INT;   # Variable para almacenar el número de reservas

    # Contar las reservas del cliente
    SELECT COUNT(*) INTO v_count 
    FROM reserva 
    WHERE id_cliente = p_id_cliente;

    RETURN v_count;
END // DELIMITER ;

# Llamada a la función para obtener la cantidad de reservaciones de un cliente
# Orden para ingresar los parametros (p_id_cliente)
SELECT fn_get_reservaciones(1) AS Reservaciones;

# ---------------------- Función Confirmación de Reservaciones -------------------

DELIMITER //
CREATE FUNCTION proyecto2.fn_confirmacion (
    id_cliente INT,        # ID del cliente para obtener su nombre
    id_hotel INT           # ID del hotel para obtener su nombre
)
RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
    DECLARE cliente VARCHAR(45);  # Variable para almacenar el nombre del cliente
    DECLARE hotel VARCHAR(45);    # Variable para almacenar el nombre del hotel

    # Obtener el nombre completo del cliente
    SET cliente = (
        SELECT CONCAT(nombre, " ", apellido) 
        FROM cliente 
        WHERE id_cliente = id_cliente
    );

    # Obtener el nombre del hotel
    SET hotel = (
        SELECT nombre 
        FROM hotel 
        WHERE id_hotel = id_hotel 
        LIMIT 1
    );

    # Verificar si el hotel existe y retornar el mensaje correspondiente
    IF hotel IS NOT NULL THEN
        RETURN CONCAT(cliente, " gracias por su reservación en el hotel ", hotel);
    ELSE
        RETURN CONCAT(cliente, " no tiene hotel asignado");
    END IF;
END // DELIMITER ;

# Llamada a la función para obtener la confirmación de la reserva
# Orden para ingresar los parametros (id_cliente, id_hotel)
SELECT fn_confirmacion(1, 1) AS Confirmacion;
