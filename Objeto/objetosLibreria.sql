USE LibreriaDB;

-- Modificar la tabla Ventas para agregar la columna id_sucursal
-- Esta columna es necesaria para identificar en qué sucursal se realizó la venta
ALTER TABLE Ventas ADD id_sucursal INT;

-- Actualizar las relaciones para incluir id_sucursal
-- Esto asegura la integridad referencial entre las ventas y las sucursales
ALTER TABLE Ventas ADD FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id);

-- Asignar una sucursal aleatoria a las ventas que no tienen id_sucursal asignado
UPDATE Ventas
SET id_sucursal = (
    SELECT id 
    FROM Sucursales
    ORDER BY RAND()  -- Ordenar aleatoriamente
    LIMIT 1          -- Seleccionar una sola sucursal
)
WHERE id_sucursal IS NULL;

-- ========================
-- 1. Funciones
-- ========================

-- Elimina la función StockDisponible si ya existe para evitar conflictos
DROP FUNCTION IF EXISTS StockDisponible;

-- Elimina la función TotalVentasCliente si ya existe para evitar conflictos
DROP FUNCTION IF EXISTS TotalVentasCliente;

-- Cambiar el delimitador para poder crear las funciones correctamente
DELIMITER //

-- Función para calcular el total de ventas de un cliente
-- Parámetros:
--   p_id_cliente: El ID del cliente para el cual se calcularán las ventas
-- Retorna:
--   El total de las ventas realizadas por el cliente en formato DECIMAL(10,2)
CREATE FUNCTION TotalVentasCliente(p_id_cliente INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_ventas DECIMAL(10, 2);
    
    -- Calcula el total de ventas sumando los valores en la tabla Ventas para el cliente especificado
    SELECT COALESCE(SUM(v.total), 0) INTO total_ventas 
    FROM Ventas v
    WHERE v.id_cliente = p_id_cliente;
    
    RETURN total_ventas;
END //

-- Función para calcular el stock disponible de un libro en una sucursal específica
-- Parámetros:
--   id_libro: El ID del libro
--   id_sucursal: El ID de la sucursal
-- Retorna:
--   La cantidad disponible del libro en la sucursal en formato INT
CREATE FUNCTION StockDisponible(id_libro INT, id_sucursal INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stock INT;
    
    -- Consulta la cantidad disponible del libro en la sucursal específica
    SELECT cantidad INTO stock 
    FROM Inventario 
    WHERE id_libro = id_libro AND id_sucursal = id_sucursal;
    
    RETURN stock;
END //

-- Volver al delimitador normal
DELIMITER ;

-- ========================
-- 2. Vistas
-- ========================

DROP VIEW IF EXISTS InventarioPorSucursal;
DROP VIEW IF EXISTS DetallesDevoluciones;
DROP VIEW IF EXISTS ReporteVentasClientes;
DROP VIEW IF EXISTS DetalleVentasPorCliente;
DROP VIEW IF EXISTS ComprarPorEditorial;

-- Vista que muestra el inventario disponible por sucursal
-- Proporciona la cantidad disponible de cada libro en cada sucursal
CREATE VIEW InventarioPorSucursal AS
SELECT s.nombre AS NombreSucursal, 
       l.titulo AS TituloLibro, 
       i.cantidad AS CantidadDisponible
FROM Inventario i
JOIN Sucursales s ON i.id_sucursal = s.id
JOIN Libros l ON i.id_libro = l.id;

-- Vista que muestra los detalles de las devoluciones realizadas
-- Incluye la fecha de devolución, el título del libro, el nombre del cliente, 
-- la cantidad devuelta y el motivo de la devolución
CREATE VIEW DetallesDevoluciones AS
SELECT d.fecha_devolucion, 
       l.titulo AS TituloLibro, 
       c.nombre AS NombreCliente, 
       d.cantidad AS CantidadDevuelta, 
       d.motivo AS Motivo
FROM Devoluciones d
JOIN Libros l ON d.id_libro = l.id
JOIN Ventas v ON d.id_venta = v.id
JOIN Clientes c ON v.id_cliente = c.id;

-- Vista que muestra el total de ventas por cliente
-- Utiliza la función TotalVentasCliente para calcular el total gastado por cada cliente
CREATE VIEW ReporteVentasClientes AS
SELECT c.id, c.nombre AS NombreCliente,
       TotalVentasCliente(c.id) AS TotalGastado
FROM Clientes c;

-- Vista que muestra detalles de las ventas por cliente
-- Incluye la fecha de la venta y el total de cada venta realizada por cada cliente
CREATE VIEW DetalleVentasPorCliente AS
SELECT c.nombre AS NombreCliente, 
       v.id AS VentaID, 
       v.fecha_venta AS FechaVenta, 
       v.total AS TotalVenta
FROM Clientes c
JOIN Ventas v ON c.id = v.id_cliente;

-- Vista que muestra el total gastado en compras por editorial
-- Agrupa por editorial y suma el total de compras realizadas a cada una
CREATE VIEW ComprasPorEditorial AS
SELECT e.nombre AS NombreEditorial, 
       SUM(c.total) AS TotalGastado
FROM Compras c
JOIN Editoriales e ON c.id_editorial = e.id
GROUP BY e.id;

-- ========================
-- 3. Procedimientos Almacenados (Stored Procedures)
-- ========================

DROP PROCEDURE IF EXISTS RegistrarVenta;
DROP PROCEDURE IF EXISTS RegistrarDevolucion;

-- Cambiar el delimitador para crear los procedimientos correctamente
DELIMITER //

-- Procedimiento para registrar una nueva venta y actualizar el inventario
-- Este procedimiento maneja una transacción completa que incluye:
--   1. Registro de la venta en la tabla Ventas
--   2. Registro de los detalles de la venta en Ventas_Libros
--   3. Actualización del inventario de la sucursal específica
CREATE PROCEDURE RegistrarVenta(
    IN p_cliente_id INT,
    IN p_libro_id INT,
    IN p_cantidad INT,
    IN p_total DECIMAL(10, 2),
    IN p_sucursal_id INT
)
BEGIN
    -- Manejador de errores: si ocurre un error, se realiza un ROLLBACK de la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        -- Aqui se podria registrar el error o realizar alguna otra acción, si es necesario
    END;

    -- Iniciar una transacción
    START TRANSACTION;

    -- Inserta la venta en la tabla Ventas
    INSERT INTO Ventas (id_cliente, fecha_venta, total, id_sucursal)
    VALUES (p_cliente_id, CURDATE(), p_total, p_sucursal_id);
    
    -- Obtiene el ID de la venta recién creada
    SET @venta_id = LAST_INSERT_ID();

    -- Inserta los detalles de la venta en Ventas_Libros
    INSERT INTO Ventas_Libros (id_venta, id_libro, cantidad)
    VALUES (@venta_id, p_libro_id, p_cantidad);

    -- Actualiza el inventario en la sucursal correspondiente
    UPDATE Inventario 
    SET cantidad = cantidad - p_cantidad
    WHERE id_libro = p_libro_id
    AND id_sucursal = p_sucursal_id;

    -- Completa la transacción
    COMMIT;
END //

-- Procedimiento para registrar una devolución y actualizar el inventario
-- Este procedimiento maneja una transacción completa que incluye:
--   1. Registro de la devolución en la tabla Devoluciones
--   2. Actualización del inventario para reflejar la devolución
CREATE PROCEDURE RegistrarDevolucion(
    IN p_venta_id INT,
    IN p_libro_id INT,
    IN p_cantidad INT,
    IN p_motivo VARCHAR(255)
)
BEGIN
    -- Manejador de errores: si ocurre un error, se realiza un ROLLBACK de la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        -- Aqui se podria registrar el error o realizar alguna otra acción, si es necesario
    END;

    -- Iniciar una transacción
    START TRANSACTION;

    -- Inserta la devolución en la tabla Devoluciones
    INSERT INTO Devoluciones (id_venta, id_libro, fecha_devolucion, cantidad, motivo)
    VALUES (p_venta_id, p_libro_id, CURDATE(), p_cantidad, p_motivo);

    -- Actualiza el inventario para reflejar la devolución
    UPDATE Inventario 
    SET cantidad = cantidad + p_cantidad
    WHERE id_libro = p_libro_id
    AND id_sucursal = (SELECT id_sucursal FROM Ventas WHERE id = p_venta_id);

    -- Completa la transacción
    COMMIT;
END //

-- Volver al delimitador normal
DELIMITER ;

-- ========================
-- 4. Triggers
-- ========================

DROP TRIGGER IF EXISTS ActualizarInventarioDespuesDevolucion;
DROP TRIGGER IF EXISTS VerificarStockAntesVenta;

-- Cambiar el delimitador para crear los triggers correctamente
DELIMITER //

-- Trigger para actualizar el inventario después de una devolución
-- Este trigger se activa después de que una devolución es insertada en la tabla Devoluciones
-- y se asegura de que el inventario correspondiente se actualice automáticamente
CREATE TRIGGER ActualizarInventarioDespuesDevolucion
AFTER INSERT ON Devoluciones
FOR EACH ROW
BEGIN
    -- Incrementa la cantidad en el inventario al devolver el libro
    UPDATE Inventario 
    SET cantidad = cantidad + NEW.cantidad
    WHERE id_libro = NEW.id_libro 
    AND id_sucursal = (SELECT id_sucursal 
                       FROM Ventas 
                       WHERE id = NEW.id_venta);
END //

-- Trigger para verificar el stock antes de registrar una venta
-- Este trigger se activa antes de que una nueva venta se inserte en la tabla Ventas_Libros
-- y se asegura de que haya suficiente stock disponible en la sucursal
CREATE TRIGGER VerificarStockAntesVenta
BEFORE INSERT ON Ventas_Libros
FOR EACH ROW
BEGIN
    DECLARE stock INT;
    -- Calcula el stock disponible en la sucursal para el libro especificado
    SET stock = StockDisponible(NEW.id_libro, (SELECT id_sucursal FROM Ventas WHERE id = NEW.id_venta));
    
    -- Si no hay suficiente stock, se lanza un error
    IF stock < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para la venta';
    END IF;
END //

-- Volver al delimitador normal
DELIMITER ;
