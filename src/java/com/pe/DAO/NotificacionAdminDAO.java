package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.NotificacionAdmin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class NotificacionAdminDAO {

    ConexionBD cn = new ConexionBD();

    // Registra una notificación nueva. No lanza excepción hacia arriba para no afectar la operación principal.
    public void registrar(String tipo, String mensaje) {
        String sql = "INSERT INTO notificacion_admin (tipo, mensaje) VALUES (?, ?)";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, tipo);
            ps.setString(2, mensaje);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("No se pudo registrar la notificación: " + e.getMessage());
        }
    }

    public int contarNoLeidas() {
        String sql = "SELECT COUNT(*) FROM notificacion_admin WHERE leida = 0";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.err.println("No se pudo contar notificaciones: " + e.getMessage());
        }
        return 0;
    }

    public List<NotificacionAdmin> listarUltimas(int cantidad) {
        List<NotificacionAdmin> lista = new ArrayList<>();
        String sql = "SELECT id, tipo, mensaje, fecha_hora, leida FROM notificacion_admin ORDER BY fecha_hora DESC LIMIT ?";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cantidad);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                NotificacionAdmin n = new NotificacionAdmin();
                n.setId(rs.getInt("id"));
                n.setTipo(rs.getString("tipo"));
                n.setMensaje(rs.getString("mensaje"));
                Timestamp ts = rs.getTimestamp("fecha_hora");
                n.setFechaHora(ts != null ? ts.toString() : "");
                n.setLeida(rs.getInt("leida") == 1);
                lista.add(n);
            }
        } catch (Exception e) {
            System.err.println("No se pudieron listar las notificaciones: " + e.getMessage());
        }
        return lista;
    }

    // Marca todas las notificaciones como leídas (usado al abrir la campana).
    public void marcarTodasLeidas() {
        String sql = "UPDATE notificacion_admin SET leida = 1 WHERE leida = 0";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("No se pudieron marcar como leídas: " + e.getMessage());
        }
    }
}
