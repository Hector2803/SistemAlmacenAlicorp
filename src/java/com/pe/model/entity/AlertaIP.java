package com.pe.model.entity;

public class AlertaIP {
    private String ip;
    private int cantidad;
    private String ultimoIntento;

    public String getIp() { return ip; }
    public void setIp(String ip) { this.ip = ip; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public String getUltimoIntento() { return ultimoIntento; }
    public void setUltimoIntento(String ultimoIntento) { this.ultimoIntento = ultimoIntento; }
}
