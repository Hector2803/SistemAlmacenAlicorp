package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Conductor;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ConductorDAO {

    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Conductor co = new Conductor();
    CallableStatement call = null;
    int men = 0;
    String mensaje = "";
    String mensaj = "";

    public List ListadoConductor() {

        ArrayList<Conductor> list = new ArrayList<>();
        String sql = "select * from Conductor";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Conductor cond = new Conductor();
                cond.setIdcond(rs.getInt("Idcond"));
                cond.setCodigo(rs.getString("Codigo"));
                cond.setNumerodocumento(rs.getString("Numerodocumento"));
                cond.setChofer(rs.getString("Chofer"));
                cond.setLicencia(rs.getString("Licencia"));
                cond.setEstado(rs.getString("Estado"));
                list.add(cond);
            }

        } catch (Exception e) {

        }
        return list;
    }

    public List ListadoEstadoActivos() {
        ArrayList<Conductor> list = new ArrayList<>();
        String sql = "select * from Conductor";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Conductor conduc = new Conductor();
                conduc.setIdcond(rs.getInt("Idcond"));
                conduc.setCodigo(rs.getString("Codigo"));
                conduc.setNumerodocumento(rs.getString("Numerodocumento"));
                conduc.setChofer(rs.getString("Chofer"));
                conduc.setLicencia(rs.getString("Licencia"));
                conduc.setEstado(rs.getString("Estado"));
                list.add(conduc);
            }
        } catch (Exception e) {
        }
        return list;
    }

    //Mostrar estado segun el ID del cliente uso en ControllerCconductor and CONDUCTOR.jsp
    public static String estado(int cod) {
        try {
            String sql = "select Estado from Conductor where Idcond=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("estado");
            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public static String getNumerodocumento(int cod) {
        try {
            String sql = "select Numerodocumento from Conductor where Idcond=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Numerodocumento");
            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public static String getConductorEstado(int cod) {

        try {
            String sql = "select Estado from Conductor where Idcond=" + cod;
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

    //Llamar al cliente para seleccionar en VInsertarventa uso en // ControllerCliente
    public Conductor BuscarPorId(int idCliente) {
        Conductor pv = null;
        String sql = "select * from Conductor where Idcond = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idCliente);
            rs = ps.executeQuery();
            if (rs.next()) {
                pv = new Conductor();
                pv.setIdcond(rs.getInt("Idcond"));
                pv.setCodigo(rs.getString("Codigo"));
                pv.setNumerodocumento(rs.getString("Numerodocumento"));
                pv.setChofer(rs.getString("Chofer"));
                pv.setLicencia(rs.getString("Licencia"));
                pv.setEstado(rs.getString("Estado"));
            }
        } catch (SQLException e) {
            mensaj = e.getMessage();
        } finally {
            cn.desconectar();
        }
        return pv;
    }

    public Conductor list(int id) {

        String sql = "select * from Conductor where Idcond=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                co.setIdcond(rs.getInt("Idcond"));
                co.setCodigo(rs.getString("Codigo"));
                co.setNumerodocumento(rs.getString("Numerodocumento"));
                co.setChofer(rs.getString("Chofer"));
                co.setLicencia(rs.getString("Licencia"));
                co.setEstado(rs.getString("Estado"));

            }

        } catch (Exception e) {

        }
        return co;
    }

    public boolean add(Conductor cat) {
        boolean flag = false;
        String sql = "insert into Conductor(Codigo,Idtipodocumento,Numerodocumento,chofer,licencia,Estado)values('" + cat.getCodigo() + "','" + cat.getIdtipodocumento() + "','" + cat.getNumerodocumento() + "','" + cat.getChofer() + "','" + cat.getLicencia() + "','" + cat.getEstado() + "')";

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

    public boolean validacion(Conductor cli) {
        boolean flag = false;
        String sql = "select Numerodocumento from Conductor where Numerodocumento=" + cli.getNumerodocumento();
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

    public boolean Edit(Conductor cat) {
        boolean flag = false;
        String sql = "update Conductor set Codigo='" + cat.getCodigo() + "', Idtipodocumento='" + cat.getIdtipodocumento() + "', Numerodocumento='" + cat.getNumerodocumento() + "', Chofer='" + cat.getChofer() + "', Licencia='" + cat.getLicencia() + "'where Idcond=" + cat.getIdcond();

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

    //Editar estado de cliente uso en ControllerCliente
    public boolean editEstado(Conductor cli, int id) {
        String sql = "update Conductor set Estado='" + cli.getEstado() + "' where Idcond=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public boolean Eliminar(int id) {
        String sql = "delete from Conductor where Idcond=" + id;
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
        String sql = "select * from Movimiento where Idcond=" + id;
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

    public String Numserie() {
        String sql = "{call sp_generar_codigoconductor()}";

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

    public static void main(String[] args) {
        ConductorDAO mp = new ConductorDAO();
        System.out.println(mp.add(new Conductor(0, "000015", 1, "15252", "hhhh", "jjjjj", "Activo")));

    }
}
