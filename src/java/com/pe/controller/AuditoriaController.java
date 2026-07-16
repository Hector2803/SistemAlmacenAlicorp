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
        String filtroRol = request.getParameter("rol");
        String fechaDesde = request.getParameter("fechaDesde");
        String fechaHasta = request.getParameter("fechaHasta");
        // Marcador enviado únicamente por el botón "Filtrar".
        // Si no viene (al entrar a la ventana), NO se consulta la base de datos.
        boolean busquedaRealizada = (request.getParameter("buscar") != null);

        if (busquedaRealizada) {
            request.setAttribute("registros",
                    auditDAO.filtrarAvanzado(filtroUsuario, filtroRol, fechaDesde, fechaHasta, 300));
        } else {
            request.setAttribute("registros", new java.util.ArrayList<com.pe.model.entity.Auditoria>());
        }

        request.setAttribute("busquedaRealizada", busquedaRealizada);
        request.setAttribute("filtroUsuario", filtroUsuario);
        request.setAttribute("filtroRol", filtroRol);
        request.setAttribute("fechaDesde", fechaDesde);
        request.setAttribute("fechaHasta", fechaHasta);

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
