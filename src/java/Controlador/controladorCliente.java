/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Entidades.Clientes;
import config.ConexionBD;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
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
public class controladorCliente {
    ConexionBD con = new ConexionBD();
    JdbcTemplate jdbcTemplate = new JdbcTemplate(con.Conectar());
    ModelAndView mav = new ModelAndView();
    
    // Clave primaria actual
    String idCliente;
    List datos;
    
    // Método para la vista de agregar
    @RequestMapping(value = "AltaCliente.htm", method = RequestMethod.GET) 
    public ModelAndView vistaAgregar(){
        mav.addObject(new Clientes());
        mav.setViewName("AltaCliente");
        return mav;
    }
    
    // Método para agregar
    @RequestMapping(value = "AltaCliente.htm", method = RequestMethod.POST)
    public ModelAndView Agregar(Clientes c){
        String sql = "insert into clientes(IdCliente,nombre,apellidoPaterno,apellidoMaterno,fechaNacimiento,correo,telefono,direccion) values(?,?,?,?,?,?,?,?)";
        this.jdbcTemplate.update(sql, c.getIdCliente(), c.getNombre(),c.getApellidoPaterno(),c.getApellidoMaterno(),c.getFechaNacimiento(),c.getCorreo(),c.getTelefono(),c.getDireccion());
        return new ModelAndView("redirect:/AltaCliente.htm");
    }
    
    // Método para listar
    @RequestMapping("listaClientes.htm")
    public ModelAndView Listar(){
        String sql = "select * from clientes";
        datos = this.jdbcTemplate.queryForList(sql);
        mav.addObject("lista", datos);
        mav.setViewName("listaClientes");
        return mav;
    }
    
    // Método para obtener la vista Actualizar
    @RequestMapping(value = "editarCliente.htm", method = RequestMethod.GET)
    public ModelAndView vistaEditar(HttpServletRequest request){
        idCliente = request.getParameter("idCliente");
        String sql = "select * from clientes where idCliente=" + idCliente;
        datos = this.jdbcTemplate.queryForList(sql);
        mav.addObject("lista", datos);     
        mav.setViewName("editarCliente");
        return mav;
    }
    
    // Método para editar
    @RequestMapping(value = "editarCliente.htm", method = RequestMethod.POST)
    public ModelAndView Editar(Clientes c){
        String sql = "UPDATE clientes SET nombre=?, apellidoPaterno=?, apellidoMaterno=?, " +
                     "fechaNacimiento=?, correo=?, telefono=?, direccion=? WHERE idCliente=?";
        this.jdbcTemplate.update(sql, c.getNombre(),c.getApellidoPaterno(),c.getApellidoMaterno(),c.getFechaNacimiento(),c.getCorreo(),c.getTelefono(),c.getDireccion(), idCliente);
        return new ModelAndView("redirect:/listaClientes.htm");
    }
    
    // Método para eliminar
    @RequestMapping(value = "eliminarCliente.htm")
    public ModelAndView Eliminar(HttpServletRequest request) {
        String idCategoria = request.getParameter("idCliente");
        String sql = "DELETE FROM clientes WHERE idCliente = ?";
        this.jdbcTemplate.update(sql, idCategoria);
        return new ModelAndView("redirect:/listaClientes.htm");
    }
}
