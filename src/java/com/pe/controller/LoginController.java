/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.controller;

import com.pe.DAO.UsuarioDAO;
import com.pe.DAO.loginDAO;
import com.pe.DAO.LogAccesoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yenny
 */
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String usuario;
            String password;
            String tipo = "";
            int resultado;
            int id;
            loginDAO CBD = new loginDAO();
            LogAccesoDAO logDAO = new LogAccesoDAO();
            RequestDispatcher rd = null;
            if (request.getParameter("btnEntrar") != null) {

                usuario = request.getParameter("txtUsuario");
                password = request.getParameter("txtPassword");
                String ip = request.getRemoteAddr();

                UsuarioDAO o = new UsuarioDAO();
                resultado = o.usu(usuario, password);
                if (resultado == -2) {
                    logDAO.registrar(usuario, false, ip, "Intento de acceso a cuenta bloqueada por seguridad");
                    new com.pe.DAO.AuditoriaDAO().registrar(usuario, "Intento de acceso bloqueado", "Auth", "Intento de acceso a cuenta ya bloqueada, desde " + ip);
                    request.setAttribute("mensaje", "<p style='color:red'>Tu cuenta est&aacute; bloqueada por seguridad tras varios intentos fallidos. Cont&aacute;ctate con el Administrador para desbloquearla.</p>");
                    rd = request.getRequestDispatcher("login.jsp");
                } else if (resultado == -3) {
                    logDAO.registrar(usuario, false, ip, "Usuario bloqueado automáticamente por seguridad tras 5 intentos fallidos seguidos");
                    new com.pe.DAO.AuditoriaDAO().registrar(usuario, "Bloqueo automático de cuenta", "Auth",
                            "Posible fuerza bruta: la cuenta " + usuario + " se bloqueó tras 5 intentos fallidos desde la IP " + ip);
                    request.setAttribute("mensaje", "<p style='color:red'>Demasiados intentos fallidos. Tu cuenta ha sido bloqueada por seguridad. Cont&aacute;ctate con el Administrador para desbloquearla.</p>");
                    rd = request.getRequestDispatcher("login.jsp");
                } else if (resultado == 0) {
                    logDAO.registrar(usuario, false, ip, "Usuario o password incorrectos");
                    new com.pe.DAO.AuditoriaDAO().registrar(usuario, "Intento fallido de inicio de sesión", "Auth", "Credenciales incorrectas desde " + ip);
                    request.setAttribute("mensaje", "<p style='color:red'>Correo o contrase&ntilde;a incorrectos</p>");
                    rd = request.getRequestDispatcher("login.jsp");
                } else {
                    tipo = CBD.Validar(usuario, password);
                    logDAO.registrar(usuario, true, ip, "Login correcto (" + tipo + ")");
                    new com.pe.DAO.AuditoriaDAO().registrar(usuario, "Inicio de sesión", "Auth", "Login exitoso desde " + ip);
                    request.setAttribute("tipo", tipo);
                    request.setAttribute("usuario", usuario);
                    rd = request.getRequestDispatcher("login.jsp");
                }

            }

            rd.forward(request, response);

        }
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
