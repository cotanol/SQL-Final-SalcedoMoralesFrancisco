-- Eliminar la base de datos si ya existe
DROP DATABASE IF EXISTS LibreriaDB;

-- Crear la base de datos
CREATE DATABASE LibreriaDB;

-- Usar la base de datos creada
USE LibreriaDB;

-- Crear la tabla Categorias
CREATE TABLE Categorias (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada categoría
    nombre VARCHAR(255) NOT NULL       -- Nombre de la categoría
) COMMENT = 'Tabla que almacenara la Categoria de los Libros';

-- Crear la tabla Editoriales
CREATE TABLE Editoriales (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada editorial
    nombre VARCHAR(255) NOT NULL,      -- Nombre de la editorial
    pais VARCHAR(100)                  -- País de origen de la editorial
) COMMENT = 'Tabla que almacena las Editoriales de los Libros';

-- Crear la tabla Autores
CREATE TABLE Autores (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada autor
    nombre VARCHAR(255) NOT NULL,      -- Nombre del autor
    apellido VARCHAR(255) NOT NULL     -- Apellido del autor
) COMMENT = 'Tabla que almacenara los Autores de los Libros';

-- Crear la tabla Libros
CREATE TABLE Libros (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada libro
    titulo VARCHAR(255) NOT NULL,      -- Título del libro
    id_categoria INT,                  -- Identificador de la categoría del libro
    id_editorial INT,                  -- Identificador de la editorial del libro
    fecha_publicacion DATE,            -- Fecha de publicación del libro
    precio DECIMAL(10, 2),             -- Precio del libro
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id), -- Relación con la tabla Categorias
    FOREIGN KEY (id_editorial) REFERENCES Editoriales(id) -- Relación con la tabla Editoriales
) COMMENT = 'Tabla que almacenara los Libros';

-- Crear la tabla Clientes
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada cliente
    nombre VARCHAR(255) NOT NULL,      -- Nombre del cliente
    email VARCHAR(255) UNIQUE NOT NULL,-- Correo electrónico del cliente, debe ser único
    telefono VARCHAR(20)               -- Teléfono del cliente
) COMMENT = 'Tabla que almacenara a los Clientes';

-- Crear la tabla Sucursales
CREATE TABLE Sucursales (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada sucursal
    nombre VARCHAR(255) NOT NULL,      -- Nombre de la sucursal
    direccion VARCHAR(255) NOT NULL,   -- Dirección de la sucursal
    ciudad VARCHAR(100) NOT NULL,      -- Ciudad donde se encuentra la sucursal
    pais VARCHAR(100) NOT NULL         -- País donde se encuentra la sucursal
) COMMENT = 'Tabla que almacenara las Sucursales';

-- Crear la tabla Empleados
CREATE TABLE Empleados (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada empleado
    nombre VARCHAR(255) NOT NULL,      -- Nombre del empleado
    apellido VARCHAR(255) NOT NULL,    -- Apellido del empleado
    id_sucursal INT,                   -- Identificador de la sucursal donde trabaja el empleado
    puesto VARCHAR(255),               -- Puesto del empleado
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id) -- Relación con la tabla Sucursales
) COMMENT = 'Tabla que almacenara a los Empleados';

-- Crear la tabla de Proveedores
CREATE TABLE Proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada proveedor
    nombre VARCHAR(255) NOT NULL,      -- Nombre del proveedor
    contacto VARCHAR(255),             -- Información de contacto del proveedor
    direccion VARCHAR(255)             -- Dirección del proveedor
) COMMENT = 'Tabla que almacena los proveedores de libros';

-- Crear la tabla Ventas
CREATE TABLE Ventas (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada venta
    id_cliente INT,                    -- Identificador del cliente que realizó la compra
    fecha_venta DATE NOT NULL,         -- Fecha de la venta
    total DECIMAL(10, 2),              -- Total de la venta
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id) -- Relación con la tabla Clientes
) COMMENT = 'Tabla que almacenara las ventas';

-- Crear la tabla de Inventario
CREATE TABLE Inventario (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada registro
    id_libro INT,                      -- Identificador del libro
    id_sucursal INT,                   -- Identificador de la sucursal
    cantidad INT NOT NULL,             -- Cantidad disponible del libro en la sucursal
    FOREIGN KEY (id_libro) REFERENCES Libros(id), -- Relación con la tabla Libros
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id) -- Relación con la tabla Sucursales
) COMMENT = 'Tabla que almacena el inventario de libros en cada sucursal';

-- Crear la tabla de Compras
CREATE TABLE Compras (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada compra
    id_editorial INT,                  -- Identificador de la editorial proveedora
    fecha_compra DATE NOT NULL,        -- Fecha de la compra
    total DECIMAL(10, 2),              -- Total de la compra
    FOREIGN KEY (id_editorial) REFERENCES Editoriales(id) -- Relación con la tabla Editoriales
) COMMENT = 'Tabla que almacena las compras realizadas a las editoriales';

-- Crear la tabla Devoluciones
CREATE TABLE Devoluciones (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada devolución
    id_venta INT,                      -- Identificador de la venta original asociada a la devolución
    id_libro INT,                      -- Identificador del libro devuelto
    fecha_devolucion DATE NOT NULL,    -- Fecha en que se realizó la devolución
    cantidad INT NOT NULL,             -- Cantidad de libros devueltos
    motivo VARCHAR(255),               -- Motivo de la devolución
    FOREIGN KEY (id_venta) REFERENCES Ventas(id), -- Relación con la tabla Ventas
    FOREIGN KEY (id_libro) REFERENCES Libros(id)  -- Relación con la tabla Libros
) COMMENT = 'Tabla que almacena las devoluciones de libros';

-- Crear la tabla intermedia Libros_Autores
CREATE TABLE Libros_Autores (
    id_libro INT,                      -- Identificador del libro
    id_autor INT,                      -- Identificador del autor
    PRIMARY KEY (id_libro, id_autor),  -- Clave primaria compuesta por el id del libro y del autor
    FOREIGN KEY (id_libro) REFERENCES Libros(id), -- Relación con la tabla Libros
    FOREIGN KEY (id_autor) REFERENCES Autores(id) -- Relación con la tabla Autores
) COMMENT = 'Tabla intermedia entre Libro y Autores';

-- Crear la tabla intermedia Ventas_Libros
CREATE TABLE Ventas_Libros (
    id_venta INT,                      -- Identificador de la venta
    id_libro INT,                      -- Identificador del libro
    cantidad INT,                      -- Cantidad de libros vendidos
    PRIMARY KEY (id_venta, id_libro),  -- Clave primaria compuesta por el id de la venta y del libro
    FOREIGN KEY (id_venta) REFERENCES Ventas(id), -- Relación con la tabla Ventas
    FOREIGN KEY (id_libro) REFERENCES Libros(id)  -- Relación con la tabla Libros
) COMMENT = 'Tabla intermedia Venta y Libro';

-- Crear la tabla RegistroVentas
CREATE TABLE RegistroVentas (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada registro
    id_venta INT,                      -- Identificador de la venta registrada
    fecha_insercion DATETIME           -- Fecha y hora de la inserción del registro
) COMMENT = 'Tabla para ver en que momento fue la insercion de la Venta en la BD';


USE LibreriaDB;

-- ========================
-- 1. Insertar Datos en Tablas
-- ========================

-- Insertar categorías
INSERT INTO Categorias (nombre) VALUES 
('Ficción'), 
('No Ficción'), 
('Ciencia'), 
('Historia'), 
('Fantasía'), 
('Biografía'), 
('Tecnología'), 
('Aventura'), 
('Misterio'), 
('Romance'), 
('Humor'), 
('Drama'), 
('Poesía'), 
('Ensayo'), 
('Cómic'), 
('Terror'), 
('Política'), 
('Negocios'), 
('Salud'), 
('Educación');

-- Insertar editoriales
INSERT INTO Editoriales (nombre, pais) VALUES 
('Editorial A', 'España'), 
('Editorial B', 'México'), 
('Editorial C', 'Argentina'), 
('Editorial D', 'Colombia'), 
('Editorial E', 'Chile'), 
('Editorial F', 'Perú'), 
('Editorial G', 'Brasil'), 
('Editorial H', 'Uruguay'), 
('Editorial I', 'Paraguay'), 
('Editorial J', 'Bolivia'), 
('Editorial K', 'Venezuela'), 
('Editorial L', 'Ecuador'), 
('Editorial M', 'Panamá'), 
('Editorial N', 'Costa Rica'), 
('Editorial O', 'Guatemala'), 
('Editorial P', 'Honduras'), 
('Editorial Q', 'El Salvador'), 
('Editorial R', 'Nicaragua'), 
('Editorial S', 'Cuba'), 
('Editorial T', 'República Dominicana');

-- Insertar autores
INSERT INTO Autores (nombre, apellido) VALUES 
('Gabriel', 'García Márquez'), 
('Isabel', 'Allende'), 
('Jorge', 'Luis Borges'), 
('Mario', 'Vargas Llosa'), 
('Julio', 'Cortázar'), 
('Pablo', 'Neruda'), 
('Octavio', 'Paz'), 
('Gabriela', 'Mistral'), 
('Laura', 'Esquivel'), 
('Carlos', 'Fuentes'), 
('Roberto', 'Bolaño'), 
('Alejo', 'Carpentier'), 
('Juan', 'Rulfo'), 
('Javier', 'Marías'), 
('César', 'Vallejo'), 
('Rosa', 'Montero'), 
('Almudena', 'Grandes'), 
('Elena', 'Poniatowska'), 
('Manuel', 'Vázquez Montalbán'), 
('Joaquín', 'Sabina');

-- Insertar libros
INSERT INTO Libros (titulo, id_categoria, id_editorial, fecha_publicacion, precio) 
VALUES 
('Cien Años de Soledad', 1, 1, '1967-06-05', 19.99), 
('La Casa de los Espíritus', 1, 2, '1982-10-20', 17.99),
('El Aleph', 1, 3, '1949-07-15', 15.50),
('Conversación en La Catedral', 1, 4, '1969-05-18', 22.00),
('Rayuela', 1, 5, '1963-10-25', 18.75),
('Ficciones', 1, 3, '1944-01-01', 14.99),
('Crónica de una Muerte Anunciada', 1, 1, '1981-04-01', 16.00),
('Los Detectives Salvajes', 1, 11, '1998-04-05', 23.50),
('Pedro Páramo', 1, 14, '1955-03-15', 12.75),
('El Llano en Llamas', 1, 14, '1953-10-01', 14.00),
('El Amante Japonés', 2, 2, '2015-05-28', 19.00),
('La Fiesta del Chivo', 2, 4, '2000-11-08', 21.50),
('La Tregua', 2, 6, '1960-03-15', 16.50),
('Las Armas Secretas', 3, 5, '1959-01-01', 17.25),
('Sobre Héroes y Tumbas', 3, 3, '1961-05-01', 18.00),
('Ensayo sobre la Ceguera', 2, 7, '1995-09-20', 20.00),
('La Sombra del Viento', 1, 8, '2001-04-05', 25.00),
('El Código Da Vinci', 9, 9, '2003-03-18', 22.00),
('Harry Potter y la Piedra Filosofal', 5, 10, '1997-06-26', 15.99),
('El Señor de los Anillos', 5, 11, '1954-07-29', 29.99);

-- Insertar clientes
INSERT INTO Clientes (nombre, email, telefono) 
VALUES 
('Juan Pérez', 'juan.perez@example.com', '1234567890'), 
('María García', 'maria.garcia@example.com', '0987654321'),
('Carlos López', 'carlos.lopez@example.com', '5551234567'),
('Ana Torres', 'ana.torres@example.com', '5559876543'),
('Luis González', 'luis.gonzalez@example.com', '5556789012'),
('Laura Martínez', 'laura.martinez@example.com', '5552345678'),
('Pedro Sánchez', 'pedro.sanchez@example.com', '5553456789'),
('Lucía Fernández', 'lucia.fernandez@example.com', '5554567890'),
('Jorge Rodríguez', 'jorge.rodriguez@example.com', '5555678901'),
('Sofía Ramírez', 'sofia.ramirez@example.com', '5556789012'),
('Andrés Hernández', 'andres.hernandez@example.com', '5557890123'),
('Elena Moreno', 'elena.moreno@example.com', '5558901234'),
('Alberto Ruiz', 'alberto.ruiz@example.com', '5559012345'),
('Cristina Navarro', 'cristina.navarro@example.com', '5550123456'),
('Diego Castillo', 'diego.castillo@example.com', '5551234567'),
('Marta Sánchez', 'marta.sanchez@example.com', '5552345678'),
('Tomás Díaz', 'tomas.diaz@example.com', '5553456789'),
('Raúl García', 'raul.garcia@example.com', '5554567890'),
('Clara López', 'clara.lopez@example.com', '5555678901'),
('Patricia Torres', 'patricia.torres@example.com', '5556789012');

-- Insertar sucursales
INSERT INTO Sucursales (nombre, direccion, ciudad, pais) 
VALUES 
('Sucursal Centro', 'Calle Mayor 1', 'Madrid', 'España'),
('Sucursal Norte', 'Avenida Libertad 45', 'Barcelona', 'España'),
('Sucursal Sur', 'Calle Sevilla 123', 'Sevilla', 'España'),
('Sucursal Este', 'Calle Valencia 78', 'Valencia', 'España'),
('Sucursal Oeste', 'Calle Coruña 56', 'La Coruña', 'España'),
('Sucursal México DF', 'Avenida Reforma 123', 'Ciudad de México', 'México'),
('Sucursal Buenos Aires', 'Calle Florida 789', 'Buenos Aires', 'Argentina'),
('Sucursal Bogotá', 'Carrera 7 85', 'Bogotá', 'Colombia'),
('Sucursal Santiago', 'Calle Ahumada 654', 'Santiago', 'Chile'),
('Sucursal Lima', 'Avenida Larco 321', 'Lima', 'Perú'),
('Sucursal Quito', 'Calle Amazonas 123', 'Quito', 'Ecuador'),
('Sucursal Caracas', 'Avenida Libertador 789', 'Caracas', 'Venezuela'),
('Sucursal La Paz', 'Calle Comercio 456', 'La Paz', 'Bolivia'),
('Sucursal San José', 'Avenida Central 789', 'San José', 'Costa Rica'),
('Sucursal Asunción', 'Avenida Mariscal 123', 'Asunción', 'Paraguay'),
('Sucursal Montevideo', '18 de Julio 456', 'Montevideo', 'Uruguay'),
('Sucursal Sao Paulo', 'Av. Paulista 1000', 'Sao Paulo', 'Brasil'),
('Sucursal Rio de Janeiro', 'Rua Rio Branco 200', 'Rio de Janeiro', 'Brasil'),
('Sucursal Santiago', 'Av. Providencia 400', 'Santiago', 'Chile'),
('Sucursal Lima Norte', 'Av. Túpac Amaru 321', 'Lima', 'Perú');

-- Insertar empleados
INSERT INTO Empleados (nombre, apellido, id_sucursal, puesto) 
VALUES 
('José', 'Martínez', 1, 'Gerente'),
('Ana', 'López', 2, 'Vendedor'),
('Luis', 'Pérez', 3, 'Vendedor'),
('Laura', 'Gómez', 4, 'Vendedor'),
('Carlos', 'Sánchez', 5, 'Gerente'),
('María', 'Rodríguez', 6, 'Vendedor'),
('Pedro', 'Hernández', 7, 'Vendedor'),
('Lucía', 'Ramírez', 8, 'Vendedor'),
('Jorge', 'García', 9, 'Gerente'),
('Sofía', 'Fernández', 10, 'Vendedor'),
('Miguel', 'García', 11, 'Vendedor'),
('Cristina', 'López', 12, 'Vendedor'),
('Roberto', 'Martínez', 13, 'Vendedor'),
('Patricia', 'González', 14, 'Vendedor'),
('Fernando', 'Rodríguez', 15, 'Gerente'),
('Andrés', 'Morales', 16, 'Gerente'),
('Elena', 'Blanco', 17, 'Vendedor'),
('Tomás', 'Suárez', 18, 'Vendedor'),
('Raquel', 'Cruz', 19, 'Gerente'),
('Santiago', 'Vargas', 20, 'Vendedor');

-- Insertar compras
INSERT INTO Compras (id_editorial, fecha_compra, total) 
VALUES 
(1, '2023-01-15', 250.00),
(2, '2023-02-20', 300.00),
(3, '2023-03-10', 150.00),
(4, '2023-04-18', 275.00),
(5, '2023-05-25', 320.00),
(6, '2023-06-30', 210.00),
(7, '2023-07-04', 230.00),
(8, '2023-08-12', 180.00),
(9, '2023-09-15', 240.00),
(10, '2023-10-01', 290.00),
(11, '2023-11-05', 260.00),
(12, '2023-12-20', 310.00),
(13, '2024-01-15', 200.00),
(14, '2024-02-22', 340.00),
(15, '2024-03-30', 150.00),
(16, '2024-04-10', 220.00),
(17, '2024-05-15', 270.00),
(18, '2024-06-20', 310.00),
(19, '2024-07-25', 350.00),
(20, '2024-08-01', 400.00);

-- Insertar inventario
INSERT INTO Inventario (id_libro, id_sucursal, cantidad) 
VALUES 
(1, 1, 50), 
(2, 2, 60),
(3, 3, 70),
(4, 4, 40),
(5, 5, 30),
(6, 6, 20),
(7, 7, 50),
(8, 8, 60),
(9, 9, 70),
(10, 10, 40),
(11, 11, 30),
(12, 12, 20),
(13, 13, 50),
(14, 14, 60),
(15, 15, 70),
(16, 16, 40),
(17, 17, 30),
(18, 18, 20),
(19, 19, 50),
(20, 20, 60);

-- Insertar ventas
INSERT INTO Ventas (id_cliente, fecha_venta, total) 
VALUES 
(1, '2023-07-01', 37.98), 
(2, '2023-07-02', 17.99),
(3, '2023-07-03', 32.50),
(4, '2023-07-04', 22.00),
(5, '2023-07-05', 41.75),
(6, '2023-07-06', 28.50),
(7, '2023-07-07', 15.00),
(8, '2023-07-08', 30.00),
(9, '2023-07-09', 19.99),
(10, '2023-07-10', 27.99),
(11, '2023-07-11', 21.00),
(12, '2023-07-12', 45.75),
(13, '2023-07-13', 33.50),
(14, '2023-07-14', 29.00),
(15, '2023-07-15', 39.99),
(16, '2023-07-16', 25.99),
(17, '2023-07-17', 27.50),
(18, '2023-07-18', 29.75),
(19, '2023-07-19', 21.99),
(20, '2023-07-20', 35.50);

-- Insertar ventas-libros
INSERT INTO Ventas_Libros (id_venta, id_libro, cantidad) 
VALUES 
(1, 1, 1), 
(1, 2, 1), 
(2, 3, 1), 
(3, 4, 2), 
(4, 5, 1),
(5, 6, 2), 
(6, 7, 1),
(7, 8, 1),
(8, 9, 1),
(9, 10, 1),
(10, 11, 1),
(11, 12, 1),
(12, 13, 2),
(13, 14, 1),
(14, 15, 1),
(15, 16, 2),
(16, 17, 1),
(17, 18, 1),
(18, 19, 1),
(19, 20, 1);

-- Insertar devoluciones
INSERT INTO Devoluciones (id_venta, id_libro, fecha_devolucion, cantidad, motivo) 
VALUES 
(1, 1, '2023-07-02', 1, 'Libro dañado'),
(2, 3, '2023-07-04', 1, 'Compra duplicada'),
(3, 5, '2023-07-06', 1, 'Cliente insatisfecho'),
(4, 7, '2023-07-08', 1, 'Libro defectuoso'),
(5, 9, '2023-07-10', 1, 'Envío incorrecto'),
(6, 11, '2023-07-12', 1, 'No era lo que esperaba'),
(7, 13, '2023-07-14', 1, 'Pedido cancelado'),
(8, 15, '2023-07-16', 1, 'Libro en mal estado'),
(9, 17, '2023-07-18', 1, 'Problema con la calidad'),
(10, 19, '2023-07-20', 1, 'Cliente cambió de opinión'),
(11, 2, '2023-07-03', 1, 'Doble pedido'),
(12, 4, '2023-07-05', 1, 'Defecto en la impresión'),
(13, 6, '2023-07-07', 1, 'Daño durante el envío'),
(14, 8, '2023-07-09', 1, 'Problema de encuadernación'),
(15, 10, '2023-07-11', 1, 'No era el libro solicitado'),
(16, 12, '2023-07-13', 1, 'Cliente cambió de parecer'),
(17, 14, '2023-07-15', 1, 'Error en el pedido'),
(18, 16, '2023-07-17', 1, 'Problema con la portada'),
(19, 18, '2023-07-19', 1, 'No coincide con la descripción'),
(20, 20, '2023-07-21', 1, 'Cliente arrepentido');

-- Insertar libros-autores (relaciones)
INSERT INTO Libros_Autores (id_libro, id_autor) VALUES 
(1, 1), 
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 3), 
(7, 1), 
(8, 11), 
(9, 14), 
(10, 14),
(11, 6), 
(12, 4), 
(13, 7), 
(14, 5), 
(15, 3);

-- Insertar proveedores
INSERT INTO Proveedores (nombre, contacto, direccion) VALUES 
('Proveedor A', 'contactoA@example.com', 'Dirección A'), 
('Proveedor B', 'contactoB@example.com', 'Dirección B'),
('Proveedor C', 'contactoC@example.com', 'Dirección C'),
('Proveedor D', 'contactoD@example.com', 'Dirección D'),
('Proveedor E', 'contactoE@example.com', 'Dirección E'),
('Proveedor F', 'contactoF@example.com', 'Dirección F'),
('Proveedor G', 'contactoG@example.com', 'Dirección G'),
('Proveedor H', 'contactoH@example.com', 'Dirección H'),
('Proveedor I', 'contactoI@example.com', 'Dirección I'),
('Proveedor J', 'contactoJ@example.com', 'Dirección J');


INSERT INTO RegistroVentas (id_venta, fecha_insercion) VALUES 
(1, '2023-07-01 10:00:00'), 
(2, '2023-07-02 11:00:00'),
(3, '2023-07-03 12:00:00');

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
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: LibreriaDB
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacenara los Autores de los Libros';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'Gabriel','García Márquez'),(2,'Isabel','Allende'),(3,'Jorge','Luis Borges'),(4,'Mario','Vargas Llosa'),(5,'Julio','Cortázar'),(6,'Pablo','Neruda'),(7,'Octavio','Paz'),(8,'Gabriela','Mistral'),(9,'Laura','Esquivel'),(10,'Carlos','Fuentes'),(11,'Roberto','Bolaño'),(12,'Alejo','Carpentier'),(13,'Juan','Rulfo'),(14,'Javier','Marías'),(15,'César','Vallejo'),(16,'Rosa','Montero'),(17,'Almudena','Grandes'),(18,'Elena','Poniatowska'),(19,'Manuel','Vázquez Montalbán'),(20,'Joaquín','Sabina');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacenara la Categoria de los Libros';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Ficción'),(2,'No Ficción'),(3,'Ciencia'),(4,'Historia'),(5,'Fantasía'),(6,'Biografía'),(7,'Tecnología'),(8,'Aventura'),(9,'Misterio'),(10,'Romance'),(11,'Humor'),(12,'Drama'),(13,'Poesía'),(14,'Ensayo'),(15,'Cómic'),(16,'Terror'),(17,'Política'),(18,'Negocios'),(19,'Salud'),(20,'Educación');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacenara a los Clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Juan Pérez','juan.perez@example.com','1234567890'),(2,'María García','maria.garcia@example.com','0987654321'),(3,'Carlos López','carlos.lopez@example.com','5551234567'),(4,'Ana Torres','ana.torres@example.com','5559876543'),(5,'Luis González','luis.gonzalez@example.com','5556789012'),(6,'Laura Martínez','laura.martinez@example.com','5552345678'),(7,'Pedro Sánchez','pedro.sanchez@example.com','5553456789'),(8,'Lucía Fernández','lucia.fernandez@example.com','5554567890'),(9,'Jorge Rodríguez','jorge.rodriguez@example.com','5555678901'),(10,'Sofía Ramírez','sofia.ramirez@example.com','5556789012'),(11,'Andrés Hernández','andres.hernandez@example.com','5557890123'),(12,'Elena Moreno','elena.moreno@example.com','5558901234'),(13,'Alberto Ruiz','alberto.ruiz@example.com','5559012345'),(14,'Cristina Navarro','cristina.navarro@example.com','5550123456'),(15,'Diego Castillo','diego.castillo@example.com','5551234567'),(16,'Marta Sánchez','marta.sanchez@example.com','5552345678'),(17,'Tomás Díaz','tomas.diaz@example.com','5553456789'),(18,'Raúl García','raul.garcia@example.com','5554567890'),(19,'Clara López','clara.lopez@example.com','5555678901'),(20,'Patricia Torres','patricia.torres@example.com','5556789012');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_editorial` int DEFAULT NULL,
  `fecha_compra` date NOT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_editorial` (`id_editorial`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_editorial`) REFERENCES `editoriales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las compras realizadas a las editoriales';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (1,1,'2023-01-15',250.00),(2,2,'2023-02-20',300.00),(3,3,'2023-03-10',150.00),(4,4,'2023-04-18',275.00),(5,5,'2023-05-25',320.00),(6,6,'2023-06-30',210.00),(7,7,'2023-07-04',230.00),(8,8,'2023-08-12',180.00),(9,9,'2023-09-15',240.00),(10,10,'2023-10-01',290.00),(11,11,'2023-11-05',260.00),(12,12,'2023-12-20',310.00),(13,13,'2024-01-15',200.00),(14,14,'2024-02-22',340.00),(15,15,'2024-03-30',150.00),(16,16,'2024-04-10',220.00),(17,17,'2024-05-15',270.00),(18,18,'2024-06-20',310.00),(19,19,'2024-07-25',350.00),(20,20,'2024-08-01',400.00);
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `comprasporeditorial`
--

DROP TABLE IF EXISTS `comprasporeditorial`;
/*!50001 DROP VIEW IF EXISTS `comprasporeditorial`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `comprasporeditorial` AS SELECT 
 1 AS `NombreEditorial`,
 1 AS `TotalGastado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `detallesdevoluciones`
--

DROP TABLE IF EXISTS `detallesdevoluciones`;
/*!50001 DROP VIEW IF EXISTS `detallesdevoluciones`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `detallesdevoluciones` AS SELECT 
 1 AS `fecha_devolucion`,
 1 AS `TituloLibro`,
 1 AS `NombreCliente`,
 1 AS `CantidadDevuelta`,
 1 AS `Motivo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `detalleventasporcliente`
--

DROP TABLE IF EXISTS `detalleventasporcliente`;
/*!50001 DROP VIEW IF EXISTS `detalleventasporcliente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `detalleventasporcliente` AS SELECT 
 1 AS `NombreCliente`,
 1 AS `VentaID`,
 1 AS `FechaVenta`,
 1 AS `TotalVenta`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `devoluciones`
--

DROP TABLE IF EXISTS `devoluciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devoluciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_venta` int DEFAULT NULL,
  `id_libro` int DEFAULT NULL,
  `fecha_devolucion` date NOT NULL,
  `cantidad` int NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_venta` (`id_venta`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `devoluciones_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`),
  CONSTRAINT `devoluciones_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las devoluciones de libros';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devoluciones`
--

LOCK TABLES `devoluciones` WRITE;
/*!40000 ALTER TABLE `devoluciones` DISABLE KEYS */;
INSERT INTO `devoluciones` VALUES (1,1,1,'2023-07-02',1,'Libro dañado'),(2,2,3,'2023-07-04',1,'Compra duplicada'),(3,3,5,'2023-07-06',1,'Cliente insatisfecho'),(4,4,7,'2023-07-08',1,'Libro defectuoso'),(5,5,9,'2023-07-10',1,'Envío incorrecto'),(6,6,11,'2023-07-12',1,'No era lo que esperaba'),(7,7,13,'2023-07-14',1,'Pedido cancelado'),(8,8,15,'2023-07-16',1,'Libro en mal estado'),(9,9,17,'2023-07-18',1,'Problema con la calidad'),(10,10,19,'2023-07-20',1,'Cliente cambió de opinión'),(11,11,2,'2023-07-03',1,'Doble pedido'),(12,12,4,'2023-07-05',1,'Defecto en la impresión'),(13,13,6,'2023-07-07',1,'Daño durante el envío'),(14,14,8,'2023-07-09',1,'Problema de encuadernación'),(15,15,10,'2023-07-11',1,'No era el libro solicitado'),(16,16,12,'2023-07-13',1,'Cliente cambió de parecer'),(17,17,14,'2023-07-15',1,'Error en el pedido'),(18,18,16,'2023-07-17',1,'Problema con la portada'),(19,19,18,'2023-07-19',1,'No coincide con la descripción'),(20,20,20,'2023-07-21',1,'Cliente arrepentido');
/*!40000 ALTER TABLE `devoluciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ActualizarInventarioDespuesDevolucion` AFTER INSERT ON `devoluciones` FOR EACH ROW BEGIN
    -- Incrementa la cantidad en el inventario al devolver el libro
    UPDATE Inventario 
    SET cantidad = cantidad + NEW.cantidad
    WHERE id_libro = NEW.id_libro 
    AND id_sucursal = (SELECT id_sucursal 
                       FROM Ventas 
                       WHERE id = NEW.id_venta);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `editoriales`
--

DROP TABLE IF EXISTS `editoriales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editoriales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `pais` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las Editoriales de los Libros';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editoriales`
--

LOCK TABLES `editoriales` WRITE;
/*!40000 ALTER TABLE `editoriales` DISABLE KEYS */;
INSERT INTO `editoriales` VALUES (1,'Editorial A','España'),(2,'Editorial B','México'),(3,'Editorial C','Argentina'),(4,'Editorial D','Colombia'),(5,'Editorial E','Chile'),(6,'Editorial F','Perú'),(7,'Editorial G','Brasil'),(8,'Editorial H','Uruguay'),(9,'Editorial I','Paraguay'),(10,'Editorial J','Bolivia'),(11,'Editorial K','Venezuela'),(12,'Editorial L','Ecuador'),(13,'Editorial M','Panamá'),(14,'Editorial N','Costa Rica'),(15,'Editorial O','Guatemala'),(16,'Editorial P','Honduras'),(17,'Editorial Q','El Salvador'),(18,'Editorial R','Nicaragua'),(19,'Editorial S','Cuba'),(20,'Editorial T','República Dominicana');
/*!40000 ALTER TABLE `editoriales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `id_sucursal` int DEFAULT NULL,
  `puesto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacenara a los Empleados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'José','Martínez',1,'Gerente'),(2,'Ana','López',2,'Vendedor'),(3,'Luis','Pérez',3,'Vendedor'),(4,'Laura','Gómez',4,'Vendedor'),(5,'Carlos','Sánchez',5,'Gerente'),(6,'María','Rodríguez',6,'Vendedor'),(7,'Pedro','Hernández',7,'Vendedor'),(8,'Lucía','Ramírez',8,'Vendedor'),(9,'Jorge','García',9,'Gerente'),(10,'Sofía','Fernández',10,'Vendedor'),(11,'Miguel','García',11,'Vendedor'),(12,'Cristina','López',12,'Vendedor'),(13,'Roberto','Martínez',13,'Vendedor'),(14,'Patricia','González',14,'Vendedor'),(15,'Fernando','Rodríguez',15,'Gerente'),(16,'Andrés','Morales',16,'Gerente'),(17,'Elena','Blanco',17,'Vendedor'),(18,'Tomás','Suárez',18,'Vendedor'),(19,'Raquel','Cruz',19,'Gerente'),(20,'Santiago','Vargas',20,'Vendedor');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_libro` int DEFAULT NULL,
  `id_sucursal` int DEFAULT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_libro` (`id_libro`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`),
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena el inventario de libros en cada sucursal';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,1,1,50),(2,2,2,60),(3,3,3,70),(4,4,4,40),(5,5,5,30),(6,6,6,20),(7,7,7,50),(8,8,8,60),(9,9,9,70),(10,10,10,40),(11,11,11,30),(12,12,12,20),(13,13,13,50),(14,14,14,60),(15,15,15,70),(16,16,16,40),(17,17,17,30),(18,18,18,20),(19,19,19,50),(20,20,20,60);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `inventarioporsucursal`
--

DROP TABLE IF EXISTS `inventarioporsucursal`;
/*!50001 DROP VIEW IF EXISTS `inventarioporsucursal`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `inventarioporsucursal` AS SELECT 
 1 AS `NombreSucursal`,
 1 AS `TituloLibro`,
 1 AS `CantidadDisponible`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `id_categoria` int DEFAULT NULL,
  `id_editorial` int DEFAULT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_editorial` (`id_editorial`),
  CONSTRAINT `libros_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`),
  CONSTRAINT `libros_ibfk_2` FOREIGN KEY (`id_editorial`) REFERENCES `editoriales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacenara los Libros';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (1,'Cien Años de Soledad',1,1,'1967-06-05',19.99),(2,'La Casa de los Espíritus',1,2,'1982-10-20',17.99),(3,'El Aleph',1,3,'1949-07-15',15.50),(4,'Conversación en La Catedral',1,4,'1969-05-18',22.00),(5,'Rayuela',1,5,'1963-10-25',18.75),(6,'Ficciones',1,3,'1944-01-01',14.99),(7,'Crónica de una Muerte Anunciada',1,1,'1981-04-01',16.00),(8,'Los Detectives Salvajes',1,11,'1998-04-05',23.50),(9,'Pedro Páramo',1,14,'1955-03-15',12.75),(10,'El Llano en Llamas',1,14,'1953-10-01',14.00),(11,'El Amante Japonés',2,2,'2015-05-28',19.00),(12,'La Fiesta del Chivo',2,4,'2000-11-08',21.50),(13,'La Tregua',2,6,'1960-03-15',16.50),(14,'Las Armas Secretas',3,5,'1959-01-01',17.25),(15,'Sobre Héroes y Tumbas',3,3,'1961-05-01',18.00),(16,'Ensayo sobre la Ceguera',2,7,'1995-09-20',20.00),(17,'La Sombra del Viento',1,8,'2001-04-05',25.00),(18,'El Código Da Vinci',9,9,'2003-03-18',22.00),(19,'Harry Potter y la Piedra Filosofal',5,10,'1997-06-26',15.99),(20,'El Señor de los Anillos',5,11,'1954-07-29',29.99);
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libros_autores`
--

DROP TABLE IF EXISTS `libros_autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros_autores` (
  `id_libro` int NOT NULL,
  `id_autor` int NOT NULL,
  PRIMARY KEY (`id_libro`,`id_autor`),
  KEY `id_autor` (`id_autor`),
  CONSTRAINT `libros_autores_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`),
  CONSTRAINT `libros_autores_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `autores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla intermedia entre Libro y Autores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros_autores`
--

LOCK TABLES `libros_autores` WRITE;
/*!40000 ALTER TABLE `libros_autores` DISABLE KEYS */;
INSERT INTO `libros_autores` VALUES (1,1),(7,1),(2,2),(3,3),(6,3),(15,3),(4,4),(12,4),(5,5),(14,5),(11,6),(13,7),(8,11),(9,14),(10,14);
/*!40000 ALTER TABLE `libros_autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `contacto` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los proveedores de libros';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Proveedor A','contactoA@example.com','Dirección A'),(2,'Proveedor B','contactoB@example.com','Dirección B'),(3,'Proveedor C','contactoC@example.com','Dirección C'),(4,'Proveedor D','contactoD@example.com','Dirección D'),(5,'Proveedor E','contactoE@example.com','Dirección E'),(6,'Proveedor F','contactoF@example.com','Dirección F'),(7,'Proveedor G','contactoG@example.com','Dirección G'),(8,'Proveedor H','contactoH@example.com','Dirección H'),(9,'Proveedor I','contactoI@example.com','Dirección I'),(10,'Proveedor J','contactoJ@example.com','Dirección J');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registroventas`
--

DROP TABLE IF EXISTS `registroventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registroventas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_venta` int DEFAULT NULL,
  `fecha_insercion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla para ver en que momento fue la insercion de la Venta en la BD';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registroventas`
--

LOCK TABLES `registroventas` WRITE;
/*!40000 ALTER TABLE `registroventas` DISABLE KEYS */;
INSERT INTO `registroventas` VALUES (1,1,'2023-07-01 10:00:00'),(2,2,'2023-07-02 11:00:00'),(3,3,'2023-07-03 12:00:00');
/*!40000 ALTER TABLE `registroventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `reporteventasclientes`
--

DROP TABLE IF EXISTS `reporteventasclientes`;
/*!50001 DROP VIEW IF EXISTS `reporteventasclientes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reporteventasclientes` AS SELECT 
 1 AS `id`,
 1 AS `NombreCliente`,
 1 AS `TotalGastado`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `pais` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacenara las Sucursales';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursales`
--

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
INSERT INTO `sucursales` VALUES (1,'Sucursal Centro','Calle Mayor 1','Madrid','España'),(2,'Sucursal Norte','Avenida Libertad 45','Barcelona','España'),(3,'Sucursal Sur','Calle Sevilla 123','Sevilla','España'),(4,'Sucursal Este','Calle Valencia 78','Valencia','España'),(5,'Sucursal Oeste','Calle Coruña 56','La Coruña','España'),(6,'Sucursal México DF','Avenida Reforma 123','Ciudad de México','México'),(7,'Sucursal Buenos Aires','Calle Florida 789','Buenos Aires','Argentina'),(8,'Sucursal Bogotá','Carrera 7 85','Bogotá','Colombia'),(9,'Sucursal Santiago','Calle Ahumada 654','Santiago','Chile'),(10,'Sucursal Lima','Avenida Larco 321','Lima','Perú'),(11,'Sucursal Quito','Calle Amazonas 123','Quito','Ecuador'),(12,'Sucursal Caracas','Avenida Libertador 789','Caracas','Venezuela'),(13,'Sucursal La Paz','Calle Comercio 456','La Paz','Bolivia'),(14,'Sucursal San José','Avenida Central 789','San José','Costa Rica'),(15,'Sucursal Asunción','Avenida Mariscal 123','Asunción','Paraguay'),(16,'Sucursal Montevideo','18 de Julio 456','Montevideo','Uruguay'),(17,'Sucursal Sao Paulo','Av. Paulista 1000','Sao Paulo','Brasil'),(18,'Sucursal Rio de Janeiro','Rua Rio Branco 200','Rio de Janeiro','Brasil'),(19,'Sucursal Santiago','Av. Providencia 400','Santiago','Chile'),(20,'Sucursal Lima Norte','Av. Túpac Amaru 321','Lima','Perú');
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int DEFAULT NULL,
  `fecha_venta` date NOT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `id_sucursal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacenara las ventas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,1,'2023-07-01',37.98,16),(2,2,'2023-07-02',17.99,20),(3,3,'2023-07-03',32.50,19),(4,4,'2023-07-04',22.00,1),(5,5,'2023-07-05',41.75,10),(6,6,'2023-07-06',28.50,16),(7,7,'2023-07-07',15.00,9),(8,8,'2023-07-08',30.00,1),(9,9,'2023-07-09',19.99,16),(10,10,'2023-07-10',27.99,5),(11,11,'2023-07-11',21.00,14),(12,12,'2023-07-12',45.75,8),(13,13,'2023-07-13',33.50,19),(14,14,'2023-07-14',29.00,14),(15,15,'2023-07-15',39.99,9),(16,16,'2023-07-16',25.99,3),(17,17,'2023-07-17',27.50,15),(18,18,'2023-07-18',29.75,20),(19,19,'2023-07-19',21.99,16),(20,20,'2023-07-20',35.50,16);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_libros`
--

DROP TABLE IF EXISTS `ventas_libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_libros` (
  `id_venta` int NOT NULL,
  `id_libro` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_venta`,`id_libro`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `ventas_libros_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`),
  CONSTRAINT `ventas_libros_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla intermedia Venta y Libro';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_libros`
--

LOCK TABLES `ventas_libros` WRITE;
/*!40000 ALTER TABLE `ventas_libros` DISABLE KEYS */;
INSERT INTO `ventas_libros` VALUES (1,1,1),(1,2,1),(2,3,1),(3,4,2),(4,5,1),(5,6,2),(6,7,1),(7,8,1),(8,9,1),(9,10,1),(10,11,1),(11,12,1),(12,13,2),(13,14,1),(14,15,1),(15,16,2),(16,17,1),(17,18,1),(18,19,1),(19,20,1);
/*!40000 ALTER TABLE `ventas_libros` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `VerificarStockAntesVenta` BEFORE INSERT ON `ventas_libros` FOR EACH ROW BEGIN
    DECLARE stock INT;
    -- Calcula el stock disponible en la sucursal para el libro especificado
    SET stock = StockDisponible(NEW.id_libro, (SELECT id_sucursal FROM Ventas WHERE id = NEW.id_venta));
    
    -- Si no hay suficiente stock, se lanza un error
    IF stock < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para la venta';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `comprasporeditorial`
--

/*!50001 DROP VIEW IF EXISTS `comprasporeditorial`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `comprasporeditorial` AS select `e`.`nombre` AS `NombreEditorial`,sum(`c`.`total`) AS `TotalGastado` from (`compras` `c` join `editoriales` `e` on((`c`.`id_editorial` = `e`.`id`))) group by `e`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `detallesdevoluciones`
--

/*!50001 DROP VIEW IF EXISTS `detallesdevoluciones`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `detallesdevoluciones` AS select `d`.`fecha_devolucion` AS `fecha_devolucion`,`l`.`titulo` AS `TituloLibro`,`c`.`nombre` AS `NombreCliente`,`d`.`cantidad` AS `CantidadDevuelta`,`d`.`motivo` AS `Motivo` from (((`devoluciones` `d` join `libros` `l` on((`d`.`id_libro` = `l`.`id`))) join `ventas` `v` on((`d`.`id_venta` = `v`.`id`))) join `clientes` `c` on((`v`.`id_cliente` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `detalleventasporcliente`
--

/*!50001 DROP VIEW IF EXISTS `detalleventasporcliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `detalleventasporcliente` AS select `c`.`nombre` AS `NombreCliente`,`v`.`id` AS `VentaID`,`v`.`fecha_venta` AS `FechaVenta`,`v`.`total` AS `TotalVenta` from (`clientes` `c` join `ventas` `v` on((`c`.`id` = `v`.`id_cliente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `inventarioporsucursal`
--

/*!50001 DROP VIEW IF EXISTS `inventarioporsucursal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `inventarioporsucursal` AS select `s`.`nombre` AS `NombreSucursal`,`l`.`titulo` AS `TituloLibro`,`i`.`cantidad` AS `CantidadDisponible` from ((`inventario` `i` join `sucursales` `s` on((`i`.`id_sucursal` = `s`.`id`))) join `libros` `l` on((`i`.`id_libro` = `l`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reporteventasclientes`
--

/*!50001 DROP VIEW IF EXISTS `reporteventasclientes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reporteventasclientes` AS select `c`.`id` AS `id`,`c`.`nombre` AS `NombreCliente`,`TotalVentasCliente`(`c`.`id`) AS `TotalGastado` from `clientes` `c` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-30 14:07:26
