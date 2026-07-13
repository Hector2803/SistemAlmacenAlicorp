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
public class Categoria {

    private Integer Idcategoria;
    private String Codigo;
    private String Nombre;
    private String Estado;
    

    public Categoria() {
    }

    public Categoria(Integer Idcategoria, String Codigo, String Nombre, String Estado) {
        this.Idcategoria = Idcategoria;
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Estado = Estado;
    }

    public Categoria(String Codigo, String Nombre, String Estado) {
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Estado = Estado;
    }
    

    public Integer getIdcategoria() {
        return Idcategoria;
    }

    public void setIdcategoria(Integer Idcategoria) {
        this.Idcategoria = Idcategoria;
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

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

   

   


    @Override
    public String toString() {
        return "Categoria{" + "Idcategoria=" + Idcategoria +", Codigo=" + Codigo + ", Nombre=" + Nombre + ",Estado="+Estado+'}';
    }

}
