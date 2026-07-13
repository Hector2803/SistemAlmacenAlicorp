package com.pe.model.entity;

public class DetalleOrdenCompra {

    private int Iddetalleoc;
    private int Idordencompra;
    private int Idproducto;
    private double Cantidad;
    private double PrecioUnitario;
    private double Subtotal;
    private Producto producto;

    public DetalleOrdenCompra() {
    }

    public int getIddetalleoc() {
        return Iddetalleoc;
    }

    public void setIddetalleoc(int Iddetalleoc) {
        this.Iddetalleoc = Iddetalleoc;
    }

    public int getIdordencompra() {
        return Idordencompra;
    }

    public void setIdordencompra(int Idordencompra) {
        this.Idordencompra = Idordencompra;
    }

    public int getIdproducto() {
        return Idproducto;
    }

    public void setIdproducto(int Idproducto) {
        this.Idproducto = Idproducto;
    }

    public double getCantidad() {
        return Cantidad;
    }

    public void setCantidad(double Cantidad) {
        this.Cantidad = Cantidad;
    }

    public double getPrecioUnitario() {
        return PrecioUnitario;
    }

    public void setPrecioUnitario(double PrecioUnitario) {
        this.PrecioUnitario = PrecioUnitario;
    }

    public double getSubtotal() {
        return Subtotal;
    }

    public void setSubtotal(double Subtotal) {
        this.Subtotal = Subtotal;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }
}
