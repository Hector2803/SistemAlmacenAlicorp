<%@page import="com.pe.DAO.OrdenCompraDAO"%>
<%@page import="com.pe.model.entity.OrdenCompra"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Ordenes de Compra | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <%@include file="css-datatable.jsp"%>
        <link href="dist/css/Stilodetabla.css" rel="stylesheet" type="text/css"/>
        <link href="dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <style>
            .badge-estado {
                display: inline-block;
                font-size: 11px;
                font-weight: 600;
                padding: 4px 12px;
                border-radius: 20px;
                letter-spacing: 0.3px;
            }
            .badge-pendiente   { background:#fff3e0; color:#e65100; }
            .badge-aprobado    { background:#e3f2fd; color:#1565c0; }
            .badge-completado  { background:#e8f5e9; color:#2e7d32; }
            .badge-anulado     { background:#fce4e4; color:#c62828; }

            .badge-origen {
                display: inline-block;
                font-size: 10px;
                font-weight: 600;
                padding: 2px 8px;
                border-radius: 6px;
                letter-spacing: 0.3px;
            }
            .badge-automatico { background:#f3e5f5; color:#7b1fa2; }
            .badge-manual     { background:#eceff1; color:#455a64; }

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
            .btn-accion:hover { opacity:0.82; transform:scale(1.05); text-decoration:none; }
            .btn-view     { background:#e8f5e9; color:#2e7d32; }
            .btn-approve  { background:#e3f2fd; color:#1565c0; }
            .btn-complete { background:#e8eaf6; color:#3949ab; }
            .btn-cancel   { background:#fce4e4; color:#c62828; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">

            <section class="content-header" style="padding: 18px 24px 10px;">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                                <i class="far fa-copy" style="color:#C8102E; margin-right:10px;"></i>
                                Ordenes de Compra
                            </h3>
                            <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">
                                Alicorp S.A.A. &mdash; Generaci&oacute;n autom&aacute;tica y manual de OC
                            </p>
                        </div>
                        <a href="InsertarOrdenCompra.jsp" class="btn-nuevo-alicorp">
                            <i class="fas fa-plus"></i> Nueva Orden de Compra
                        </a>
                    </div>
                    <nav style="margin-top:10px;">
                        <ol style="list-style:none; padding:0; margin:0; display:flex; gap:6px; font-size:12px; color:#aaa;">
                            <li><a href="DashboardAlmacen.jsp" style="color:#C8102E; text-decoration:none;">Dashboard</a></li>
                            <li style="color:#ccc;">/</li>
                            <li style="color:#555;">Ordenes de Compra</li>
                        </ol>
                    </nav>
                </div>
            </section>

            <section class="content" style="padding: 0 24px 24px;">
                <div class="container-fluid">

                    <!-- Resumen rapido -->
                    <%
                        OrdenCompraDAO ocdaoStats = new OrdenCompraDAO();
                        List<OrdenCompra> todas = ocdaoStats.listarOC();
                        int totPendiente = 0, totAprobado = 0, totCompletado = 0, totAnulado = 0, totAutomatico = 0;
                        for (OrdenCompra o : todas) {
                            switch (o.getEstado()) {
                                case "Pendiente": totPendiente++; break;
                                case "Aprobado": totAprobado++; break;
                                case "Completado": totCompletado++; break;
                                case "Anulado": totAnulado++; break;
                            }
                            if ("Automatico".equalsIgnoreCase(o.getOrigen())) totAutomatico++;
                        }
                    %>
                    <div class="row mb-3">
                        <div class="col-md-3 col-6 mb-2">
                            <div style="background:#fff; border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.06); border-left:4px solid #e65100;">
                                <p style="font-size:11px; color:#888; margin:0; text-transform:uppercase; letter-spacing:0.5px;">Pendientes</p>
                                <h4 style="font-size:26px; font-weight:700; color:#e65100; margin:4px 0 0;"><%= totPendiente %></h4>
                            </div>
                        </div>
                        <div class="col-md-3 col-6 mb-2">
                            <div style="background:#fff; border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.06); border-left:4px solid #1565c0;">
                                <p style="font-size:11px; color:#888; margin:0; text-transform:uppercase; letter-spacing:0.5px;">Aprobadas</p>
                                <h4 style="font-size:26px; font-weight:700; color:#1565c0; margin:4px 0 0;"><%= totAprobado %></h4>
                            </div>
                        </div>
                        <div class="col-md-3 col-6 mb-2">
                            <div style="background:#fff; border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.06); border-left:4px solid #2e7d32;">
                                <p style="font-size:11px; color:#888; margin:0; text-transform:uppercase; letter-spacing:0.5px;">Completadas</p>
                                <h4 style="font-size:26px; font-weight:700; color:#2e7d32; margin:4px 0 0;"><%= totCompletado %></h4>
                            </div>
                        </div>
                        <div class="col-md-3 col-6 mb-2">
                            <div style="background:#fff; border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.06); border-left:4px solid #7b1fa2;">
                                <p style="font-size:11px; color:#888; margin:0; text-transform:uppercase; letter-spacing:0.5px;">Generadas autom&aacute;tic.</p>
                                <h4 style="font-size:26px; font-weight:700; color:#7b1fa2; margin:4px 0 0;"><%= totAutomatico %></h4>
                            </div>
                        </div>
                    </div>

                    <!-- Tabla -->
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center gap-2">
                                <i class="fas fa-list" style="color:#C8102E; margin-right:8px;"></i>
                                <h3 class="card-title mb-0">Lista de &Oacute;rdenes de Compra</h3>
                            </div>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body" style="padding:20px;">
                            <table id="example" class="table table-striped table-bordered second" style="width:100%">
                                <thead>
                                    <tr>
                                        <th style="display:none;">Id</th>
                                        <th style="width:110px;">C&oacute;digo</th>
                                        <th>Proveedor</th>
                                        <th style="width:140px;">Fecha Emisi&oacute;n</th>
                                        <th style="width:100px;">Origen</th>
                                        <th style="width:110px;">Total</th>
                                        <th style="width:100px;">Estado</th>
                                        <th style="width:160px; text-align:center;">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% DecimalFormat df = new DecimalFormat("#,##0.00");
                                       OrdenCompraDAO ocdao = new OrdenCompraDAO();
                                       List<OrdenCompra> lista = ocdao.listarOC();
                                       for (OrdenCompra oc : lista) { %>
                                    <tr>
                                        <td style="display:none;"><%= oc.getIdordencompra() %></td>
                                        <td style="text-align:center;">
                                            <span style="font-family:monospace; font-size:12px; background:#f4f6fb; padding:2px 8px; border-radius:5px; color:#333;">
                                                <%= oc.getCodigo() %>
                                            </span>
                                        </td>
                                        <td><%= oc.getAuxiliar().getNombre() %></td>
                                        <td style="font-size:12.5px; color:#555;"><%= oc.getFechaEmision() %></td>
                                        <td style="text-align:center;">
                                            <% if ("Automatico".equalsIgnoreCase(oc.getOrigen())) { %>
                                                <span class="badge-origen badge-automatico"><i class="fas fa-robot"></i> Auto</span>
                                            <% } else { %>
                                                <span class="badge-origen badge-manual"><i class="fas fa-user"></i> Manual</span>
                                            <% } %>
                                        </td>
                                        <td style="text-align:right; font-weight:600;">S/ <%= df.format(oc.getTotal()) %></td>
                                        <td style="text-align:center;">
                                            <% String est = oc.getEstado();
                                               String claseBadge = "badge-pendiente";
                                               if ("Aprobado".equalsIgnoreCase(est)) claseBadge = "badge-aprobado";
                                               else if ("Completado".equalsIgnoreCase(est)) claseBadge = "badge-completado";
                                               else if ("Anulado".equalsIgnoreCase(est)) claseBadge = "badge-anulado";
                                            %>
                                            <span class="badge-estado <%= claseBadge %>"><%= est %></span>
                                        </td>
                                        <td style="text-align:center;">
                                            <a href="OrdenCompraController?accion=detalle&id=<%= oc.getIdordencompra() %>"
                                               class="btn-accion btn-view" title="Ver detalle">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <% if ("Pendiente".equalsIgnoreCase(oc.getEstado())) { %>
                                            <a href="#" onclick="aprobarOC(<%= oc.getIdordencompra() %>); return false;"
                                               class="btn-accion btn-approve" title="Aprobar">
                                                <i class="fas fa-check"></i>
                                            </a>
                                            <a href="#" onclick="anularOC(<%= oc.getIdordencompra() %>); return false;"
                                               class="btn-accion btn-cancel" title="Anular">
                                                <i class="fas fa-times"></i>
                                            </a>
                                            <% } else if ("Aprobado".equalsIgnoreCase(oc.getEstado())) { %>
                                            <a href="#" onclick="completarOC(<%= oc.getIdordencompra() %>); return false;"
                                               class="btn-accion btn-complete" title="Marcar como completada">
                                                <i class="fas fa-box-open"></i>
                                            </a>
                                            <% } %>
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
        <script src="plugins/toastr/toastr.min.js"></script>

        <script>
            function aprobarOC(id) {
                if (!confirm('¿Aprobar esta orden de compra?')) return;
                $.post('OrdenCompraController', { accion: 'aprobar', id: id }, function (resp) {
                    if (resp.trim() === 'ok') {
                        toastr.success('Orden de compra aprobada');
                        setTimeout(function () { location.reload(); }, 800);
                    } else {
                        toastr.error('No se pudo aprobar la orden');
                    }
                });
            }

            function anularOC(id) {
                if (!confirm('¿Anular esta orden de compra? Esta acción no se puede deshacer.')) return;
                $.post('OrdenCompraController', { accion: 'anular', id: id }, function (resp) {
                    if (resp.trim() === 'ok') {
                        toastr.warning('Orden de compra anulada');
                        setTimeout(function () { location.reload(); }, 800);
                    } else {
                        toastr.error('No se pudo anular la orden');
                    }
                });
            }

            function completarOC(id) {
                if (!confirm('¿Marcar esta orden como completada (mercadería recibida)?')) return;
                $.post('OrdenCompraController', { accion: 'completar', id: id }, function (resp) {
                    if (resp.trim() === 'ok') {
                        toastr.success('Orden completada: el stock de los productos ya fue actualizado');
                        setTimeout(function () { location.reload(); }, 800);
                    } else {
                        toastr.error('No se pudo completar la orden');
                    }
                });
            }
        </script>

    </body>
</html>
