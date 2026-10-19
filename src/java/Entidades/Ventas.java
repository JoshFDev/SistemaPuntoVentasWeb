/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Joshua
 */
public class Ventas {
    Date dt = new Date();
    SimpleDateFormat newFecha = new SimpleDateFormat("yyyy-MM-dd");
    private String idVenta;
    private String fecha = newFecha.format(dt);
    private String idCliente;
    private String total;   

    public Ventas() {
    }

    public Ventas(String idVenta, String idCliente, String total) {
        this.idVenta = idVenta;
        this.idCliente = idCliente;
        this.total = total;
    }

    public String getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(String idVenta) {
        this.idVenta = idVenta;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(String idCliente) {
        this.idCliente = idCliente;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
    
    
   

}
