package com.pe.controller;

import com.pe.DAO.ConductorDAO;
import com.pe.model.entity.Conductor;
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
public class ConductoresController extends HttpServlet {

    int id;
    ConductorDAO conducdao = new ConductorDAO();
    Conductor conduct = new Conductor();
    ConductorDAO auxiDAO;
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
        if (accion.equals("editar")) {
            this.Editar(request, response);
        }
        if (accion.equals("eliminar")) {
            this.eliminar(request, response);
        }
        if (accion.equals("Estado")) {
            this.Estado(request, response);
        }
//        if (accion.equals("BuscarPorId")) {
//            this.BuscarPorId(request, response);
//        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Conductor cli = new Conductor();
        String codigo = request.getParameter("txtcodigo");
        String Idtipodocumento = request.getParameter("Txtidtipodocumento");
        String numerodocumento = request.getParameter("Txtnumerodocumento");
        String Chofer = request.getParameter("txtchofer");
        String Licencia = request.getParameter("Txtlicencia");
        cli.setCodigo(codigo);
        cli.setIdtipodocumento(Integer.parseInt(Idtipodocumento));
        cli.setNumerodocumento(numerodocumento);
        cli.setChofer(Chofer);
        cli.setLicencia(Licencia);
        cli.setEstado("Activo");
        ConductorDAO conddao = new ConductorDAO();
        boolean validacion = false;
        validacion = conddao.validacion(cli);
        if (validacion == true) {
            response.getWriter().print("yaexiste");
        } else {
        if (conddao.add(cli)) {
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("El cliente no ha sido registrado");
        }
    }}

    private void Edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
        String codigo = request.getParameter("txtcodigo");
        String Idtipodocumento = request.getParameter("Txtidtipodocumento");
        String numerodocumento = request.getParameter("Txtnumerodocumento");
        String Chofer = request.getParameter("txtchofer");
        String Licencia = request.getParameter("Txtlicencia");

        conduct.setIdcond(id);
        conduct.setCodigo(codigo);
        conduct.setIdtipodocumento(Integer.parseInt(Idtipodocumento));
        conduct.setNumerodocumento(numerodocumento);
        conduct.setChofer(Chofer);
        conduct.setLicencia(Licencia);
        if (conducdao.Edit(conduct)) {
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("El cliente no ha sido editado");
        }
    }

    private void Editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idcon", request.getParameter("id"));
        request.getRequestDispatcher("EditarConductor.jsp").forward(
                request, response);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idCon"));
        System.out.println("[ID] " + id);
        conducdao.Eliminar(id);
        ConductorDAO condf = new ConductorDAO();
        boolean validacion = false;
        validacion = condf.Yatienemovimiento(id);
        if (validacion == true) {
            response.getWriter().print("tienemovi");
        }
    }

    private void Estado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = ConductorDAO.estado(id);
        String estadoNuevo;
        if (estado.equalsIgnoreCase("Activo")) {
            estadoNuevo = "Desactivado";
        } else {
            estadoNuevo = "Activo";
        }
        conduct.setEstado(estadoNuevo);
        conducdao.editEstado(conduct, id);

        javax.servlet.http.HttpSession sesEstadoCond = request.getSession(false);
        String actorEstadoCond = sesEstadoCond != null ? (String) sesEstadoCond.getAttribute("usuario") : "";
        new com.pe.DAO.AuditoriaDAO().registrar(actorEstadoCond, "Cambio de estado de conductor", "Logistica",
                "Conductor id " + id + " cambiado a " + estadoNuevo);
    }

//    private void BuscarPorId(HttpServletRequest request, HttpServletResponse response)
//            throws IOException, IOException {
//        int codigo = Integer.parseInt(request.getParameter("idCliente"));
//        ConductorDAO pdao = new ConductorDAO();
//        Conductor obj = pdao.BuscarPorId(codigo);
//        request.getSession().setAttribute("cliente", obj);
//        response.sendRedirect("InsertarVenta.jsp");
//    }
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
