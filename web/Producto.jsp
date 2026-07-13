<%@page import="com.pe.DAO.UnidadVentaDAO"%>
<%@page import="com.pe.model.entity.Producto"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Productos | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <%@include file="css-datatable.jsp"%>
        <link href="dist/css/Stilodetabla.css" rel="stylesheet" type="text/css"/>
        <link href="dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">

            <!-- Header -->
            <section class="content-header" style="padding: 18px 24px 10px;">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                                <i class="fas fa-boxes" style="color:#C8102E; margin-right:10px;"></i>
                                Administrar Productos
                            </h3>
                            <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">
                                Alicorp S.A.A. &mdash; Gesti&oacute;n de inventario
                            </p>
                        </div>
                        <a href="InsertarProducto.jsp" class="btn-nuevo-alicorp">
                            <i class="fas fa-plus"></i> Nuevo Producto
                        </a>
                    </div>
                    <!-- Breadcrumb -->
                    <nav style="margin-top:10px;">
                        <ol style="list-style:none; padding:0; margin:0; display:flex; gap:6px; font-size:12px; color:#aaa;">
                            <li><a href="DashboardAlmacen.jsp" style="color:#C8102E; text-decoration:none;">Dashboard</a></li>
                            <li style="color:#ccc;">/</li>
                            <li>Configuraci&oacute;n</li>
                            <li style="color:#ccc;">/</li>
                            <li style="color:#555;">Productos</li>
                        </ol>
                    </nav>
                </div>
            </section>

            <!-- Contenido principal -->
            <section class="content" style="padding: 0 24px 24px;">
                <div class="container-fluid">

                    <!-- Stats rápidas -->
                    <div class="row mb-3">
                        <%
                            ProductoDAO pdaoStats = new ProductoDAO();
                            List<Producto> listStats = pdaoStats.ListadoProducto();
                            int totalProductos = listStats.size();
                            int totalActivos = 0;
                            for (Producto p : listStats) {
                                if ("Activo".equalsIgnoreCase(ProductoDAO.estado(p.getIdproducto()))) totalActivos++;
                            }
                        %>
                        <div class="col-md-3 col-6 mb-2">
                            <div style="background:#fff; border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.06); border-left:4px solid #C8102E;">
                                <p style="font-size:11px; color:#888; margin:0; text-transform:uppercase; letter-spacing:0.5px;">Total Productos</p>
                                <h4 style="font-size:26px; font-weight:700; color:#1a1f2e; margin:4px 0 0;">
                                    <%= totalProductos %>
                                </h4>
                            </div>
                        </div>
                        <div class="col-md-3 col-6 mb-2">
                            <div style="background:#fff; border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.06); border-left:4px solid #2e7d32;">
                                <p style="font-size:11px; color:#888; margin:0; text-transform:uppercase; letter-spacing:0.5px;">Activos</p>
                                <h4 style="font-size:26px; font-weight:700; color:#2e7d32; margin:4px 0 0;">
                                    <%= totalActivos %>
                                </h4>
                            </div>
                        </div>
                        <div class="col-md-3 col-6 mb-2">
                            <div style="background:#fff; border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.06); border-left:4px solid #e65100;">
                                <p style="font-size:11px; color:#888; margin:0; text-transform:uppercase; letter-spacing:0.5px;">Inactivos</p>
                                <h4 style="font-size:26px; font-weight:700; color:#e65100; margin:4px 0 0;">
                                    <%= totalProductos - totalActivos %>
                                </h4>
                            </div>
                        </div>
                        <div class="col-md-3 col-6 mb-2">
                            <div style="background:#fff; border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.06); border-left:4px solid #1565c0;">
                                <p style="font-size:11px; color:#888; margin:0; text-transform:uppercase; letter-spacing:0.5px;">Alicorp S.A.A.</p>
                                <h4 style="font-size:14px; font-weight:600; color:#1565c0; margin:6px 0 0;">
                                    RUC 20100055237
                                </h4>
                            </div>
                        </div>
                    </div>

                    <!-- Tabla -->
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center gap-2">
                                <i class="fas fa-list" style="color:#C8102E; margin-right:8px;"></i>
                                <h3 class="card-title mb-0">Lista de Productos</h3>
                            </div>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <button type="button" class="btn btn-tool" data-card-widget="remove">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>

                        <div class="card-body" style="padding:20px;">
                            <table id="example" class="table table-striped table-bordered second" style="width:100%">
                                <thead>
                                    <tr>
                                        <th style="display:none;">Id</th>
                                        <th style="width:90px;">C&oacute;digo</th>
                                        <th style="width:110px;">C&oacute;d. Anexo</th>
                                        <th>Descripci&oacute;n</th>
                                        <th style="width:100px;">U. Medida</th>
                                        <th style="width:90px;">Estado</th>
                                        <th style="width:130px; text-align:center;">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% DecimalFormat df = new DecimalFormat("#.##");
                                       ProductoDAO pdao = new ProductoDAO();
                                       List<Producto> listS = pdao.ListadoProducto();
                                       Iterator<Producto> iterr = listS.iterator();
                                       Producto pro = null;
                                       while (iterr.hasNext()) {
                                           pro = iterr.next(); %>
                                    <tr>
                                        <td style="display:none;" id="idpro"><%= pro.getIdproducto() %></td>
                                        <td style="text-align:center;">
                                            <span style="font-family:monospace; font-size:12px; background:#f4f6fb; padding:2px 8px; border-radius:5px; color:#333;">
                                                <%= pro.getCodigo() %>
                                            </span>
                                        </td>
                                        <td style="text-align:center; color:#666; font-size:12px;">
                                            <%= pro.getCodigoanexo() %>
                                        </td>
                                        <td style="font-weight:500; color:#1a1f2e;">
                                            <%= pro.getDescripcion() %>
                                        </td>
                                        <td style="text-align:center; font-size:12px; color:#555;">
                                            <%= UnidadVentaDAO.getNombreUnidadventa(pro.getIduventa()) %>
                                        </td>
                                        <% String Estado = ProductoDAO.estado(pro.getIdproducto());
                                           if (Estado.equalsIgnoreCase("Activo")) { %>
                                        <td style="text-align:center;">
                                            <markactivo><%= Estado %></markactivo>
                                        </td>
                                        <% } else { %>
                                        <td style="text-align:center;">
                                            <markdesactivado><%= Estado %></markdesactivado>
                                        </td>
                                        <% } %>
                                        <td style="text-align:center;">
                                            <a href="ProductoController?accion=editar&id=<%= pro.getIdproducto() %>"
                                               class="btn-accion btn-edit" title="Editar">
                                                <i class="fas fa-pencil-alt"></i>
                                            </a>
                                            <a id="btn-estado" class="btn-accion btn-state" title="Cambiar estado">
                                                <i class="fas fa-sync-alt"></i>
                                            </a>
                                            <a href="ProductoController?accion=detalle&id=<%= pro.getIdproducto() %>"
                                               class="btn-accion btn-view" title="Ver detalle">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a id="btn-eliminar" class="btn-accion btn-del" title="Eliminar">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </section>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <%@include file="js-datatable.jsp"%>
        <script src="assets/jqueryy.js" type="text/javascript"></script>
        <script src="assets/bootstrapp.min.js" type="text/javascript"></script>
        <script src="Validacionysweetalert/Producto.js" type="text/javascript"></script>

    </body>
</html>
