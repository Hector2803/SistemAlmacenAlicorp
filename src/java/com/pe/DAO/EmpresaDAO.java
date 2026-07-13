/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Empresa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author yenny
 */
public class EmpresaDAO {

    ConexionBD cn = new ConexionBD();
    int mensaje = 0;
    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection con = null;
    String mensaj = "";
    Empresa U = new Empresa();

    public static String img() {

        try {
            String sql = "select filename1 from Empresa where id='1' ";
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("filename1");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public static String Nombre() {

        try {
            String sql = "select nombre from Empresa where id='1' ";
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("nombre");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public static String Direccion() {

        try {
            String sql = "select Direccion from Empresa where id='1' ";
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Direccion");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }
    public static String Nro() {

        try {
            String sql = "select Nro from Empresa where id='1' ";
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Nro");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }
       public static String ubigeo() {

        try {
            String sql = "select ubigeo from Empresa where id='1' ";
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("ubigeo");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }
              public static String adicional() {

        try {
            String sql = "select Adicional from Empresa where id='1' ";
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Adicional");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }
    public List ListadoEmpresa() {
        ArrayList<Empresa> list = new ArrayList<>();
        String sql = "select * from Empresa";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

                Empresa Emp = new Empresa();
                Emp.setId(rs.getInt("id"));
                Emp.setNombre(rs.getString("nombre"));
                Emp.setNro(rs.getString("Nro"));
                Emp.setDireccion(rs.getString("Direccion"));
                Emp.setUbigeo(rs.getString("Ubigeo"));
                Emp.setAdicional(rs.getString("Adicional"));
                Emp.setFilename1(rs.getString("filename1"));
                list.add(Emp);
            }
        } catch (Exception e) {

        }
        return list;

    }

    public Empresa list(int id) {
        ArrayList<Empresa> list = new ArrayList<>();
        String sql = "select * from Empresa where id=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                U.setId(rs.getInt("id"));
                U.setNombre(rs.getString("nombre"));
                U.setNro(rs.getString("Nro"));
                U.setDireccion(rs.getString("Direccion"));
                U.setUbigeo(rs.getString("Ubigeo"));
                U.setAdicional(rs.getString("Adicional"));
                U.setFilename1(rs.getString("filename1"));
                list.add(U);
            }

        } catch (Exception e) {

        }
        return U;
    }

    public boolean Editimgg(Empresa i) {
        boolean rpt = false;
        try {
            con = cn.getConnection();
            String sql = "UPDATE Empresa SET nombre=?, Nro=?, Direccion=?,Ubigeo=?, Adicional=?, filename1=?, path1=? WHERE id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, i.getNombre());
            pst.setString(2, i.getNro());
            pst.setString(3, i.getDireccion());
            pst.setString(4, i.getUbigeo());
            pst.setString(5, i.getAdicional());
            pst.setString(6, i.getFilename1());
            pst.setString(7, i.getPath1());
            pst.setInt(8, i.getId());

            if (pst.executeUpdate() == 1) {
                rpt = true;
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return rpt;
    }

}
