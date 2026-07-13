package com.pe.model.entity;

import java.util.List;

public class OrdenCompra {

    private int Idordencompra;
    private String Codigo;
    private int Idauxiliar;
    private String FechaEmision;
    private String FechaEntrega;
    private String Origen;
    private String Estado;
    private double Total;
    private String Observacion;
    private String Idusuario;
    private Auxiliar auxiliar;
    private List<DetalleOrdenCompra> detalle;

    public OrdenCompra() {
    }

    public OrdenCompra(int Idordencompra) {
        this.Idordencompra = Idordencompra;
    }

    public int getIdordencompra() {
        return Idordencompra;
    }

    public void setIdordencompra(int Idordencompra) {
        this.Idordencompra = Idordencompra;
    }

    public String getCodigo() {
        return Codigo;
    }

    public void setCodigo(String Codigo) {
        this.Codigo = Codigo;
    }

    public int getIdauxiliar() {
        return Idauxiliar;
    }

    public void setIdauxiliar(int Idauxiliar) {
        this.Idauxiliar = Idauxiliar;
    }

    public String getFechaEmision() {
        return FechaEmision;
    }

    public void setFechaEmision(String FechaEmision) {
        this.FechaEmision = FechaEmision;
    }

    public String getFechaEntrega() {
        return FechaEntrega;
    }

    public void setFechaEntrega(String FechaEntrega) {
        this.FechaEntrega = FechaEntrega;
    }

    public String getOrigen() {
        return Origen;
    }

    public void setOrigen(String Origen) {
        this.Origen = Origen;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    public double getTotal() {
        return Total;
    }

    public void setTotal(double Total) {
        this.Total = Total;
    }

    public String getObservacion() {
        return Observacion;
    }

    public void setObservacion(String Observacion) {
        this.Observacion = Observacion;
    }

    public String getIdusuario() {
        return Idusuario;
    }

    public void setIdusuario(String Idusuario) {
        this.Idusuario = Idusuario;
    }

    public Auxiliar getAuxiliar() {
        return auxiliar;
    }

    public void setAuxiliar(Auxiliar auxiliar) {
        this.auxiliar = auxiliar;
    }

    public List<DetalleOrdenCompra> getDetalle() {
        return detalle;
    }

    public void setDetalle(List<DetalleOrdenCompra> detalle) {
        this.detalle = detalle;
    }
}
