package com.pe.model.entity;

/**
 * Representa un registro de la bitácora de accesos (login).
 */
public class LogAcceso {
    private String usuarioIntento;
    private boolean exito;
    private String fechaHora;
    private String ipOrigen;
    private String mensaje;

    public String getUsuarioIntento() { return usuarioIntento; }
    public void setUsuarioIntento(String usuarioIntento) { this.usuarioIntento = usuarioIntento; }

    public boolean isExito() { return exito; }
    public void setExito(boolean exito) { this.exito = exito; }

    public String getFechaHora() { return fechaHora; }
    public void setFechaHora(String fechaHora) { this.fechaHora = fechaHora; }

    public String getIpOrigen() { return ipOrigen; }
    public void setIpOrigen(String ipOrigen) { this.ipOrigen = ipOrigen; }

    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }
}
