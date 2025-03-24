#activar base de datos
use proyecto2;

# -------------- Inserciones Cliente ------------------------

# Inserción de países
INSERT INTO pais (nombre)
VALUES 
    ("Honduras"),
    ("Mexico"),
    ("USA");

# Inserción de ciudades
INSERT INTO ciudad (nombre, id_pais)
VALUES 
    ("Ciudad de Mexico", 1);

# Inserción de domicilios
INSERT INTO domicilio (direccion, id_ciudad)
VALUES 
    ("AV. Reforma 200", 1);

# Inserción de clientes
INSERT INTO cliente 
    (nombre, apellido, organizacion, cargo, numPasaporte, 
     fechaNacimiento, nacionalidad, telefono, fax, email, id_domicilio) 
VALUES 
    ('Carlos', 
     'González', 
     'Empresa A', 
     'Gerente', 
     'X123456', 
     '1985-05-10', 
     'Mexicano', 
     '555-1234', 
     '555-5678', 
     'carlos@email.com', 
     1);

# Consulta para verificar la inserción de clientes
SELECT * FROM proyecto2.cliente;

# ------------------------ Inserciones Hotel ------------------------------------------

# Inserción de hoteles
INSERT INTO hotel (nombre)
VALUES 
    ("Plaza San Francisco"), 
    ("Caesar Business Santiago"), 
    ("Sheraton Santiago"), 
    ("San Cristobal Tower");

# Inserción de tipos de habitación
INSERT INTO tipoHabitacion (tipoHabitacion)
VALUES
    ("Standard"), 
    ("Classic"), 
    ("Grand Deluxe");

# Inserción de tipos de acomodación
INSERT INTO acomodacion (tipo)
VALUES 
    ("single"), 
    ("doble"), 
    ("twin");

# Inserción de habitaciones
INSERT INTO habitacion (id_hotel, id_tipoHabitacion, id_acomodacion, precio)
VALUES 
    (1, 1, 1, 125.00);

# Consulta para verificar la inserción de habitaciones
SELECT * FROM habitacion;

# --------------------------- Inserciones Tarjeta ---------------------------------------

# Inserción de tipos de tarjeta
INSERT INTO tipoTarjeta (tipo)
VALUES 
    ('AMEX'), 
    ('VISA'), 
    ('MasterCard'), 
    ('Diners');

# Inserción de tarjetas
INSERT INTO tarjeta (numTarjeta, fechaVencimiento, nombreTitular, id_cliente, id_tipoTarjeta)
VALUES 
    ('9999-9999-9999-9999', '2025/01/15', 'Carlos Gonzales', 1, 1);

# Consulta para verificar la inserción de tarjetas
SELECT * FROM proyecto2.tarjeta;
