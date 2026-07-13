package com.pe.model.entity;

/**
 *
 * @author yenny
 */
public class Transporte {
private Integer Idtrans;
private String Codigo;
private String nombre;
private String tipo;
private String Estado;

    public Transporte() {
    }

    public Transporte(Integer Idtrans, String Codigo, String nombre, String tipo, String Estado) {
        this.Idtrans = Idtrans;
        this.Codigo = Codigo;
        this.nombre = nombre;
        this.tipo = tipo;
        this.Estado = Estado;
    }

    public Transporte(String Codigo, String nombre, String tipo, String Estado) {
        this.Codigo = Codigo;
        this.nombre = nombre;
        this.tipo = tipo;
        this.Estado = Estado;
    }

 

    public Integer getIdtrans() {
        return Idtrans;
    }

    public void setIdtrans(Integer Idtrans) {
        this.Idtrans = Idtrans;
    }


    public String getCodigo() {
        return Codigo;
    }

    public void setCodigo(String Codigo) {
        this.Codigo = Codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEstado() {
        return Estado;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

}
