package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Auxiliar;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/**
 *
 * @author fanay
 */
public class AuxiliarDAO {

    ConexionBD cn = new ConexionBD();
    Connection con;
    int mensaje = 0;
    PreparedStatement ps;
    ResultSet rs;
    CallableStatement call = null;
    String mensaj = "";
    Auxiliar prov = new Auxiliar();
    Auxiliar Cliente = new Auxiliar();


//Listar cliente uso en Cliente.jsp.jsp
    public List ListadoCliente() {
        ArrayList<Auxiliar> listaCliente = new ArrayList<>();
        String sql = "SELECT * FROM Auxiliar where Tipoauxi=\"C\"";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Auxiliar Clientes = new Auxiliar();
                Clientes.setIdauxiliar(rs.getInt("Idauxiliar"));
                Clientes.setTipoauxi(rs.getString("Tipoauxi"));
                Clientes.setCodigo(rs.getString("Codigo"));
                Clientes.setNombre(rs.getString("Nombre"));
                Clientes.setCorreo(rs.getString("Correo"));
                Clientes.setTelefono(rs.getString("Telefono"));
                Clientes.setCelular(rs.getString("Celular"));
                Clientes.setDireccion(rs.getString("Direccion"));
                Clientes.setContacto(rs.getString("Contacto"));
                Clientes.setFechaderegistro(rs.getString("Fechaderegistro"));
                Clientes.setIdtipodocumento(rs.getInt("Idtipodocumento"));
                Clientes.setNumerodocumento(rs.getString("Numerodocumento"));
                Clientes.setSexo(rs.getString("Sexo"));
                Clientes.setEstado(rs.getString("Estado"));
                listaCliente.add(Clientes);
            }
        } catch (Exception e) {
        }
        return listaCliente;
    }

    //Listar cliente uso en Insertarboletaventa.jsp con ruc
    public List ListadoClienteruc() {
        ArrayList<Auxiliar> listaCliente = new ArrayList<>();
        String sql = "SELECT * FROM Cliente where Idtipodocumento =\"4\"";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Auxiliar Clientes = new Auxiliar();
                Clientes.setIdauxiliar(rs.getInt("Idcliente"));
                Clientes.setCodigo(rs.getString("Codigo"));
                Clientes.setNombre(rs.getString("Cliente"));
                Clientes.setCorreo(rs.getString("Correo"));
                Clientes.setTelefono(rs.getString("Telefono"));
                Clientes.setCelular(rs.getString("Celular"));
                Clientes.setDireccion(rs.getString("Direccion"));
                Clientes.setContacto(rs.getString("Contacto"));
                Clientes.setFechaderegistro(rs.getString("Fechaderegistro"));
                Clientes.setIdtipodocumento(rs.getInt("Idtipodocumento"));
                Clientes.setNumerodocumento(rs.getString("Numerodocumento"));
                Clientes.setSexo(rs.getString("Sexo"));
                Clientes.setEstado(rs.getString("Estado"));
                listaCliente.add(Clientes);
            }
        } catch (Exception e) {
        }
        return listaCliente;
    }

    //Insertar Cliente uso ControllerCliente
    public boolean add(Auxiliar cli) {
        boolean flag = false;
        String sql = "insert into Auxiliar(Tipoauxi,Codigo, Nombre, Correo, Telefono, Celular, Direccion, Contacto, Fechaderegistro, Idtipodocumento, Numerodocumento, Sexo,Estado) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, cli.getTipoauxi());
            ps.setString(2, cli.getCodigo());
            ps.setString(3, cli.getNombre());
            ps.setString(4, cli.getCorreo());
            ps.setString(5, cli.getTelefono());
            ps.setString(6, cli.getCelular());
            ps.setString(7, cli.getDireccion());
            ps.setString(8, cli.getContacto());
            ps.setString(9, cli.getFechaderegistro());
            ps.setInt(10, cli.getIdtipodocumento());
            ps.setString(11, cli.getNumerodocumento());
            ps.setString(12, cli.getSexo());
            ps.setString(13, cli.getEstado());
            if (ps.executeUpdate() == 1) {
                flag = true;
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return flag;
    }

//Editar cliente uso en ControllerCliente
    public boolean Edit(Auxiliar Cliente) {
        boolean flag = false;
        String sql = "UPDATE Auxiliar set Tipoauxi='" + Cliente.getTipoauxi() + "',Codigo='" + Cliente.getCodigo() + "',Nombre='" + Cliente.getNombre() + "',Correo='" + Cliente.getCorreo() + "',Telefono='" + Cliente.getTelefono() + "',Celular='" + Cliente.getCelular() + "',Direccion='" + Cliente.getDireccion() + "',Contacto='" + Cliente.getContacto() + "',Fechaderegistro='" + Cliente.getFechaderegistro() + "',Idtipodocumento='" + Cliente.getIdtipodocumento() + "',Numerodocumento='" + Cliente.getNumerodocumento() + "',Sexo='" + Cliente.getSexo() + "' WHERE Idauxiliar=" + Cliente.getIdauxiliar();
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

    //Eliminar cliente uso en ControllerCliente
    public boolean Eliminar(int id) {
        String sql = "delete from Auxiliar where Idauxiliar=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    public static String getEstado(int cod) {

        try {
            String sql = "select Estado from Auxiliar where Idauxiliar=" + cod;
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

    //Mostrar estado segun el ID del cliente uso en ControllerCliente and Cliente.jsp
    public static String estado(int cod) {
        try {
            String sql = "select Estado from Auxiliar where Idauxiliar=" + cod;
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

    //Editar estado de cliente uso en ControllerCliente
    public boolean editEstado(Auxiliar cli, int id) {
        String sql = "update Auxiliar set Estado='" + cli.getEstado() + "' where Idauxiliar=" + id;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return false;
    }

    //Codigo para cliente us en InsertarCliente.jsp
    public String Numseriecliente() {
        String sql = "{call sp_generar_codigocliente()}";
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
    //Codigo para cliente us en InsertarCliente.jsp

    public String Numserieproveedor() {
        String sql = "{call sp_generar_codigoproveedor()}";
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

    public Auxiliar BuscarPorId(int idCliente) {
        String sql = "select * from Auxiliar where Idauxiliar ="+idCliente;
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                prov.setIdauxiliar(rs.getInt("Idauxiliar"));
                prov.setTipoauxi(rs.getString("Tipoauxi"));
                prov.setCodigo(rs.getString("Codigo"));
                prov.setNombre(rs.getString("Nombre"));
                prov.setCorreo(rs.getString("Correo"));
                prov.setTelefono(rs.getString("Telefono"));
                prov.setCelular(rs.getString("Celular"));
                prov.setDireccion(rs.getString("Direccion"));
                prov.setContacto(rs.getString("Contacto"));
                prov.setFechaderegistro(rs.getString("Fechaderegistro"));
                prov.setIdtipodocumento(rs.getInt("Idtipodocumento"));
                prov.setNumerodocumento(rs.getString("Numerodocumento"));
                prov.setSexo(rs.getString("Sexo"));
                prov.setEstado(rs.getString("Estado"));
            }

        } catch (Exception e) {

        }
        return prov;
    }

    public static String getNombre(int cod) {
        try {
            String sql = "Select Nombre from Auxiliar where Idauxiliar=" + cod;
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

    public static String getNombremostrarendetalle(int cod) {
        try {
            String sql = "select Nombre from Auxiliar u join Movimiento p where u.Idauxiliar=p.Idauxiliar And Idmovimiento=" + cod;
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

    public static String getCorreo(int cod) {

        try {
            String sql = "Select Correo from Auxiliar where Idauxiliar=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Correo");

            }
            return "--";

        } catch (Exception e) {
            return "--";
        }

    }

    public static String getnrodocumento(int cod) {
        try {
            String sql = "Select Numerodocumento from Auxiliar where Idauxiliar=" + cod;
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

    public static String gettelefono(int cod) {
        try {
            String sql = "Select Telefono from Auxiliar where Idauxiliar=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Telefono");
            }
            return "--";

        } catch (Exception e) {
            return "--";
        }
    }

    public static String getDireccion(int cod) {
        try {
            String sql = "Select Direccion from Auxiliar where Idauxiliar=" + cod;
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

    public boolean validacionprove(Auxiliar cli) {
        boolean flag = false;
        String sql = "select * from Auxiliar where tipoauxi='P' and Numerodocumento=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, cli.getNumerodocumento());
            rs = ps.executeQuery();
            while (rs.next()) {
                flag = true;
            }
        } catch (Exception e) {

        }
        return flag;
    }

    public boolean validacion(Auxiliar cli) {
        boolean flag = false;
        String sql = "select * from Auxiliar where tipoauxi='C' and Numerodocumento=" + cli.getNumerodocumento();
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

    public boolean Yatienemovimiento(int id) {
        boolean flag = false;
        String sql = "select * from Movimiento where Idauxiliar=" + id;
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

    public List ListadeProveedoresActivos() {
        ArrayList<Auxiliar> listaProveedor = new ArrayList<>();
        String sql = "SELECT * FROM Auxiliar where Tipoauxi='P' and Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Auxiliar Proveedor = new Auxiliar();
                Proveedor.setIdauxiliar(rs.getInt("Idauxiliar"));
                Proveedor.setTipoauxi(rs.getString("Tipoauxi"));
                Proveedor.setCodigo(rs.getString("Codigo"));
                Proveedor.setNombre(rs.getString("Nombre"));
                Proveedor.setCorreo(rs.getString("Correo"));
                Proveedor.setTelefono(rs.getString("Telefono"));
                Proveedor.setCelular(rs.getString("Celular"));
                Proveedor.setDireccion(rs.getString("Direccion"));
                Proveedor.setContacto(rs.getString("Contacto"));
                Proveedor.setFechaderegistro(rs.getString("Fechaderegistro"));
                Proveedor.setIdtipodocumento(rs.getInt("Idtipodocumento"));
                Proveedor.setNumerodocumento(rs.getString("Numerodocumento"));
                Proveedor.setSexo(rs.getString("Sexo"));
                Proveedor.setEstado(rs.getString("Estado"));
                listaProveedor.add(Proveedor);
            }
        } catch (Exception e) {
        }
        return listaProveedor;
    }

    public List ListadeClientesActivos() {
        ArrayList<Auxiliar> listaProveedor = new ArrayList<>();
        String sql = "SELECT * FROM Auxiliar where Tipoauxi='C' and Estado='Activo'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Auxiliar Proveedor = new Auxiliar();
                Proveedor.setIdauxiliar(rs.getInt("Idauxiliar"));
                Proveedor.setTipoauxi(rs.getString("Tipoauxi"));
                Proveedor.setCodigo(rs.getString("Codigo"));
                Proveedor.setNombre(rs.getString("Nombre"));
                Proveedor.setCorreo(rs.getString("Correo"));
                Proveedor.setTelefono(rs.getString("Telefono"));
                Proveedor.setCelular(rs.getString("Celular"));
                Proveedor.setDireccion(rs.getString("Direccion"));
                Proveedor.setContacto(rs.getString("Contacto"));
                Proveedor.setFechaderegistro(rs.getString("Fechaderegistro"));
                Proveedor.setIdtipodocumento(rs.getInt("Idtipodocumento"));
                Proveedor.setNumerodocumento(rs.getString("Numerodocumento"));
                Proveedor.setSexo(rs.getString("Sexo"));
                Proveedor.setEstado(rs.getString("Estado"));
                listaProveedor.add(Proveedor);
            }
        } catch (Exception e) {
        }
        return listaProveedor;
    }

//    Agregar Codigo a clientes en Insertarcliente.jsp
    public int BuscarNclientes() {
        String sSQL = "SELECT COUNT(*) as Nclientes FROM Auxiliar WHERE Tipoauxi ='C'";

        try {
            int Nclientes = 0;
            con = cn.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sSQL);
            while (rs.next()) {
                Nclientes = rs.getInt("Nclientes");
            }

            return Nclientes;

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
            return 0;
        }

    }

    //    Agregar Codigo a proveedor en Insertarcliente.jsp
    public int BuscarNproveedor() {
        String sSQL = "SELECT COUNT(*) as Nproveedor FROM Auxiliar WHERE Tipoauxi ='P'";

        try {
            int Nclientes = 0;
            con = cn.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sSQL);
            while (rs.next()) {
                Nclientes = rs.getInt("Nproveedor");
            }

            return Nclientes;

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
            return 0;
        }

    }

    //Listar cliente uso en Cliente.jsp.jsp
    public List ListadoProveedor() {
        ArrayList<Auxiliar> listap = new ArrayList<>();
        String sql = "SELECT * FROM Auxiliar where Tipoauxi='P'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Auxiliar P = new Auxiliar();
                P.setIdauxiliar(rs.getInt("Idauxiliar"));
                P.setTipoauxi(rs.getString("Tipoauxi"));
                P.setCodigo(rs.getString("Codigo"));
                P.setNombre(rs.getString("Nombre"));
                P.setCorreo(rs.getString("Correo"));
                P.setTelefono(rs.getString("Celular"));
                P.setCelular(rs.getString("Celular"));
                P.setDireccion(rs.getString("Direccion"));
                P.setContacto(rs.getString("Contacto"));
                P.setFechaderegistro(rs.getString("Fechaderegistro"));
                P.setIdtipodocumento(rs.getInt("Idtipodocumento"));
                P.setNumerodocumento(rs.getString("Numerodocumento"));
                P.setSexo(rs.getString("Sexo"));
                P.setEstado(rs.getString("Estado"));
                listap.add(P);
            }
        } catch (Exception e) {
        }
        return listap;
    }

    //Listar cliente uso en Cliente.jsp.jsp
    public List Listadoauxiliar() {
        ArrayList<Auxiliar> listap = new ArrayList<>();
        String sql = "SELECT * FROM Auxiliar";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Auxiliar P = new Auxiliar();
                P.setIdauxiliar(rs.getInt("Idauxiliar"));
                P.setTipoauxi(rs.getString("Tipoauxi"));
                P.setCodigo(rs.getString("Codigo"));
                P.setNombre(rs.getString("Nombre"));
                P.setCorreo(rs.getString("Correo"));
                P.setTelefono(rs.getString("Celular"));
                P.setCelular(rs.getString("Celular"));
                P.setDireccion(rs.getString("Direccion"));
                P.setContacto(rs.getString("Contacto"));
                P.setFechaderegistro(rs.getString("Fechaderegistro"));
                P.setIdtipodocumento(rs.getInt("Idtipodocumento"));
                P.setNumerodocumento(rs.getString("Numerodocumento"));
                P.setSexo(rs.getString("Sexo"));
                P.setEstado(rs.getString("Estado"));
                listap.add(P);
            }
        } catch (Exception e) {
        }
        return listap;
    }

//    public static void main(String[] args) {
//
//        ClienteDAO td = new ClienteDAO();
//        List<Cliente> lista = td.ListadoCliente();
//        System.out.println("Lista " + lista.size());
//
//        lista.forEach(c -> {
//            System.out.println(c.toString());
//
//        });
//              //  System.out.println(td.add(new Cliente(0,"0009","loca DDD", "HDG@gmail.com", 123223233, "av. lima 22","2020-11-27", 1,8733463,"M")));
//
//    }
}
