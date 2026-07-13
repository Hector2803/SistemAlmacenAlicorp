package com.pe.model.entity;

public class KardexMovimiento {

    private int idmovimiento;
    private String fecha;
    private String tipocomprobante;
    private String serie;
    private String correlativo;
    private double ingreso;
    private double salida;
    private double saldo;
    private double costo;

    public int getIdmovimiento() { return idmovimiento; }
    public void setIdmovimiento(int idmovimiento) { this.idmovimiento = idmovimiento; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }

    public String getTipocomprobante() { return tipocomprobante; }
    public void setTipocomprobante(String tipocomprobante) { this.tipocomprobante = tipocomprobante; }

    public String getSerie() { return serie; }
    public void setSerie(String serie) { this.serie = serie; }

    public String getCorrelativo() { return correlativo; }
    public void setCorrelativo(String correlativo) { this.correlativo = correlativo; }

    public double getIngreso() { return ingreso; }
    public void setIngreso(double ingreso) { this.ingreso = ingreso; }

    public double getSalida() { return salida; }
    public void setSalida(double salida) { this.salida = salida; }

    public double getSaldo() { return saldo; }
    public void setSaldo(double saldo) { this.saldo = saldo; }

    public double getCosto() { return costo; }
    public void setCosto(double costo) { this.costo = costo; }
}
