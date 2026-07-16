/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pe.controller;

import com.pe.DAO.ProductoDAO;
import com.pe.model.entity.Producto;
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
public class ProductoController extends HttpServlet {

    int id;
    Producto p = new Producto();
    ProductoDAO pdao = new ProductoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        // NUEVO: validación AJAX del producto por nombre (botón "Validar producto").
        // Devuelve el código existente si ya está registrado, o "NUEVO" si no existe.
        if ("validarNombre".equals(accion)) {
            String desc = request.getParameter("descripcion");
            String cod = new com.pe.DAO.ProductoDAO().buscarCodigoPorNombre(desc);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().print(cod != null ? cod : "NUEVO");
            return;
        }

        if (accion.equals("add")) {
            this.add(request, response);
        }
        if (accion.equals("editar")) {
            this.Editar(request, response);
        }
        if (accion.equals("actualizar")) {
            this.Edit(request, response);
        }
        if (accion.equals("detalle")) {
            this.Detalle(request, response);
        }
        if (accion.equals("Editarstockminmax")) {
            this.Editarstockminmax(request, response);
        }
        if (accion.equals("eliminar")) {
            this.eliminar(request, response);
        }
        if (accion.equals("estado")) {
            this.estado(request, response);
        }

    }

    private void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Producto p = new Producto();
        String codigo = request.getParameter("Txtcodigo");
        String descripcion = request.getParameter("Txtdescripcion");
        int clasi = Integer.parseInt(request.getParameter("Txtmarca"));
        int categoria = Integer.parseInt(request.getParameter("Txtcategoria"));
        int subc = Integer.parseInt(request.getParameter("TxtIdpublico"));
        int unidadv = Integer.parseInt(request.getParameter("Txtunidadv"));
        int proveedor = Integer.parseInt(request.getParameter("Txtproveedor"));
        String Codanexo = request.getParameter("Txtcodanexo");
        double pcompra = Double.parseDouble(request.getParameter("Txtpcompra"));
        double pventa = Double.parseDouble(request.getParameter("Txtpventa"));
        String fecha = request.getParameter("Txtfechaderegistro");
        String obser = request.getParameter("Txtobser");

        p.setCodigo(codigo);
        p.setDescripcion(descripcion);
        p.setIdclasi(clasi);
        p.setIdcategoria(categoria);
        p.setIdsubc(subc);
        p.setIdauxiliar(proveedor);
        p.setIduventa(unidadv);
        p.setMoneda("Soles");
        p.setCodigoanexo(Codanexo);
        p.setPreciocompra(pcompra);
        p.setPrecioVenta(pventa);
        p.setFechaRegistro(fecha);
        p.setObser(obser);
        p.setStock(0.00);
        p.setStockminimo(0.00);
        p.setStockmaximo(0.00);
        p.setEstado("Activo");
        ProductoDAO prodao = new ProductoDAO();
        boolean validacion = false;
        validacion = prodao.validacion(Codanexo);
        if (validacion == true) {
            response.getWriter().print("yaexiste");
        } else {
            if (prodao.add(p)) {
                javax.servlet.http.HttpSession sesProd1 = request.getSession(false);
                String actorProd1 = sesProd1 != null ? (String) sesProd1.getAttribute("usuario") : "";
                new com.pe.DAO.AuditoriaDAO().registrar(actorProd1, "Creación de producto", "Productos",
                        "Producto " + descripcion + " creado");
                response.getWriter().print("ok");

            } else {
                response.getWriter().print("no ha sido registrado correctamente");

            }
        }
    }

    private void Editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idpro", request.getParameter("id"));
        request.getRequestDispatcher("EditarProducto.jsp").forward(
                request, response);
    }

    private void Detalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idpro", request.getParameter("id"));
        request.getRequestDispatcher("DetalleProducto.jsp").forward(
                request, response);
    }

    private void Edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
        String codigo = request.getParameter("Txtcodigo");
        String descripcion = request.getParameter("Txtdescripcion");
        int clasi = Integer.parseInt(request.getParameter("Txtmarca"));
        int categoria = Integer.parseInt(request.getParameter("Txtcategoria"));
        int subc = Integer.parseInt(request.getParameter("TxtIdpublico"));
        int unidadv = Integer.parseInt(request.getParameter("Txtunidadv"));
        String Codanexo = request.getParameter("Txtcodanexo");
        String pcompra = request.getParameter("Txtpcompra");
        String pventa = request.getParameter("Txtpventa");
        String fecha = request.getParameter("Txtfechaderegistro");
        String observ = request.getParameter("Txtobser");

        p.setIdproducto(id);
        p.setCodigo(codigo);
        p.setDescripcion(descripcion);
        p.setIdclasi(clasi);
        p.setIdcategoria(categoria);
        p.setIdsubc(subc);
        p.setIdauxiliar(1);
        p.setIduventa(unidadv);
        p.setMoneda("Soles");
        p.setCodigoanexo(Codanexo);
        p.setPreciocompra(Float.parseFloat(pcompra));
        p.setPrecioVenta(Float.parseFloat(pventa));
        p.setFechaRegistro(fecha);
        p.setObser(observ);
        if (pdao.Edit(p)) {
            javax.servlet.http.HttpSession sesProd2 = request.getSession(false);
            String actorProd2 = sesProd2 != null ? (String) sesProd2.getAttribute("usuario") : "";
            new com.pe.DAO.AuditoriaDAO().registrar(actorProd2, "Edición de producto", "Productos",
                    "Producto " + descripcion + " editado");
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("El producto no ha sido registrado correctamente");
        }
    }

    private void Editarstockminmax(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
        String codigo = request.getParameter("Txtcodigo");
        String descripcion = request.getParameter("Txtdescripcion");
        String pcompra = request.getParameter("Txtpcompra");
        String pventa = request.getParameter("Txtpventa");
        p.setIdproducto(id);
        p.setCodigo(codigo);
        p.setDescripcion(descripcion);
        p.setStockminimo(Float.parseFloat(pcompra));
        p.setStockmaximo(Float.parseFloat(pventa));
        if (pdao.Editstockminmax(p)) {
            javax.servlet.http.HttpSession sesStock = request.getSession(false);
            String actorStock = sesStock != null ? (String) sesStock.getAttribute("usuario") : "";
            new com.pe.DAO.AuditoriaDAO().registrar(actorStock, "Actualización de stock mín/máx", "Productos",
                    descripcion + " — mínimo: " + pcompra + ", máximo: " + pventa);
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("El producto no ha sido registrado correctamente");
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idPro"));
        String nombreProdBorrar = ProductoDAO.getProducto(id);
        pdao.Eliminar(id);
        javax.servlet.http.HttpSession sesElim = request.getSession(false);
        String actorElim = sesElim != null ? (String) sesElim.getAttribute("usuario") : "";
        new com.pe.DAO.AuditoriaDAO().registrar(actorElim, "Eliminación de producto", "Productos",
                (nombreProdBorrar != null ? nombreProdBorrar : ("id " + id)) + " eliminado");
        ProductoDAO clidao = new ProductoDAO();
        
        boolean validacion = false;
        validacion = clidao.Yatienemovimiento(id);
        if (validacion == true) {
            response.getWriter().print("tienemovi");
        }
    }

    private void estado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        p.setIdproducto(id);

        String estado = ProductoDAO.estado(id);
        String estadoo = ProductoDAO.estadoalmacenp(id);
        String estadoNuevo;
        if (estado.equalsIgnoreCase("Activo")) {
            estadoNuevo = "Desactivado";
        } else {
            estadoNuevo = "Activo";
        }
        p.setEstado(estadoNuevo);
        pdao.editEstado(p, id);

        javax.servlet.http.HttpSession sesEstado = request.getSession(false);
        String actorEstado = sesEstado != null ? (String) sesEstado.getAttribute("usuario") : "";
        String nombreProd = ProductoDAO.getProducto(id);
        new com.pe.DAO.AuditoriaDAO().registrar(actorEstado, "Cambio de estado de producto", "Productos",
                (nombreProd != null ? nombreProd : ("id " + id)) + " cambiado a " + estadoNuevo);
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
