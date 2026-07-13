/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.UnidadCompra;
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
public class UnidadCompraDAO {

    UnidadCompra v = new UnidadCompra();
    ConexionBD cn = new ConexionBD();
    CallableStatement call = null;
    String mensaj = "";
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    String mensaje = "";

    public List ListaUnidadCompra() {
        ArrayList<UnidadCompra> listaunidad = new ArrayList<>();
        String sql = "SELECT * FROM UnidadMedidaCompra";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                UnidadCompra uc = new UnidadCompra();
                uc.setIducompra(rs.getInt("Iducompra"));
                uc.setCodigo(rs.getString("Codigo"));
                uc.setNombre(rs.getString("Nombre"));
                uc.setContenido(rs.getInt("Contenido"));
                uc.setEstado(rs.getString("Estado"));
                listaunidad.add(uc);
            }
        } catch (Exception e) {
        }
        return listaunidad;
    }

    public static int getcontenido(int cod) {
        int mensaje = 0;
        try {
            String sql = "select Contenido from UnidadMedidaCompra where Iducompra=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("Contenido");

            }
            return mensaje;

        } catch (Exception e) {
            return mensaje;
        }
    }
    //Mostrar nombre de categoria en Producto.jsp

    public static String getNombreUnidadcompra(int cod) {
        try {
            String sql = "select Nombre from UnidadMedidaCompra where Iducompra=" + cod;
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

    public UnidadCompra list(int id) {

        String sql = "select * from UnidadMedidaCompra where Iducompra=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

                v.setIducompra(rs.getInt("Iducompra"));
                v.setCodigo(rs.getString("Codigo"));
                v.setNombre(rs.getString("Nombre"));
                v.setContenido(rs.getInt("Contenido"));
                v.setEstado(rs.getString("Estado"));

            }

        } catch (Exception e) {

        }
        return v;
    }

    public boolean add(UnidadCompra uv) {
        boolean flag = false;
        String sql = "insert into UnidadMedidaCompra(Codigo,Nombre,Contenido,Estado)values('" + uv.getCodigo() + "','" + uv.getNombre() + "','" + uv.getContenido() + "','" + uv.getEstado() + "')";

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

    public boolean Edit(UnidadCompra uv) {
        boolean flag = false;
        String sql = "update UnidadMedidaCompra set Codigo='" + uv.getCodigo() + "', Nombre='" + uv.getNombre() + "', Contenido='" + uv.getContenido() + "'where Iducompra=" + uv.getIducompra();
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
        String sql = "delete from UnidadMedidaCompra where Iducompra=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public String Numserie() {
        String sql = "{call sp_generar_codigoUndcompra()}";

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

    public static String getUcompraEstado(int cod) {
        try {
            String sql = "select Estado from UnidadMedidaCompra where Iducompra=" + cod;
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

    public boolean Estado(UnidadCompra mo, int id) {
        String sql = "update UnidadMedidaCompra set Estado='" + mo.getEstado() + "'where Iducompra=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public static void main(String[] args) {

        UnidadCompraDAO uc = new UnidadCompraDAO();
        List<UnidadCompra> lista = uc.ListaUnidadCompra();
        System.out.println("Lista " + lista.size());

        lista.forEach(c -> {
            System.out.println(c.toString());

        });
        System.out.println(uc.add(new UnidadCompra(0, "00008", "kk", 1, "Activo")));
    }

}
