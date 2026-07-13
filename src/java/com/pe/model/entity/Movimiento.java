package com.pe.model.entity;

import java.sql.Timestamp;

/**
 *
 * @author yenny
 */
public class Movimiento {

    private int Idmovimiento;
    private int Idauxiliar;
    private int Idusuario;
    private String Tipocomprobante;
    private String Serie;
    private String Correlativo;
    private String Fecha;
    private String Fechaentrega;
    private int Idreferencia;
    private String Referencia;
    private String Tienda;
    private String Almacen;
    private String Condicion;
    private int Idmotivo;
    private int Idtrans;
    private int Idvehi;
    private int Idcond;
    private double Subtotal;
    private double Igv;
    private double Total;
    private String Estado;
    private Auxiliar cliente;
    
    
    private int Iddocref;
    private String Tipdocref;
    private String Serieref;
    private String Correlativoref;
    

    public Movimiento() {
    }

    public int getIdmovimiento() {
        return Idmovimiento;
    }

    public void setIdmovimiento(int Idmovimiento) {
        this.Idmovimiento = Idmovimiento;
    }

    public int getIdauxiliar() {
        return Idauxiliar;
    }

    public void setIdauxiliar(int Idauxiliar) {
        this.Idauxiliar = Idauxiliar;
    }

    public int getIdmotivo() {
        return Idmotivo;
    }

    public int getIdtrans() {
        return Idtrans;
    }

    public void setIdtrans(int Idtrans) {
        this.Idtrans = Idtrans;
    }

    public int getIdvehi() {
        return Idvehi;
    }

    public void setIdvehi(int Idvehi) {
        this.Idvehi = Idvehi;
    }

    public int getIdcond() {
        return Idcond;
    }

    public void setIdcond(int Idcond) {
        this.Idcond = Idcond;
    }

    public int getIdreferencia() {
        return Idreferencia;
    }

    public void setIdreferencia(int Idreferencia) {
        this.Idreferencia = Idreferencia;
    }

    public void setIdmotivo(int Idmotivo) {
        this.Idmotivo = Idmotivo;
    }

    public int getIdusuario() {
        return Idusuario;
    }

    public void setIdusuario(int Idusuario) {
        this.Idusuario = Idusuario;
    }

    public String getTipocomprobante() {
        return Tipocomprobante;
    }

    public void setTipocomprobante(String Tipocomprobante) {
        this.Tipocomprobante = Tipocomprobante;
    }

    public String getSerie() {
        return Serie;
    }

    public void setSerie(String Serie) {
        this.Serie = Serie;
    }

    public String getCorrelativo() {
        return Correlativo;
    }

    public void setCorrelativo(String Correlativo) {
        this.Correlativo = Correlativo;
    }

    public String getFecha() {
        return Fecha;
    }

    public void setFecha(String Fecha) {
        this.Fecha = Fecha;
    }

    public String getTienda() {
        return Tienda;
    }

    public void setTienda(String Tienda) {
        this.Tienda = Tienda;
    }

    public String getAlmacen() {
        return Almacen;
    }

    public void setAlmacen(String Almacen) {
        this.Almacen = Almacen;
    }

    public String getCondicion() {
        return Condicion;
    }

    public void setCondicion(String Condicion) {
        this.Condicion = Condicion;
    }

    public double getSubtotal() {
        return Subtotal;
    }

    public void setSubtotal(double Subtotal) {
        this.Subtotal = Subtotal;
    }

    public double getIgv() {
        return Igv;
    }

    public void setIgv(double Igv) {
        this.Igv = Igv;
    }

    public double getTotal() {
        return Total;
    }

    public void setTotal(double Total) {
        this.Total = Total;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    public Auxiliar getCliente() {
        return cliente;
    }

    public void setCliente(Auxiliar cliente) {
        this.cliente = cliente;
    }

    public String getFechaentrega() {
        return Fechaentrega;
    }

    public void setFechaentrega(String Fechaentrega) {
        this.Fechaentrega = Fechaentrega;
    }

    public String getReferencia() {
        return Referencia;
    }

    public void setReferencia(String Referencia) {
        this.Referencia = Referencia;
    }

    public int getIddocref() {
        return Iddocref;
    }

    public void setIddocref(int Iddocref) {
        this.Iddocref = Iddocref;
    }

    public String getTipdocref() {
        return Tipdocref;
    }

    public void setTipdocref(String Tipdocref) {
        this.Tipdocref = Tipdocref;
    }

    public String getSerieref() {
        return Serieref;
    }

    public void setSerieref(String Serieref) {
        this.Serieref = Serieref;
    }

    public String getCorrelativoref() {
        return Correlativoref;
    }

    public void setCorrelativoref(String Correlativoref) {
        this.Correlativoref = Correlativoref;
    }

}
