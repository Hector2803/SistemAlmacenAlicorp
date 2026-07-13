/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.controller;

import com.pe.DAO.CategoriaDAO;
import com.pe.model.entity.Categoria;
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
public class CategoriaController extends HttpServlet {

    int id;
    CategoriaDAO catedao = new CategoriaDAO();
    Categoria categoria = new Categoria();

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
        Categoria cat = new Categoria();
        String codig = request.getParameter("txtCod");
        String txtNom = request.getParameter("txtNom");
        cat.setCodigo(codig);
        cat.setNombre(txtNom);
        cat.setEstado("Activo");
        CategoriaDAO catdao = new CategoriaDAO();
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
        categoria.setIdcategoria(id);
        categoria.setCodigo(cod);
        categoria.setNombre(nombre);
        if (catedao.Edit(categoria)) {
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("El proveedor no ha sido registrado correctamente");
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idCat"));
        System.out.println("[ID] " + id);
        catedao.Eliminar(id);
        CategoriaDAO clidao = new CategoriaDAO();
        boolean validacion = false;
        validacion = clidao.Yatienemovimiento(id);
        if (validacion == true) {
            response.getWriter().print("tienemovi");
        }
    }

    private void Estado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = CategoriaDAO.getCategoriaEstado(id);
        String estadoNuevo;
        if (estado.equalsIgnoreCase("Activo")) {
            estadoNuevo = "Desactivado";
        } else {
            estadoNuevo = "Activo";
        }
        categoria.setEstado(estadoNuevo);
        catedao.EditarEstado(categoria, id);

        javax.servlet.http.HttpSession sesEstadoCat = request.getSession(false);
        String actorEstadoCat = sesEstadoCat != null ? (String) sesEstadoCat.getAttribute("usuario") : "";
        new com.pe.DAO.AuditoriaDAO().registrar(actorEstadoCat, "Cambio de estado de categoría", "Configuracion",
                "Categoría id " + id + " cambiada a " + estadoNuevo);
        response.sendRedirect("Categoria.jsp");
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
