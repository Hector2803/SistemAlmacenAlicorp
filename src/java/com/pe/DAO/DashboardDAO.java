/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Auxiliar;
import com.pe.model.entity.DetalleMovimiento;
import com.pe.model.entity.KardexMovimiento;
import com.pe.model.entity.Producto;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author yenny
 */
public class DashboardDAO {

    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    CallableStatement call = null;
    int men = 0;
    String mensaje = "";

    public String ocpendiente() {
        String sql = "{call sp_generar_contarOC()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

    public String contarcliente() {
        String sql = "{call sp_generar_contarcliente()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

    public String contarproveedor() {
        String sql = "{call sp_generar_contarproveedor()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

    public String contarproducto() {
        String sql = "{call sp_generar_contarproducto()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

    public List consulta10productosconmasingresos() {
        ArrayList<Producto> list = new ArrayList<>();
        String sql = "SELECT p.Codigo, p.Descripcion, SUM(d.cantidad) as cantidad\n"
                + "    FROM Detallemovimiento d JOIN Producto p \n"
                + "    ON d.idproducto = p.idproducto \n"
                + "JOIN Movimiento m\n"
                + "ON m.idmovimiento=d.idmovimiento where m.Serie=\"NI01\" and m.Estado<>\"anulado\"\n"
                + "    GROUP BY p.idProducto\n"
                + "    ORDER BY SUM(d.cantidad) DESC LIMIT 10;";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto cat = new Producto();
                cat.setCodigo(rs.getString("Codigo"));
                cat.setDescripcion(rs.getString("Descripcion"));
                cat.setStock(rs.getInt("cantidad"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List consulta10productosconmassalidas() {
        ArrayList<Producto> list = new ArrayList<>();
        String sql = "SELECT p.Codigo, p.Descripcion, SUM(d.cantidad) as cantidad\n"
                + "    FROM Detallemovimiento d JOIN Producto p \n"
                + "    ON d.idproducto = p.idproducto \n"
                + "JOIN Movimiento m\n"
                + "ON m.idmovimiento=d.idmovimiento where m.Tipocomprobante IN (\"NOTA DE SALIDA\",\"GUIA DE REMISION\") and m.Estado<>\"anulado\"\n"
                + "    GROUP BY p.idProducto\n"
                + "    ORDER BY SUM(d.cantidad) DESC LIMIT 10;";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto cat = new Producto();
                cat.setCodigo(rs.getString("Codigo"));
                cat.setDescripcion(rs.getString("Descripcion"));
                cat.setStock(rs.getInt("cantidad"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }

    // Detalle completo (no solo el top 10) de todos los movimientos de ingreso, con fecha y hora
    public List consultaDetalleIngresos() {
        ArrayList<KardexMovimiento> list = new ArrayList<>();
        String sql = "SELECT p.Codigo, p.Descripcion, d.cantidad, m.Fecha, m.Serie, m.Correlativo\n"
                + "    FROM Detallemovimiento d JOIN Producto p ON d.idproducto = p.idproducto\n"
                + "    JOIN Movimiento m ON m.idmovimiento = d.idmovimiento\n"
                + "    WHERE m.Serie=\"NI01\" and m.Estado<>\"anulado\"\n"
                + "    ORDER BY d.cantidad DESC;";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                KardexMovimiento k = new KardexMovimiento();
                k.setSerie(rs.getString("Codigo"));
                k.setTipocomprobante(rs.getString("Descripcion"));
                k.setIngreso(rs.getDouble("cantidad"));
                k.setFecha(rs.getString("Fecha"));
                k.setCorrelativo(rs.getString("Serie") + "-" + rs.getString("Correlativo"));
                list.add(k);
            }
        } catch (Exception e) {
        }
        return list;
    }

    // Detalle completo (no solo el top 10) de todos los movimientos de salida (Nota de Salida + Guía de Remisión), con fecha y hora
    public List consultaDetalleSalidas() {
        ArrayList<KardexMovimiento> list = new ArrayList<>();
        String sql = "SELECT p.Codigo, p.Descripcion, d.cantidad, m.Fecha, m.Serie, m.Correlativo\n"
                + "    FROM Detallemovimiento d JOIN Producto p ON d.idproducto = p.idproducto\n"
                + "    JOIN Movimiento m ON m.idmovimiento = d.idmovimiento\n"
                + "    WHERE m.Tipocomprobante IN (\"NOTA DE SALIDA\",\"GUIA DE REMISION\") and m.Estado<>\"anulado\"\n"
                + "    ORDER BY d.cantidad DESC;";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                KardexMovimiento k = new KardexMovimiento();
                k.setSerie(rs.getString("Codigo"));
                k.setTipocomprobante(rs.getString("Descripcion"));
                k.setIngreso(rs.getDouble("cantidad"));
                k.setFecha(rs.getString("Fecha"));
                k.setCorrelativo(rs.getString("Serie") + "-" + rs.getString("Correlativo"));
                list.add(k);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public String contarOC() {
        String sql = "{call sp_generar_contaroc()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

    public String contarFactura() {
        String sql = "{call sp_generar_contarfc()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

    public String valorcompra() {
        String sql = "{call sp_generar_valortotaldecompra()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

    public String Contarempleado() {
        String sql = "{call sp_generar_contarusuario()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

    public String Valorinventario() {
        String sql = "{call sp_generar_valorinventario()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }

     public List consulta10principalesprovedores() {
        ArrayList<Auxiliar> list = new ArrayList<>();
        String sql = "SELECT u.Nombre, u.Numerodocumento, SUM(d.cantidad) AS TOTAL\n" +
"FROM Movimiento v\n" +
"INNER JOIN Auxiliar u ON u.idauxiliar = v.idauxiliar\n" +
"INNER JOIN DetalleMovimiento d ON d.idmovimiento = v.idmovimiento\n" +
"GROUP BY u.idauxiliar, u.Nombre ORDER BY TOTAL desc;";
         try {
             con = cn.getConnection();
             ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Auxiliar cat = new Auxiliar();
                cat.setNombre(rs.getString("Nombre"));
                cat.setNumerodocumento(rs.getString("Numerodocumento"));
                cat.setIdauxiliar(rs.getInt("TOTAL"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    
}
