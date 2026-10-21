/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;


import Entidades.Ventas;
import config.ConexionBD;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
/**
 *
 * @author sergi
 */
@Controller
public class controladorVentas {
    ConexionBD con = new ConexionBD();
    JdbcTemplate jdbcTemplate = new JdbcTemplate(con.Conectar());
    ModelAndView mav = new ModelAndView();
    
    // Clave primaria actual
    String idVenta;
    List datos;
    
    // Método para la vista de agregar
    @RequestMapping(value = "AltaVenta.htm", method = RequestMethod.GET) 
    public ModelAndView vistaAgregar(){
//        mav.addObject(new Ventas());
//        mav.setViewName("AltaVenta");
//        return mav;
        
        String sqlClientes = "SELECT idCliente, nombre FROM clientes";
        List<Map<String, Object>> clientes = jdbcTemplate.queryForList(sqlClientes);

        mav.addObject("venta", new Ventas()); // NOMBRE EXPLÍCITO
        mav.addObject("clientes", clientes);
        mav.setViewName("AltaVenta");
        return mav;
        
    }
    
    // Método para agregar
    @RequestMapping(value = "AltaVenta.htm", method = RequestMethod.POST)
    public ModelAndView Agregar(Ventas c){
        String sql = "insert into ventas(fecha,idCliente,total) values(?,?,?)";
        this.jdbcTemplate.update(sql, c.getFecha(), c.getIdCliente(),c.getTotal());
        return new ModelAndView("redirect:/AltaVenta.htm");
    }
    
   
    @RequestMapping("listaVentas.htm")
    public ModelAndView Listar(){
        String sql = "select * from ventas";
        datos = this.jdbcTemplate.queryForList(sql);
        mav.addObject("lista", datos);
        mav.setViewName("listaVentas");
        return mav;
    }
    
// Método para obtener la vista Actualizar
@RequestMapping(value = "editarVenta.htm", method = RequestMethod.GET)
public ModelAndView vistaEditar(HttpServletRequest request){
    idVenta = request.getParameter("idVenta");
    String sql = "select * from ventas where idVenta=" + idVenta;
    datos = this.jdbcTemplate.queryForList(sql);
    
    // Obtener la lista de clientes para el desplegable
    String sqlClientes = "SELECT idCliente, nombre FROM clientes";
    List<Map<String, Object>> clientes = jdbcTemplate.queryForList(sqlClientes);
    
    mav.addObject("lista", datos);
    mav.addObject("clientes", clientes); // Añadir la lista de clientes
    mav.setViewName("editarVenta");
    return mav;
}
    
@RequestMapping(value = "editarVenta.htm", method = RequestMethod.POST)
public ModelAndView Editar(
    @RequestParam("fecha") String fechaStr,
    @RequestParam("idCliente") int idCliente,
    @RequestParam("total") double total) {
    
    try {
        // Convertir el String a Timestamp (para fecha y hora)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date parsedDate = dateFormat.parse(fechaStr);
        Timestamp timestamp = new Timestamp(parsedDate.getTime());
        
        String sql = "UPDATE ventas SET fecha=?, idCliente=?, total=? WHERE idVenta=?";
        this.jdbcTemplate.update(
            sql, 
            timestamp,  // Usamos Timestamp en lugar de Date
            idCliente,
            total, 
            idVenta
        );
    } catch (Exception e) {
        e.printStackTrace();
        // Puedes manejar el error redirigiendo a una página de error
        return new ModelAndView("redirect:/error.htm");
    }
    
    return new ModelAndView("redirect:/listaVentas.htm");
}
    
    // Método para eliminar
    @RequestMapping(value = "eliminarVenta.htm")
    public ModelAndView eliminarVenta(@RequestParam("idVenta") String idVenta) {
    try {
        String sql = "DELETE FROM ventas WHERE idVenta = ?";
        jdbcTemplate.update(sql, idVenta);
    } catch (Exception e) {
        // Opcional: Manejar el error si lo necesitas
    }
    return new ModelAndView("redirect:/listaVentas.htm");
}

}
