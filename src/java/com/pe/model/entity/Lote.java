package com.pe.model.entity;

public class Lote {
    private int idlote;
    private int idproducto;
    private String codigoProducto;
    private String descripcionProducto;
    private String codigoLote;
    private String fechaVencimiento;
    private double cantidadInicial;
    private String fechaIngreso;
    private String estado;

    public int getIdlote() { return idlote; }
    public void setIdlote(int idlote) { this.idlote = idlote; }

    public int getIdproducto() { return idproducto; }
    public void setIdproducto(int idproducto) { this.idproducto = idproducto; }

    public String getCodigoProducto() { return codigoProducto; }
    public void setCodigoProducto(String codigoProducto) { this.codigoProducto = codigoProducto; }

    public String getDescripcionProducto() { return descripcionProducto; }
    public void setDescripcionProducto(String descripcionProducto) { this.descripcionProducto = descripcionProducto; }

    public String getCodigoLote() { return codigoLote; }
    public void setCodigoLote(String codigoLote) { this.codigoLote = codigoLote; }

    public String getFechaVencimiento() { return fechaVencimiento; }
    public void setFechaVencimiento(String fechaVencimiento) { this.fechaVencimiento = fechaVencimiento; }

    public double getCantidadInicial() { return cantidadInicial; }
    public void setCantidadInicial(double cantidadInicial) { this.cantidadInicial = cantidadInicial; }

    public String getFechaIngreso() { return fechaIngreso; }
    public void setFechaIngreso(String fechaIngreso) { this.fechaIngreso = fechaIngreso; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
