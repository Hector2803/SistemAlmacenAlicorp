package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.AlertaIP;
import com.pe.model.entity.LogAcceso;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO de la bitácora de accesos: registra cada intento de login (exitoso o
 * fallido) y permite al administrador consultar el historial.
 */
public class LogAccesoDAO {

    ConexionBD cn = new ConexionBD();

    /**
     * Registra un intento de acceso. No lanza excepción hacia arriba para
     * que, si falla el registro del log, el login en sí no se vea afectado.
     */
    public void registrar(String usuarioIntento, boolean exito, String ipOrigen, String mensaje) {
        String sql = "INSERT INTO log_acceso (usuario_intento, exito, ip_origen, mensaje) VALUES (?,?,?,?)";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuarioIntento == null ? "" : usuarioIntento);
            ps.setInt(2, exito ? 1 : 0);
            ps.setString(3, ipOrigen);
            ps.setString(4, mensaje);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("No se pudo registrar el log de acceso: " + e.getMessage());
        }
    }

    /**
     * Lista los últimos N registros de la bitácora, más recientes primero.
     */
    public List<LogAcceso> listarUltimos(int cantidad) {
        List<LogAcceso> lista = new ArrayList<>();
        String sql = "SELECT usuario_intento, exito, fecha_hora, ip_origen, mensaje "
                + "FROM log_acceso ORDER BY fecha_hora DESC LIMIT ?";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cantidad);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LogAcceso log = new LogAcceso();
                log.setUsuarioIntento(rs.getString("usuario_intento"));
                log.setExito(rs.getInt("exito") == 1);
                Timestamp ts = rs.getTimestamp("fecha_hora");
                log.setFechaHora(ts != null ? ts.toString() : "");
                log.setIpOrigen(rs.getString("ip_origen"));
                log.setMensaje(rs.getString("mensaje"));
                lista.add(log);
            }
        } catch (Exception e) {
            System.err.println("No se pudo listar el log de acceso: " + e.getMessage());
        }
        return lista;
    }

    /**
     * Lista los accesos de un usuario específico (útil para investigar un caso puntual).
     */
    public List<LogAcceso> listarPorUsuario(String usuario, int cantidad) {
        List<LogAcceso> lista = new ArrayList<>();
        String sql = "SELECT usuario_intento, exito, fecha_hora, ip_origen, mensaje "
                + "FROM log_acceso WHERE usuario_intento = ? ORDER BY fecha_hora DESC LIMIT ?";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setInt(2, cantidad);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LogAcceso log = new LogAcceso();
                log.setUsuarioIntento(rs.getString("usuario_intento"));
                log.setExito(rs.getInt("exito") == 1);
                Timestamp ts = rs.getTimestamp("fecha_hora");
                log.setFechaHora(ts != null ? ts.toString() : "");
                log.setIpOrigen(rs.getString("ip_origen"));
                log.setMensaje(rs.getString("mensaje"));
                lista.add(log);
            }
        } catch (Exception e) {
            System.err.println("No se pudo listar el log de acceso por usuario: " + e.getMessage());
        }
        return lista;
    }

    /**
     * Detecta IPs con muchos intentos fallidos en poco tiempo (posible ataque de fuerza bruta).
     * Umbral configurable: por defecto, 5 o más fallos en los últimos 30 minutos.
     */
    public List<AlertaIP> detectarIPsSospechosas(int minimoIntentos, int minutosVentana) {
        List<AlertaIP> lista = new ArrayList<>();
        String sql = "SELECT ip_origen, COUNT(*) AS cantidad, MAX(fecha_hora) AS ultimo "
                + "FROM log_acceso WHERE exito = 0 AND ip_origen IS NOT NULL "
                + "AND fecha_hora >= (NOW() - INTERVAL ? MINUTE) "
                + "GROUP BY ip_origen HAVING COUNT(*) >= ? ORDER BY cantidad DESC";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, minutosVentana);
            ps.setInt(2, minimoIntentos);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AlertaIP a = new AlertaIP();
                a.setIp(rs.getString("ip_origen"));
                a.setCantidad(rs.getInt("cantidad"));
                Timestamp ts = rs.getTimestamp("ultimo");
                a.setUltimoIntento(ts != null ? ts.toString() : "");
                lista.add(a);
            }
        } catch (Exception e) {
            System.err.println("No se pudo detectar IPs sospechosas: " + e.getMessage());
        }
        return lista;
    }
}
