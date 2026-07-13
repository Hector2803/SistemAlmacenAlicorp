/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.pe.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DetallePDFController extends HttpServlet {

    int id;
    String DetalleNI = "PDFDetalleNI.jsp";
    String DetalleNS = "PDFDetalleNS.jsp";
    String DetalleOC = "PDFDetalleOC.jsp";
    String DetalleGR = "PDFDetalleGR.jsp";
    String DetalleGRC = "PDFDetalleGRC.jsp";
    String DetalleFC = "PDFDetalleFC.jsp";
    String DetalleOCAlmacen = "PDFDetalleOC-Almacen.jsp";
    String DetalleNICompra = "PDFDetalleNI-Compra.jsp";
    String Movimientoporproducto = "Movimientoporproducto.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DetallePDFController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetallePDFController at " + request.getContextPath() + "</h1>");
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
        // inicio agregar
        if (action.equalsIgnoreCase("DetalleNI")) {
            request.setAttribute("idNI", request.getParameter("id"));
            acceso = DetalleNI;
        } else if (action.equalsIgnoreCase("DetalleNS")) {
            request.setAttribute("idNS", request.getParameter("id"));
            acceso = DetalleNS;
        } else if (action.equalsIgnoreCase("DetalleOC")) {
            request.setAttribute("idOC", request.getParameter("id"));
            acceso = DetalleOC;
        } else if (action.equalsIgnoreCase("DetalleGR")) {
            request.setAttribute("idGR", request.getParameter("id"));
            acceso = DetalleGR;
        } else if (action.equalsIgnoreCase("DetalleGRC")) {
            request.setAttribute("idGRC", request.getParameter("id"));
            acceso = DetalleGRC;
        } 
        else if (action.equalsIgnoreCase("DetalleFC")) {
            request.setAttribute("idFC", request.getParameter("id"));
            acceso = DetalleFC;
        } else if (action.equalsIgnoreCase("DetalleOCAlmacen")) {
            request.setAttribute("idOCAlm", request.getParameter("id"));
            acceso = DetalleOCAlmacen;
        }
        if (action.equalsIgnoreCase("DetalleNICompra")) {
            request.setAttribute("idNICom", request.getParameter("id"));
            acceso = DetalleNICompra;
        }
        if (action.equalsIgnoreCase("movixp")) {
            request.setAttribute("idmovi", request.getParameter("id"));
            acceso = Movimientoporproducto;
        }
        

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
