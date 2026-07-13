package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Motivo;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MotivoDAO {

    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Motivo c = new Motivo();
    CallableStatement call = null;
    int men = 0;
    String mensaje = "";

    public List ListadoMotivo() {

        ArrayList<Motivo> list = new ArrayList<>();
        String sql = "select * from Motivo";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Motivo mot = new Motivo();
                mot.setIdmotivo(rs.getInt("Idmotivo"));
                mot.setCodigo(rs.getString("Codigo"));
                mot.setNombre(rs.getString("Nombre"));
                mot.setTipo(rs.getString("Tipo"));
                mot.setEstado(rs.getString("Estado"));
                list.add(mot);
            }

        } catch (Exception e) {

        }
        return list;
    }

    public List ListadoEstadoActivos() {

        ArrayList<Motivo> list = new ArrayList<>();
        String sql = "select * from Motivo";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Motivo moti = new Motivo();
                moti.setIdmotivo(rs.getInt("Idmotivo"));
                moti.setCodigo(rs.getString("Codigo"));
                moti.setNombre(rs.getString("Nombre"));
                moti.setTipo(rs.getString("Tipo"));
                moti.setEstado(rs.getString("Estado"));
                list.add(moti);
            }

        } catch (Exception e) {

        }
        return list;
    }

    public List ListadoSalidaActivo() {

        ArrayList<Motivo> list = new ArrayList<>();
        String sql = "select * from Motivo where Tipo='Salida' and Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Motivo moti = new Motivo();
                moti.setIdmotivo(rs.getInt("Idmotivo"));
                moti.setCodigo(rs.getString("Codigo"));
                moti.setNombre(rs.getString("Nombre"));
                moti.setTipo(rs.getString("Tipo"));
                moti.setEstado(rs.getString("Estado"));
                list.add(moti);
            }

        } catch (Exception e) {

        }
        return list;
    }

    public List ListadoIngresoActivo() {

        ArrayList<Motivo> list = new ArrayList<>();
        String sql = "select * from Motivo where Tipo='Ingreso' and Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Motivo moti = new Motivo();
                moti.setIdmotivo(rs.getInt("Idmotivo"));
                moti.setCodigo(rs.getString("Codigo"));
                moti.setNombre(rs.getString("Nombre"));
                moti.setTipo(rs.getString("Tipo"));
                moti.setEstado(rs.getString("Estado"));
                list.add(moti);
            }

        } catch (Exception e) {

        }
        return list;
    }

    public static String estado(int cod) {

        try {
            String sql = "select Estado from Motivo where Idmotivo=" + cod;
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

    public static String getNombreMotivo(int cod) {
        try {
            String sql = "select Nombre from Motivo where Idmotivo=" + cod;
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

    public static String getMotivoEstado(int cod) {

        try {
            String sql = "select Estado from Motivo where Idmotivo=" + cod;
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

    public Motivo list(int id) {

        String sql = "select * from Motivo where Idmotivo=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

                c.setIdmotivo(rs.getInt("Idmotivo"));
                c.setCodigo(rs.getString("Codigo"));
                c.setTipo(rs.getString("Tipo"));
                c.setEstado(rs.getString("Estado"));
                c.setNombre(rs.getString("Nombre"));

            }

        } catch (Exception e) {

        }
        return c;
    }

    public boolean add(Motivo cat) {
        boolean flag = false;
        String sql = "insert into Motivo(Codigo,Nombre,Tipo,Estado)values('" + cat.getCodigo() + "','" + cat.getNombre() + "','" + cat.getTipo() + "','" + cat.getEstado() + "')";

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
        String sql = "select Nombre from Motivo where Nombre=?";
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

    public boolean Edit(Motivo cat) {
        boolean flag = false;
        String sql = "update Motivo set Codigo='" + cat.getCodigo() + "', Nombre='" + cat.getNombre() + "'where Idmotivo=" + cat.getIdmotivo();

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

    public boolean EditEstado(Motivo mo, int id) {
        String sql = "update Motivo set Estado='" + mo.getEstado() + "'where Idmotivo=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public boolean Eliminar(int id) {
        String sql = "delete from Motivo where Idmotivo=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public String Numserie() {
        String sql = "{call sp_generar_codigomotivo()}";

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
    public boolean Yatienemovimiento(int id) {
        boolean flag = false;
        String sql = "select * from Movimiento where Idmotivo=" + id;
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

    public static void main(String[] args) {
        MotivoDAO mp = new MotivoDAO();
        System.out.println(mp.add(new Motivo(0, "00004", "kk", "Tipo", "Activo")));

    }
}
