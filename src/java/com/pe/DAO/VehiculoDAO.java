/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Vehiculo;
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
public class VehiculoDAO {

    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Vehiculo c = new Vehiculo();
    CallableStatement call = null;
    int men = 0;
    String mensaje = "";

    //Listar todo el registro de Vehiculo uso en Vehiculo.jsp
    public List ListadoVehiculo() {
        ArrayList<Vehiculo> list = new ArrayList<>();
        String sql = "SELECT * FROM Vehiculo ORDER BY Idvehi desc";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Vehiculo cat = new Vehiculo();
                cat.setIdvehi(rs.getInt("Idvehi"));
                cat.setCodigo(rs.getString("Codigo"));
                cat.setPlaca(rs.getString("placa"));
                cat.setMarca(rs.getString("marca"));
                cat.setEstado(rs.getString("Estado"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List ListadoEstadoActivos() {
        ArrayList<Vehiculo> list = new ArrayList<>();
        String sql = "select * from Vehiculo where Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Vehiculo cat = new Vehiculo();
                cat.setIdvehi(rs.getInt("Idvehi"));
                cat.setCodigo(rs.getString("Codigo"));
                cat.setPlaca(rs.getString("placa"));
                cat.setMarca(rs.getString("marca"));
                cat.setEstado(rs.getString("Estado"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }

    //Obtener el estdo de Vehiculo uso en ControllerVehiculo and Vehiculo.js
    public static String getVehiculoEstado(int cod) {
        try {
            String sql = "select Estado from Vehiculo where Idvehi=" + cod;
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

    //Mostrar nombre de Vehiculo en Producto.jsp
    public static String getPlaca(int cod) {
        try {
            String sql = "select Placa from Vehiculo where Idvehi=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Placa");
            }
            return "--";
        } catch (Exception e) {
            return "--";
        }
    }
    //Mostrar nombre de Vehiculo en Producto.jsp

    public static String getMarca(int cod) {
        try {
            String sql = "select Marca from Vehiculo where Idvehi=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Marca");
            }
            return "--";
        } catch (Exception e) {
            return "--";
        }
    }

    //Optener Vehiculo por ID uso en EditarVehiculo.jsp
    public Vehiculo VehiculoID(int id) {
        String sql = "select * from Vehiculo where Idvehi=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                c.setIdvehi(rs.getInt("Idvehi"));
                c.setCodigo(rs.getString("Codigo"));
                c.setPlaca(rs.getString("placa"));
                c.setMarca(rs.getString("marca"));
                c.setEstado(rs.getString("Estado"));
            }
        } catch (Exception e) {
        }
        return c;
    }

    //Insertar Vehiculo uso en ControllerVehiculo
    public boolean add(Vehiculo cat) {
        boolean flag = false;
        String sql = "insert into Vehiculo(Codigo,placa,marca,Estado)values('" + cat.getCodigo() + "','" + cat.getPlaca() + "','" + cat.getMarca() + "','" + cat.getEstado() + "')";
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

    public boolean validacion(String cl) {
        boolean flag = false;
        String sql = "select placa from Vehiculo where placa=?";
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

    //Editar Vehiculo uso en ControllerVehiculo
    public boolean Edit(Vehiculo cat) {
        boolean flag = false;
        String sql = "update Vehiculo set Codigo='" + cat.getCodigo() + "', placa='" + cat.getPlaca() + "', marca='" + cat.getMarca() + "'where Idvehi=" + cat.getIdvehi();

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

    //Editar estado Vehiculo uso en ControllerVehiculo
    public boolean EditarEstado(Vehiculo cat, int id) {
        String sql = "update Vehiculo set Estado='" + cat.getEstado() + "'where Idvehi=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    //Eliminar Vehiculo uso en ControllerVehiculo
    public boolean Eliminar(int id) {
        String sql = "delete from Vehiculo where Idvehi=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }
    
        public boolean Yatienemovimiento(int id) {
        boolean flag = false;
        String sql = "select * from Movimiento where Idvehi=" + id;
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

    //Codigo Vehiculo uso en Vehiculo.jsp
    public String Numserie() {
        String sql = "{call sp_generar_codigoVehiculo()}";
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

}
