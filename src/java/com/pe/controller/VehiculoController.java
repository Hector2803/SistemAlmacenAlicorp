/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.pe.controller;

import com.pe.DAO.VehiculoDAO;
import com.pe.model.entity.Vehiculo;
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
public class VehiculoController extends HttpServlet {

    int id;
    VehiculoDAO catedao = new VehiculoDAO();
    Vehiculo vehiculo = new Vehiculo();

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
        Vehiculo vehi = new Vehiculo();
        String cod = request.getParameter("TxtCod");
        String placa = request.getParameter("Txtplaca");
        String marca = request.getParameter("Txtmarca");
        vehi.setIdvehi(id);
        vehi.setCodigo(cod);
        vehi.setPlaca(placa);
        vehi.setMarca(marca);
        vehi.setEstado("Activo");
        VehiculoDAO catdao = new VehiculoDAO();
        boolean validacion = false;
        validacion = catdao.validacion(placa);
        if (validacion == true) {
            response.getWriter().print("yaexiste");
        } else {
            if (catdao.add(vehi)) {
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
        String placa = request.getParameter("Txtplaca");
        String marca = request.getParameter("Txtmarca");
   
        vehiculo.setIdvehi(id);
        vehiculo.setCodigo(cod);
        vehiculo.setPlaca(placa);
        vehiculo.setMarca(marca);
        if (catedao.Edit(vehiculo)) {
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
                VehiculoDAO condf = new VehiculoDAO();
        boolean validacion = false;
        validacion = condf.Yatienemovimiento(id);
        if (validacion == true) {
            response.getWriter().print("tienemovi");
        }
    }

    private void Estado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = VehiculoDAO.getVehiculoEstado(id);
        String estadoNuevo;
        if (estado.equalsIgnoreCase("Activo")) {
            estadoNuevo = "Desactivado";
        } else {
            estadoNuevo = "Activo";
        }
        vehiculo.setEstado(estadoNuevo);
        catedao.EditarEstado(vehiculo, id);

        javax.servlet.http.HttpSession sesEstadoVeh = request.getSession(false);
        String actorEstadoVeh = sesEstadoVeh != null ? (String) sesEstadoVeh.getAttribute("usuario") : "";
        new com.pe.DAO.AuditoriaDAO().registrar(actorEstadoVeh, "Cambio de estado de vehículo", "Logistica",
                "Vehículo id " + id + " cambiado a " + estadoNuevo);
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
