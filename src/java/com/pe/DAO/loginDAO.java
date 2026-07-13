package com.pe.DAO;
import com.pe.model.entity.loginBean;
import java.sql.*;
public class loginDAO {
    loginBean BD=new loginBean();
    String sql="";
    Connection cn;
    PreparedStatement ps;
    ResultSet rs;

    public loginDAO(){
        
    }
    public String Validar(String email, String cla){
        String tipo="";
        try {
            Class.forName(BD.getDri());
            cn=DriverManager.getConnection(BD.getUrl(), BD.getUsu(), BD.getCla());
            // Nota: la verificación de la contraseña (con hash) ya se hizo en UsuarioDAO.usu().
            // Aquí solo obtenemos el rol del usuario ya autenticado, por su correo corporativo.
            sql="SELECT rol FROM usuario WHERE email=?";
            ps=cn.prepareStatement(sql);
            ps.setString(1, email);
            rs=ps.executeQuery();
            while(rs.next()){
                tipo=rs.getString(1);
            }
            cn.close();
            rs.close();
            return tipo;
        } catch (SQLException | ClassNotFoundException e){
            return tipo;
        }
    }
    
     
}