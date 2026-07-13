package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Subcategoria;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubcategoriaDAO {

    ConexionBD cn = new ConexionBD();
    Connection con;
    String mensaje = "";
    PreparedStatement ps;
    ResultSet rs;
    Subcategoria c = new Subcategoria();
    CallableStatement call = null;

    public List<Subcategoria> listarSubcategoria() {
        ArrayList<Subcategoria> list = new ArrayList<>();
        String sql = "SELECT s.*, c.Nombre AS NombreCategoria FROM Subcategoria s "
                + "LEFT JOIN Categoria c ON s.Idcategoria = c.Idcategoria ORDER BY s.Idsubc desc";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Subcategoria cat = new Subcategoria();
                cat.setIdsubc(rs.getInt("Idsubc"));
                cat.setCodigo(rs.getString("Codigo"));
                cat.setNombre(rs.getString("Nombre"));
                cat.setEstado(rs.getString("Estado"));
                cat.setIdcategoria(rs.getInt("Idcategoria"));
                cat.setNombreCategoria(rs.getString("NombreCategoria"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List ListadoEstadoActivos() {
        ArrayList<Subcategoria> list = new ArrayList<>();
        String sql = "select * from Subcategoria where Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Subcategoria cat = new Subcategoria();
                cat.setIdsubc(rs.getInt("Idsubc"));
                cat.setCodigo(rs.getString("Codigo"));
                cat.setNombre(rs.getString("Nombre"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }
    //Obtener el estdo de Subcategoria uso en ControllerSubcategoria and Subcategoria.js

    public static String getSubCategoriaEstado(int cod) {
        try {
            String sql = "select Estado from Subcategoria where Idsubc=" + cod;
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
    //Mostrar nombre de Publico en Producto.jsp

    public static String getNombreSubcaregoria(int cod) {
        try {
            String sql = "Select Nombre from Subcategoria u inner join Producto p where u.Idsubc=p.Idsubc And Idproducto=" + cod;
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
    
        //Optener Subcategoria por ID uso en EditarSubcategoria.jsp
    public Subcategoria SubcategoriaID(int id) {
        String sql = "select * from Subcategoria where Idsubc=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                c.setIdsubc(rs.getInt("Idsubc"));
                c.setCodigo(rs.getString("Codigo"));
                c.setNombre(rs.getString("Nombre"));
                c.setEstado(rs.getString("Estado"));
                c.setIdcategoria(rs.getInt("Idcategoria"));
            }
        } catch (Exception e) {
        }
        return c;
    }

    //Insertar Subcategoria uso en ControllerSubcategoria
    public boolean add(Subcategoria cat) {
        boolean flag = false;
        String sql = "insert into Subcategoria(Codigo,Nombre,Estado,Idcategoria) values(?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, cat.getCodigo());
            ps.setString(2, cat.getNombre());
            ps.setString(3, cat.getEstado());
            ps.setInt(4, cat.getIdcategoria());
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
        String sql = "select Nombre from Subcategoria where Nombre=?";
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

    //Editar Subcategoria uso en ControllerSubcategoria
    public boolean Edit(Subcategoria scat) {
        boolean flag = false;
        String sql = "update Subcategoria set Codigo=?, Nombre=?, Idcategoria=? where Idsubc=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, scat.getCodigo());
            ps.setString(2, scat.getNombre());
            ps.setInt(3, scat.getIdcategoria());
            ps.setInt(4, scat.getIdsubc());
            if (ps.executeUpdate() == 1) {
                flag = true;
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return flag;
    }

    //Editar estado Subcategoria uso en ControllerSubcategoria
    public boolean EditarEstado(Subcategoria scat, int id) {
        String sql = "update Subcategoria set Estado='" + scat.getEstado() + "'where Idsubc=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    //Eliminar Subcategoria uso en ControllerSubcategoria
    public boolean Eliminar(int id) {
        String sql = "delete from Subcategoria where Idsubc=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }
    //Codigo Subcategoria uso en Subcategoria.jsp
    public String Numserie() {
        String sql = "{call sp_generar_codigoSubcategoria()}";
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
       //Mostrar nombre de Clasificacion en Producto.jsp
    public static String getNombresubcategoria(int cod) {
        try {
            String sql = "select Nombre from Subcategoria u join Producto p where u.Idsubc=p.Idsubc And Idproducto=" + cod;
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

}

