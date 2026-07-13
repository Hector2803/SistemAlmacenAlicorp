package com.pe.model.entity;

public class UnidadCompra {

    private int Iducompra;
    private String Codigo;
    private String Nombre;
    private int Contenido;
    private String Estado;

    public UnidadCompra() {
    }

    public UnidadCompra(int Iducompra, String Codigo, String Nombre, int Contenido, String Estado) {
        this.Iducompra = Iducompra;
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Contenido = Contenido;
        this.Estado = Estado;
    }

    public int getIducompra() {
        return Iducompra;
    }

    public void setIducompra(int Iducompra) {
        this.Iducompra = Iducompra;
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