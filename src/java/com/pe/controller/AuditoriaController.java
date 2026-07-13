package com.pe.controller;

import com.pe.DAO.AuditoriaDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Muestra la bitácora de auditoría general (creaciones, ediciones, movimientos, sesión).
 * Acceso restringido: solo usuarios con sesión activa y rol Administrador.
 */
public class AuditoriaController extends HttpServlet {

    AuditoriaDAO auditDAO = new AuditoriaDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        String tipo = (sesion != null) ? (String) sesion.getAttribute("tipo") : null;

        if (sesion == null || tipo == null || !tipo.equalsIgnoreCase("Administrador")) {
            request.setAttribute("accesoDenegado", true);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String filtroUsuario = request.getParameter("usuario");
        String filtroModulo = request.getParameter("modulo");

        request.setAttribute("registros", auditDAO.filtrar(filtroUsuario, filtroModulo, 300));
        request.setAttribute("filtroUsuario", filtroUsuario);
        request.setAttribute("filtroModulo", filtroModulo);

        request.getRequestDispatcher("Auditoria.jsp").forward(request, response);
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
