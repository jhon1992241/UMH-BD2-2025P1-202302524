/* creacion de la tabla cuenta*/
CREATE TABLE cuentas (
    numero_cuenta INT PRIMARY KEY,
    saldo DECIMAL(15, 2) DEFAULT 0,
    total_debitos DECIMAL(15, 2) DEFAULT 0,
    total_creditos DECIMAL(15, 2) DEFAULT 0
);

/* creacion de la tabla transacciones*/
CREATE TABLE transacciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_cuenta INT,
    tipo_transaccion ENUM('DEBITO', 'CREDITO') NOT NULL,
    monto DECIMAL(15, 2) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (numero_cuenta) REFERENCES cuentas(numero_cuenta)
);

INSERT INTO cuentas (numero_cuenta, saldo) VALUES
(101, 1000.00),
(102, 1500.00);

DELIMITER 

DROP PROCEDURE IF EXISTS realizar_transaccion;

CREATE PROCEDURE realizar_transaccion(
    IN p_numero_cuenta INT,
    IN p_tipo_transaccion ENUM('DEBITO', 'CREDITO'),
    IN p_monto DECIMAL(15, 2)
)
BEGIN
    DECLARE v_saldo_actual DECIMAL(15, 2);
    DECLARE v_total_debitos DECIMAL(15, 2);
    DECLARE v_total_creditos DECIMAL(15, 2);
    
    -- Validar que la cuenta existe
    IF NOT EXISTS (SELECT 1 FROM cuentas WHERE numero_cuenta = p_numero_cuenta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cuenta no existe';
    END IF;

    -- Validar que el monto no sea negativo para transacciones de débito
    IF p_tipo_transaccion = 'DEBITO' AND p_monto <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto para débito debe ser positivo';
    END IF;

    -- Validar que el saldo sea suficiente para una transacción de débito
    IF p_tipo_transaccion = 'DEBITO' THEN
        SELECT saldo INTO v_saldo_actual FROM cuentas WHERE numero_cuenta = p_numero_cuenta;
        IF v_saldo_actual < p_monto THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente para realizar el débito';
        END IF;
    END IF;

    -- Registrar la transacción en la tabla de transacciones
    INSERT INTO transacciones (numero_cuenta, tipo_transaccion, monto)
    VALUES (p_numero_cuenta, p_tipo_transaccion, p_monto);

    -- Actualizar los totales de débitos o créditos en la tabla de cuentas
    IF p_tipo_transaccion = 'DEBITO' THEN
        UPDATE cuentas
        SET saldo = saldo - p_monto,
            total_debitos = total_debitos + p_monto
        WHERE numero_cuenta = p_numero_cuenta;
    ELSEIF p_tipo_transaccion = 'CREDITO' THEN
        UPDATE cuentas
        SET saldo = saldo + p_monto,
            total_creditos = total_creditos + p_monto
        WHERE numero_cuenta = p_numero_cuenta;
    END IF;

END

DELIMITER ;
-- Ejecutar el procedimiento almacenado para una transacción de débito
CALL realizar_transaccion(101, 'DEBITO', 100);

-- Ejecutar el procedimiento almacenado para una transacción de crédito
CALL realizar_transaccion(102, 'CREDITO', 200);
