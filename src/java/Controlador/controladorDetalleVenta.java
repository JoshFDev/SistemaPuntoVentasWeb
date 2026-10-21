package Controlador;

import Entidades.DetalleVenta;
import config.ConexionBD;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class controladorDetalleVenta {
    ConexionBD con = new ConexionBD();
    JdbcTemplate jdbcTemplate = new JdbcTemplate(con.Conectar());
    ModelAndView mav = new ModelAndView();

    String idDetalle;
    List datos;

    // Vista de Alta
@RequestMapping(value = "AltaDetalleVenta.htm", method = RequestMethod.GET)
public ModelAndView vistaAgregar() {
    // Obtener ventas
    String sqlVentas = "SELECT idVenta, fecha FROM ventas";
    List<Map<String, Object>> ventas = jdbcTemplate.queryForList(sqlVentas);
    
    // Obtener productos
    String sqlProductos = "SELECT idProducto, nombreProducto, marca, precio, stock FROM productos";
    List<Map<String, Object>> productos = jdbcTemplate.queryForList(sqlProductos);
    
    mav.addObject("ventas", ventas);
    mav.addObject("productos", productos);
    mav.addObject(new DetalleVenta());
    mav.setViewName("AltaDetalleVenta");
    return mav;
}

    // Insertar nuevo detalle y actualizar stock
    @RequestMapping(value = "AltaDetalleVenta.htm", method = RequestMethod.POST)
    public ModelAndView Agregar(DetalleVenta d) {
        // Obtener el stock actual del producto
        String sqlStock = "SELECT stock FROM productos WHERE idProducto = ?";
        int stockActual = jdbcTemplate.queryForObject(sqlStock, new Object[]{d.getIdProducto()}, Integer.class);

        if (stockActual >= d.getCantidad()) {
            // Calcular subtotal
            double subtotal = (d.getPrecioUnitario() - d.getDescuento()) * d.getCantidad();

            // Insertar el detalle de venta
            String sqlInsert = "INSERT INTO detalleventa (idVenta, idProducto, cantidad, precioUnitario, descuento, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
            jdbcTemplate.update(sqlInsert, d.getIdVenta(), d.getIdProducto(), d.getCantidad(), d.getPrecioUnitario(), d.getDescuento(), subtotal);

            // Actualizar el stock
            String sqlUpdateStock = "UPDATE productos SET stock = stock - ? WHERE idProducto = ?";
            jdbcTemplate.update(sqlUpdateStock, d.getCantidad(), d.getIdProducto());

            return new ModelAndView("redirect:/listaDetalleVenta.htm");
        } else {
            // Insuficiente stock (la validación visual se hará en la vista)
            mav.addObject("error", "Stock insuficiente");
            mav.setViewName("AltaDetalleVenta");
            return mav;
        }
    }

@RequestMapping("listaDetalleVenta.htm")
public ModelAndView Listar() {
    // Consulta para los detalles de venta con fecha
    String sql = "SELECT dv.*, v.fecha as fechaVenta, p.nombreProducto " +
                 "FROM detalleventa dv " +
                 "JOIN ventas v ON dv.idVenta = v.idVenta " +
                 "JOIN productos p ON dv.idProducto = p.idProducto";
    
    datos = jdbcTemplate.queryForList(sql);
    
    // Consulta para obtener todos los productos (para el filtro)
    String sqlProductos = "SELECT idProducto, nombreProducto FROM productos";
    List<Map<String, Object>> productos = jdbcTemplate.queryForList(sqlProductos);
    
    mav.addObject("lista", datos);
    mav.addObject("productos", productos);
    mav.setViewName("listaDetalleVenta");
    return mav;
}


@RequestMapping(value = "editarDetalleVenta.htm", method = RequestMethod.GET)
public ModelAndView vistaEditar(HttpServletRequest request) {
    String idDetalle = request.getParameter("idDetalle");
    
    // Consulta SQL corregida (precio en lugar de precioProducto)
    String sql = "SELECT dv.*, p.nombreProducto, p.precio as precioProducto, p.stock " +
                "FROM detalleventa dv " +
                "JOIN productos p ON dv.idProducto = p.idProducto " +
                "WHERE dv.idDetalle = ?";
    
    Map<String, Object> detalle = jdbcTemplate.queryForMap(sql, idDetalle);
    
    // Consulta para obtener todos los productos con precio y stock
    String sqlProductos = "SELECT idProducto, nombreProducto, precio, stock FROM productos";
    List<Map<String, Object>> productos = jdbcTemplate.queryForList(sqlProductos);
    
    ModelAndView mav = new ModelAndView();
    mav.addObject("detalle", detalle);
    mav.addObject("productos", productos);
    mav.setViewName("editarDetalleVenta");
    return mav;
}

@RequestMapping(value = "editarDetalleVenta.htm", method = RequestMethod.POST)
public ModelAndView Editar(@ModelAttribute("detalleVenta") DetalleVenta dv, 
                          HttpServletRequest request) {
    // Obtener el detalle actual para comparar cantidades
    String sqlDetalleActual = "SELECT idProducto, cantidad FROM detalleventa WHERE idDetalle = ?";
    Map<String, Object> detalleActual = jdbcTemplate.queryForMap(sqlDetalleActual, dv.getIdDetalle());
    
    int cantidadAnterior = (int) detalleActual.get("cantidad");
    int idProductoAnterior = (int) detalleActual.get("idProducto");
    
    // Verificar stock solo si cambió el producto o la cantidad
    if (dv.getIdProducto() != idProductoAnterior || dv.getCantidad() != cantidadAnterior) {
        String sqlStock = "SELECT stock FROM productos WHERE idProducto = ?";
        int stockActual = jdbcTemplate.queryForObject(sqlStock, new Object[]{dv.getIdProducto()}, Integer.class);
        
        if (stockActual < dv.getCantidad()) {
            ModelAndView mav = new ModelAndView("editarDetalleVenta");
            mav.addObject("error", "Stock insuficiente. Stock disponible: " + stockActual);
            
            // Recargar datos necesarios para la vista
            String sqlProductos = "SELECT idProducto, nombreProducto, precio, stock FROM productos";
            List<Map<String, Object>> productos = jdbcTemplate.queryForList(sqlProductos);
            mav.addObject("productos", productos);
            mav.addObject("detalle", dv);
            return mav;
        }
    }
    
    // Calcular subtotal
    // Validar que el descuento no sea mayor que el precio unitario
    if (dv.getDescuento() > dv.getPrecioUnitario()) {
        ModelAndView mav = new ModelAndView("editarDetalleVenta");
        mav.addObject("error", "El descuento no puede ser mayor que el precio unitario");
        
        // Recargar datos necesarios para la vista
        String sqlProductos = "SELECT idProducto, nombreProducto, precio, stock FROM productos";
        List<Map<String, Object>> productos = jdbcTemplate.queryForList(sqlProductos);
        mav.addObject("productos", productos);
        mav.addObject("detalle", dv);
        return mav;
    }
    
    // Resto de tu lógica de actualización...
    double subtotal = (dv.getPrecioUnitario() - dv.getDescuento()) * dv.getCantidad();
    
    // Verificar que el subtotal no sea negativo
    if (subtotal < 0) {
        ModelAndView mav = new ModelAndView("editarDetalleVenta");
        mav.addObject("error", "El subtotal no puede ser negativo. Revise precio y descuento.");
        // Recargar datos...
        return mav;
    }    
    // Actualizar en la base de datos
    String sql = "UPDATE detalleventa SET " +
                 "idProducto = ?, cantidad = ?, precioUnitario = ?, " +
                 "descuento = ?, subtotal = ? " +
                 "WHERE idDetalle = ?";
    
    jdbcTemplate.update(sql, dv.getIdProducto(), dv.getCantidad(), 
                      dv.getPrecioUnitario(), dv.getDescuento(), 
                      subtotal, dv.getIdDetalle());
    
    // Ajustar stock si hubo cambios
    if (dv.getIdProducto() != idProductoAnterior || dv.getCantidad() != cantidadAnterior) {
        // Devolver stock al producto anterior
        if (dv.getIdProducto() != idProductoAnterior) {
            String sqlDevolverStock = "UPDATE productos SET stock = stock + ? WHERE idProducto = ?";
            jdbcTemplate.update(sqlDevolverStock, cantidadAnterior, idProductoAnterior);
        }
        
        // Actualizar stock del nuevo producto
        String sqlActualizarStock = "UPDATE productos SET stock = stock - ? WHERE idProducto = ?";
        jdbcTemplate.update(sqlActualizarStock, dv.getCantidad(), dv.getIdProducto());
    }
    
    return new ModelAndView("redirect:/listaDetalleVenta.htm");
}

    // Eliminar
    @RequestMapping("eliminarDetalleVenta.htm")
    public ModelAndView Eliminar(HttpServletRequest request) {
        String id = request.getParameter("idDetalle");
        String sql = "DELETE FROM detalleventa WHERE idDetalle = ?";
        jdbcTemplate.update(sql, id);
        return new ModelAndView("redirect:/listaDetalleVenta.htm");
    }
}
