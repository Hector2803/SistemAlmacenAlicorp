<%@page import="com.pe.DAO.EmpresaDAO"%>
<%@page import="com.pe.DAO.UsuarioDAO"%>
<%@page import="com.pe.model.entity.Usuario"%>
<%
    HttpSession sesion = request.getSession();
    if (sesion.getAttribute("tipo") == null) {
        response.sendRedirect("login.jsp");
    } else {
        String tipo = sesion.getAttribute("tipo").toString();
        if (!tipo.equals("Administrador") & !tipo.equals("Compra") & !tipo.equals("Almacen") & !tipo.equals("Venta")
                & !tipo.equals("Supervisor") & !tipo.equals("Logistico")) {
            response.sendRedirect("login.jsp");
        }
    }
%>
<%
    String codigo = (String) sesion.getAttribute("usuario");
    Usuario usu = UsuarioDAO.listimgPorEmail(codigo);
    String cliente = usu.getFilename1();
%>

<style>
/* ── Navbar top ── */
.main-header.navbar {
    background: #ffffff !important;
    border-bottom: 1px solid #e8e8e8 !important;
    box-shadow: 0 1px 6px rgba(0,0,0,0.06) !important;
}
.main-header .nav-link {
    color: #555 !important;
}
.main-header .nav-link:hover {
    color: #C8102E !important;
}

/* ── Sidebar base ── */
.main-sidebar {
    background: #1a1f2e !important;
    box-shadow: 2px 0 12px rgba(0,0,0,0.15) !important;
}

/* ── Brand / logo area ── */
.brand-link {
    background: #C8102E !important;
    border-bottom: none !important;
    padding: 14px 16px !important;
    display: flex !important;
    align-items: center !important;
    gap: 10px !important;
}
.brand-link:hover {
    background: #a50d25 !important;
}
.alicorp-brand {
    display: flex;
    align-items: center;
    gap: 6px;
}
.alicorp-brand-text {
    font-size: 24px;
    font-weight: 700;
    color: #ffffff;
    letter-spacing: -0.3px;
    line-height: 1;
    font-family: 'Source Sans Pro', sans-serif;
}
.alicorp-brand-text .letter-a {
    position: relative;
    display: inline-block;
}
.alicorp-brand-text .leaf {
    display: inline-block;
    width: 8px;
    height: 8px;
    background: #4CAF50;
    border-radius: 50% 50% 0 50%;
    transform: rotate(-40deg);
    position: absolute;
    top: -1px;
    left: 1px;
}
.brand-sub {
    font-size: 10px;
    color: rgba(255,255,255,0.65);
    font-family: 'Source Sans Pro', sans-serif;
    line-height: 1.2;
    margin-top: 2px;
}

/* ── User panel ── */
.user-panel {
    background: rgba(255,255,255,0.04) !important;
    border-bottom: 1px solid rgba(255,255,255,0.07) !important;
    padding: 14px 16px !important;
    margin: 0 !important;
}
.user-panel .image img {
    width: 36px !important;
    height: 36px !important;
    border: 2px solid #C8102E !important;
}
.user-panel .info a {
    color: #e8e8e8 !important;
    font-size: 13px !important;
    font-weight: 500 !important;
}
.user-role-badge {
    display: inline-block;
    font-size: 10px;
    background: rgba(200,16,46,0.25);
    color: #ff8a9a;
    border-radius: 4px;
    padding: 1px 6px;
    margin-top: 2px;
}

/* ── Nav section headers ── */
.nav-header-custom {
    padding: 18px 16px 6px !important;
    font-size: 10px !important;
    font-weight: 600 !important;
    letter-spacing: 1px !important;
    color: rgba(255,255,255,0.30) !important;
    text-transform: uppercase !important;
    font-family: 'Source Sans Pro', sans-serif;
}

/* ── Nav items ── */
.nav-sidebar .nav-item > .nav-link {
    color: rgba(255,255,255,0.65) !important;
    border-radius: 8px !important;
    margin: 1px 8px !important;
    padding: 9px 12px !important;
    font-size: 13px !important;
    transition: background 0.15s, color 0.15s !important;
}
.nav-sidebar .nav-item > .nav-link:hover {
    background: rgba(255,255,255,0.07) !important;
    color: #ffffff !important;
}
.nav-sidebar .nav-item > .nav-link.active {
    background: #C8102E !important;
    color: #ffffff !important;
}
.nav-sidebar .nav-item > .nav-link .nav-icon {
    color: rgba(255,255,255,0.40) !important;
    font-size: 15px !important;
    width: 20px !important;
    margin-right: 8px !important;
}
.nav-sidebar .nav-item > .nav-link:hover .nav-icon,
.nav-sidebar .nav-item > .nav-link.active .nav-icon {
    color: #ffffff !important;
}

/* ── Submenu items (treeview) ── */
.nav-treeview .nav-link {
    color: rgba(255,255,255,0.45) !important;
    font-size: 12.5px !important;
    padding: 7px 12px 7px 36px !important;
    border-radius: 6px !important;
    margin: 1px 8px !important;
    transition: background 0.15s, color 0.15s !important;
}
.nav-treeview .nav-link:hover {
    background: rgba(255,255,255,0.06) !important;
    color: #ffffff !important;
}
.nav-treeview .nav-link .nav-icon {
    font-size: 6px !important;
    color: rgba(255,255,255,0.25) !important;
    margin-right: 8px !important;
}
.nav-treeview .nav-link:hover .nav-icon {
    color: #C8102E !important;
}

/* Sub-sub menu (reportes) */
.nav-treeview .nav-treeview .nav-link {
    padding-left: 52px !important;
    font-size: 12px !important;
    color: rgba(255,255,255,0.35) !important;
}
.nav-treeview .nav-treeview .nav-link:hover {
    color: #ffffff !important;
    background: rgba(200,16,46,0.12) !important;
}

/* ── Sidebar divider ── */
.sidebar-divider {
    border-top: 1px solid rgba(255,255,255,0.07);
    margin: 8px 16px;
}

/* ── Content wrapper mejoras ── */
.content-wrapper {
    background: #f4f6fb !important;
}
.content-header h3 {
    font-size: 20px !important;
    font-weight: 600 !important;
    color: #1a1f2e !important;
}

/* ── Cards mejoradas ── */
.card {
    border: none !important;
    border-radius: 12px !important;
    box-shadow: 0 2px 12px rgba(0,0,0,0.07) !important;
}
.card-header {
    background: #ffffff !important;
    border-bottom: 1px solid #f0f0f0 !important;
    border-radius: 12px 12px 0 0 !important;
    padding: 14px 20px !important;
}
.card-header .card-title {
    font-size: 13px !important;
    font-weight: 600 !important;
    color: #555 !important;
    letter-spacing: 0.5px !important;
    text-transform: uppercase !important;
}

/* ── Boton NUEVO ── */
.btn-nuevo-alicorp {
    background: #C8102E !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 8px !important;
    padding: 8px 18px !important;
    font-size: 13px !important;
    font-weight: 500 !important;
    display: inline-flex !important;
    align-items: center !important;
    gap: 6px !important;
    text-decoration: none !important;
    transition: background 0.15s !important;
}
.btn-nuevo-alicorp:hover {
    background: #a50d25 !important;
    color: #ffffff !important;
    text-decoration: none !important;
}

/* ── Tabla mejorada ── */
.table thead th {
    background: #f8f9fc !important;
    color: #666 !important;
    font-size: 11px !important;
    font-weight: 600 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.5px !important;
    border-bottom: 2px solid #e8e8e8 !important;
    padding: 12px 14px !important;
}
.table tbody td {
    font-size: 13px !important;
    color: #333 !important;
    padding: 11px 14px !important;
    vertical-align: middle !important;
    border-bottom: 1px solid #f2f2f2 !important;
}
.table tbody tr:hover td {
    background: #fef5f6 !important;
}

/* ── Badges de estado ── */
markactivo {
    display: inline-block;
    background: #e8f5e9;
    color: #2e7d32;
    font-size: 11px;
    font-weight: 600;
    padding: 3px 10px;
    border-radius: 20px;
    letter-spacing: 0.3px;
}
markdesactivado {
    display: inline-block;
    background: #fce4e4;
    color: #c62828;
    font-size: 11px;
    font-weight: 600;
    padding: 3px 10px;
    border-radius: 20px;
    letter-spacing: 0.3px;
}

/* ── Botones de acción en tabla ── */
.btn-accion {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 30px;
    height: 30px;
    border-radius: 6px;
    font-size: 13px;
    border: none;
    cursor: pointer;
    transition: opacity 0.15s, transform 0.1s;
    text-decoration: none;
}
.btn-accion:hover { opacity: 0.82; transform: scale(1.05); text-decoration: none; }
.btn-edit  { background: #fff3e0; color: #e65100; }
.btn-state { background: #e3f2fd; color: #1565c0; }
.btn-view  { background: #e8f5e9; color: #2e7d32; }
.btn-del   { background: #fce4e4; color: #c62828; }

/* ── DataTables overrides ── */
.dataTables_wrapper .dataTables_filter input {
    border: 1.5px solid #e0e0e0 !important;
    border-radius: 8px !important;
    padding: 5px 12px !important;
    font-size: 13px !important;
}
.dataTables_wrapper .dataTables_filter input:focus {
    border-color: #C8102E !important;
    outline: none !important;
}
.dataTables_wrapper .dt-buttons .dt-button {
    background: #f4f6fb !important;
    border: 1px solid #e0e0e0 !important;
    color: #555 !important;
    border-radius: 6px !important;
    font-size: 12px !important;
    padding: 5px 12px !important;
    margin-right: 4px !important;
}
.dataTables_wrapper .dt-buttons .dt-button:hover {
    background: #e8e8e8 !important;
}
.paginate_button.current, .paginate_button.current:hover {
    background: #C8102E !important;
    color: #fff !important;
    border: none !important;
    border-radius: 6px !important;
}
.paginate_button:hover {
    background: #f0f0f0 !important;
    border-radius: 6px !important;
}
</style>

<!-- Navbar -->
<div class="main-header navbar navbar-expand navbar-white navbar-light">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button">
                <i class="fas fa-bars"></i>
            </a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="DashboardAlmacen.jsp" class="nav-link" style="color:#C8102E; font-weight:600; font-size:13px;">
                <i class="fas fa-warehouse" style="margin-right:5px;"></i> Sistema de Almac&eacute;n
            </a>
        </li>
    </ul>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item">
            <a class="nav-link" data-widget="fullscreen" href="#" role="button" title="Pantalla completa">
                <i class="fas fa-expand-arrows-alt"></i>
            </a>
        </li>
        <% if ("Administrador".equalsIgnoreCase(sesion.getAttribute("tipo") != null ? sesion.getAttribute("tipo").toString() : "")) {
               com.pe.DAO.NotificacionAdminDAO notifDAO = new com.pe.DAO.NotificacionAdminDAO();
               int noLeidas = notifDAO.contarNoLeidas();
               java.util.List<com.pe.model.entity.NotificacionAdmin> notificaciones = notifDAO.listarUltimas(10);
        %>
        <li class="nav-item dropdown">
            <a class="nav-link" id="campanaNotif" data-toggle="dropdown" href="#" title="Notificaciones" style="position:relative;" onclick="marcarNotificacionesLeidas()">
                <i class="fas fa-bell" style="color:<%= noLeidas > 0 ? "#C8102E" : "#888" %>;"></i>
                <% if (noLeidas > 0) { %>
                <span id="badgeNotif" style="position:absolute; top:2px; right:2px; background:#C8102E; color:#fff; border-radius:50%; width:16px; height:16px; font-size:10px; display:flex; align-items:center; justify-content:center; font-weight:700;"><%= noLeidas %></span>
                <% } %>
            </a>
            <div class="dropdown-menu dropdown-menu-right" style="min-width:340px; max-height:420px; overflow-y:auto; padding:0; border:none; box-shadow:0 6px 24px rgba(0,0,0,.15); border-radius:10px; overflow-x:hidden;">
                <div style="background:#C8102E; color:#fff; padding:10px 16px; font-size:12.5px; font-weight:600; position:sticky; top:0;">
                    <i class="fas fa-bell"></i> Notificaciones
                </div>
                <% if (notificaciones.isEmpty()) { %>
                <div style="padding:16px; font-size:12.5px; color:#999; text-align:center;">Sin notificaciones por ahora.</div>
                <% } else {
                       for (com.pe.model.entity.NotificacionAdmin n : notificaciones) { %>
                <div style="padding:10px 16px; font-size:12px; color:#444; border-bottom:1px solid #f0f0f0; background:<%= n.isLeida() ? "#fff" : "#fff7f7" %>;">
                    <i class="fas <%= n.getIcono() %>" style="color:#C8102E; margin-right:6px;"></i><%= n.getMensaje() %>
                    <div style="color:#999; font-size:10.5px; margin-top:2px; margin-left:20px;"><%= n.getFechaHora() %></div>
                </div>
                <% } } %>
                <a href="ReporteAccesosController" style="display:block; text-align:center; padding:10px; font-size:12px; color:#C8102E; font-weight:600; text-decoration:none; background:#fafafa;">Ver Reporte de Accesos</a>
            </div>
        </li>
        <script>
            function marcarNotificacionesLeidas() {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'NotificacionController', true);
                xhr.onload = function () {
                    var badge = document.getElementById('badgeNotif');
                    if (badge) { badge.remove(); }
                    var icono = document.querySelector('#campanaNotif i');
                    if (icono) { icono.style.color = '#888'; }
                };
                xhr.send();
            }
        </script>
        <% } %>
        <li class="nav-item" style="display:flex; align-items:center; padding:0 12px; border-left:1px solid #eee; margin-left:4px;">
            <span style="font-size:13px; color:#555; margin-right:10px;">
                <i class="fas fa-user-circle" style="color:#C8102E; margin-right:4px;"></i>
                <%= usu.getNombre() != null ? usu.getNombre() : "" %>
            </span>
            <a class="nav-link btn-exit" href="login.jsp?cerrar=1" title="Cerrar sesi&oacute;n"
               style="background:#fff0f2; border-radius:8px; padding:6px 12px; color:#C8102E; font-size:13px; font-weight:500;">
                <i class="fas fa-sign-out-alt"></i> Salir
            </a>
        </li>
    </ul>
</div>

<!-- Sidebar -->
<section class="main-sidebar sidebar-dark-primary elevation-4">

    <!-- Brand -->
    <a href="DashboardAlmacen.jsp" class="brand-link">
        <div class="alicorp-brand">
            <div>
                <div class="alicorp-brand-text">
                    <span class="letter-a">A<span class="leaf"></span></span>licorp
                </div>
                <div class="brand-sub">Sistema de Almac&eacute;n</div>
            </div>
        </div>
    </a>

    <div class="sidebar">
        <!-- User panel -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <img src="<%= (usu.getFilename1() != null && !usu.getFilename1().trim().isEmpty()) ? usu.getFilename1() : "dist/img/avatar.png" %>" class="img-circle elevation-5" alt="Foto de perfil">
            </div>
            <div class="info">
                <a href="#" class="d-block"><%= usu.getNombre() != null ? usu.getNombre() : "" %></a>
                <span class="user-role-badge"><%= sesion.getAttribute("tipo") %></span>
            </div>
        </div>

        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="true">

                <!-- PANEL PRINCIPAL -->
                <li class="nav-item">
                    <a href="DashboardAlmacen.jsp" class="nav-link">
                        <i class="nav-icon fas fa-columns"></i>
                        <p>Panel Principal</p>
                    </a>
                </li>

                <div class="sidebar-divider"></div>

                <!-- INVENTARIOS -->
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-boxes"></i>
                        <p>Inventarios <i class="right fas fa-angle-left"></i></p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="Producto.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Productos</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Stockminimoymaximo.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Stock M&iacute;n / M&aacute;x</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Clasificacion.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Clasificaci&oacute;n</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Categoria.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Categor&iacute;a</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Subcategoria.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Subcategor&iacute;a</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Unidadmedida.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Unidad de Medida</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Motivo.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Motivo</p>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- LOGISTICA -->
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-truck"></i>
                        <p>Log&iacute;stica <i class="right fas fa-angle-left"></i></p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="Transporte.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Transportes</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Vehiculo.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Veh&iacute;culos</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Conductor.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Conductores</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Cliente.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Clientes</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Proveedor.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Proveedores</p>
                            </a>
                        </li>
                        <% if (sesion.getAttribute("tipo") != null && (sesion.getAttribute("tipo").equals("Administrador") || sesion.getAttribute("tipo").equals("Almacen") || sesion.getAttribute("tipo").equals("Logistico"))) { %>
                        <li class="nav-item">
                            <a href="ListarNotaingreso.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Nota de Ingreso</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="ListarNotasalida.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Nota de Salida</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="ListarGuiaremisioncliente.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Gu&iacute;a de Remisi&oacute;n</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="ListarOrdenCompra.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>&Oacute;rdenes de Compra</p>
                            </a>
                        </li>
                        <% } %>
                    </ul>
                </li>

                <!-- REPORTES -->
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-chart-bar"></i>
                        <p>Reportes <i class="right fas fa-angle-left"></i></p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="ReporteIngreso.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Registro de Ingreso</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Reportesalida.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Registro de Salida</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="ReporteStockproducto.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Stock Producto</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="ReporteStockminimo.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Stock M&iacute;nimo</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="ReporteStockmaximo.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Stock M&aacute;ximo</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Listaproductoconsultamovimiento.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Movimiento por Producto</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Lotes.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Trazabilidad por Lote</p>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- ADMINISTRACION (solo admin) -->
                <% if (sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("Administrador")) { %>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user-shield"></i>
                        <p>Administraci&oacute;n <i class="fas fa-angle-left right"></i></p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="Usuario.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Usuarios</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="Empresa.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Empresa</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="ReporteAccesosController" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Reporte de Accesos</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="AuditoriaController" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Auditor&iacute;a</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <% } %>

            </ul>
        </nav>
    </div>
</section>

<script>
    // Cierre de sesión automático por inactividad (20 min sin mover el mouse, teclear o hacer scroll).
    (function () {
        var LIMITE_MINUTOS = 20;
        var temporizador;
        function reiniciarTemporizador() {
            clearTimeout(temporizador);
            temporizador = setTimeout(function () {
                alert('Tu sesión se cerró automáticamente por inactividad.');
                window.location.href = 'login.jsp?cerrar=1';
            }, LIMITE_MINUTOS * 60 * 1000);
        }
        ['mousemove', 'mousedown', 'keypress', 'scroll', 'touchstart'].forEach(function (evento) {
            document.addEventListener(evento, reiniciarTemporizador, true);
        });
        reiniciarTemporizador();
    })();
</script>
