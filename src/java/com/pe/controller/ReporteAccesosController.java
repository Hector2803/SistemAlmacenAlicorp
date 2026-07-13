package com.pe.controller;

import com.pe.DAO.LogAccesoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Muestra la bitácora de accesos (login exitosos y fallidos).
 * Acceso restringido: solo usuarios con sesión activa y rol Administrador.
 */
public class ReporteAccesosController extends HttpServlet {

    LogAccesoDAO logDAO = new LogAccesoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        String tipo = (sesion != null) ? (String) sesion.getAttribute("tipo") : null;

        // Solo el Administrador puede ver este reporte
        if (sesion == null || tipo == null || !tipo.equalsIgnoreCase("Administrador")) {
            request.setAttribute("accesoDenegado", true);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String filtroUsuario = request.getParameter("usuario");
        if (filtroUsuario != null && !filtroUsuario.trim().isEmpty()) {
            request.setAttribute("logs", logDAO.listarPorUsuario(filtroUsuario.trim(), 200));
            request.setAttribute("filtroUsuario", filtroUsuario.trim());
        } else {
            request.setAttribute("logs", logDAO.listarUltimos(200));
        }

        request.getRequestDispatcher("ReporteAccesos.jsp").forward(request, response);
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
