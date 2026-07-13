package com.pe.model.entity;

public class Subcategoria {

    private Integer Idsubc;
    String Codigo, Nombre, Estado;
    private Integer Idcategoria;
    private String NombreCategoria; // solo para mostrar en listados, no se guarda en esta tabla

    public Subcategoria(Integer Idsubc, String Codigo, String Nombre, String Estado) {
        this.Idsubc = Idsubc;
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Estado = Estado;
    }

    public Subcategoria() {
    }

    public Integer getIdsubc() {
        return Idsubc;
    }

    public void setIdsubc(Integer Idsubc) {
        this.Idsubc = Idsubc;
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

    public Integer getIdcategoria() {
        return Idcategoria;
    }

    public void setIdcategoria(Integer Idcategoria) {
        this.Idcategoria = Idcategoria;
    }

    public String getNombreCategoria() {
        return NombreCategoria;
    }

    public void setNombreCategoria(String NombreCategoria) {
        this.NombreCategoria = NombreCategoria;
    }

    }
