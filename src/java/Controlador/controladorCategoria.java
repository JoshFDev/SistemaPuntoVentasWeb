package Controlador;

import Entidades.Categorias;
import config.ConexionBD;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class controladorCategoria {
    ConexionBD con = new ConexionBD();
    JdbcTemplate jdbcTemplate = new JdbcTemplate(con.Conectar());
    ModelAndView mav = new ModelAndView();
    
    // Método para la vista de agregar
    @RequestMapping(value = "AltaCategoria.htm", method = RequestMethod.GET) 
    public ModelAndView vistaAgregar(){
        mav.addObject(new Categorias());
        mav.setViewName("AltaCategoria");
        return mav;
    }
    
    // Método para agregar
    @RequestMapping(value = "AltaCategoria.htm", method = RequestMethod.POST)
    public ModelAndView Agregar(Categorias c){
        String sql = "insert into categorias(idCategoria, nombreCategoria) values(?,?)";
        this.jdbcTemplate.update(sql, c.getIdCategoria(), c.getNombreCategoria());
        return new ModelAndView("redirect:/AltaCategoria.htm");
    }
    
    // Método para listar
    @RequestMapping("listaCategorias.htm")
    public ModelAndView Listar(){
        String sql = "select * from categorias";
        List datos = this.jdbcTemplate.queryForList(sql);
        mav.addObject("lista", datos);
        mav.setViewName("listaCategorias");
        return mav;
    }
    
    // Método para obtener la vista Actualizar
    @RequestMapping(value = "editarCategoria.htm", method = RequestMethod.GET)
    public ModelAndView vistaEditar(HttpServletRequest request){
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        String sql = "select * from categorias where idCategoria=?";
        Categorias categoria = this.jdbcTemplate.queryForObject(
            sql, 
            new Object[]{idCategoria},
            (rs, rowNum) -> new Categorias(
                rs.getInt("idCategoria"),
                rs.getString("nombreCategoria")
            )
        );
        mav.addObject("categoria", categoria);
        mav.setViewName("editarCategoria");
        return mav;
    }
    
    // Método para editar (actualizado)
    @RequestMapping(value = "editarCategoria.htm", method = RequestMethod.POST)
    public ModelAndView Editar(@ModelAttribute("categoria") Categorias c){
        String sql = "update categorias set nombreCategoria=? where idCategoria=?";
        this.jdbcTemplate.update(sql, c.getNombreCategoria(), c.getIdCategoria());
        return new ModelAndView("redirect:/listaCategorias.htm");
    }
    
    // Método para eliminar
    @RequestMapping(value = "eliminarCategoria.htm")
    public ModelAndView Eliminar(HttpServletRequest request) {
        String idCategoria = request.getParameter("idCategoria");
        String sql = "DELETE FROM categorias WHERE idCategoria = ?";
        this.jdbcTemplate.update(sql, idCategoria);
        return new ModelAndView("redirect:/listaCategorias.htm");
    }
}