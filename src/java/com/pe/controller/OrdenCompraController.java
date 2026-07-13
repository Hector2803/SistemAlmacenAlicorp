package com.pe.controller;

import com.pe.DAO.OrdenCompraDAO;
import com.pe.model.entity.DetalleOrdenCompra;
import com.pe.model.entity.OrdenCompra;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controlador del modulo de Ordenes de Compra.
 * Mismo patron (accion=...) que el resto de los controllers del proyecto.
 */
public class OrdenCompraController extends HttpServlet {

    OrdenCompraDAO ocDAO = new OrdenCompraDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }
        switch (accion) {
            case "add":
                this.add(request, response);
                break;
            case "editar":
                this.editarForm(request, response);
                break;
            case "Actualizar":
                this.actualizar(request, response);
                break;
            case "detalle":
                this.detalle(request, response);
                break;
            case "aprobar":
                this.aprobar(request, response);
                break;
            case "anular":
                this.anular(request, response);
                break;
            case "completar":
                this.completar(request, response);
                break;
            case "eliminar":
                this.eliminar(request, response);
                break;
            case "eliminarDetalle":
                this.eliminarDetalle(request, response);
                break;
            default:
                this.listar(request, response);
                break;
        }
    }

    // ── Listar (redirige a la vista de lista) ───────────────────────
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("ListarOrdenCompra.jsp").forward(request, response);
    }

    // ── Registrar nueva OC (cabecera + N detalles) ──────────────────
    // Espera parametros: Txtproveedor, Txtfechaentrega, Txtobservacion,
    // y arreglos paralelos: idproducto[], cantidad[], preciounitario[]
    private void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("usuario");

        OrdenCompra oc = new OrdenCompra();
        oc.setCodigo(ocDAO.generarCodigo());
        oc.setIdauxiliar(Integer.parseInt(request.getParameter("Txtproveedor")));
        oc.setFechaEntrega(request.getParameter("Txtfechaentrega"));
        oc.setOrigen("Manual");
        oc.setEstado("Pendiente");
        oc.setTotal(0);
        oc.setObservacion(request.getParameter("Txtobservacion"));
        oc.setIdusuario(usuario);

        int idOC = ocDAO.registrar(oc);

        if (idOC > 0) {
            String[] idsProducto = request.getParameterValues("idproducto[]");
            String[] cantidades = request.getParameterValues("cantidad[]");
            String[] precios = request.getParameterValues("preciounitario[]");

            if (idsProducto != null) {
                for (int i = 0; i < idsProducto.length; i++) {
                    DetalleOrdenCompra d = new DetalleOrdenCompra();
                    d.setIdordencompra(idOC);
                    d.setIdproducto(Integer.parseInt(idsProducto[i]));
                    double cantidad = Double.parseDouble(cantidades[i]);
                    double precio = Double.parseDouble(precios[i]);
                    d.setCantidad(cantidad);
                    d.setPrecioUnitario(precio);
                    d.setSubtotal(cantidad * precio);
                    ocDAO.registrarDetalle(d);
                }
                ocDAO.actualizarTotal(idOC);
            }
            response.getWriter().print("ok");
            new com.pe.DAO.AuditoriaDAO().registrar(usuario, "Creación de orden de compra", "Compras", "Orden " + oc.getCodigo() + " creada");
        } else {
            response.getWriter().print("error");
        }
    }

    // ── Mostrar formulario de edicion ────────────────────────────────
    private void editarForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idoc", request.getParameter("id"));
        request.getRequestDispatcher("EditarOrdenCompra.jsp").forward(request, response);
    }

    // ── Actualizar cabecera ──────────────────────────────────────────
    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        OrdenCompra oc = new OrdenCompra();
        oc.setIdordencompra(Integer.parseInt(request.getParameter("txtid")));
        oc.setIdauxiliar(Integer.parseInt(request.getParameter("Txtproveedor")));
        oc.setFechaEntrega(request.getParameter("Txtfechaentrega"));
        oc.setObservacion(request.getParameter("Txtobservacion"));

        if (ocDAO.editar(oc)) {
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("error");
        }
    }

    // ── Ver detalle de una OC ─────────────────────────────────────────
    private void detalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idoc", request.getParameter("id"));
        request.getRequestDispatcher("DetalleOrdenCompra.jsp").forward(request, response);
    }

    // ── Aprobar OC ──────────────────────────────────────────────────────
    private void aprobar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String usuario = (String) request.getSession().getAttribute("usuario");
        if (ocDAO.aprobar(id, usuario)) {
            response.getWriter().print("ok");
            new com.pe.DAO.AuditoriaDAO().registrar(usuario, "Aprobación de orden de compra", "Compras", "Orden id " + id + " aprobada");
        } else {
            response.getWriter().print("error");
        }
    }

    // ── Anular OC ────────────────────────────────────────────────────────
    private void anular(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String usuario = (String) request.getSession().getAttribute("usuario");
        if (ocDAO.anular(id, usuario)) {
            response.getWriter().print("ok");
            new com.pe.DAO.AuditoriaDAO().registrar(usuario, "Anulación de orden de compra", "Compras", "Orden id " + id + " anulada");
        } else {
            response.getWriter().print("error");
        }
    }

    // ── Completar OC (mercaderia recibida) ────────────────────────────────
    private void completar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String usuario = (String) request.getSession().getAttribute("usuario");
        if (ocDAO.completar(id, usuario)) {
            response.getWriter().print("ok");
            new com.pe.DAO.AuditoriaDAO().registrar(usuario, "Habilitación en almacén", "Compras", "Orden id " + id + " completada: stock actualizado");
        } else {
            response.getWriter().print("error");
        }
    }

    // ── Eliminar OC (solo si esta Pendiente) ──────────────────────────────
    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        if (ocDAO.eliminar(id)) {
            response.getWriter().print("ok");
        } else {
            response.getWriter().print("notiene");
        }
    }

    // ── Eliminar un producto del detalle ──────────────────────────────────
    private void eliminarDetalle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int iddetalle = Integer.parseInt(request.getParameter("iddetalle"));
        int idoc = Integer.parseInt(request.getParameter("idoc"));
        ocDAO.eliminarDetalle(iddetalle);
        ocDAO.actualizarTotal(idoc);
        response.getWriter().print("ok");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controlador del modulo Orden de Compra - Alicorp";
    }
}
