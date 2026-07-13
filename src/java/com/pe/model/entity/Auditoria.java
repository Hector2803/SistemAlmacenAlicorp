package com.pe.model.entity;

public class Auditoria {
    private int id;
    private String usuario;
    private String accion;
    private String modulo;
    private String detalle;
    private String fechaHora;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }

    public String getAccion() { return accion; }
    public void setAccion(String accion) { this.accion = accion; }

    public String getModulo() { return modulo; }
    public void setModulo(String modulo) { this.modulo = modulo; }

    public String getDetalle() { return detalle; }
    public void setDetalle(String detalle) { this.detalle = detalle; }

    public String getFechaHora() { return fechaHora; }
    public void setFechaHora(String fechaHora) { this.fechaHora = fechaHora; }

    // Color sugerido para la etiqueta de acción en la interfaz
    public String getColorAccion() {
        if (accion == null) return "#555";
        String a = accion.toLowerCase();
        if (a.contains("elimina") || a.contains("anula") || a.contains("bloque")) return "#c62828";
        if (a.contains("crea") || a.contains("registra") || a.contains("agrega")) return "#2e7d32";
        if (a.contains("edita") || a.contains("actualiza") || a.contains("restablece")) return "#e65100";
        if (a.contains("sesión") || a.contains("sesion")) return "#0d6efd";
        return "#555";
    }
}
