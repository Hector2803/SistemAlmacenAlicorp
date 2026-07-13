/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.controller;

import com.pe.DAO.TransporteDAO;
import com.pe.model.entity.Transporte;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yenny
 */
public class TransporteController extends HttpServlet {

    int id;
    TransporteDAO matedao = new TransporteDAO();
    Transporte mat = new Transporte();

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
        int resultado;
        String cod = request.getParameter("txtCod");
        String nom = request.getParameter("txtNom");
        String tip = request.getParameter("txtTipo");
        Transporte m = new Transporte(cod, nom,tip,"Activo");
        TransporteDAO mdao = new TransporteDAO();
        if (mdao.add(m)) {
            response.getWriter().print("ok");

        } else {
            response.getWriter().print("Ya existe el almacen");

        }
    }

    private void Edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
        String codigo = request.getParameter("TxtCod");
        String nombre = request.getParameter("TxtNom");
        mat.setIdtrans(id);
        mat.setCodigo(codigo);
        mat.setNombre(nombre);
        if (matedao.Edit(mat)) {
            response.getWriter().print("ok");

        } else {
            response.getWriter().print("El Almacen no ha sido registrado correctamente");

        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idMat"));
        System.out.println("[ID] " + id);
        matedao.Eliminar(id);
                TransporteDAO condf = new TransporteDAO();
        boolean validacion = false;
        validacion = condf.Yatienemovimiento(id);
        if (validacion == true) {
            response.getWriter().print("tienemovi");
        }
    }

    private void Estado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = TransporteDAO.estado(id);
        String estadoNuevo;
        if (estado.equalsIgnoreCase("Activo")) {
            estadoNuevo = "Desactivado";
        } else {
            estadoNuevo = "Activo";
        }
        mat.setEstado(estadoNuevo);
        matedao.Estado(mat, id);

        javax.servlet.http.HttpSession sesEstadoTr = request.getSession(false);
        String actorEstadoTr = sesEstadoTr != null ? (String) sesEstadoTr.getAttribute("usuario") : "";
        new com.pe.DAO.AuditoriaDAO().registrar(actorEstadoTr, "Cambio de estado de transportista", "Logistica",
                "Transportista id " + id + " cambiado a " + estadoNuevo);
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
