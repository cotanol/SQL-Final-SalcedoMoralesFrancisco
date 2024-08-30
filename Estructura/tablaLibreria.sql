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


