/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.controller;

import com.pe.DAO.ClasificacionDAO;
import com.pe.model.entity.Clasificacion;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yenny
 */
public class ControllerClasificacion extends HttpServlet {

    int id;
    ClasificacionDAO marc = new ClasificacionDAO();
    Clasificacion mar = new Clasificacion();
    ArrayList<String> listaErrores = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion.equals("add")) {
            this.add(request, response);
        }
        if (accion.equals("Actualizar")) {
            this.Edit(request, response);
        }
        if (accion.equals("eliminar")) {
            this.eliminar(request, response);
        }
        if (accion.equals("Estado")) {
            this.Estado(request, response);
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cod = request.getParameter("txtCod");
        String txtNom = request.getParameter("txtNom");
        Clasificacion m = new Clasificacion(cod, txtNom, "Activo");
        ClasificacionDAO mdao = new ClasificacionDAO();
        boolean validacion = false;
        validacion = mdao.validacion(txtNom);
        if (validacion == true) {
            response.getWriter().print("yaexiste");
        } else {
            if (mdao.add(m)) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("No se registro correctamente");
            }
        }
    }

    private void Edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
        String codigo = request.getParameter("TxtCod");
        String nombre = request.getParameter("TxtNom");
        mar.setIdclasi(id);
        mar.setCodigo(codigo);
        mar.setNombre(nombre);
        if (marc.Edit(mar)) {
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("No ha sido registrado correctamente");
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idMar"));
        System.out.println("[ID] " + id);
        marc.Eliminar(id);
        ClasificacionDAO clidao = new ClasificacionDAO();
        boolean validacion = false;
        validacion = clidao.Yatienemovimiento(id);
        if (validacion == true) {
            response.getWriter().print("tienemovi");
        }
    }

    private void Estado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = ClasificacionDAO.getclasificacionEstado(id);
        if (estado.equalsIgnoreCase("Activo")) {
            mar.setEstado("Desactivado");
        } else {
            mar.setEstado("Activo");
        }
        marc.EditarEstado(mar, id);
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
