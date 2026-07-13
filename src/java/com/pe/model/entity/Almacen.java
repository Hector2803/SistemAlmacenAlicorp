package com.pe.model.entity;

public class Almacen {
    private int idalmacen;
    private String codigo;
    private String nombre;
    private String direccion;
    private String estado;

    public int getIdalmacen() { return idalmacen; }
    public void setIdalmacen(int idalmacen) { this.idalmacen = idalmacen; }

    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
