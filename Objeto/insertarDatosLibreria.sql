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

