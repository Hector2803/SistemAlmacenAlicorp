/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.controller;

import com.pe.DAO.ProductoDAO;
import com.pe.model.entity.Producto;
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
public class ControllerdatosModal extends HttpServlet {

    int id;
    String Cantidadni = "CantidadNotaingreso.jsp";
    String Cantidadns = "CantidadNotasalida.jsp";
    String Cantidadoc = "CantidadOrdenCompra.jsp";
    String Cantidadco = "CantidadCotizacionventa.jsp";
    String Cantidadpedi = "CantidadPedidoventa.jsp";
    String Cantidadfb = "CantidadFacturaventa.jsp";
    String Cantidadbo = "CantidadBoletaventa.jsp";
    String Cantidadcarrito = "_Cantidadcarritoventa.jsp";
    String Cantidadrequerimiento = "Cantidadrequerimientocompra.jsp";
    String Cantidadguiaremisioncliente = "Cantidadguiaremisioncliente.jsp";
    String cantrefoc = "RefCantidadordendecompra.jsp";
    String Cantidadrefni = "RefCantidadni.jsp";
    String EditCliente = "EditarCliente.jsp";
    String addCliente = "InsertarCliente.jsp";
    String EditProveedor = "EditarProveedor.jsp";
    String InsertarProveedor = "InsertarProveedor.jsp";
    String Stock = "AlmacenStock.jsp";
    String EditarUsu = "EditarUsuario.jsp";
    String detallecliente = "DetalleCliente.jsp";
    Producto c = new Producto();
    ProductoDAO cdao = new ProductoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ControllerdatosModal</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerdatosModal at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String acceso = "";
        String action = request.getParameter("accion");
        if (action.equalsIgnoreCase("Cantidadni")) {
            request.setAttribute("idproxalmni", request.getParameter("id"));
            acceso = Cantidadni;
        }
        if (action.equalsIgnoreCase("Cantidadns")) {
            request.setAttribute("idproxalmns", request.getParameter("id"));
            acceso = Cantidadns;
        }
        if (action.equalsIgnoreCase("Cantidadoc")) {
            request.setAttribute("idproxalmoc", request.getParameter("id"));
            acceso = Cantidadoc;
        }
        if (action.equalsIgnoreCase("Cantidadpedi")) {
            request.setAttribute("idproxalmpedi", request.getParameter("id"));
            acceso = Cantidadpedi;
        }
         if (action.equalsIgnoreCase("Cantidadcarrito")) {
            request.setAttribute("idproxalmcarrito", request.getParameter("id"));
            acceso = Cantidadcarrito;
        }
        if (action.equalsIgnoreCase("Cantidadco")) {
            request.setAttribute("idproxalmco", request.getParameter("id"));
            acceso = Cantidadco;
        }
        if (action.equalsIgnoreCase("Cantidadfb")) {
            request.setAttribute("idproxalmfb", request.getParameter("id"));
            acceso = Cantidadfb;
        }
        if (action.equalsIgnoreCase("Cantidadbo")) {
            request.setAttribute("idproxalmbo", request.getParameter("id"));
            acceso = Cantidadbo;
        }
        if (action.equalsIgnoreCase("Cantidadrequerimiento")) {
            request.setAttribute("req", request.getParameter("id"));
            acceso = Cantidadrequerimiento;
        }
        if (action.equalsIgnoreCase("Cantidadguiaremisioncliente")) {
            request.setAttribute("guiacliente", request.getParameter("id"));
            acceso = Cantidadguiaremisioncliente;
        }

        if (action.equalsIgnoreCase("cantrefoc")) {
            request.setAttribute("refoc", request.getParameter("id"));
            acceso = cantrefoc;
        }

        if (action.equalsIgnoreCase("cantrefni")) {
            request.setAttribute("refni", request.getParameter("id"));
            acceso = Cantidadrefni;
        }
        if (action.equalsIgnoreCase("editarcliente")) {
            request.setAttribute("idcli", request.getParameter("id"));
            acceso = EditCliente;
        }
        if (action.equalsIgnoreCase("addcliente")) {
            acceso = addCliente;
        }
        if (action.equalsIgnoreCase("editarProveedor")) {
            request.setAttribute("idprove", request.getParameter("id"));
            acceso = EditProveedor;
        }

        if (action.equalsIgnoreCase("InsertarProveedor")) {
            acceso = InsertarProveedor;
        }
        if (action.equalsIgnoreCase("Stock")) {
            request.setAttribute("St", request.getParameter("id"));
            acceso = Stock;
        }
        if (action.equalsIgnoreCase("Editusu")) {
            request.setAttribute("Eu", request.getParameter("id"));
            acceso = EditarUsu;
        }
        if (action.equalsIgnoreCase("detallecliente")) {
            request.setAttribute("idcli", request.getParameter("id"));
            acceso = detallecliente;
        }
        // fin Estado
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
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
