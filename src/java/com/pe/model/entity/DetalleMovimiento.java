/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.model.entity;

public class DetalleMovimiento {

    private int Iddetalle;
    private int Idmovimiento;
    private int Idproducto;
    private double Cantidad;
    private double Costo;
    private double Subtotal;
    private String Estado;
    private double Saldo;
    private Movimiento venta;
    private Producto producto;


    public DetalleMovimiento() {
    }

    public double subtotal() {
        return (Cantidad * producto.getPrecioVenta());
    }

    public DetalleMovimiento(int Iddetalle, int Idmovimiento, int Idproducto, double Cantidad, double Costo, double Subtotal) {
        this.Iddetalle = Iddetalle;
        this.Idmovimiento = Idmovimiento;
        this.Idproducto = Idproducto;
        this.Cantidad = Cantidad;
        this.Costo = Costo;
        this.Subtotal = Subtotal;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    public int getIddetalle() {
        return Iddetalle;
    }

    public void setIddetalle(int Iddetalle) {
        this.Iddetalle = Iddetalle;
    }

    public int getIdmovimiento() {
        return Idmovimiento;
    }

    public void setIdmovimiento(int Idmovimiento) {
        this.Idmovimiento = Idmovimiento;
    }

    public double getCosto() {
        return Costo;
    }

    public void setCosto(double Costo) {
        this.Costo = Costo;
    }

    public double getSaldo() {
        return Saldo;
    }

    public void setSaldo(double Saldo) {
        this.Saldo = Saldo;
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

    public Movimiento getVenta() {
        return venta;
    }

    public void setVenta(Movimiento venta) {
        this.venta = venta;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public double getSubtotal() {
        return Subtotal;
    }

    public void setSubtotal(double Subtotal) {
        this.Subtotal = Subtotal;
    }

}
