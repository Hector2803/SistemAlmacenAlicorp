package com.pe.controller;

import com.pe.DAO.AuxiliarDAO;
import com.pe.model.entity.Auxiliar;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yenny
 */
public class ProveedorController extends HttpServlet {

    int id;
    AuxiliarDAO proveedao = new AuxiliarDAO();
    Auxiliar provee = new Auxiliar();
    AuxiliarDAO auxiDAO;
    DecimalFormat formateadorproveedor;
    ArrayList<String> listaErrores = new ArrayList<>();

    public ProveedorController() {
        auxiDAO = new AuxiliarDAO();
        formateadorproveedor = new DecimalFormat("000000");
    }

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
        if (accion.equals("detalle")) {
            this.Detalle(request, response);
        }
        if (accion.equals("eliminar")) {
            this.eliminar(request, response);
        }
        if (accion.equals("Estado")) {
            this.Estado(request, response);
        }

        if (accion.equals("buscarPorIdNI")) {
            this.BuscarPorId(request, response);
        }
          if (accion.equals("buscarPorIdROC")) {
            this.BuscarPorROC(request, response);
        }
        if (accion.equals("buscarPorIdOC")) {
            this.BuscarPorIdOC(request, response);
        }
        if (accion.equals("buscarPorIdREQ")) {
            this.BuscarPorIdREQ(request, response);
        }
    }

    private void BuscarPorId(HttpServletRequest request, HttpServletResponse response)
            throws IOException, IOException {

        int codigo = Integer.parseInt(request.getParameter("idProveedorNI"));
        AuxiliarDAO pdao = new AuxiliarDAO();

        Auxiliar obj = pdao.BuscarPorId(codigo);

        request.getSession().setAttribute("proveedorNI", obj);

        response.sendRedirect("InsertarNotadeIngreso.jsp");

    }
    private void BuscarPorROC(HttpServletRequest request, HttpServletResponse response)
            throws IOException, IOException {

        int codigo = Integer.parseInt(request.getParameter("idProveedorROC"));
        AuxiliarDAO pdao = new AuxiliarDAO();

        Auxiliar obj = pdao.BuscarPorId(codigo);

        request.getSession().setAttribute("proveedorROC", obj);

        response.sendRedirect("RefInsertarOrdencompradesdeRQ.jsp");

    }
    private void BuscarPorIdOC(HttpServletRequest request, HttpServletResponse response)
            throws IOException, IOException {

        int codigo = Integer.parseInt(request.getParameter("idProveedorOC"));
        AuxiliarDAO pdao = new AuxiliarDAO();

        Auxiliar obj = pdao.BuscarPorId(codigo);

        request.getSession().setAttribute("proveedorOC", obj);

        response.sendRedirect("InsertarOrdendeCompra.jsp");

    }

    private void BuscarPorIdREQ(HttpServletRequest request, HttpServletResponse response)
            throws IOException, IOException {

        int codigo = Integer.parseInt(request.getParameter("idProveedorREQ"));
        AuxiliarDAO pdao = new AuxiliarDAO();

        Auxiliar obj = pdao.BuscarPorId(codigo);

        request.getSession().setAttribute("proveedorREQ", obj);

        response.sendRedirect("InsertarRequerimiento.jsp");

    }

    private void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Auxiliar cli = new Auxiliar();
        String cliente = request.getParameter("Txtapellidos");
        String correo = request.getParameter("Txtcorreo");
        String telefono = request.getParameter("Txttelefono");
        String celular = request.getParameter("Txtcelular");
        String direccion = request.getParameter("Txtdireccion");
        String Contacto = request.getParameter("Txtcontacto");
        String fechaderegistro = request.getParameter("Txtfechaderegistro");
        String numerodocumento = request.getParameter("Txtnumerodocumento");
        cli.setTipoauxi("P");
        int Nproveedor = auxiDAO.BuscarNproveedor();
        Nproveedor = Nproveedor + 1;
        String format = formateadorproveedor.format(Nproveedor);
        cli.setCodigo(format);
        cli.setNombre(cliente);
        cli.setTelefono(telefono);
        cli.setCorreo(correo);
        cli.setCelular(celular);
        cli.setDireccion(direccion);
        cli.setContacto(Contacto);
        cli.setFechaderegistro(fechaderegistro);
        // Un proveedor es una empresa: siempre se identifica con RUC (Idtipodocumento=4), no se pide en el formulario.
        cli.setIdtipodocumento(4);
        cli.setNumerodocumento(numerodocumento);
        // Género no aplica a una empresa.
        cli.setSexo("");
        cli.setEstado("Activo");
        AuxiliarDAO clidao = new AuxiliarDAO();
        boolean validacion = false;
        validacion = clidao.validacionprove(cli);
        if (validacion == true) {
            response.getWriter().print("yaexiste");
        } else {
            if (clidao.add(cli)) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("no ha sido registrado correctamente");

            }
        }
    }

    private void Edit(HttpServletRequest request, HttpServletResponse response)
            throws IOException, IOException {
        id = Integer.parseInt(request.getParameter("txtid"));
        String Tipoauxi = request.getParameter("txtTipoauxi");
        String codigo = request.getParameter("Txtcodigo");
        String cliente = request.getParameter("Txtapellidos");
        String correo = request.getParameter("Txtcorreo");
        String telefono = request.getParameter("Txttelefono");
        String celular = request.getParameter("Txtcelular");
        String direccion = request.getParameter("Txtdireccion");
        String Contaco = request.getParameter("Txtcontacto");
        String fechaderegistro = request.getParameter("Txtfechaderegistro");
        String numerodocumento = request.getParameter("Txtnumerodocumento");
        provee.setIdauxiliar(id);
        provee.setTipoauxi(Tipoauxi);
        provee.setCodigo(codigo);
        provee.setNombre(cliente);
        provee.setCorreo(correo);
        provee.setTelefono(telefono);
        provee.setCelular(celular);
        provee.setDireccion(direccion);
        provee.setContacto(Contaco);
        provee.setFechaderegistro(fechaderegistro);
        // Un proveedor es una empresa: siempre RUC, sin género.
        provee.setIdtipodocumento(4);
        provee.setNumerodocumento(numerodocumento);
        provee.setSexo("");

        if (proveedao.Edit(provee)) {
            response.getWriter().print("ok");

        } else {
            response.getWriter().print("El cliente no ha sido registrado");

        }
    }

    private void Editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idprove", request.getParameter("id"));
        request.getRequestDispatcher("EditarProveedores.jsp").forward(
                request, response);
    }

    private void Detalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("idprove", request.getParameter("id"));
        request.getRequestDispatcher("DetalleProveedor.jsp").forward(
                request, response);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("idprove"));
        proveedao.Eliminar(id);

        AuxiliarDAO clidao = new AuxiliarDAO();
        boolean validacion = false;
        validacion = clidao.Yatienemovimiento(id);
        if (validacion == true) {
            response.getWriter().print("tienemovi");
        }
    }

    private void Estado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        id = Integer.parseInt(request.getParameter("id"));
        provee.setIdauxiliar(id);
        String estado = AuxiliarDAO.estado(id);
        String estadoNuevo;
        if (estado.equalsIgnoreCase("Activo")) {
            estadoNuevo = "Desactivado";
        } else {
            estadoNuevo = "Activo";
        }
        provee.setEstado(estadoNuevo);

        proveedao.editEstado(provee, id);

        javax.servlet.http.HttpSession sesEstadoProv = request.getSession(false);
        String actorEstadoProv = sesEstadoProv != null ? (String) sesEstadoProv.getAttribute("usuario") : "";
        new com.pe.DAO.AuditoriaDAO().registrar(actorEstadoProv, "Cambio de estado de proveedor", "Logistica",
                "Proveedor id " + id + " cambiado a " + estadoNuevo);
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
