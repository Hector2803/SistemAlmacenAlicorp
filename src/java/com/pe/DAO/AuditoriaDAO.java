package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Auditoria;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class AuditoriaDAO {

    ConexionBD cn = new ConexionBD();

    // No lanza excepción hacia arriba: si falla el registro de auditoría, la acción principal no debe verse afectada.
    public void registrar(String usuario, String accion, String modulo, String detalle) {
        String sql = "INSERT INTO auditoria (usuario, accion, modulo, detalle) VALUES (?,?,?,?)";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario == null ? "" : usuario);
            ps.setString(2, accion);
            ps.setString(3, modulo);
            ps.setString(4, detalle);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("No se pudo registrar la auditoría: " + e.getMessage());
        }
        // Toda entrada de auditoría también genera una notificación para el administrador.
        String mensajeNotif = (usuario != null ? usuario + ": " : "") + accion
                + (detalle != null && !detalle.trim().isEmpty() ? " — " + detalle : "");
        new NotificacionAdminDAO().registrar(mapearTipoNotificacion(modulo, accion), mensajeNotif);
    }

    private String mapearTipoNotificacion(String modulo, String accion) {
        String a = accion == null ? "" : accion.toLowerCase();
        if (a.contains("bloque") || a.contains("intento fallido")) {
            return "ip_sospechosa";
        }
        if (a.contains("contraseña") || a.contains("password")) {
            return "password_cambiada";
        }
        if ("Logistica".equalsIgnoreCase(modulo) || "Compras".equalsIgnoreCase(modulo)) {
            return "movimiento_stock";
        }
        return "auditoria";
    }

    public List<Auditoria> listarUltimas(int cantidad) {
        List<Auditoria> lista = new ArrayList<>();
        String sql = "SELECT id, usuario, accion, modulo, detalle, fecha_hora FROM auditoria ORDER BY fecha_hora DESC LIMIT ?";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cantidad);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (Exception e) {
            System.err.println("No se pudo listar la auditoría: " + e.getMessage());
        }
        return lista;
    }

    public List<Auditoria> filtrar(String usuario, String modulo, int cantidad) {
        List<Auditoria> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT id, usuario, accion, modulo, detalle, fecha_hora FROM auditoria WHERE 1=1");
        if (usuario != null && !usuario.trim().isEmpty()) {
            sql.append(" AND usuario LIKE ?");
        }
        if (modulo != null && !modulo.trim().isEmpty()) {
            sql.append(" AND modulo = ?");
        }
        sql.append(" ORDER BY fecha_hora DESC LIMIT ?");
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql.toString());
            int idx = 1;
            if (usuario != null && !usuario.trim().isEmpty()) {
                ps.setString(idx++, "%" + usuario.trim() + "%");
            }
            if (modulo != null && !modulo.trim().isEmpty()) {
                ps.setString(idx++, modulo.trim());
            }
            ps.setInt(idx, cantidad);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (Exception e) {
            System.err.println("No se pudo filtrar la auditoría: " + e.getMessage());
        }
        return lista;
    }

    // NUEVO: filtra por usuario, rol (uniendo con la tabla usuario), y rango de fechas.
    // Cualquier parámetro vacío/nulo simplemente no se aplica.
    public List<Auditoria> filtrarAvanzado(String usuario, String rol, String fechaDesde, String fechaHasta, int cantidad) {
        List<Auditoria> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT a.id, a.usuario, a.accion, a.modulo, a.detalle, a.fecha_hora "
                + "FROM auditoria a LEFT JOIN usuario u ON a.usuario = u.email WHERE 1=1");
        boolean fUsuario = usuario != null && !usuario.trim().isEmpty();
        boolean fRol = rol != null && !rol.trim().isEmpty();
        boolean fDesde = fechaDesde != null && !fechaDesde.trim().isEmpty();
        boolean fHasta = fechaHasta != null && !fechaHasta.trim().isEmpty();
        if (fUsuario) {
            sql.append(" AND a.usuario LIKE ?");
        }
        if (fRol) {
            sql.append(" AND u.rol = ?");
        }
        if (fDesde) {
            sql.append(" AND DATE(a.fecha_hora) >= ?");
        }
        if (fHasta) {
            sql.append(" AND DATE(a.fecha_hora) <= ?");
        }
        sql.append(" ORDER BY a.fecha_hora DESC LIMIT ?");
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql.toString());
            int idx = 1;
            if (fUsuario) {
                ps.setString(idx++, "%" + usuario.trim() + "%");
            }
            if (fRol) {
                ps.setString(idx++, rol.trim());
            }
            if (fDesde) {
                ps.setString(idx++, fechaDesde.trim());
            }
            if (fHasta) {
                ps.setString(idx++, fechaHasta.trim());
            }
            ps.setInt(idx, cantidad);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (Exception e) {
            System.err.println("No se pudo filtrar la auditoría: " + e.getMessage());
        }
        return lista;
    }

    private Auditoria mapear(ResultSet rs) throws Exception {
        Auditoria a = new Auditoria();
        a.setId(rs.getInt("id"));
        a.setUsuario(rs.getString("usuario"));
        a.setAccion(rs.getString("accion"));
        a.setModulo(rs.getString("modulo"));
        a.setDetalle(rs.getString("detalle"));
        Timestamp ts = rs.getTimestamp("fecha_hora");
        a.setFechaHora(ts != null ? ts.toString() : "");
        return a;
    }
}
