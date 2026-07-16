package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Usuario;
import com.pe.util.PasswordUtil;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import javax.swing.JOptionPane;

public class UsuarioDAO {
//Atributos

    ConexionBD cn = new ConexionBD();//cn: Objeto de la clase ConexionBD que se utiliza para establecer la conexión con la base de datos.
    int mensaje = 0;//Variable entera que se utiliza para almacenar algún tipo de mensaje.
    PreparedStatement ps = null;//ps: Objeto de tipo PreparedStatement utilizado para ejecutar consultas 
    ResultSet rs = null;//rs: Objeto de tipo ResultSet utilizado para almacenar el resultado de consultas SQL.
    Connection con = null;//con: Objeto de tipo Connection utilizado para representar la conexión con la base de datos.
    String mensaj = "";//mensaj: Cadena de texto que almacena algún mensaje.
    Usuario U = new Usuario();//U: Objeto de la clase Usuario utilizado para manipular datos relacionados con usuarios.

    //Metodo que obtiene un listado de usuarios desde la base de datos
    public List ListadoUsuario() {
        // Se crea una nueva lista de usuarios utilizando la clase ArrayList
        ArrayList<Usuario> list = new ArrayList<>();
        // Consulta SQL para seleccionar todos los registros de la tabla "usuario"
        String sql = "select * from usuario";

        try {
            // Se establece la conexión a la base de datos
            con = cn.getConnection();
            // Se prepara la declaración SQL
            ps = con.prepareStatement(sql);
            // Se ejecuta la consulta y se obtiene un conjunto de resultados
            rs = ps.executeQuery();
            // Se recorre el conjunto de resultados
            while (rs.next()) {
                // Se crea un nuevo objeto de la clase Usuario
                Usuario usu = new Usuario();
                // Se establecen los atributos del objeto con los valores obtenidos de la base de datos
                usu.setId(rs.getInt("id"));
                usu.setNombre(rs.getString("nombre"));
                usu.setUsu(rs.getString("usu"));
                usu.setPassword(rs.getString("password"));
                usu.setRol(rs.getString("rol"));
                usu.setFilename1(rs.getString("filename1"));
                usu.setBloqueado(rs.getInt("Bloqueado") == 1);
                // Se añade el objeto Usuario a la lista
                list.add(usu);
            }
        } catch (Exception e) {

        }
        // Se retorna la lista de usuarios obtenida de la base de datos
        return list;

    }

    //Metodo que obtiene información de un usuario específico basado en su identificador (id) 
    public Usuario list(int id) {
        String sql = "select * from usuario where id=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                U.setId(rs.getInt("id"));
                U.setNombre(rs.getString("nombre"));
                U.setUsu(rs.getString("usu"));
                U.setPassword(rs.getString("password"));
                U.setRol(rs.getString("rol"));
                U.setFilename1(rs.getString("filename1"));
            }

        } catch (Exception e) {

        }
        return U;
    }

    //Metodo para agrega un nuevo usuario a la base de datos con información detallada
    // Guarda el último error de base de datos ocurrido en addimg(), para poder mostrarlo al usuario si algo falla.
    private String ultimoError = "";

    public String getUltimoError() {
        return ultimoError;
    }

    public boolean addimg(Usuario i) {
        boolean rpt = false;
        ultimoError = "";
        try {

            con = cn.getConnection();
            // IMPORTANTE: se listan las columnas explícitamente (en vez de "insert into usuario values(...)")
            // porque la tabla usuario tiene columnas adicionales (reset_token, reset_token_expira) que no
            // se llenan aquí; sin el listado explícito, el INSERT fallaba por "column count mismatch".
            String sql = "insert into usuario "
                    + "(id,Codigo,nombre,Idtipodocumento,dni,sueldo,telefono,direccion,email,fecharegistro,filename1,path1,usu,password,rol,estado) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNull(1, java.sql.Types.INTEGER); // id: se deja que MySQL lo autogenere (AUTO_INCREMENT)
            pst.setString(2, i.getCodigo());
            pst.setString(3, i.getNombre());
            pst.setInt(4, i.getIdTipodocumento());
            pst.setString(5, i.getNrodocumento());
            pst.setDouble(6, i.getSueldo());
            pst.setString(7, i.getTelefono());
            pst.setString(8, i.getDireccion());
            pst.setString(9, i.getEmail());
            pst.setString(10, i.getFechaderegistro());
            pst.setString(11, i.getFilename1());
            pst.setString(12, i.getPath1());
            pst.setString(13, i.getUsu());
            pst.setString(14, PasswordUtil.hashPassword(i.getPassword()));
            pst.setString(15, i.getRol());
            pst.setString(16, i.getEstado());

            if (pst.executeUpdate() == 1) {
                rpt = true;
            }

        } catch (Exception e) {
            ultimoError = e.getMessage();
            System.err.println("Error al guardar usuario: " + e.getMessage());
        }
        return rpt;
    }

    //Metodo parar actualiza información específica de un usuario,
    public boolean Editimgg(Usuario i) {
        boolean rpt = false;
        try {
            con = cn.getConnection();
            String sql = "UPDATE usuario SET nombre=?, usu=?, password=?, rol=?, filename1=?, path1=? WHERE id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, i.getNombre());
            pst.setString(2, i.getUsu());
            // Si ya viene en formato hash (porque no se cambió la contraseña), se guarda tal cual.
            // Si es texto plano (el admin escribió una contraseña nueva), se hashea antes de guardar.
            String passwordFinal = PasswordUtil.isHashed(i.getPassword())
                    ? i.getPassword()
                    : PasswordUtil.hashPassword(i.getPassword());
            pst.setString(3, passwordFinal);
            pst.setString(4, i.getRol());
            pst.setString(5, i.getFilename1());
            pst.setString(6, i.getPath1());
            pst.setInt(7, i.getId());

            if (pst.executeUpdate() == 1) {
                rpt = true;
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return rpt;
    }

    //Metodo para elimina un usuario de la base de datos según su identificador (id).
    public boolean Eliminar(int id) {
        boolean flag = false;
        ultimoError = "";
        String sql = "delete from usuario where id=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            if (ps.executeUpdate() == 1) {
                flag = true;
            }
        } catch (Exception e) {
            if (e.getMessage() != null && e.getMessage().toLowerCase().contains("foreign key")) {
                ultimoError = "No se puede eliminar: este usuario tiene movimientos registrados en el sistema (ventas, ingresos, etc.). Puedes desactivarlo en vez de eliminarlo.";
            } else {
                ultimoError = e.getMessage();
            }
            System.err.println(e.getMessage());
        }
        return flag;
    }

    //Metodo para autenticar a un usuario basado en su correo corporativo (email) y la contraseña (password).
    //Ya no concatena valores en el SQL (evita inyección SQL) y verifica la contraseña usando hash
    //(con migración progresiva de contraseñas antiguas en texto plano).
    // Devuelve: id del usuario si el login es correcto, 0 si las credenciales son incorrectas,
    // -2 si la cuenta está bloqueada por seguridad (demasiados intentos fallidos).
    public int usu(String email, String pass) {
        String sql = "SELECT id, password, IntentosFallidos, Bloqueado FROM usuario WHERE email = ?";

        try {
            con = cn.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String passwordGuardado = rs.getString("password");
                boolean estaBloqueado = rs.getInt("Bloqueado") == 1;

                if (estaBloqueado) {
                    return -2;
                }

                boolean claveCorrecta;
                if (PasswordUtil.isHashed(passwordGuardado)) {
                    claveCorrecta = PasswordUtil.verificarPassword(pass, passwordGuardado);
                } else {
                    // Contraseña todavía en texto plano (usuario antiguo, no migrado aún)
                    claveCorrecta = passwordGuardado != null && passwordGuardado.equals(pass);
                    if (claveCorrecta) {
                        migrarPasswordAHash(id, pass);
                    }
                }

                if (claveCorrecta) {
                    reiniciarIntentosFallidos(id);
                    return id;
                } else {
                    boolean quedoBloqueado = registrarIntentoFallido(id);
                    return quedoBloqueado ? -3 : 0;
                }
            }
            return 0;

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
            return 0;
        }

    }

    // Cuántos intentos fallidos seguidos bloquean la cuenta.
    private static final int MAX_INTENTOS_FALLIDOS = 5;

    // Suma un intento fallido; si llega al máximo, bloquea la cuenta automáticamente.
    // Devuelve true si este intento es el que causó el bloqueo.
    private boolean registrarIntentoFallido(int id) {
        try {
            con = cn.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT IntentosFallidos FROM usuario WHERE id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            int intentosActuales = rs.next() ? rs.getInt("IntentosFallidos") : 0;
            int nuevosIntentos = intentosActuales + 1;
            boolean seBloquea = nuevosIntentos >= MAX_INTENTOS_FALLIDOS;

            PreparedStatement pst2 = con.prepareStatement(
                    "UPDATE usuario SET IntentosFallidos = ?, Bloqueado = ? WHERE id = ?");
            pst2.setInt(1, nuevosIntentos);
            pst2.setInt(2, seBloquea ? 1 : 0);
            pst2.setInt(3, id);
            pst2.executeUpdate();
            return seBloquea;
        } catch (Exception e) {
            System.err.println("No se pudo registrar el intento fallido: " + e.getMessage());
            return false;
        }
    }

    // Reinicia el contador tras un login correcto.
    private void reiniciarIntentosFallidos(int id) {
        try {
            con = cn.getConnection();
            PreparedStatement pst = con.prepareStatement("UPDATE usuario SET IntentosFallidos = 0 WHERE id = ?");
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (Exception e) {
            System.err.println("No se pudo reiniciar los intentos fallidos: " + e.getMessage());
        }
    }

    // Usado por el Administrador para desbloquear manualmente una cuenta.
    public boolean desbloquearUsuario(int id) {
        try {
            con = cn.getConnection();
            PreparedStatement pst = con.prepareStatement("UPDATE usuario SET Bloqueado = 0, IntentosFallidos = 0 WHERE id = ?");
            pst.setInt(1, id);
            return pst.executeUpdate() == 1;
        } catch (Exception e) {
            System.err.println("No se pudo desbloquear el usuario: " + e.getMessage());
            return false;
        }
    }

    // Verifica si un usuario está bloqueado (usado para mostrar el estado en la interfaz).
    public boolean estaBloqueado(int id) {
        try {
            con = cn.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT Bloqueado FROM usuario WHERE id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("Bloqueado") == 1;
            }
        } catch (Exception e) {
            System.err.println("No se pudo verificar el bloqueo: " + e.getMessage());
        }
        return false;
    }

    //Migra silenciosamente una contraseña en texto plano a hash PBKDF2 la primera vez que el usuario inicia sesión correctamente.
    private void migrarPasswordAHash(int id, String passwordPlano) {
        try {
            String hash = PasswordUtil.hashPassword(passwordPlano);
            con = cn.getConnection();
            PreparedStatement pst = con.prepareStatement("UPDATE usuario SET password = ? WHERE id = ?");
            pst.setString(1, hash);
            pst.setInt(2, id);
            pst.executeUpdate();
        } catch (Exception e) {
            System.err.println("No se pudo migrar password a hash: " + e.getMessage());
        }
    }

    //Restablece la contraseña de un usuario (usado por el Administrador desde "Administrar Usuarios").
    public boolean actualizarPasswordPorAdmin(int id, String passwordPlanoNueva) {
        try {
            String hash = PasswordUtil.hashPassword(passwordPlanoNueva);
            con = cn.getConnection();
            // Se marca debe_cambiar_password = 1: la clave es temporal y el
            // usuario deberá cambiarla obligatoriamente en su próximo ingreso.
            PreparedStatement pst = con.prepareStatement(
                    "UPDATE usuario SET password = ?, debe_cambiar_password = 1 WHERE id = ?");
            pst.setString(1, hash);
            pst.setInt(2, id);
            return pst.executeUpdate() == 1;
        } catch (Exception e) {
            System.err.println("No se pudo restablecer la contraseña: " + e.getMessage());
            return false;
        }
    }

    // NUEVO: indica si el usuario está obligado a cambiar su contraseña
    // (porque el administrador se la restableció con una clave temporal).
    public boolean debeCambiarPassword(int id) {
        String sql = "SELECT debe_cambiar_password FROM usuario WHERE id = ?";
        try {
            con = cn.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet r = pst.executeQuery();
            if (r.next()) {
                return r.getInt("debe_cambiar_password") == 1;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error verificando cambio obligatorio: " + e.getMessage());
            return false;
        }
    }

    // NUEVO: el propio usuario define su nueva contraseña y se apaga la
    // marca de cambio obligatorio, permitiéndole ya ingresar al sistema.
    public boolean cambiarPasswordObligatorio(int id, String nuevaPasswordPlano) {
        try {
            String hash = PasswordUtil.hashPassword(nuevaPasswordPlano);
            con = cn.getConnection();
            PreparedStatement pst = con.prepareStatement(
                    "UPDATE usuario SET password = ?, debe_cambiar_password = 0 WHERE id = ?");
            pst.setString(1, hash);
            pst.setInt(2, id);
            return pst.executeUpdate() == 1;
        } catch (Exception e) {
            System.err.println("No se pudo cambiar la contraseña obligatoria: " + e.getMessage());
            return false;
        }
    }

    //Genera una contraseña aleatoria que cumple la política de seguridad (mayúscula, minúscula, número, símbolo).
    public static String generarPasswordAleatoria() {
        String mayus = "ABCDEFGHJKLMNPQRSTUVWXYZ";
        String minus = "abcdefghijkmnpqrstuvwxyz";
        String nums = "23456789";
        String simb = "!@#$%*";
        java.security.SecureRandom rnd = new java.security.SecureRandom();
        StringBuilder sb = new StringBuilder();
        sb.append(mayus.charAt(rnd.nextInt(mayus.length())));
        sb.append(minus.charAt(rnd.nextInt(minus.length())));
        sb.append(nums.charAt(rnd.nextInt(nums.length())));
        sb.append(simb.charAt(rnd.nextInt(simb.length())));
        String todos = mayus + minus + nums + simb;
        for (int i = 0; i < 6; i++) {
            sb.append(todos.charAt(rnd.nextInt(todos.length())));
        }
        // barajar el resultado para que los caracteres fijos no queden siempre al inicio
        char[] arr = sb.toString().toCharArray();
        for (int i = arr.length - 1; i > 0; i--) {
            int j = rnd.nextInt(i + 1);
            char tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
        }
        return new String(arr);
    }

    //Metodo para busca un usuario por su identificador (idUsuario)
    public Usuario BuscarPorId(int idUsuario) {
        Usuario u = null;
        String sql = "select * from usuario where idempleado = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                u = new Usuario();
                u.setNombre(rs.getString("nombre"));
                u.setUsu(rs.getString("usu"));
                u.setPassword(rs.getString("password"));
                u.setRol(rs.getString("rol"));
            }
        } catch (SQLException e) {
            mensaj = e.getMessage();
        } finally {
            cn.desconectar();
        }
        return u;
    }

    //Verifica la existencia de un usuario en la base de datos basado en su nombre de usuario (usu).
    public boolean validacion(String cl) {
        boolean flag = false;
        String sql = "select usu from Usuario where usu=?";
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

    public boolean vali(Usuario cli) {
        boolean flag = false;
        String sql = "select * from Usuario where idempleado=" + cli.getNombre();
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

    //NUEVO: valida correctamente si el correo ya existe en la base de datos (para evitar duplicados)
    public boolean existeEmail(String email) {
        boolean flag = false;
        String sql = "select id from usuario where email = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                flag = true;
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return flag;
    }

    //NUEVO: busca un usuario por correo (usado en "olvidé mi contraseña")
    public Usuario buscarPorEmail(String email) {
        Usuario u = null;
        String sql = "select * from usuario where email = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setUsu(rs.getString("usu"));
                u.setEmail(rs.getString("email"));
                u.setRol(rs.getString("rol"));
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return u;
    }

    //NUEVO: genera un token aleatorio seguro y lo guarda en el usuario, con expiración de 30 minutos
    public String generarYGuardarTokenRecuperacion(int idUsuario) {
        String token = generarTokenAleatorio();
        String sql = "update usuario set reset_token = ?, reset_token_expira = ? where id = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, token);
            // Expira en 30 minutos
            Timestamp expira = new Timestamp(System.currentTimeMillis() + 30 * 60 * 1000);
            ps.setTimestamp(2, expira);
            ps.setInt(3, idUsuario);
            ps.executeUpdate();
            return token;
        } catch (Exception e) {
            System.err.println(e.getMessage());
            return null;
        }
    }

    //NUEVO: valida que el token exista, corresponda al usuario y no haya expirado. Retorna el id del usuario o 0 si no es válido.
    public int validarToken(String token) {
        String sql = "select id from usuario where reset_token = ? and reset_token_expira > NOW()";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, token);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
            return 0;
        } catch (Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }

    //NUEVO: guarda la nueva contraseña (hasheada) y limpia el token para que no se pueda reutilizar
    public boolean actualizarPasswordPorToken(String token, String nuevaPasswordPlano) {
        int idUsuario = validarToken(token);
        if (idUsuario == 0) {
            return false;
        }
        String sql = "update usuario set password = ?, reset_token = NULL, reset_token_expira = NULL where id = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, PasswordUtil.hashPassword(nuevaPasswordPlano));
            ps.setInt(2, idUsuario);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    private String generarTokenAleatorio() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[32];
        random.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }
//Metdodo para Obtiene la cantidad total de usuarios registrados en la base de datos.
    public int BuscarNusuarios() {
        String sSQL = "SELECT COUNT(*) as Nusuarios FROM usuario";

        try {
            int Nusuarios = 0;
            con = cn.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sSQL);
            while (rs.next()) {
                Nusuarios = rs.getInt("Nusuarios");
            }
            return Nusuarios;
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
            return 0;
        }

    }
    //Metodo Obtiene el nombre de usuario basado en su identificador (id).

    public static String getNombre(int cod) {
        try {
            String sql = "Select Usu from Usuario where id=" + cod;
            Connection connection = ConexionBD.Conectar();
            PreparedStatement prepare = connection.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("Usu");
            }
            return "--";
        } catch (Exception e) {
            return "--";
        }
    }

    //Metodo para Obtiene información específica de un usuario basado en su código
    //NUEVO: obtiene los datos (nombre, foto, etc.) de un usuario a partir de su correo.
    //Se usa en el menú lateral, ya que ahora la sesión guarda el correo (login por email), no el "usu".
    public static Usuario listimgPorEmail(String email) {
        Usuario u = new Usuario();
        String sql = "select * from usuario where email = ?";
        try {
            ConexionBD conexion = new ConexionBD();
            Connection con = conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setUsu(rs.getString("usu"));
                u.setEmail(rs.getString("email"));
                u.setRol(rs.getString("rol"));
                u.setFilename1(rs.getString("filename1"));
            }
        } catch (Exception e) {
            System.err.println("No se pudo obtener el usuario por correo: " + e.getMessage());
        }
        return u;
    }

    public static Usuario listimg(String codigo) {
        Usuario U = new Usuario();
        Connection cn;
        ConexionBD con = new ConexionBD();
        cn = con.Conectar();

        try {
            CallableStatement cs = cn.prepareCall("CALL MOSTRAR_USUARIO_POR_CODIGO (?)");
            cs.setString(1, codigo);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                U.setId(rs.getInt("id"));
                U.setNombre(rs.getString("nombre"));
                U.setUsu(rs.getString("usu"));
                U.setPassword(rs.getString("password"));
                U.setRol(rs.getString("rol"));
                U.setFilename1(rs.getString("filename1"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return U;
    }

//    -----------------------------------------------------------------------------
    //
//    @Override
//    public boolean add(Usuario usu) {
//        boolean flag = false;
//        String sql = "INSERT INTO usuario(Codigo,idempleado,usu,password,rol)"
//                + "VALUES('" + usu.getCodigo() + "','" + usu.getNombre() + "','" + usu.getUsu() + "','" + usu.getPassword() + "','" + usu.getRol() + "')";
//
//        try {
//            con = cn.getConnection();
//            ps = con.prepareStatement(sql);
//            if (ps.executeUpdate() == 1) {
//                flag = true;
//            }
//        } catch (Exception e) {
//            System.err.println(e.getMessage());
//        }
//        return flag;
//    }
//    @Override
//    public boolean Edit(Usuario usu) {
//        boolean flag = false;
//        String sql = "update usuario set idempleado='" + usu.getNombre() + "',usu='" + usu.getUsu() + "',password='" + usu.getPassword() + "',rol='" + usu.getRol() + "',filename1='" + usu.getFilename1() + "',path1='" + usu.getPath1() + "' where id=" + usu.getId();
//        try {
//            con = cn.getConnection();
//            ps = con.prepareStatement(sql);
//            if (ps.executeUpdate() == 1) {
//                flag = true;
//            }
//        } catch (Exception e) {
//            System.err.println(e.getMessage());
//        }
//        return flag;
//    }
    public static void main(String[] args) {
        UsuarioDAO mp = new UsuarioDAO();

    }

}
