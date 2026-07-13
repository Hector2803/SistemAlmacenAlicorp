/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pe.model.entity;

/**
 *
 * @author yenny
 */
public class Empresa {

    private int Id;
    private String Nombre;
    private String Nro;
    private String Direccion;
    private String Ubigeo;
    private String Adicional;
    private String filename1;
    private String path1;

    public Empresa() {
    }

    public Empresa(int Id, String Nombre, String Nro, String Direccion, String Ubigeo, String Adicional, String filename1, String path1) {
        this.Id = Id;
        this.Nombre = Nombre;
        this.Nro = Nro;
        this.Direccion = Direccion;
        this.Ubigeo = Ubigeo;
        this.Adicional = Adicional;
        this.filename1 = filename1;
        this.path1 = path1;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getNro() {
        return Nro;
    }

    public void setNro(String Nro) {
        this.Nro = Nro;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getUbigeo() {
        return Ubigeo;
    }

    public void setUbigeo(String Ubigeo) {
        this.Ubigeo = Ubigeo;
    }

    public String getAdicional() {
        return Adicional;
    }

    public void setAdicional(String Adicional) {
        this.Adicional = Adicional;
    }

    public String getFilename1() {
        return filename1;
    }

    public void setFilename1(String filename1) {
        this.filename1 = filename1;
    }

    public String getPath1() {
        return path1;
    }

    public void setPath1(String path1) {
        this.path1 = path1;
    }

}
