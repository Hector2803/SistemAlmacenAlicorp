<%@page import="com.pe.model.entity.Producto"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="com.pe.DAO.DashboardDAO"%>
<%@page import="com.pe.DAO.OrdenCompraDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dashboard | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <%@include file="css-datatable.jsp"%>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

        <style>
            .content-wrapper { min-height: auto !important; }
            /* ── KPI Cards ── */
            .kpi-card {
                border-radius: 12px;
                padding: 22px 22px 18px;
                color: #ffffff;
                position: relative;
                overflow: hidden;
                box-shadow: 0 4px 16px rgba(0,0,0,0.10);
                min-height: 118px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                text-decoration: none !important;
                transition: transform 0.15s, box-shadow 0.15s;
            }
            .kpi-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 24px rgba(0,0,0,0.16);
                text-decoration: none !important;
            }
            .kpi-card .kpi-icon-bg {
                position: absolute;
                right: -10px;
                top: -10px;
                font-size: 80px;
                opacity: 0.15;
                color: #ffffff;
            }
            .kpi-card .kpi-label {
                font-size: 12.5px;
                font-weight: 500;
                color: rgba(255,255,255,0.92);
                text-transform: uppercase;
                letter-spacing: 0.4px;
                margin-bottom: 2px;
            }
            .kpi-card .kpi-number {
                font-size: 34px;
                font-weight: 700;
                color: #ffffff;
                line-height: 1;
                margin: 6px 0 14px;
            }
            .kpi-card .kpi-footer {
                font-size: 12px;
                font-weight: 500;
                color: rgba(255,255,255,0.95);
                display: flex;
                align-items: center;
                gap: 6px;
            }
            .kpi-green  { background: linear-gradient(135deg, #2e9e4f, #1b7a37); }
            .kpi-amber  { background: linear-gradient(135deg, #f0a020, #d6810a); }
            .kpi-cyan   { background: linear-gradient(135deg, #1aa5c8, #0d80a0); }
            .kpi-red    { background: linear-gradient(135deg, #d6213b, #a50d25); }

            /* ── Section title ── */
            .section-title-row {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin: 28px 0 14px;
            }
            .section-title-row h2 {
                font-size: 16px;
                font-weight: 600;
                color: #1a1f2e;
                margin: 0;
            }

            /* ── Ranking cards ── */
            .rank-card {
                background: #ffffff;
                border-radius: 12px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.07);
                overflow: hidden;
                height: 100%;
            }
            .rank-card-header {
                padding: 16px 20px;
                display: flex;
                align-items: center;
                gap: 10px;
                border-bottom: 1px solid #f0f0f0;
            }
            .rank-card-header .rh-icon {
                width: 34px;
                height: 34px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 15px;
                color: #fff;
                flex-shrink: 0;
            }
            .rh-icon-up   { background: #2e9e4f; }
            .rh-icon-down { background: #d6213b; }
            .rank-card-header h3 {
                font-size: 13px;
                font-weight: 600;
                color: #444;
                text-transform: uppercase;
                letter-spacing: 0.4px;
                margin: 0;
            }
            .rank-table {
                width: 100%;
                border-collapse: collapse;
            }
            .rank-table thead th {
                background: #f8f9fc;
                font-size: 11px;
                font-weight: 600;
                color: #888;
                text-transform: uppercase;
                letter-spacing: 0.4px;
                padding: 10px 20px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            .rank-table tbody td {
                padding: 10px 20px;
                font-size: 13px;
                color: #333;
                border-bottom: 1px solid #f5f5f5;
            }
            .rank-table tbody tr:hover td {
                background: #fafbfd;
            }
            .rank-table tbody tr:last-child td {
                border-bottom: none;
            }
            .rank-code {
                font-family: monospace;
                font-size: 11.5px;
                background: #f4f6fb;
                padding: 2px 8px;
                border-radius: 5px;
                color: #555;
            }
            .rank-qty {
                font-weight: 600;
                color: #1a1f2e;
            }
            .rank-empty {
                padding: 24px 20px;
                text-align: center;
                color: #bbb;
                font-size: 13px;
            }
            .rank-card-footer {
                padding: 12px 20px;
                border-top: 1px solid #f0f0f0;
            }
            .rank-card-footer a {
                font-size: 12.5px;
                font-weight: 500;
                color: #C8102E;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }
            .rank-card-footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">

            <section class="content-header" style="padding: 18px 24px 6px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-th-large" style="color:#C8102E; margin-right:10px;"></i>
                        Dashboard
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">
                        Alicorp S.A.A. &mdash; Panel general de almac&eacute;n
                    </p>
                </div>
            </section>

            <section class="content" style="padding: 10px 24px 24px;">
                <div class="container-fluid">

                    <!-- KPI cards -->
                    <div class="row">
                        <div class="col-lg-3 col-6 mb-3">
                            <%
                                OrdenCompraDAO ocdaoKpi = new OrdenCompraDAO();
                                String numRQ = ocdaoKpi.contarPendientes();
                            %>
                            <a href="ListarOrdenCompra.jsp" class="kpi-card kpi-green">
                                <i class="far fa-copy kpi-icon-bg"></i>
                                <div>
                                    <p class="kpi-label">&Oacute;rdenes Pendientes</p>
                                    <h3 class="kpi-number"><%= numRQ %></h3>
                                </div>
                                <div class="kpi-footer">M&aacute;s informaci&oacute;n <i class="fas fa-arrow-circle-right"></i></div>
                            </a>
                        </div>

                        <div class="col-lg-3 col-6 mb-3">
                            <%
                                DashboardDAO comm = new DashboardDAO();
                                String numcli = comm.contarcliente();
                            %>
                            <a href="Cliente.jsp" class="kpi-card kpi-amber">
                                <i class="ion ion-person-add kpi-icon-bg"></i>
                                <div>
                                    <p class="kpi-label">Clientes Registrados</p>
                                    <h3 class="kpi-number"><%= numcli %></h3>
                                </div>
                                <div class="kpi-footer">M&aacute;s informaci&oacute;n <i class="fas fa-arrow-circle-right"></i></div>
                            </a>
                        </div>

                        <div class="col-lg-3 col-6 mb-3">
                            <%
                                DashboardDAO prov = new DashboardDAO();
                                String numprove = prov.contarproveedor();
                            %>
                            <a href="Proveedor.jsp" class="kpi-card kpi-cyan">
                                <i class="ion ion-person-add kpi-icon-bg"></i>
                                <div>
                                    <p class="kpi-label">Proveedores Registrados</p>
                                    <h3 class="kpi-number"><%= numprove %></h3>
                                </div>
                                <div class="kpi-footer">M&aacute;s informaci&oacute;n <i class="fas fa-arrow-circle-right"></i></div>
                            </a>
                        </div>

                        <div class="col-lg-3 col-6 mb-3">
                            <%
                                DashboardDAO pro = new DashboardDAO();
                                String numproduc = pro.contarproducto();
                            %>
                            <a href="Producto.jsp" class="kpi-card kpi-red">
                                <i class="fas fa-tag kpi-icon-bg"></i>
                                <div>
                                    <p class="kpi-label">Productos Registrados</p>
                                    <h3 class="kpi-number"><%= numproduc %></h3>
                                </div>
                                <div class="kpi-footer">M&aacute;s informaci&oacute;n <i class="fas fa-arrow-circle-right"></i></div>
                            </a>
                        </div>

                        <div class="col-lg-3 col-6 mb-3">
                            <%
                                DashboardDAO valInv = new DashboardDAO();
                                String valorInventario = valInv.Valorinventario();
                            %>
                            <a href="Producto.jsp" class="kpi-card kpi-green">
                                <i class="fas fa-warehouse kpi-icon-bg"></i>
                                <div>
                                    <p class="kpi-label">Valor de Inventario (S/)</p>
                                    <h3 class="kpi-number">S/ <%= valorInventario != null ? valorInventario : "0.00" %></h3>
                                </div>
                                <div class="kpi-footer">M&aacute;s informaci&oacute;n <i class="fas fa-arrow-circle-right"></i></div>
                            </a>
                        </div>
                    </div>

                    <!-- Rankings -->
                    <div class="section-title-row">
                        <h2><i class="fas fa-chart-line" style="color:#C8102E; margin-right:8px;"></i>Movimientos destacados</h2>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 mb-3">
                            <div class="rank-card">
                                <div class="rank-card-header">
                                    <div class="rh-icon rh-icon-up"><i class="fas fa-arrow-up"></i></div>
                                    <h3>10 productos con m&aacute;s ingresos</h3>
                                </div>
                                <table class="rank-table">
                                    <thead>
                                        <tr>
                                            <th style="width:90px;">C&oacute;digo</th>
                                            <th>Descripci&oacute;n</th>
                                            <th style="width:140px;">Cant. Ingreso</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%  DashboardDAO dao = new DashboardDAO();
                                            List<Producto> list = dao.consulta10productosconmasingresos();
                                            Iterator<Producto> iter = list.iterator();
                                            Producto per = null;
                                            boolean hasIngresos = false;
                                            while (iter.hasNext()) {
                                                per = iter.next();
                                                hasIngresos = true;
                                        %>
                                        <tr>
                                            <td><span class="rank-code"><%= per.getCodigo() %></span></td>
                                            <td><%= per.getDescripcion() %></td>
                                            <td class="rank-qty"><%= per.getStock() %></td>
                                        </tr>
                                        <% }
                                            if (!hasIngresos) { %>
                                        <tr><td colspan="3" class="rank-empty">No hay movimientos de ingreso registrados</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <div class="rank-card-footer">
                                    <a href="DetalleMovimientosProducto.jsp?tipo=ingreso">Ver reporte completo <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 mb-3">
                            <div class="rank-card">
                                <div class="rank-card-header">
                                    <div class="rh-icon rh-icon-down"><i class="fas fa-arrow-down"></i></div>
                                    <h3>10 productos con m&aacute;s salidas</h3>
                                </div>
                                <table class="rank-table">
                                    <thead>
                                        <tr>
                                            <th style="width:90px;">C&oacute;digo</th>
                                            <th>Descripci&oacute;n</th>
                                            <th style="width:140px;">Cant. Salida</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%  DashboardDAO daao = new DashboardDAO();
                                            List<Producto> lisst = daao.consulta10productosconmassalidas();
                                            Iterator<Producto> iters = lisst.iterator();
                                            Producto pers = null;
                                            boolean hasSalidas = false;
                                            while (iters.hasNext()) {
                                                pers = iters.next();
                                                hasSalidas = true;
                                        %>
                                        <tr>
                                            <td><span class="rank-code"><%= pers.getCodigo() %></span></td>
                                            <td><%= pers.getDescripcion() %></td>
                                            <td class="rank-qty"><%= pers.getStock() %></td>
                                        </tr>
                                        <% }
                                            if (!hasSalidas) { %>
                                        <tr><td colspan="3" class="rank-empty">No hay movimientos de salida registrados</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <div class="rank-card-footer">
                                    <a href="DetalleMovimientosProducto.jsp?tipo=salida">Ver reporte completo <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 mb-3">
                            <div class="rank-card">
                                <div class="rank-card-header">
                                    <div class="rh-icon rh-icon-down"><i class="fas fa-truck"></i></div>
                                    <h3>Top 10 proveedores</h3>
                                </div>
                                <table class="rank-table">
                                    <thead>
                                        <tr>
                                            <th>Proveedor</th>
                                            <th style="width:130px;">Documento</th>
                                            <th style="width:110px;">Cant. Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%  DashboardDAO daoProv = new DashboardDAO();
                                            List<Auxiliar> listProv = daoProv.consulta10principalesprovedores();
                                            Iterator<Auxiliar> iterProv = listProv.iterator();
                                            Auxiliar perProv = null;
                                            boolean hasProv = false;
                                            while (iterProv.hasNext()) {
                                                perProv = iterProv.next();
                                                hasProv = true;
                                        %>
                                        <tr>
                                            <td><%= perProv.getNombre() %></td>
                                            <td><%= perProv.getNumerodocumento() %></td>
                                            <td class="rank-qty"><%= perProv.getIdauxiliar() %></td>
                                        </tr>
                                        <% }
                                            if (!hasProv) { %>
                                        <tr><td colspan="3" class="rank-empty">A&uacute;n no hay movimientos registrados con proveedores</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <div class="rank-card-footer">
                                    <a href="Proveedor.jsp">Ver proveedores <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </section>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <script src="plugins/toastr/toastr.min.js"></script>

    </body>
</html>
