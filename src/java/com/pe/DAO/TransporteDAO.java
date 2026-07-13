package com.pe.DAO;
import com.pe.conection.ConexionBD;
import com.pe.model.entity.Transporte;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class TransporteDAO {
    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Transporte c = new Transporte();
    CallableStatement call=null;
    int men=0;
    String mensaje = "";

    public List ListadoTransporte() {
        ArrayList<Transporte> list = new ArrayList<>();
        String sql = "SELECT * FROM Transporte ORDER BY Idtrans DESC";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Transporte mat = new Transporte();
                mat.setIdtrans(rs.getInt("Idtrans"));
                mat.setCodigo(rs.getString("Codigo"));
                mat.setNombre(rs.getString("Nombre"));
                mat.setTipo(rs.getString("tipo"));
                mat.setEstado(rs.getString("Estado"));
                list.add(mat);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List ListadoEstadoActivos() {
        ArrayList<Transporte> list = new ArrayList<>();
        String sql = "select * from Transporte where Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Transporte mat = new Transporte();
                mat.setIdtrans(rs.getInt("Idtrans"));
                mat.setNombre(rs.getString("Nombre"));
                list.add(mat);
            }
        } catch (Exception e) {

        }
        return list;
    }
    
    public static String estado(int cod) {
        try {
            String sql = "select Estado from Transporte where Idtrans=" + cod;
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
    public static String getNombre(int cod) {
        try {
            String sql = "select Nombre from Transporte where Idtrans=" + cod;
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
    public static String getTipo(int cod) {
        try {
            String sql = "select Tipo from Transporte where Idtrans=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Tipo");
            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }
    
    public Transporte list(int id) {
        String sql = "select * from Transporte where Idtrans=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

                c.setIdtrans(rs.getInt("Idtrans"));
                c.setCodigo(rs.getString("Codigo"));
                c.setNombre(rs.getString("Nombre"));
            }
        } catch (Exception e) {
        }
        return c;
    }
    
    public boolean add(Transporte mat) {
        boolean flag = false;
        String sql = "insert into Transporte(Codigo,Nombre,Tipo,Estado)values('" + mat.getCodigo() + "','" + mat.getNombre()+ "','" + mat.getTipo() + "','" + mat.getEstado() + "')";
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
    
    public boolean Edit(Transporte mat) {
        boolean flag = false;
        String sql = "update Transporte set Codigo='"+mat.getCodigo()+"',Nombre='" + mat.getNombre() + "'where Idtrans=" + mat.getIdtrans();
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
    
    public boolean Estado(Transporte cat, int id) {
        String sql = "update Transporte set Estado='" + cat.getEstado() + "'where Idtrans=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public boolean Eliminar(int id) {
        String sql = "delete from Transporte where Idtrans=" + id;
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
        String sql = "select * from Movimiento where Idtrans=" + id;
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
        String sql = "{call sp_generar_codigotransporte()}";
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
//    
//    public String Generarserie(){
//    String numeroserie="";
//        String sql = "select max(Codigo) from ventas";
//        try {
//            con = cn.getConnection();
//            call = con.prepareCall(sql);
//            rs = call.executeQuery();
//
//            if (rs.next()) {
//                numeroserie = rs.getString(1);
//            }
//        } catch (SQLException e) {
//        }
//        return numeroserie;
//    
//    }
    
    
    public static void main(String[] args) {
        TransporteDAO td = new TransporteDAO();
        List<Transporte> lista = td.ListadoTransporte();
        System.out.println("Lista " + lista.size());
        lista.forEach(c -> {
            System.out.println(c.toString());
        });
    }
}
