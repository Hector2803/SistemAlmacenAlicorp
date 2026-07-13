/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.controller;

import com.pe.DAO.UnidadVentaDAO;
import com.pe.model.entity.UnidadVenta;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yenny
 */
public class UnidadmedidaController extends HttpServlet {
    int id, con;
    UnidadVentaDAO univdao = new UnidadVentaDAO();
    UnidadVenta unidadv = new UnidadVenta();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion.equals("adduventa")) {
            this.adduventa(request, response);
        }
        if(accion.equals("Editar")) {
            this.Edituventa(request, response);
        }
        if (accion.equals("eliminaruventa")) {
            this.eliminaruventa(request, response);
        }
        if (accion.equals("Estadouventa")) {
            this.Estadouventa(request, response);
        }
    }
        private void adduventa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UnidadVenta uv = new UnidadVenta();
        String codig = request.getParameter("txtCod");
        String nom = request.getParameter("txtNom");
        int conteni = Integer.parseInt(request.getParameter("txtCont"));
        uv.setCodigo(codig);
        uv.setNombre(nom);
        uv.setContenido(conteni);
        uv.setEstado("Activo");

        UnidadVentaDAO uvdao = new UnidadVentaDAO();
        if (uvdao.add(uv)) {
            response.getWriter().print("ok");

        } else {
            response.getWriter().print("No ha sido registrado correctamente");
        }
    }

    private void Edituventa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
        String cod = request.getParameter("txtCod");
        String nombre = request.getParameter("txtNom");
        int conteni = Integer.parseInt(request.getParameter("txtCont"));
        unidadv.setIduventa(id);
        unidadv.setCodigo(cod);
        unidadv.setNombre(nombre);
        unidadv.setContenido(conteni);
        if (univdao.Edit(unidadv)) {
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("El motivo no ha sido registrado correctamente");
        }
    }

    private void eliminaruventa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idUv"));
        System.out.println("[ID] " + id);
        univdao.Eliminar(id);
    }

    private void Estadouventa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = UnidadVentaDAO.getUventaEstado(id);
        if (estado.equalsIgnoreCase("Activo")) {
            unidadv.setEstado("Desactivado");
        } else {
            unidadv.setEstado("Activo");

        }
        univdao.Estado(unidadv, id);
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
