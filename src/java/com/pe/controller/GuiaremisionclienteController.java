/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.pe.controller;

import com.pe.DAO.MovimientoDAO;
import com.pe.DAO.ProductoDAO;
import com.pe.model.entity.DetalleMovimiento;
import com.pe.model.entity.Movimiento;
import com.pe.model.entity.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yenny
 */
public class GuiaremisionclienteController extends HttpServlet {

    MovimientoDAO grcdao = new MovimientoDAO();
    int id;
    MovimientoDAO grcDAO;
    // venta
    String grccomprobante;
    String numgrccomprobante;
    // detalle _detalle
    int Ngrc;
    DecimalFormat formateadorgrc;
    Movimiento grc = new Movimiento();
    DetalleMovimiento dgrc = new DetalleMovimiento();

    public GuiaremisionclienteController() {
        grcDAO = new MovimientoDAO();
        formateadorgrc = new DecimalFormat("00000000");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion.equalsIgnoreCase("procesarCarritogrc")) {
            this.procesarCarritogrc(request, response);
        }
        if (accion.equals("AnadirCarritogrc")) {
            this.anadirCarritogrc(request, response);
        }
        if (accion.equals("actualizarcantidadgrc")) {
            this.actualizarcantidadgrc(request, response);
        }
        if (accion.equals("Registrarguiaremisoncliente")) {
            this.Registrarguiaremisoncliente(request, response);
        }
        if (accion.equals("estadoanulargrc")) {
            this.estadoanulargrc(request, response);
        }
        if (accion.equals("Limpiargrc")) {
            this.Limpiargrc(request, response);
        }
    }

    private void procesarCarritogrc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        ArrayList<DetalleMovimiento> cargrc;//
        if (sesion.getAttribute("cargrc") == null) {
            cargrc = new ArrayList<DetalleMovimiento>();

        } else {
            cargrc = (ArrayList<DetalleMovimiento>) sesion.getAttribute("cargrc");
        }
        if (cargrc.size() > 0) {
            for (int i = 0; i < cargrc.size(); i++) {

                DetalleMovimiento det = cargrc.get(i);
                // subtotal+= det.subtotal();
            }
            //Compra
            //insert into compra values(numero_serie , idProveedor , idTRabjador , fecha , impuesto , subtotal , (subtotal + (subtotal * impuesto)));
            //Detalle
            for (int i = 0; i < cargrc.size(); i++) {

                DetalleMovimiento det = cargrc.get(i);
                // insert into DetalleMovimiento values(null , det.getProducto.getIdproducto() , numero_serie ,det.getCantidad(),det.getPrecioCompra , det.getPrecioVenta );
            }
        } else {
            //Validar si esta vacio
        }
        sesion.setAttribute("cargrc", cargrc);
        response.sendRedirect("InsertarGuiaremisioncliente.jsp");
    }

    private void anadirCarritogrc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        double subtotal;
        HttpSession sesion = request.getSession();//
        ArrayList<DetalleMovimiento> cargrc;//
        if (sesion.getAttribute("cargrc") == null) {
            cargrc = new ArrayList<DetalleMovimiento>();
        } else {
            cargrc = (ArrayList<DetalleMovimiento>) sesion.getAttribute("cargrc");
        }
        Producto p = ProductoDAO.obtenerProducto(Integer.parseInt(request.getParameter("txtPro_id")));
        DetalleMovimiento d = new DetalleMovimiento();
        d.setIdproducto(Integer.parseInt(request.getParameter("txtPro_id")));
        d.setProducto(p);
        d.setCantidad(Double.parseDouble(request.getParameter("txtPro_cantidad")));
        boolean indice = false;
        double SaldoS = p.getStock() - d.getCantidad();
        d.setSaldo(SaldoS);
        for (int i = 0; i < cargrc.size(); i++) {
            DetalleMovimiento det = cargrc.get(i);
            if (det.getIdproducto() == p.getIdproducto()) {
                // det.setCantidad(det.getCantidad()+ d.getCantidad());//auto incrementar cantidad
                // det.setDet_com_descuento(d.getDet_com_descuento()*det.getDet_com_cantidad());
                indice = true;
                break;
            }
        }
        if (!indice) {
            cargrc.add(d);
        }
        sesion.setAttribute("cargrc", cargrc);
        response.sendRedirect("InsertarGuiaremisioncliente.jsp");
    }

    private void actualizarcantidadgrc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        ArrayList<DetalleMovimiento> cargrc;//
        if (sesion.getAttribute("cargrc") == null) {
            cargrc = new ArrayList<DetalleMovimiento>();
        } else {
            cargrc = (ArrayList<DetalleMovimiento>) sesion.getAttribute("cargrc");
        }
        Double cantidad = Double.parseDouble(request.getParameter("cantgrc"));
        int fila = Integer.parseInt(request.getParameter("idproductogrc"));
        DetalleMovimiento det = cargrc.get(fila);
        det.setCantidad(cantidad);
        double SaldoS = det.getProducto().getStock() - det.getCantidad();
        det.setSaldo(SaldoS);
        cargrc.set(fila, det);
        sesion.setAttribute("cargrc", cargrc);
        response.sendRedirect("InsertarGuiaremisioncliente.jsp");
    }

    private void Registrarguiaremisoncliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        Movimiento v = new Movimiento();
        v.setIdauxiliar(Integer.parseInt(request.getParameter("txtIdcli").toUpperCase()));
        // Se usa el usuario realmente logueado (antes estaba fijo en 2, un usuario que ni siquiera existe).
        com.pe.model.entity.Usuario usuarioSesion = com.pe.DAO.UsuarioDAO.listimgPorEmail((String) sesion.getAttribute("usuario"));
        v.setIdusuario(usuarioSesion != null && usuarioSesion.getId() != 0 ? usuarioSesion.getId() : 1);
        v.setTipocomprobante(request.getParameter("txtTipodoc").toUpperCase());
        v.setSerie("GR02");
        int Ngrcpt = grcDAO.BuscarNguiaremisongrc();
        Ngrcpt = Ngrcpt + 1;
        String format = formateadorgrc.format(Ngrcpt);
        v.setCorrelativo(format);
        v.setFecha(new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()).toUpperCase());
        v.setFechaentrega("");
        v.setReferencia("");
        v.setTienda(request.getParameter("txtTienda").toUpperCase());
        v.setAlmacen(request.getParameter("txtAlmacen").toUpperCase());
        v.setCondicion(request.getParameter("txtCondicion").toUpperCase());
        v.setIdmotivo(Integer.parseInt(request.getParameter("txtMotivo").toUpperCase()));
        v.setIdtrans(Integer.parseInt(request.getParameter("txtTransporte").toUpperCase()));
        v.setIdvehi(Integer.parseInt(request.getParameter("txtVehiculo").toUpperCase()));
        v.setIdcond(Integer.parseInt(request.getParameter("txtConductor").toUpperCase()));
        v.setSubtotal(0.00);
        v.setIgv(0.00);
        v.setTotal(0.00);
        v.setEstado("Terminado");
        ArrayList<DetalleMovimiento> detalle = (ArrayList<DetalleMovimiento>) sesion.getAttribute("cargrc");
        if (grcDAO.insertarMovimiento(v, detalle) && grcDAO.addinsersalida(v, detalle)) {
            request.getSession().removeAttribute("clienteGRC");
            request.getSession().removeAttribute("cargrc");
            String rolSesion = (String) sesion.getAttribute("tipo");
            new com.pe.DAO.AuditoriaDAO().registrar((String) sesion.getAttribute("usuario"), "Confirmación de despacho", "Logistica",
                    "GR02-" + v.getCorrelativo() + " — " + (detalle != null ? detalle.size() : 0) + " producto(s) despachados de " + v.getAlmacen());
            response.getWriter().print("oki");
        } else {
            request.getSession().removeAttribute("clienteGRC");
            request.getSession().removeAttribute("cargrc");
            response.getWriter().print("Nose realizo la venta");

        }
    }

    private void estadoanulargrc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = MovimientoDAO.estado(id);
        if (estado.equalsIgnoreCase("Terminado")) {

            grc.setEstado("Anulado");
            dgrc.setEstado("Anulado");
        } else {
            grc.setEstado("Anulado");
            dgrc.setEstado("Anulado");
        }

        grcDAO.editarEstado(grc, id);
        grcDAO.editaranulardetalle(dgrc, id);
        grcDAO.Eliminarkardex(id);
    }

    private void Limpiargrc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().removeAttribute("clienteGRC");
        request.getSession().removeAttribute("cargrc");
        response.sendRedirect("InsertarGuiaremisioncliente.jsp");
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
