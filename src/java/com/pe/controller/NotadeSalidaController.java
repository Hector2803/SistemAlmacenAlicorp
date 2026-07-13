/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
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
public class NotadeSalidaController extends HttpServlet {

    MovimientoDAO nsdao = new MovimientoDAO();
    int id;
    MovimientoDAO nsDAO;
    // venta
    String nscomprobante;
    String numnscomprobante;
    // detalle _detalle
    int Nns;
    DecimalFormat formateadorns;
    Movimiento ni = new Movimiento();
    DetalleMovimiento dni = new DetalleMovimiento();

    public NotadeSalidaController() {
        nsDAO = new MovimientoDAO();
        formateadorns = new DecimalFormat("00000000");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion.equalsIgnoreCase("procesarCarritons")) {
            this.procesarCarritons(request, response);
        }
        if (accion.equals("AnadirCarritons")) {
            this.anadirCarritons(request, response);
        }
        if (accion.equals("actualizarcantidadns")) {
            this.actualizarcantidadns(request, response);
        }
        if (accion.equals("Registrarnotadesalida")) {
            this.Registrarnotadesalida(request, response);
        }
        if (accion.equals("estadoanularns")) {
            this.estadoanularns(request, response);
        }
        if (accion.equals("Limpiarns")) {
            this.Limpiarns(request, response);
        }
    }

    private void procesarCarritons(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        ArrayList<DetalleMovimiento> carns;//
        if (sesion.getAttribute("carns") == null) {
            carns = new ArrayList<DetalleMovimiento>();

        } else {
            carns = (ArrayList<DetalleMovimiento>) sesion.getAttribute("carns");
        }
        if (carns.size() > 0) {
            for (int i = 0; i < carns.size(); i++) {

                DetalleMovimiento det = carns.get(i);
                // subtotal+= det.subtotal();
            }
            //Compra
            //insert into compra values(numero_serie , idProveedor , idTRabjador , fecha , impuesto , subtotal , (subtotal + (subtotal * impuesto)));
            //Detalle
            for (int i = 0; i < carns.size(); i++) {

                DetalleMovimiento det = carns.get(i);
                // insert into DetalleMovimiento values(null , det.getProducto.getIdproducto() , numero_serie ,det.getCantidad(),det.getPrecioCompra , det.getPrecioVenta );
            }
        } else {
            //Validar si esta vacio
        }
        sesion.setAttribute("carns", carns);
        response.sendRedirect("InsertarNotadeSalida.jsp");
    }

    private void anadirCarritons(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        double subtotal;
        HttpSession sesion = request.getSession();//
        ArrayList<DetalleMovimiento> carns;//
        if (sesion.getAttribute("carns") == null) {
            carns = new ArrayList<DetalleMovimiento>();
        } else {
            carns = (ArrayList<DetalleMovimiento>) sesion.getAttribute("carns");
        }
        Producto p = ProductoDAO.obtenerProducto(Integer.parseInt(request.getParameter("txtPro_id")));
        DetalleMovimiento d = new DetalleMovimiento();
        d.setIdproducto(Integer.parseInt(request.getParameter("txtPro_id")));
        d.setProducto(p);
        d.setCantidad(Double.parseDouble(request.getParameter("txtPro_cantidad")));
        double SaldoS = p.getStock() - d.getCantidad();
        d.setSaldo(SaldoS);
        boolean indice = false;
        for (int i = 0; i < carns.size(); i++) {
            DetalleMovimiento det = carns.get(i);
            if (det.getIdproducto() == p.getIdproducto()) {
                // det.setCantidad(det.getCantidad()+ d.getCantidad());//auto incrementar cantidad
                // det.setDet_com_descuento(d.getDet_com_descuento()*det.getDet_com_cantidad());
                indice = true;
                break;
            }
        }
        if (!indice) {
            carns.add(d);
        }
        sesion.setAttribute("carns", carns);
        response.sendRedirect("InsertarNotadeSalida.jsp");
    }

    private void actualizarcantidadns(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        ArrayList<DetalleMovimiento> carns;//
        if (sesion.getAttribute("carns") == null) {
            carns = new ArrayList<DetalleMovimiento>();
        } else {
            carns = (ArrayList<DetalleMovimiento>) sesion.getAttribute("carns");
        }
        Double cantidad = Double.parseDouble(request.getParameter("cantns"));
        int fila = Integer.parseInt(request.getParameter("idproductons"));
        DetalleMovimiento det = carns.get(fila);
        det.setCantidad(cantidad);
        double SaldoS = det.getProducto().getStock() - det.getCantidad();
        det.setSaldo(SaldoS);
        carns.set(fila, det);
        sesion.setAttribute("carns", carns);
        response.sendRedirect("InsertarNotadeSalida.jsp");
    }

    private void Registrarnotadesalida(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        Movimiento v = new Movimiento();
        v.setIdauxiliar(Integer.parseInt(request.getParameter("txtIdcli").toUpperCase()));
        // Se usa el usuario realmente logueado (antes estaba fijo en 1, lo que rompía el registro
        // si ese usuario ya no existe en la base de datos).
        com.pe.model.entity.Usuario usuarioSesion = com.pe.DAO.UsuarioDAO.listimgPorEmail((String) sesion.getAttribute("usuario"));
        v.setIdusuario(usuarioSesion != null && usuarioSesion.getId() != 0 ? usuarioSesion.getId() : 1);
        v.setTipocomprobante(request.getParameter("txtTipodoc").toUpperCase());
        v.setSerie("NS01");
        int Nnspt = nsDAO.BuscarNnotasalidamp();
        Nnspt = Nnspt + 1;
        String format = formateadorns.format(Nnspt);
        v.setCorrelativo(format);
        v.setFecha(new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()).toUpperCase());
        v.setFechaentrega("");
        v.setReferencia("");
        v.setTienda(request.getParameter("txtTienda").toUpperCase());
        v.setAlmacen(request.getParameter("txtAlmacen").toUpperCase());
        v.setCondicion(request.getParameter("txtCondicion").toUpperCase());
        v.setIdmotivo(Integer.parseInt(request.getParameter("txtMotivo").toUpperCase()));
        v.setIdtrans(1);
        v.setIdvehi(1);
        v.setIdcond(1);
        v.setSubtotal(0.00);
        v.setIgv(0.00);
        v.setTotal(0.00);
        v.setEstado("Terminado");
        ArrayList<DetalleMovimiento> detalle = (ArrayList<DetalleMovimiento>) sesion.getAttribute("carns");
        if (nsDAO.insertarMovimiento(v, detalle) && nsDAO.addinsersalida(v, detalle)) {
            request.getSession().removeAttribute("clienteNS");
            request.getSession().removeAttribute("carns");
            String rolSesion = (String) sesion.getAttribute("tipo");
            new com.pe.DAO.AuditoriaDAO().registrar((String) sesion.getAttribute("usuario"), "Salida de inventario", "Logistica",
                    "NS01-" + v.getCorrelativo() + " — " + (detalle != null ? detalle.size() : 0) + " producto(s) despachados de " + v.getAlmacen());
            response.getWriter().print("oki");
        } else {
            request.getSession().removeAttribute("clienteNS");
            request.getSession().removeAttribute("carns");
            response.getWriter().print("Nose realizo la venta");

        }
    }

    private void estadoanularns(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        String estado = MovimientoDAO.estado(id);
        if (estado.equalsIgnoreCase("Terminado")) {

            ni.setEstado("Anulado");
            dni.setEstado("Anulado");
        } else {
            ni.setEstado("Anulado");
            dni.setEstado("Anulado");
        }

        nsDAO.editarEstado(ni, id);
        nsDAO.editaranulardetalle(dni, id);
        nsDAO.Eliminarkardex(id);

    }

    private void Limpiarns(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().removeAttribute("clienteNS");
        request.getSession().removeAttribute("carns");
        response.sendRedirect("InsertarNotadeSalida.jsp");
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
