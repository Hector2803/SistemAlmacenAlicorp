/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.pe.controller;

import com.pe.DAO.MotivoDAO;
import com.pe.model.entity.Motivo;
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
public class MotivoController extends HttpServlet {

    int id;
    MotivoDAO motidao = new MotivoDAO();
    Motivo motivo = new Motivo();

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
        Motivo cat = new Motivo();
        String codig = request.getParameter("txtCod");
        String txtNom = request.getParameter("txtNom");
        String tip = request.getParameter("txtTipo");
        cat.setCodigo(codig);
        cat.setNombre(txtNom);
        cat.setTipo(tip);
        cat.setEstado("Activo");
        MotivoDAO catdao = new MotivoDAO();
        boolean validacion = false;
        validacion = catdao.validacion(txtNom);
        if (validacion == true) {
            response.getWriter().print("yaexiste");
        } else {
            if (catdao.add(cat)) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("No ha sido registrado correctamente");
            }
        }
    }

    private void Edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
        String cod = request.getParameter("TxtCod");
        String nombre = request.getParameter("Txtnombre");
        motivo.setIdmotivo(id);
        motivo.setCodigo(cod);
        motivo.setNombre(nombre);
        if (motidao.Edit(motivo)) {
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("El proveedor no ha sido registrado correctamente");
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idMot"));
        System.out.println("[ID] " + id);
        motidao.Eliminar(id);
        
        MotivoDAO clidao = new MotivoDAO();
        boolean validacion = false;
        validacion = clidao.Yatienemovimiento(id);
        if (validacion == true) {
            response.getWriter().print("tienemovi");
        }
    }

    private void Estado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = MotivoDAO.getMotivoEstado(id);
        if (estado.equalsIgnoreCase("Activo")) {
            motivo.setEstado("Desactivado");
        } else {
            motivo.setEstado("Activo");
        }
        motidao.EditEstado(motivo, id);
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
