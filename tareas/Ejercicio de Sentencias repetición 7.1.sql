DELIMITER 

CREATE PROCEDURE SimuladorAhorro(
    IN monto DECIMAL(10, 2),
    IN meses INT
)
BEGIN
    DECLARE mes INT DEFAULT 1;
    DECLARE saldo_acumulado DECIMAL(10, 2) DEFAULT 0;

    -- Crear una tabla temporal para almacenar los resultados
    CREATE TEMPORARY TABLE IF NOT EXISTS AhorroSimulador (
        Mes INT,
        Monto DECIMAL(10, 2),
        SaldoAcumulado DECIMAL(10, 2)
    );

    -- Borrar los datos previos si existiera la tabla
    DELETE FROM AhorroSimulador;

    -- Llenar la tabla temporal con los datos de la simulación
    WHILE mes <= meses DO
        SET saldo_acumulado = saldo_acumulado + monto;
        INSERT INTO AhorroSimulador (Mes, Monto, SaldoAcumulado)
        VALUES (mes, monto, saldo_acumulado);
        SET mes = mes + 1;
    END WHILE;

    -- Mostrar el resultado
    SELECT * FROM AhorroSimulador;

    -- Limpiar la tabla temporal 
    DROP TEMPORARY TABLE IF EXISTS AhorroSimulador;
END 

DELIMITER ;	