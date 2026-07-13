package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Producto;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO{

    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Producto p = new Producto();
    CallableStatement call = null;
    String mensaje = "";

    public Producto BuscarPorId(int idProducto) {
        Producto pro = null;
        String sql = "select * from Producto where Idproducto = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idProducto);
            rs = ps.executeQuery();
            if (rs.next()) {
                pro = new Producto();
                pro.setIdproducto(rs.getInt("Idproducto"));
                pro.setCodigo(rs.getString("Codigo"));
                pro.setDescripcion(rs.getString("Descripcion"));
                pro.setIdclasi(rs.getInt("Idclasi"));
                pro.setIdcategoria(rs.getInt("Idcategoria"));
                pro.setIdsubc(rs.getInt("Idsubc"));
                pro.setIdauxiliar(rs.getInt("Idauxiliar"));
                pro.setIduventa(rs.getInt("Iduventa"));
                pro.setMoneda(rs.getString("Moneda"));
                pro.setCodigoanexo(rs.getString("Codigoanexo"));
                pro.setPreciocompra(rs.getDouble("Preciocompra"));
                pro.setPrecioVenta(rs.getDouble("Precioventa"));
                pro.setFechaRegistro(rs.getString("Fecharegistro"));
                pro.setObser(rs.getString("Obser"));
                pro.setEstado(rs.getString("Estado"));

            }

        } catch (SQLException e) {
            mensaje = e.getMessage();
        } finally {
            cn.desconectar();
        }
        return pro;
    }

    public static String getProducto(int cod) {

        try {
            String sql = "select Descripcion from Producto where Idproducto=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Descripcion");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public static String getCodProd(int cod) {

        try {
            String sql = "select Codigo from Producto where Idproducto=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Codigo");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public List ListadoStockmaximoyActivo() {
        ArrayList<Producto> list = new ArrayList<>();
        String sql = "select * from Producto where Stock>=Stockmaximo and Stockmaximo>0";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto pro = new Producto();
                pro.setIdproducto(rs.getInt("Idproducto"));
                pro.setCodigo(rs.getString("Codigo"));
                pro.setDescripcion(rs.getString("Descripcion"));
                pro.setIdclasi(rs.getInt("Idclasi"));
                pro.setIdcategoria(rs.getInt("Idcategoria"));
                pro.setIdsubc(rs.getInt("Idsubc"));
                pro.setIdauxiliar(rs.getInt("Idauxiliar"));
                pro.setIduventa(rs.getInt("Iduventa"));
                pro.setMoneda(rs.getString("Moneda"));
                pro.setCodigoanexo(rs.getString("Codigoanexo"));
                pro.setPreciocompra(rs.getDouble("Preciocompra"));
                pro.setPrecioVenta(rs.getDouble("Precioventa"));
                pro.setFechaRegistro(rs.getString("Fecharegistro"));
                pro.setObser(rs.getString("Obser"));
                pro.setStock(rs.getDouble("Stock"));
                pro.setStockminimo(rs.getDouble("Stockminimo"));
                pro.setStockmaximo(rs.getDouble("Stockmaximo"));
                pro.setEstado(rs.getString("Estado"));

                list.add(pro);
            }
        } catch (Exception e) {

        }
        return list;
    }
//Listado de producto en JSP Producto

    public List ListadoProducto() {
        ArrayList<Producto> list = new ArrayList<>();
        String sql = "select * from Producto";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto pro = new Producto();
                pro.setIdproducto(rs.getInt("Idproducto"));
                pro.setCodigo(rs.getString("Codigo"));
                pro.setDescripcion(rs.getString("Descripcion"));
                pro.setIdclasi(rs.getInt("Idclasi"));
                pro.setIdcategoria(rs.getInt("Idcategoria"));
                pro.setIdsubc(rs.getInt("Idsubc"));
                pro.setIdauxiliar(rs.getInt("Idauxiliar"));
                pro.setIduventa(rs.getInt("Iduventa"));
                pro.setMoneda(rs.getString("Moneda"));
                pro.setCodigoanexo(rs.getString("Codigoanexo"));
                pro.setPreciocompra(rs.getDouble("Preciocompra"));
                pro.setPrecioVenta(rs.getDouble("Precioventa"));
                pro.setFechaRegistro(rs.getString("Fecharegistro"));
                pro.setObser(rs.getString("Obser"));
                pro.setStock(rs.getDouble("Stock"));
                pro.setStockminimo(rs.getDouble("Stockminimo"));
                pro.setStockmaximo(rs.getDouble("Stockmaximo"));
                pro.setEstado(rs.getString("Estado"));

                list.add(pro);
            }

        } catch (Exception e) {

        }
        return list;
    }

    public List ListadoEstadoActivoPT() {
        ArrayList<Producto> list = new ArrayList<>();
        String sql = "select * from Producto where Estado='Activo' and Idclasi='1'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdproducto(rs.getInt("Idproducto"));
                prod.setCodigo(rs.getString("Codigo"));
                prod.setDescripcion(rs.getString("Descripcion"));
                prod.setPrecioVenta(rs.getDouble("PrecioVenta"));
                prod.setStock(rs.getDouble("Stock"));
                prod.setEstado(rs.getString("Estado"));

                list.add(prod);
            }

        } catch (Exception e) {

        }
        return list;
    }
    
    
    public List ListadoEstadoActivo() {
        ArrayList<Producto> list = new ArrayList<>();
        String sql = "select * from Producto where Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdproducto(rs.getInt("Idproducto"));
                prod.setCodigo(rs.getString("Codigo"));
                prod.setDescripcion(rs.getString("Descripcion"));
                prod.setPrecioVenta(rs.getDouble("PrecioVenta"));
                prod.setStock(rs.getDouble("Stock"));
                prod.setEstado(rs.getString("Estado"));

                list.add(prod);
            }

        } catch (Exception e) {

        }
        return list;
    }

    public Producto list(int id) {

        String sql = "select * from Producto where Idproducto=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

                p.setIdproducto(rs.getInt("Idproducto"));
                p.setCodigo(rs.getString("Codigo"));
                p.setDescripcion(rs.getString("Descripcion"));
                p.setIdclasi(rs.getInt("Idclasi"));
                p.setIdcategoria(rs.getInt("Idcategoria"));
                p.setIdsubc(rs.getInt("Idsubc"));
                p.setIdauxiliar(rs.getInt("Idauxiliar"));
                p.setIduventa(rs.getInt("Iduventa"));
                p.setMoneda(rs.getString("Moneda"));
                p.setCodigoanexo(rs.getString("Codigoanexo"));
                p.setPreciocompra(rs.getDouble("Preciocompra"));
                p.setPrecioVenta(rs.getDouble("Precioventa"));
                p.setFechaRegistro(rs.getString("Fecharegistro"));
                p.setObser(rs.getString("Obser"));
                p.setStock(rs.getDouble("Stock"));

            }

        } catch (Exception e) {

        }
        return p;
    }

    public boolean add(Producto prod) {
        boolean flag = false;
        String sql = "insert into producto(Codigo,Descripcion,Idclasi,Idcategoria,Idsubc,Idauxiliar,Iduventa,Moneda,Codigoanexo,Preciocompra,Precioventa,Fecharegistro,Obser,Stock,Stockminimo,Stockmaximo,Estado)"
                + "values('" + prod.getCodigo() + "','" + prod.getDescripcion() + "','" + prod.getIdclasi() + "','" + prod.getIdcategoria() + "','" + prod.getIdsubc() + "','" + prod.getIdauxiliar() + "','" + prod.getIduventa() + "','" + prod.getMoneda() + "','" + prod.getCodigoanexo() + "','" + prod.getPreciocompra() + "','" + prod.getPrecioVenta() + "','" + prod.getFechaRegistro() + "','" + prod.getObser() + "','" + prod.getStock() + "','" + prod.getStockminimo() + "','" + prod.getStockmaximo() + "','" + prod.getEstado() + "')";

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
        String sql = "select Codigoanexo from Producto where Codigoanexo=?";
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

    public boolean Edit(Producto p) {
        boolean flag = false;
        String sql = "UPDATE Producto set Codigo='" + p.getCodigo() + "',Descripcion='" + p.getDescripcion() + "',Idclasi='" + p.getIdclasi() + "',Idcategoria='" + p.getIdcategoria() + "',Idsubc='" + p.getIdsubc() + "',Idauxiliar='" + p.getIdauxiliar() + "',Iduventa='" + p.getIduventa() + "',Moneda='" + p.getMoneda() + "',Codigoanexo='" + p.getCodigoanexo() + "',Preciocompra='" + p.getPreciocompra() + "',Precioventa='" + p.getPrecioVenta() + "',Fecharegistro='" + p.getFechaRegistro() + "',Obser='" + p.getObser() + "'WHERE Idproducto=" + p.getIdproducto();
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

    public boolean Editstockminmax(Producto p) {
        boolean flag = false;
        String sql = "UPDATE Producto set Codigo='" + p.getCodigo() + "',Descripcion='" + p.getDescripcion() + "',Stockminimo='" + p.getStockminimo() + "',Stockmaximo='" + p.getStockmaximo() + "'WHERE Idproducto=" + p.getIdproducto();
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

    public boolean editEstado(Producto prod, int id) {
        String sql = "update Producto set Estado='" + prod.getEstado() + "' where Idproducto=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public static String estado(int cod) {

        try {
            String sql = "select Estado from Producto where Idproducto=" + cod;
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

    public static String estadoalmacenp(int cod) {

        try {
            String sql = "select Estado from Almacenxproducto where Idproducto=" + cod;
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

    public boolean Eliminar(int id) {
        String sql = "delete from Producto where Idproducto=" + id;
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
        String sql = "select * from DetalleMovimiento where Idproducto=" + id;
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

    public static Producto obtenerProducto(int Id) {
        Producto pro = null;
        try {
            CallableStatement cl = ConexionBD.Conectar().prepareCall("{CALL sp_listaporid(?)}");
            cl.setInt(1, Id);
            ResultSet rs = cl.executeQuery();
            while (rs.next()) {
                pro = new Producto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getDouble(11), rs.getDouble(12), rs.getString(13), rs.getString(14), rs.getDouble(15), rs.getDouble(16), rs.getDouble(17), rs.getString(18));
            }
        } catch (Exception e) {
        }
        return pro;
    }

    public static ArrayList<Producto> obtenerProductop(int num) {
        ArrayList<Producto> lista = new ArrayList<Producto>();
        try {
            CallableStatement cl = ConexionBD.ConectarDB().prepareCall("{CALL sp_Consultarproductoporproveedor(?)}");
            cl.setInt(1, num);
            ResultSet rs = cl.executeQuery();
            while (rs.next()) {
                Producto p = new Producto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getDouble(11), rs.getDouble(12), rs.getString(13), rs.getString(14), rs.getDouble(15), rs.getDouble(16), rs.getDouble(17), rs.getString(18));
                lista.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return lista;
    }

    public String Numserie() {
        String sql = "{call sp_generar_codigoproducto()}";

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

    //Mostrar nombre de categoria en Producto.jsp
    public static String getNombreprovedor(int cod) {
        try {
            String sql = "select Razonsocial from Proveedor where Idproveedor=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Razonsocial");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public static double getProductoprecio(double cod) {
        double mensaje = 0.00;
        try {
            String sql = "select Precioventa from Producto where Idproducto=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getDouble("Precioventa");
            }
            return mensaje;
        } catch (Exception e) {
            return mensaje;
        }
    }

    public static double getProductocosto(double cod) {
        double mensaje = 0.00;
        try {
            String sql = "select Preciocompra from Producto where Idproducto=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getDouble("Preciocompra");
            }
            return mensaje;
        } catch (Exception e) {
            return mensaje;
        }
    }

    public static int getValidarstock(int cod) {
        int mensaje = 0;
        try {
            String sql = "Select Stock from Producto where Idproducto=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("Stock");

            }
            return mensaje;

        } catch (Exception e) {
            return mensaje;
        }
    }

    public List ListadoStockminimo() {
        ArrayList<Producto> list = new ArrayList<>();
        String sql = "SELECT * From Producto where Stock<=stockminimo and stockminimo>0";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto pro = new Producto();
                pro.setIdproducto(rs.getInt("Idproducto"));
                pro.setCodigo(rs.getString("Codigo"));
                pro.setDescripcion(rs.getString("Descripcion"));
                pro.setIdclasi(rs.getInt("Idclasi"));
                pro.setIdcategoria(rs.getInt("Idcategoria"));
                pro.setIdsubc(rs.getInt("Idsubc"));
                pro.setIdauxiliar(rs.getInt("Idauxiliar"));
                pro.setIduventa(rs.getInt("Iduventa"));
                pro.setMoneda(rs.getString("Moneda"));
                pro.setCodigoanexo(rs.getString("Codigoanexo"));
                pro.setPreciocompra(rs.getDouble("Preciocompra"));
                pro.setPrecioVenta(rs.getDouble("Precioventa"));
                pro.setFechaRegistro(rs.getString("Fecharegistro"));
                pro.setObser(rs.getString("Obser"));
                pro.setStock(rs.getDouble("Stock"));
                pro.setStockminimo(rs.getDouble("Stockminimo"));
                pro.setStockmaximo(rs.getDouble("Stockmaximo"));
                pro.setEstado(rs.getString("Estado"));

                list.add(pro);
            }

        } catch (Exception e) {

        }
        return list;
    }

    public static void main(String[] args) {
        ProductoDAO mp = new ProductoDAO();
        System.out.println(mp.add(new Producto(0, "22222", "ffff", 1, 1, 1, 1, 1, "22222", "22222", 1, 1, "2015-11-05", "activo", 1, 1, 1, "activo")));

    }
}
