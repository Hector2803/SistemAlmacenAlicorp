/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.model.entity;

/**
 *
 * @author yenny
 */
public class Motivo {

    private Integer Idmotivo;
    private String Codigo;
    private String Nombre;
    private String Tipo;
    private String Estado;

    public Motivo(Integer Idmotivo, String Codigo, String Nombre, String Tipo, String Estado) {
        this.Idmotivo = Idmotivo;
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Tipo = Tipo;
        this.Estado = Estado;
    }

    public Motivo() {
    }

    public Integer getIdmotivo() {
        return Idmotivo;
    }

    public void setIdmotivo(Integer Idmotivo) {
        this.Idmotivo = Idmotivo;
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

    public String getTipo() {
        return Tipo;
    }

    public void setTipo(String Tipo) {
        this.Tipo = Tipo;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }
    
    
    

}
