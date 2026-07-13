package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Categoria;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO{

    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Categoria c = new Categoria();
    CallableStatement call = null;
    int men = 0;
    String mensaje = "";

    //Listar todo el registro de categoria uso en Categoria.jsp
    public List ListadoCategoria() {
        ArrayList<Categoria> list = new ArrayList<>();
        String sql = "SELECT * FROM Categoria ORDER BY Idcategoria desc";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Categoria cat = new Categoria();
                cat.setIdcategoria(rs.getInt("Idcategoria"));
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
        ArrayList<Categoria> list = new ArrayList<>();
        String sql = "select * from Categoria where Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Categoria cat = new Categoria();
                cat.setIdcategoria(rs.getInt("Idcategoria"));
                cat.setCodigo(rs.getString("Codigo"));
                cat.setNombre(rs.getString("Nombre"));
                list.add(cat);
            }
        } catch (Exception e) {
        }
        return list;
    }

    //Obtener el estdo de Categoria uso en ControllerCategoria and Categoria.js
    public static String getCategoriaEstado(int cod) {
        try {
            String sql = "select Estado from Categoria where Idcategoria=" + cod;
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

    //Mostrar nombre de categoria en Producto.jsp
    public static String getNombreCategoria(int cod) {
        try {
            String sql = "select Nombre from Categoria u join Producto p where u.Idcategoria=p.Idcategoria And Idproducto=" + cod;
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

    //Optener categoria por ID uso en Editarcategoria.jsp
    public Categoria CategoriaID(int id) {
        String sql = "select * from Categoria where Idcategoria=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                c.setIdcategoria(rs.getInt("Idcategoria"));
                c.setCodigo(rs.getString("Codigo"));
                c.setNombre(rs.getString("Nombre"));
            }
        } catch (Exception e) {
        }
        return c;
    }

    //Insertar Categoria uso en ControllerCategoria
    public boolean add(Categoria cat) {
        boolean flag = false;
        String sql = "insert into Categoria(Codigo,Nombre,Estado)values('" + cat.getCodigo() + "','" + cat.getNombre() + "','" + cat.getEstado() + "')";
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
        String sql = "select Nombre from Categoria where Nombre=?";
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

    //Editar Categoria uso en ControllerCategoria
    public boolean Edit(Categoria cat) {
        boolean flag = false;
        String sql = "update Categoria set Codigo='" + cat.getCodigo() + "', Nombre='" + cat.getNombre() + "'where Idcategoria=" + cat.getIdcategoria();

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

    //Editar estado categoria uso en ControllerCategoria
    public boolean EditarEstado(Categoria cat, int id) {
        String sql = "update Categoria set Estado='" + cat.getEstado() + "'where Idcategoria=" + id;

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    //Eliminar Categoria uso en ControllerCategoria
    public boolean Eliminar(int id) {
        String sql = "delete from Categoria where Idcategoria=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    //Codigo Categoria uso en Categoria.jsp
    public String Numserie() {
        String sql = "{call sp_generar_codigoCategoria()}";
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
        String sql = "select * from Producto where Idcategoria=" + id;
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

}
