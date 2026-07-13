/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.pe.controller;

import com.pe.DAO.UsuarioDAO;
import com.pe.DAO.LogAccesoDAO;
import com.pe.model.entity.Usuario;
import com.pe.util.ValidacionUtil;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

//Esta anotación @MultipartConfig se utiliza para especificar la configuración relacionada con el manejo de solicitudes multipartes. 
//Este tipo de solicitudes se utiliza comúnmente cuando se espera la carga de archivos a través de formularios HTML.
@MultipartConfig(
//Este parámetro establece el umbral de tamaño para el manejo de archivos en memoria antes de almacenarlos en disco.
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
//Este parámetro establece el tamaño máximo permitido para un archivo individual.
        maxFileSize = 1024 * 1024 * 10, // 10MB
//Este parámetro establece el tamaño máximo total permitido para la solicitud multipartes.
        maxRequestSize = 1024 * 1024 * 50)

public class UsuarioController extends HttpServlet {

    int id; //Un atributo entero
    // Instancia de la clase UsuarioDAO que se utilizará para interactuar con la base de datos en relación con la entidad Usuario.
    UsuarioDAO usuarioDao = new UsuarioDAO();
    //Instancia de la clase Usuario
    Usuario usuario = new Usuario();
    UsuarioDAO usuDAO;
    DecimalFormat dfusu;

    //Una constante que especifica el directorio donde se guardarán las imágenes.
    public static final String UPLOAD_DIR = "images";
    //Una variable de cadena que se utiliza para almacenar el nombre del archivo de la primera imagen asociada a un usuario.
    public String dbFileName1 = "";

    public UsuarioController() {
        usuDAO = new UsuarioDAO();
        //Un objeto DecimalFormat llamado dfusu, que se utiliza para formatear números como cadenas con un patrón específico "000000";
        dfusu = new DecimalFormat("000000");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion.equals("add")) {
            this.add(request, response);
        }
        if (accion.equals("Actualizar")) {
            this.Edit(request, response);
        }
        if (accion.equals("editar")) {
            this.Editar(request, response);
        }
        if (accion.equals("detalle")) {
            this.Detalle(request, response);
        }
        if (accion.equals("eliminar")) {
            this.eliminar(request, response);
        }
        if (accion.equals("resetPassword")) {
            this.resetPassword(request, response);
        }
        if (accion.equals("desbloquear")) {
            this.desbloquear(request, response);
        }
    }
//Este método es responsable de procesar la solicitud de agregar un nuevo usuario.

    private void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Se instancia un nuevo objeto Usuario llamado usu.
        Usuario usu = new Usuario();
        //Se obtienen los parámetros de la solicitud que contienen la información del nuevo usuario, como nombre, sueldo, etc.
        String nombre = request.getParameter("txtNombre");
        String tipoDocParam = request.getParameter("Txtidtipodocumento");
        String numDoc = request.getParameter("Txtdni");
        String telefono = request.getParameter("Txttelefono");
        String email = request.getParameter("Txtemail");
        String fechaderegistro = request.getParameter("Txtfechaderegistro");
        String Usua = request.getParameter("txtusu");
        String pass = request.getParameter("txtpassword");
        String rol = request.getParameter("txtrol");

        // Validación 1: formato y dominio corporativo del correo (@alicorp.pe)
        if (!ValidacionUtil.esCorreoCorporativoValido(email)) {
            response.getWriter().print("dominio_invalido");
            return;
        }

        // Validación 1b: el campo "Usuario" debe ser en sí mismo un correo corporativo válido
        // (protege contra manipulación del formulario, ya que en pantalla es de solo lectura).
        if (!ValidacionUtil.esCorreoCorporativoValido(Usua)) {
            response.getWriter().print("usuario_invalido");
            return;
        }

        // Validación 2: correo no debe estar ya registrado
        if (usuDAO.existeEmail(email)) {
            response.getWriter().print("email_existe");
            return;
        }

        // Validación 3: contraseña alfanumérica de al menos 8 caracteres
        if (!ValidacionUtil.esPasswordSegura(pass)) {
            response.getWriter().print("password_debil");
            return;
        }

        // Validación 4: debe haberse seleccionado un rol
        if (rol == null || rol.trim().isEmpty()) {
            response.getWriter().print("rol_invalido");
            return;
        }

        // Validación 5: debe haberse seleccionado un tipo de documento válido
        int idTipoDocumento;
        try {
            idTipoDocumento = Integer.parseInt(tipoDocParam);
        } catch (Exception e) {
            response.getWriter().print("tipodoc_invalido");
            return;
        }

        //Se genera un código para el usuario
        int Nusuarios = usuDAO.BuscarNusuarios();
        Nusuarios = Nusuarios + 1;
        String format = dfusu.format(Nusuarios);

        //manejo de la subida de archivos (LA FOTO ES OPCIONAL: si no se selecciona ninguna, no debe romper el registro)
        Part part = request.getPart("file1");
        dbFileName1 = "";
        String savePath1 = "";
        if (part != null && part.getSize() > 0) {
            String fileName1 = extractFileName(part);//file name
            if (fileName1 != null && !fileName1.trim().isEmpty()) {
                //Se configuran las rutas para guardar el archivo de imagen y se almacena en el sistema.
                String applicationPath = getServletContext().getRealPath("");
                String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
                File fileUploadDirectory = new File(uploadPath);
                if (!fileUploadDirectory.exists()) {
                    fileUploadDirectory.mkdirs();
                }
                savePath1 = uploadPath + File.separator + fileName1;
                try {
                    part.write(savePath1);
                    dbFileName1 = UPLOAD_DIR + File.separator + fileName1;
                } catch (Exception e) {
                    System.err.println("No se pudo guardar la foto de perfil: " + e.getMessage());
                    dbFileName1 = "";
                    savePath1 = "";
                }
            }
        }

        //Se configuran los atributos del objeto Usuario con los valores obtenidos de los parámetros de la solicitud 
        //y del manejo de archivos.
        usu.setCodigo(format);
        usu.setNombre(nombre);
        usu.setIdTipodocumento(1);
        usu.setNrodocumento(numDoc);
        usu.setSueldo(0.00);
        usu.setTelefono(telefono);
        usu.setDireccion("");
        usu.setEmail(email);
        usu.setFechaderegistro(fechaderegistro);
        usu.setUsu(Usua);
        usu.setPassword(pass);
        usu.setRol(rol);
        usu.setFilename1(dbFileName1);
        usu.setPath1(savePath1);
        usu.setEstado("Activo");

        UsuarioDAO usudao = new UsuarioDAO();
        if (usudao.addimg(usu)) {
            javax.servlet.http.HttpSession ses1 = request.getSession(false);
            String actor1 = ses1 != null ? (String) ses1.getAttribute("usuario") : "";
            new com.pe.DAO.AuditoriaDAO().registrar(actor1, "Creación de usuario", "Usuarios",
                    "Usuario " + email + " creado con rol " + rol);
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("error_bd: " + usudao.getUltimoError());
        }
    }

    private void Editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idusu", request.getParameter("id"));
        request.getRequestDispatcher("EditarUsuario.jsp").forward(
                request, response);
    }

    private void Detalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idusu", request.getParameter("id"));
        request.getRequestDispatcher("DetalleUsuario.jsp").forward(
                request, response);
    }

    private void Edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
//        int idempleados = Integer.parseInt(request.getParameter("txtidempleado"));
        String nombre = request.getParameter("Txtnombre");
        String usuarios = request.getParameter("Txtnomusu");
        String pass = request.getParameter("Txtpass");
        String rol = request.getParameter("Txtrol");
        String imgactual = request.getParameter("txtImagen");
        Part part = request.getPart("txtModificarImagen");//

        usuario.setId(id);
        usuario.setNombre(nombre);
        usuario.setUsu(usuarios);
        if (pass != null && !pass.trim().isEmpty()) {
            // Validación: contraseña alfanumérica de al menos 8 caracteres
            if (!ValidacionUtil.esPasswordSegura(pass)) {
                response.getWriter().print("password_debil");
                return;
            }
            // El admin escribió una contraseña nueva: se hasheará en UsuarioDAO.Editimgg
            usuario.setPassword(pass);
        } else {
            // No se escribió contraseña nueva: se conserva la actual (ya hasheada) sin cambios
            Usuario actual = usuDAO.list(id);
            usuario.setPassword(actual.getPassword());
        }
        usuario.setRol(rol);

        String imagen = request.getParameter("selected");

        if (imagen.equals("SelectImagenActual")) {
            usuario.setFilename1(imgactual);
            usuario.setPath1(imgactual);

        } else {
            String fileName1 = extractFileName(part);//file name
            String applicationPath = getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
            System.out.println("applicationPath:" + applicationPath);
            File fileUploadDirectory = new File(uploadPath);
            if (!fileUploadDirectory.exists()) {
                fileUploadDirectory.mkdirs();
            }
            String savePath1 = uploadPath + File.separator + fileName1;

            //Imagen1
            part.write(savePath1);
            dbFileName1 = UPLOAD_DIR + File.separator + fileName1;
            usuario.setFilename1(dbFileName1);
            usuario.setPath1(savePath1);
        }

        if (usuDAO.Editimgg(usuario)) {
            javax.servlet.http.HttpSession ses2 = request.getSession(false);
            String actor2 = ses2 != null ? (String) ses2.getAttribute("usuario") : "";
            new com.pe.DAO.AuditoriaDAO().registrar(actor2, "Edición de usuario", "Usuarios",
                    "Usuario " + nombre + " (usu: " + usuarios + ") editado");
            response.getWriter().print("ok");

        } else {
            response.getWriter().print("El cliente no ha sido registrado");

        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idUsu"));
        Usuario usuABorrar = usuDAO.list(id);
        if (usuDAO.Eliminar(id)) {
            javax.servlet.http.HttpSession ses3 = request.getSession(false);
            String actor3 = ses3 != null ? (String) ses3.getAttribute("usuario") : "";
            new com.pe.DAO.AuditoriaDAO().registrar(actor3, "Eliminación de usuario", "Usuarios",
                    "Usuario " + (usuABorrar != null ? usuABorrar.getNombre() : ("id " + id)) + " eliminado");
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("error_bd: " + usuDAO.getUltimoError());
        }
    }

    // Restablece la contraseña de un usuario y genera una nueva de forma aleatoria.
    // Solo puede usarlo un Administrador con sesión activa (se valida por servidor, no solo por la interfaz).
    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        String tipoSesion = (sesion != null) ? (String) sesion.getAttribute("tipo") : null;
        if (sesion == null || tipoSesion == null || !tipoSesion.equalsIgnoreCase("Administrador")) {
            response.getWriter().print("no_autorizado");
            return;
        }

        int idObjetivo = Integer.parseInt(request.getParameter("id"));
        Usuario objetivo = usuDAO.list(idObjetivo);
        String nuevaPassword = UsuarioDAO.generarPasswordAleatoria();

        if (usuDAO.actualizarPasswordPorAdmin(idObjetivo, nuevaPassword)) {
            String adminEmail = (String) sesion.getAttribute("usuario");
            LogAccesoDAO logDAO = new LogAccesoDAO();
            String detalle = "Contraseña restablecida por administrador (" + adminEmail + ") para el usuario "
                    + (objetivo != null ? objetivo.getNombre() : ("id " + idObjetivo));
            logDAO.registrar(objetivo != null ? objetivo.getUsu() : "", true, request.getRemoteAddr(), detalle);
            new com.pe.DAO.AuditoriaDAO().registrar(adminEmail, "Restablecimiento de contraseña", "Usuarios", detalle);
            response.getWriter().print("ok:" + nuevaPassword);
        } else {
            response.getWriter().print("error");
        }
    }

    // Desbloquea manualmente una cuenta (solo Administrador).
    private void desbloquear(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        String tipoSesion = (sesion != null) ? (String) sesion.getAttribute("tipo") : null;
        if (sesion == null || tipoSesion == null || !tipoSesion.equalsIgnoreCase("Administrador")) {
            response.getWriter().print("no_autorizado");
            return;
        }

        int idObjetivo = Integer.parseInt(request.getParameter("id"));
        Usuario objetivo = usuDAO.list(idObjetivo);
        if (usuDAO.desbloquearUsuario(idObjetivo)) {
            String adminEmail = (String) sesion.getAttribute("usuario");
            LogAccesoDAO logDAO = new LogAccesoDAO();
            String detalle = "Cuenta desbloqueada manualmente por administrador (" + adminEmail + ")";
            logDAO.registrar(objetivo != null ? objetivo.getUsu() : "", true, request.getRemoteAddr(), detalle);
            new com.pe.DAO.AuditoriaDAO().registrar(adminEmail, "Desbloqueo de cuenta", "Usuarios", detalle);
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("error");
        }
    }

    private String extractFileName(Part part) {//This method will print the file name.
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
