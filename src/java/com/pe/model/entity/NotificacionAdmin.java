package com.pe.model.entity;

public class NotificacionAdmin {
    private int id;
    private String tipo;
    private String mensaje;
    private String fechaHora;
    private boolean leida;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }

    public String getFechaHora() { return fechaHora; }
    public void setFechaHora(String fechaHora) { this.fechaHora = fechaHora; }

    public boolean isLeida() { return leida; }
    public void setLeida(boolean leida) { this.leida = leida; }

    // Ícono sugerido según el tipo, usado en la campana
    public String getIcono() {
        switch (tipo) {
            case "ip_sospechosa": return "fa-shield-alt";
            case "password_cambiada": return "fa-key";
            case "movimiento_stock": return "fa-dolly";
            default: return "fa-bell";
        }
    }
}
