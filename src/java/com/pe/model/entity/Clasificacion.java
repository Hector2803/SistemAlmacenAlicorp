
package com.pe.model.entity;

public class  Clasificacion {
    
    int Idclasi;
    String Codigo,Nombre,Estado;

    public Clasificacion() {
    }

    public Clasificacion(String Codigo, String Nombre, String Estado) {
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Estado = Estado;
    }

    public Clasificacion(int Idclasi, String Codigo, String Nombre, String Estado) {
        this.Idclasi = Idclasi;
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Estado = Estado;
    }

    public int getIdclasi() {
        return Idclasi;
    }

    public void setIdclasi(int Idclasi) {
        this.Idclasi = Idclasi;
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

    
   
}
