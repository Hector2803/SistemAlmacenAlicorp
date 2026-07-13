package com.pe.controller;

import com.pe.DAO.UsuarioDAO;
import com.pe.model.entity.Usuario;
import com.pe.util.ValidacionUtil;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controlador de recuperación de contraseña.
 *
 * Flujo:
 * 1) accion=solicitar  -> el usuario ingresa su correo. Si existe, se genera
 *    un token temporal (30 min) y se guarda en BD. Como el sistema aún no
 *    tiene envío de correos configurado, el token se muestra en pantalla
 *    (RecuperarPassword.jsp) a modo de demo. Para producción, reemplazar
 *    ese paso por un envío real de correo (ver nota al final de este archivo).
 * 2) accion=restablecer -> el usuario ingresa el token recibido + nueva
 *    contraseña. Se valida el token (existencia y expiración) y se
 *    actualiza la contraseña (hasheada).
 */
public class RecuperarPasswordController extends HttpServlet {

    UsuarioDAO usuarioDao = new UsuarioDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");

        if ("solicitar".equals(accion)) {
            solicitarToken(request, response);
        } else if ("restablecer".equals(accion)) {
            restablecerPassword(request, response);
        } else {
            request.getRequestDispatcher("RecuperarPassword.jsp").forward(request, response);
        }
    }

    private void solicitarToken(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("txtEmailRecuperacion");

        // Mensaje genérico siempre (no revelamos si el correo existe o no, por seguridad)
        String mensaje = "Si el correo ingresado está registrado, se generó un enlace/token de recuperación.";
        String tokenGenerado = null;

        if (email != null && !email.trim().isEmpty()) {
            Usuario u = usuarioDao.buscarPorEmail(email.trim());
            if (u != null) {
                tokenGenerado = usuarioDao.generarYGuardarTokenRecuperacion(u.getId());
            }
        }

        request.setAttribute("mensaje", mensaje);
        // NOTA: Mostrar el token en pantalla es solo temporal, mientras no haya envío de correo.
        // En producción, este token se debe enviar por correo y esta línea debe eliminarse.
        if (tokenGenerado != null) {
            request.setAttribute("tokenDemo", tokenGenerado);
        }

        request.getRequestDispatcher("RecuperarPassword.jsp").forward(request, response);
    }

    private void restablecerPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("txtToken");
        String nuevaPassword = request.getParameter("txtNuevaPassword");
        String confirmarPassword = request.getParameter("txtConfirmarPassword");

        try (PrintWriter out = response.getWriter()) {
            if (token == null || token.trim().isEmpty()) {
                out.print("token_invalido");
                return;
            }
            if (nuevaPassword == null || !ValidacionUtil.esPasswordSegura(nuevaPassword)) {
                out.print("password_corta");
                return;
            }
            if (!nuevaPassword.equals(confirmarPassword)) {
                out.print("password_no_coincide");
                return;
            }

            int idUsuarioAfectado = usuarioDao.validarToken(token.trim());
            boolean actualizado = usuarioDao.actualizarPasswordPorToken(token.trim(), nuevaPassword);
            if (actualizado) {
                if (idUsuarioAfectado != 0) {
                    com.pe.model.entity.Usuario afectado = usuarioDao.list(idUsuarioAfectado);
                    if (afectado != null) {
                        new com.pe.DAO.AuditoriaDAO().registrar(afectado.getUsu(), "Cambio de contraseña (autoservicio)", "Usuarios",
                                afectado.getNombre() + " (" + afectado.getRol() + ") cambió su propia contraseña");
                    }
                }
                out.print("ok");
            } else {
                out.print("token_invalido");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}

/*
 * ================== INTEGRACIÓN FUTURA DE ENVÍO DE CORREO ==================
 * Cuando quieras enviar el token por correo real en vez de mostrarlo en
 * pantalla, agrega la librería JavaMail (javax.mail) al proyecto y, en
 * solicitarToken(), reemplaza el bloque "request.setAttribute("tokenDemo"...)"
 * por algo como:
 *
 *   String link = "http://localhost:8080/SistemaDeAlmacen/RestablecerPassword.jsp?token=" + tokenGenerado;
 *   EnviarCorreo.enviar(u.getEmail(), "Recuperación de contraseña",
 *       "Usa este enlace (válido 30 min) para restablecer tu contraseña: " + link);
 *
 * Y quitar por completo la línea que expone el token en la respuesta al navegador.
 * =============================================================================
 */
