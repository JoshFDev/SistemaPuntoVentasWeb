/*
 * Controlador para gestión de productos
 */
package Controlador;

import Entidades.Categorias;
import Entidades.Productos;
import config.ConexionBD;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class controladorProductos {
    ConexionBD con = new ConexionBD();
    JdbcTemplate jdbcTemplate = new JdbcTemplate(con.Conectar());
    ModelAndView mav = new ModelAndView();
    
    int idProducto;
    List datos;
    
    // Método auxiliar para determinar estado según stock
    private String determinarEstado(int stock) {
        if(stock == 0) {
            return "AGOTADO";
        } else if(stock <= 5) {
            return "ÚLTIMAS UNIDADES";
        } else {
            return "DISPONIBLE";
        }
    }

    // Método para la vista de agregar
@RequestMapping(value = "AltaProducto.htm", method = RequestMethod.GET) 
public ModelAndView vistaAgregar(){

    // Obtener categorías
    String sqlCategorias = "SELECT idCategoria, nombreCategoria FROM categorias";
    List<Map<String, Object>> categorias = jdbcTemplate.queryForList(sqlCategorias);

    mav.addObject("producto", new Productos()); // NOMBRE EXPLÍCITO
    mav.addObject("categorias", categorias);
    mav.setViewName("AltaProducto");
    return mav;
}

@RequestMapping(value = "AltaProducto.htm", method = RequestMethod.POST)
public ModelAndView Agregar(Productos p, HttpServletRequest request) {
    String estado = determinarEstado(p.getStock());
    
    // Manejo seguro de precioMayoreo
    String precioMayoreoParam = request.getParameter("precioMayoreo");
    BigDecimal precioMayoreo = null;
    
    if(precioMayoreoParam != null && !precioMayoreoParam.trim().isEmpty()) {
        try {
            precioMayoreo = new BigDecimal(precioMayoreoParam);
        } catch(NumberFormatException e) {
            // Si hay error en el formato, se queda como null
        }
    }
    
    String sql = "INSERT INTO productos(nombreProducto, descripcion, unidadMedida, precio, precioMayoreo, marca, stock, idCategoria, estado, imagen) " +
                 "VALUES(?,?,?,?,?,?,?,?,?,?)";
    this.jdbcTemplate.update(sql, 
            p.getNombreProducto(),
            p.getDescripcion(),
            p.getUnidadMedida(),
            p.getPrecio(),
            precioMayoreo,  // Usamos el valor procesado
            p.getMarca(),
            p.getStock(),
            p.getIdCategoria(),
            estado,
            p.getImagen());
    return new ModelAndView("redirect:/listaProductos.htm");
}    

    
    // Método para listar
@RequestMapping("listaProductos.htm")
public ModelAndView Listar(){
    try {
        // Consulta para productos
        String sqlProductos = "SELECT p.*, c.nombreCategoria FROM productos p " +
                     "LEFT JOIN categorias c ON p.idCategoria = c.idCategoria";
        List<Map<String, Object>> productos = jdbcTemplate.queryForList(sqlProductos);
        
        // Consulta para categorías usando la entidad
        String sqlCategorias = "SELECT idCategoria, nombreCategoria FROM categorias";
        List<Categorias> categorias = jdbcTemplate.query(
            sqlCategorias,
            new BeanPropertyRowMapper<>(Categorias.class));
        
        ModelAndView mav = new ModelAndView("listaProductos");
        mav.addObject("lista", productos);
        mav.addObject("categorias", categorias);
        return mav;
        
    } catch (Exception e) {
        // Manejo de errores
        ModelAndView mav = new ModelAndView("error");
        mav.addObject("mensaje", "Error al cargar los productos: " + e.getMessage());
        return mav;
    }
}

@RequestMapping("eliminarProducto.htm")
public ModelAndView vaciarStock(HttpServletRequest request) {
    try {
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        String sql = "UPDATE productos SET stock = 0, estado = 'AGOTADO' WHERE idProducto = ?";
        this.jdbcTemplate.update(sql, idProducto);
    } catch (Exception e) {
        // Manejo de errores
        System.err.println("Error al vaciar stock: " + e.getMessage());
    }
    return new ModelAndView("redirect:/listaProductos.htm");
}

// Método para obtener la vista de edición
@RequestMapping(value = "editarProducto.htm", method = RequestMethod.GET)
public ModelAndView vistaEditar(HttpServletRequest request) {
    idProducto = Integer.parseInt(request.getParameter("idProducto"));
    
    // Consulta para obtener el producto a editar
    String sqlProducto = "SELECT p.*, c.nombreCategoria FROM productos p " +
                        "LEFT JOIN categorias c ON p.idCategoria = c.idCategoria " +
                        "WHERE p.idProducto = " + idProducto;
    List<Map<String, Object>> producto = jdbcTemplate.queryForList(sqlProducto);
    
    // Consulta para obtener todas las categorías
    String sqlCategorias = "SELECT idCategoria, nombreCategoria FROM categorias";
    List<Map<String, Object>> categorias = jdbcTemplate.queryForList(sqlCategorias);
    
    mav.addObject("producto", producto.get(0)); // Pasamos el primer (y único) producto
    mav.addObject("categorias", categorias);
    mav.setViewName("editarProducto");
    return mav;
}

// Método para procesar la edición
@RequestMapping(value = "editarProducto.htm", method = RequestMethod.POST)
public ModelAndView Editar(Productos p, HttpServletRequest request) {
    String estado = determinarEstado(p.getStock());
    
    // Manejo seguro de precioMayoreo
    String precioMayoreoParam = request.getParameter("precioMayoreo");
    BigDecimal precioMayoreo = null;
    
    if(precioMayoreoParam != null && !precioMayoreoParam.trim().isEmpty()) {
        try {
            precioMayoreo = new BigDecimal(precioMayoreoParam);
        } catch(NumberFormatException e) {
            // Si hay error en el formato, se queda como null
        }
    }
    
    String sql = "UPDATE productos SET nombreProducto=?, descripcion=?, unidadMedida=?, " +
                 "precio=?, precioMayoreo=?, marca=?, stock=?, idCategoria=?, estado=?, imagen=? " +
                 "WHERE idProducto=?";
    
    this.jdbcTemplate.update(sql, 
            p.getNombreProducto(),
            p.getDescripcion(),
            p.getUnidadMedida(),
            p.getPrecio(),
            precioMayoreo,
            p.getMarca(),
            p.getStock(),
            p.getIdCategoria(),
            estado,
            p.getImagen(),
            idProducto);
    
    return new ModelAndView("redirect:/listaProductos.htm");
}    
    
    
}