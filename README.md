# Sistema de Punto de Ventas

Aplicacion web para la gestion de un punto de venta. Permite administrar clientes, productos, categorias, ventas y el detalle de cada venta, ademas de generar reportes basicos de inventario y ventas.

## Caracteristicas

- Gestion de clientes (alta, edicion y eliminacion).
- Gestion de productos e inventario.
- Gestion de categorias.
- Registro de ventas y detalle de venta.
- Listados y reportes de ventas e inventario.
- Interfaz web moderna con panel de control.

## Tecnologias

- Java 8
- Spring MVC 4
- JSP y JSTL
- MySQL
- Apache Ant / NetBeans
- iText 2.1.7
- Apache POI 3.17

## Requisitos

- JDK 8
- Apache NetBeans (o Ant)
- Servidor de aplicaciones compatible con Java EE 7 (GlassFish / Payara)
- MySQL Server (puerto 3307 por defecto)
- Base de datos `SistemaPuntoVenta`

## Configuracion de la base de datos

La conexion se configura en `src/java/config/ConexionBD.java`:

- URL: `jdbc:mysql://localhost:3307/SistemaPuntoVenta`
- Usuario: `root`
- Contrasena: `mariadb`

Cree la base de datos `SistemaPuntoVenta` y las tablas correspondientes (clientes, productos, categorias, ventas, detalle_venta) antes de ejecutar la aplicacion.

## Ejecucion

1. Abra el proyecto en NetBeans.
2. Configure el servidor de aplicaciones y las librerias del proyecto.
3. Compile y despliegue el archivo WAR (`SistemaPuntoVentas.war`).
4. Acceda a la aplicacion desde el navegador.

## Estructura del proyecto

- `src/java/Controlador`: controladores Spring MVC.
- `src/java/Entidades`: entidades del dominio.
- `src/java/config`: configuracion de conexion a base de datos.
- `web/WEB-INF/jsp`: vistas JSP.
- `web/WEB-INF`: configuracion de Spring y web.xml.
- `lib`: librerias adicionales (iText, POI).

## Licencia

Proyecto academico / de uso libre.