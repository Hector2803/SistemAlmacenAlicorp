package com.pe.model.entity;

public class Auxiliar {

    private int Idauxiliar;
    private String Tipoauxi;
    private String Codigo;
    private String Nombre;
    private String Correo;
    private String Celular;
    private String Telefono;
    private String Direccion;
    private String Contacto;
    private String Fechaderegistro;
    private int Idtipodocumento;
    private String Numerodocumento;
    private String Sexo;
    private String Estado;

    public Auxiliar() {
    }

    public Auxiliar(int Idauxiliar, String Tipoauxi, String Codigo, String Nombre, String Correo,String Telefono, String Celular, String Direccion, String Contacto, String Fechaderegistro, int Idtipodocumento, String Numerodocumento, String Sexo, String Estado) {
        this.Idauxiliar = Idauxiliar;
        this.Tipoauxi = Tipoauxi;
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Correo = Correo;
        this.Telefono = Telefono;
        this.Celular = Celular;
        this.Direccion = Direccion;
        this.Contacto = Contacto;
        this.Fechaderegistro = Fechaderegistro;
        this.Idtipodocumento = Idtipodocumento;
        this.Numerodocumento = Numerodocumento;
        this.Sexo = Sexo;
        this.Estado = Estado;
    }

    public Auxiliar(String Tipoauxi, String Codigo, String Nombre, String Correo,String Telefono, String Celular, String Direccion, String Contacto, String Fechaderegistro, int Idtipodocumento, String Numerodocumento, String Sexo, String Estado) {
        this.Tipoauxi = Tipoauxi;
        this.Codigo = Codigo;
        this.Nombre = Nombre;
        this.Correo = Correo;
        this.Telefono = Telefono;
        this.Celular = Celular;
        this.Direccion = Direccion;
        this.Contacto = Contacto;
        this.Fechaderegistro = Fechaderegistro;
        this.Idtipodocumento = Idtipodocumento;
        this.Numerodocumento = Numerodocumento;
        this.Sexo = Sexo;
        this.Estado = Estado;
    }

    public int getIdauxiliar() {
        return Idauxiliar;
    }

    public void setIdauxiliar(int Idauxiliar) {
        this.Idauxiliar = Idauxiliar;
    }

    public String getTipoauxi() {
        return Tipoauxi;
    }

    public void setTipoauxi(String Tipoauxi) {
        this.Tipoauxi = Tipoauxi;
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

    public String getCorreo() {
        return Correo;
    }

    public void setCorreo(String Correo) {
        this.Correo = Correo;
    }

    public String getTelefono() {
        return Telefono;
    }

    public void setTelefono(String Telefono) {
        this.Telefono = Telefono;
    }
    
    public String getCelular() {
        return Celular;
    }

    public void setCelular(String Celular) {
        this.Celular = Celular;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getContacto() {
        return Contacto;
    }

    public void setContacto(String Contacto) {
        this.Contacto = Contacto;
    }

    public String getFechaderegistro() {
        return Fechaderegistro;
    }

    public void setFechaderegistro(String Fechaderegistro) {
        this.Fechaderegistro = Fechaderegistro;
    }

    public int getIdtipodocumento() {
        return Idtipodocumento;
    }

    public void setIdtipodocumento(int Idtipodocumento) {
        this.Idtipodocumento = Idtipodocumento;
    }

    public String getNumerodocumento() {
        return Numerodocumento;
    }

    public void setNumerodocumento(String Numerodocumento) {
        this.Numerodocumento = Numerodocumento;
    }

    public String getSexo() {
        return Sexo;
    }

    public void setSexo(String Sexo) {
        this.Sexo = Sexo;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

}
