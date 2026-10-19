/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.math.BigDecimal;
import javax.persistence.Column;

/**
 *
 * @author Joshua
 */
public class Productos {
    private int idProducto;
    private String nombreProducto;
    private String descripcion;
    @Column(name = "unidadMedida", length = 20)
    private String unidadMedida;
    private BigDecimal precio;
    @Column(name = "precioMayoreo", precision = 10, scale = 2)
    private BigDecimal precioMayoreo;
    private String marca;
    private int stock;
    private String estado; 
    private String imagen;
    private int idCategoria;

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUnidadMedida() {
        return unidadMedida;
    }

    public void setUnidadMedida(String unidadMedida) {
        this.unidadMedida = unidadMedida;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public BigDecimal getPrecioMayoreo() {
        return precioMayoreo;
    }

    public void setPrecioMayoreo(BigDecimal precioMayoreo) {
        this.precioMayoreo = precioMayoreo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public Productos(int idProducto, String nombreProducto, String descripcion, String unidadMedida, BigDecimal precio, BigDecimal precioMayoreo, String marca, int stock, String estado, String imagen, int idCategoria) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.descripcion = descripcion;
        this.unidadMedida = unidadMedida;
        this.precio = precio;
        this.precioMayoreo = precioMayoreo;
        this.marca = marca;
        this.stock = stock;
        this.estado = estado;
        this.imagen = imagen;
        this.idCategoria = idCategoria;
    }

    public Productos() {
    }

    
}
