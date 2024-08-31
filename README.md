# Documentación de la Base de Datos para una Librería

## Introducción
Este documento describe el diseño y la implementación de una base de datos para una librería. La base de datos está diseñada para gestionar eficientemente información clave como libros, autores, editoriales, clientes, sucursales, empleados, inventario, ventas, compras, devoluciones, y proveedores. Con este sistema, se busca mejorar la organización y la administración de los datos relacionados con las operaciones diarias de la librería, asegurando su integridad y disponibilidad para análisis y toma de decisiones.

## Objetivo
El objetivo principal de esta base de datos es proporcionar una estructura centralizada y eficiente para el manejo de la información crítica de una librería. Esto incluye la gestión de la colección de libros, la administración de clientes y empleados, el seguimiento del inventario en distintas sucursales, y la gestión de transacciones comerciales como ventas, compras y devoluciones. El sistema está diseñado para ser robusto, seguro y capaz de generar informes detallados que faciliten la toma de decisiones estratégicas en la operación de la librería.

## Situación Problemática
En una librería con múltiples sucursales, la gestión eficiente de la información relacionada con libros, ventas, inventario, y clientes puede volverse complicada. La falta de un sistema centralizado puede conducir a inconsistencias en los datos, problemas en la gestión de inventario, dificultades para realizar un seguimiento de las ventas y devoluciones, y una experiencia insatisfactoria para el cliente. Además, la falta de herramientas para generar informes precisos puede limitar la capacidad de tomar decisiones informadas.

## Modelo de Negocio
El modelo de negocio de la librería se basa en la venta de libros a través de múltiples sucursales, ofreciendo una amplia variedad de títulos de diferentes categorías y editoriales. La librería también se relaciona con autores y proveedores para garantizar una oferta diversa y actualizada de libros. Se gestionan los inventarios a nivel de sucursal, se realizan compras a editoriales y proveedores, y se manejan devoluciones de clientes. La base de datos soporta todas estas operaciones, desde la venta al detalle hasta la gestión de inventarios y la generación de reportes de ventas.

## Diagrama de Entidad-Relación
![Diagrama de la Base de Datos](DERFINAL.png)

## Listado de Tablas con Descripción de Estructura

### Categorías
- **id:** `INT` (Primary Key, Auto Increment)
- **nombre:** `VARCHAR(255)` (No Nulo)

### Editoriales
- **id:** `INT` (Primary Key, Auto Increment)
- **nombre:** `VARCHAR(255)` (No Nulo)
- **pais:** `VARCHAR(100)`

### Autores
- **id:** `INT` (Primary Key, Auto Increment)
- **nombre:** `VARCHAR(255)` (No Nulo)
- **apellido:** `VARCHAR(255)` (No Nulo)

### Libros
- **id:** `INT` (Primary Key, Auto Increment)
- **titulo:** `VARCHAR(255)` (No Nulo)
- **id_categoria:** `INT` (Foreign Key a `Categorias`)
- **id_editorial:** `INT` (Foreign Key a `Editoriales`)
- **fecha_publicacion:** `DATE`
- **precio:** `DECIMAL(10, 2)`

### Clientes
- **id:** `INT` (Primary Key, Auto Increment)
- **nombre:** `VARCHAR(255)` (No Nulo)
- **email:** `VARCHAR(255)` (No Nulo, Único)
- **telefono:** `VARCHAR(20)`

### Sucursales
- **id:** `INT` (Primary Key, Auto Increment)
- **nombre:** `VARCHAR(255)` (No Nulo)
- **direccion:** `VARCHAR(255)` (No Nulo)
- **ciudad:** `VARCHAR(100)` (No Nulo)
- **pais:** `VARCHAR(100)` (No Nulo)

### Empleados
- **id:** `INT` (Primary Key, Auto Increment)
- **nombre:** `VARCHAR(255)` (No Nulo)
- **apellido:** `VARCHAR(255)` (No Nulo)
- **id_sucursal:** `INT` (Foreign Key a `Sucursales`)
- **puesto:** `VARCHAR(255)`

### Proveedores
- **id:** `INT` (Primary Key, Auto Increment)
- **nombre:** `VARCHAR(255)` (No Nulo)
- **contacto:** `VARCHAR(255)`
- **direccion:** `VARCHAR(255)`

### Ventas
- **id:** `INT` (Primary Key, Auto Increment)
- **id_cliente:** `INT` (Foreign Key a `Clientes`)
- **fecha_venta:** `DATE` (No Nulo)
- **total:** `DECIMAL(10, 2)`
- **id_sucursal:** `INT` (Foreign Key a `Sucursales`)

### Inventario
- **id:** `INT` (Primary Key, Auto Increment)
- **id_libro:** `INT` (Foreign Key a `Libros`)
- **id_sucursal:** `INT` (Foreign Key a `Sucursales`)
- **cantidad:** `INT` (No Nulo)

### Compras
- **id:** `INT` (Primary Key, Auto Increment)
- **id_editorial:** `INT` (Foreign Key a `Editoriales`)
- **fecha_compra:** `DATE` (No Nulo)
- **total:** `DECIMAL(10, 2)` 

### Devoluciones
- **id:** `INT` (Primary Key, Auto Increment)
- **id_venta:** `INT` (Foreign Key a `Ventas`)
- **id_libro:** `INT` (Foreign Key a `Libros`)
- **fecha_devolucion:** `DATE` (No Nulo)
- **cantidad:** `INT` (No Nulo)
- **motivo:** `VARCHAR(255)`

### Libros_Autores
- **id_libro:** `INT` (Foreign Key a `Libros`)
- **id_autor:** `INT` (Foreign Key a `Autores`)
- **PRIMARY KEY (`id_libro`, `id_autor`)**

### Ventas_Libros
- **id_venta:** `INT` (Foreign Key a `Ventas`)
- **id_libro:** `INT` (Foreign Key a `Libros`)
- **cantidad:** `INT`
- **PRIMARY KEY (`id_venta`, `id_libro`)**

### RegistroVentas
- **id:** `INT` (Primary Key, Auto Increment)
- **id_venta:** `INT` (Foreign Key a `Ventas`)
- **fecha_insercion:** `DATETIME`

## Scripts de Creación de Cada Objeto de la Base de Datos
*(Aquí se incluiría el código SQL completo para la creación de todas las tablas y objetos de la base de datos, como el proporcionado anteriormente.)*

## Scripts de Inserción de Datos
*(Aquí se agregarían ejemplos de scripts SQL para la inserción de datos en cada una de las tablas de la base de datos.)*

## Informes Generados en Base a la Información de la Base
- **Inventario por Sucursal:** Proporciona la cantidad disponible de cada libro en cada sucursal.
- **Detalles de Devoluciones:** Muestra la fecha de devolución, el título del libro, el nombre del cliente, la cantidad devuelta y el motivo de la devolución.
- **Total de Ventas por Cliente:** Calcula el total gastado por cada cliente.
- **Detalles de Ventas por Cliente:** Muestra detalles de las ventas, incluyendo la fecha y el total de cada venta realizada por cada cliente.
- **Total Gastado en Compras por Editorial:** Suma el total de compras realizadas a cada editorial.

## Herramientas y Tecnologías Usadas
- **Base de Datos:** MySQL
- **Lenguaje SQL:** Utilizado para la creación de tablas, vistas, funciones y procedimientos almacenados.
- **Modelado ER:** Herramientas como MySQL Workbench para la creación del diagrama entidad-relación.

## Futuras Líneas
- **Mejorar el manejo de inventario:** Implementación de un sistema más avanzado de gestión de inventarios que considere devoluciones y rotación de stock.
- **Automatización de informes:** Crear procedimientos almacenados adicionales para generar informes automáticos en intervalos regulares.
- **Seguridad:** Implementación de roles y permisos más granulares para asegurar que solo usuarios autorizados puedan acceder y modificar la base de datos.
