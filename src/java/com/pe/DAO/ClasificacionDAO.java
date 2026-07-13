/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Clasificacion;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClasificacionDAO {

    ConexionBD cn = new ConexionBD();
    Connection con;
    int mensaje = 0;
    PreparedStatement ps;
    ResultSet rs;
    Clasificacion c = new Clasificacion();
    CallableStatement call = null;
    int men = 0;
    String mensaj = "";

    //Listado Clasificacion uso en Clasificacion.jsp
    public List ListadoClasificacion() {
        ArrayList<Clasificacion> list = new ArrayList<>();
        String sql = "SELECT * FROM Clasificacion";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Clasificacion cat = new Clasificacion();
                cat.setIdclasi(rs.getInt("Idclasi"));
                cat.setCodigo(rs.getString("Codigo"));
                cat.setNombre(rs.getString("Nombre"));
                cat.setEstado(rs.getString("Estado"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List ListadoEstadoActivos() {
        ArrayList<Clasificacion> list = new ArrayList<>();
        String sql = "select * from Clasificacion where Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Clasificacion cat = new Clasificacion();
                cat.setIdclasi(rs.getInt("Idclasi"));
                cat.setCodigo(rs.getString("Codigo"));
                cat.setNombre(rs.getString("Nombre"));
                list.add(cat);
            }
        } catch (Exception e) {

        }
        return list;
    }

    //Seleccionar Clasificacion dependiendo el ID uso en EditarClasificacion.jsp
    public Clasificacion BuscarporID(int id) {
        String sql = "select * from Clasificacion where Idclasi=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                c.setIdclasi(rs.getInt("Idclasi"));
                c.setCodigo(rs.getString("Codigo"));
                c.setNombre(rs.getString("Nombre"));
            }
        } catch (Exception e) {
        }
        return c;
    }

    //Insertar Clasificacion uso ControllerClasificacion
    public boolean add(Clasificacion cat) {
        boolean flag = false;
        String sql = "insert into Clasificacion(Codigo,Nombre,Estado)values('" + cat.getCodigo() + "','" + cat.getNombre() + "','" + cat.getEstado() + "')";
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

    //Editar Clasificacion uso ControllerClasificacion
    public boolean Edit(Clasificacion cla) {
        boolean flag = false;
        String sql = "update Clasificacion set Codigo='" + cla.getCodigo() + "',Nombre='" + cla.getNombre() + "'where Idclasi=" + cla.getIdclasi();
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

    //Eliminar Clasificacion uso ControllerClasificacion
    public boolean Eliminar(int id) {
        boolean flag = false;
        String sql = "delete from Clasificacion where Idclasi=" + id;
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

    public boolean Yatienemovimiento(int id) {
        boolean flag = false;
        String sql = "select * from Producto where Idclasi=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                flag = true;
            }
        } catch (Exception e) {

        }
        return flag;
    }

    public boolean validacion(String cl) {
        boolean flag = false;
        String sql = "select Nombre from Clasificacion where Nombre=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, cl);
            rs = ps.executeQuery();
            while (rs.next()) {
                flag = true;
            }
        } catch (Exception e) {

        }
        return flag;
    }

    //Mostrar nombre de la Clasificacion la lista de producto en Producto.jsp
    public static String getNombreClasificacionc(int cod) {
        try {
            String sql = "select Nombre from Clasificacion where Idclasi=" + cod;
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
    //Mostrar nombre de Clasificacion en Producto.jsp

    public static String getNombreClasificacion(int cod) {
        try {
            String sql = "select Nombre from Clasificacion u join Producto p where u.Idclasi=p.Idclasi And Idproducto=" + cod;
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

    //obtener estado Clasificacion cin el ID uso en ControllerClasificacion and Clasificacion.jsp
    public static String getclasificacionEstado(int cod) {
        try {
            String sql = "select Estado from Clasificacion where Idclasi=" + cod;
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

    //Editar estado uso ControllerClasificacion
    public boolean EditarEstado(Clasificacion cat, int id) {
        String sql = "update Clasificacion set Estado='" + cat.getEstado() + "'where Idclasi=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    //Codigo para Clasificacion uso en Clasificacion.jsp
    public String Numserie() {
        String sql = "{call sp_generar_codigoclasificacion()}";
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

}
