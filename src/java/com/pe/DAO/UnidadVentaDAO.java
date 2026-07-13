/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.UnidadVenta;
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
public class UnidadVentaDAO {

    UnidadVenta v = new UnidadVenta();
    CallableStatement call = null;
    String mensaj = "";

    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    String mensaje = "";

    public List ListaUnidadVenta() {
        ArrayList<UnidadVenta> listaunidad = new ArrayList<>();
        String sql = "SELECT * FROM UnidadMedidaVenta";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                UnidadVenta uv = new UnidadVenta();
                uv.setIduventa(rs.getInt("Iduventa"));
                uv.setCodigo(rs.getString("Codigo"));
                uv.setNombre(rs.getString("Nombre"));
                uv.setContenido(rs.getInt("Contenido"));
                uv.setEstado(rs.getString("Estado"));
                listaunidad.add(uv);
            }
        } catch (Exception e) {
        }
        return listaunidad;
    }

    public UnidadVenta list(int id) {

        String sql = "select * from UnidadMedidaVenta where Iduventa=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

                v.setIduventa(rs.getInt("Iduventa"));
                v.setCodigo(rs.getString("Codigo"));
                v.setNombre(rs.getString("Nombre"));
                v.setContenido(rs.getInt("Contenido"));
                v.setEstado(rs.getString("Estado"));

            }

        } catch (Exception e) {

        }
        return v;
    }

    //Mostrar nombre de UnidadVenta en Producto.jsp
    public static String getNombreUnidadventa(int cod) {
        try {
            String sql = "select Nombre from UnidadMedidaVenta where Iduventa=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Nombre");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public static String getUndVenta(int cod) {
        try {
            String sql = "Select Nombre from UnidadMedidaVenta u inner join Producto p where u.Iduventa=p.Iduventa And Idproducto=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Nombre");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public boolean add(UnidadVenta uv) {
        boolean flag = false;
        String sql = "insert into UnidadMedidaVenta(Codigo,Nombre,Contenido,Estado)values('" + uv.getCodigo() + "','" + uv.getNombre() + "','" + uv.getContenido() + "','" + uv.getEstado() + "')";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            if (ps.executeUpdate() == 1) {
                flag = true;
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return flag;
    }

    public boolean Edit(UnidadVenta uv) {
        boolean flag = false;
        String sql = "update UnidadMedidaVenta set Codigo='" + uv.getCodigo() + "', Nombre='" + uv.getNombre() + "', Contenido='" + uv.getContenido() + "'where Iduventa=" + uv.getIduventa();
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            if (ps.executeUpdate() == 1) {
                flag = true;
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return flag;
    }

    public boolean Eliminar(int id) {
        String sql = "delete from UnidadMedidaVenta where Iduventa=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public String Numserie() {
        String sql = "{call sp_generar_codigoUndVenta()}";

        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();

            if (rs.next()) {
                mensaj = rs.getString(1);

            }
        } catch (SQLException e) {
        }
        return mensaj;

    }

    public static String getUventaEstado(int cod) {

        try {
            String sql = "select Estado from UnidadMedidaVenta where Iduventa=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Estado");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public boolean Estado(UnidadVenta mo, int id) {
        String sql = "update UnidadMedidaVenta set Estado='" + mo.getEstado() + "'where Iduventa=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public static void main(String[] args) {

        UnidadVentaDAO uv = new UnidadVentaDAO();
        List<UnidadVenta> lista = uv.ListaUnidadVenta();
        System.out.println("Lista " + lista.size());

        lista.forEach(c -> {
            System.out.println(c.toString());

        });
    }

}
