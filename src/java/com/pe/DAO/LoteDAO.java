package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Lote;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class LoteDAO {

    ConexionBD cn = new ConexionBD();

    public void registrar(int idProducto, int idMovimiento, String codigoLote, String fechaVencimiento, double cantidad) {
        String sql = "INSERT INTO Lote (Idproducto, Idmovimiento, CodigoLote, FechaVencimiento, CantidadInicial) VALUES (?,?,?,?,?)";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idProducto);
            ps.setInt(2, idMovimiento);
            ps.setString(3, codigoLote);
            if (fechaVencimiento != null && !fechaVencimiento.trim().isEmpty()) {
                ps.setDate(4, Date.valueOf(fechaVencimiento));
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }
            ps.setDouble(5, cantidad);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("No se pudo registrar el lote: " + e.getMessage());
        }
    }

    public List<Lote> listarTodos() {
        List<Lote> lista = new ArrayList<>();
        String sql = "SELECT l.*, p.Codigo AS CodigoProd, p.Descripcion FROM Lote l "
                + "JOIN Producto p ON l.Idproducto = p.Idproducto ORDER BY l.FechaVencimiento IS NULL, l.FechaVencimiento ASC";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lote l = new Lote();
                l.setIdlote(rs.getInt("Idlote"));
                l.setIdproducto(rs.getInt("Idproducto"));
                l.setCodigoProducto(rs.getString("CodigoProd"));
                l.setDescripcionProducto(rs.getString("Descripcion"));
                l.setCodigoLote(rs.getString("CodigoLote"));
                Date fv = rs.getDate("FechaVencimiento");
                l.setFechaVencimiento(fv != null ? fv.toString() : "");
                l.setCantidadInicial(rs.getDouble("CantidadInicial"));
                Timestamp fi = rs.getTimestamp("FechaIngreso");
                l.setFechaIngreso(fi != null ? fi.toString() : "");
                l.setEstado(rs.getString("Estado"));
                lista.add(l);
            }
        } catch (Exception e) {
            System.err.println("No se pudieron listar los lotes: " + e.getMessage());
        }
        return lista;
    }
}
