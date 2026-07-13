package com.pe.controller;

import com.pe.DAO.NotificacionAdminDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NotificacionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        HttpSession sesion = request.getSession(false);
        String tipo = (sesion != null) ? (String) sesion.getAttribute("tipo") : null;
        if (sesion == null || tipo == null || !tipo.equalsIgnoreCase("Administrador")) {
            response.getWriter().print("no_autorizado");
            return;
        }
        new NotificacionAdminDAO().marcarTodasLeidas();
        response.getWriter().print("ok");
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
