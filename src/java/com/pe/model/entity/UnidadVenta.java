package com.pe.model.entity;

public class UnidadVenta {

    private int Iduventa;
    private String Codigo;
    private String Nombre;
    private int Contenido;
    private String Estado;

    public UnidadVenta() {
    }

    public int getIduventa() {
        return Iduventa;
    }

    public void setIduventa(int Iduventa) {
        this.Iduventa = Iduventa;
    }

    public String getCodigo() {
        return Codigo;
    }

    public void setCodigo(String Codigo) {
        this.Codigo = Codigo;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public int getContenido() {
        return Contenido;
    }

    public void setContenido(int Contenido) {
        this.Contenido = Contenido;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    
}
