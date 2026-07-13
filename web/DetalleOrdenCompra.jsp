<%@page import="com.pe.DAO.OrdenCompraDAO"%>
<%@page import="com.pe.model.entity.OrdenCompra"%>
<%@page import="com.pe.model.entity.DetalleOrdenCompra"%>
<%@page import="java.text.DecimalFormat"%>
<%
    int idoc = Integer.parseInt((String) request.getAttribute("idoc"));
    OrdenCompraDAO ocDao = new OrdenCompraDAO();
    OrdenCompra oc = ocDao.buscarPorId(idoc);
    DecimalFormat df = new DecimalFormat("#,##0.00");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Detalle OC <%= oc.getCodigo() %> | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <link href="dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <style>
            .detalle-card {
                background:#fff; border-radius:12px; box-shadow:0 2px 12px rgba(0,0,0,0.07);
                padding:24px; margin-bottom:20px;
            }
            .detalle-header {
                display:flex; align-items:center; justify-content:space-between;
                padding-bottom:16px; border-bottom:1px solid #f0f0f0; margin-bottom:18px;
            }
            .oc-codigo { font-size:22px; font-weight:700; color:#1a1f2e; }
            .badge-estado {
                display:inline-block; font-size:12px; font-weight:600; padding:5px 14px;
                border-radius:20px; letter-spacing:0.3px;
            }
            .badge-pendiente   { background:#fff3e0; color:#e65100; }
            .badge-aprobado    { background:#e3f2fd; color:#1565c0; }
            .badge-completado  { background:#e8f5e9; color:#2e7d32; }
            .badge-anulado     { background:#fce4e4; color:#c62828; }

            .info-item { margin-bottom:14px; }
            .info-label { font-size:11px; color:#999; text-transform:uppercase; letter-spacing:0.4px; margin-bottom:2px; }
            .info-value { font-size:14px; color:#1a1f2e; font-weight:500; }

            table.tabla-detalle th {
                background:#f8f9fc; font-size:11px; font-weight:600; color:#888;
                text-transform:uppercase; letter-spacing:0.4px; padding:10px 14px; border-bottom:2px solid #eee;
            }
            table.tabla-detalle td { padding:10px 14px; font-size:13px; border-bottom:1px solid #f5f5f5; }

            .total-final {
                text-align:right; padding:14px 0; font-size:18px; font-weight:700; color:#C8102E;
            }

            .btn-accion-grande {
                border:none; border-radius:8px; padding:10px 22px; font-size:13.5px; font-weight:500;
                display:inline-flex; align-items:center; gap:7px;
            }
            .btn-approve  { background:#1565c0; color:#fff; }
            .btn-complete { background:#3949ab; color:#fff; }
            .btn-cancel   { background:#c62828; color:#fff; }
            .btn-back     { background:#f0f0f0; color:#555; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-file-invoice" style="color:#C8102E; margin-right:10px;"></i>
                        Detalle de Orden de Compra
                    </h3>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">

                    <div class="detalle-card">
                        <div class="detalle-header">
                            <div>
                                <div class="oc-codigo"><%= oc.getCodigo() %></div>
                                <div style="font-size:12px; color:#999; margin-top:3px;">
                                    <% if ("Automatico".equalsIgnoreCase(oc.getOrigen())) { %>
                                        <i class="fas fa-robot" style="color:#7b1fa2;"></i> Generada autom&aacute;ticamente por stock m&iacute;nimo
                                    <% } else { %>
                                        <i class="fas fa-user" style="color:#455a64;"></i> Creada manualmente
                                    <% } %>
                                </div>
                            </div>
                            <%
                                String est = oc.getEstado();
                                String claseBadge = "badge-pendiente";
                                if ("Aprobado".equalsIgnoreCase(est)) claseBadge = "badge-aprobado";
                                else if ("Completado".equalsIgnoreCase(est)) claseBadge = "badge-completado";
                                else if ("Anulado".equalsIgnoreCase(est)) claseBadge = "badge-anulado";
                            %>
                            <span class="badge-estado <%= claseBadge %>"><%= est %></span>
                        </div>

                        <div class="row">
                            <div class="col-md-4 info-item">
                                <div class="info-label">Proveedor</div>
                                <div class="info-value"><%= oc.getAuxiliar().getNombre() %></div>
                            </div>
                            <div class="col-md-4 info-item">
                                <div class="info-label">Documento</div>
                                <div class="info-value"><%= oc.getAuxiliar().getNumerodocumento() %></div>
                            </div>
                            <div class="col-md-4 info-item">
                                <div class="info-label">Fecha de Emisi&oacute;n</div>
                                <div class="info-value"><%= oc.getFechaEmision() %></div>
                            </div>
                            <div class="col-md-4 info-item">
                                <div class="info-label">Fecha de Entrega Estimada</div>
                                <div class="info-value"><%= (oc.getFechaEntrega() != null) ? oc.getFechaEntrega() : "No especificada" %></div>
                            </div>
                            <div class="col-md-8 info-item">
                                <div class="info-label">Observaci&oacute;n</div>
                                <div class="info-value"><%= (oc.getObservacion() != null) ? oc.getObservacion() : "Sin observaciones" %></div>
                            </div>
                        </div>
                    </div>

                    <div class="detalle-card">
                        <h3 style="font-size:13px; font-weight:600; color:#555; text-transform:uppercase; letter-spacing:0.5px; margin-bottom:16px;">
                            Productos Solicitados
                        </h3>
                        <table class="table tabla-detalle" style="width:100%;">
                            <thead>
                                <tr>
                                    <th>C&oacute;digo</th>
                                    <th>Descripci&oacute;n</th>
                                    <th style="text-align:right;">Cantidad</th>
                                    <th style="text-align:right;">P. Unitario</th>
                                    <th style="text-align:right;">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (DetalleOrdenCompra d : oc.getDetalle()) { %>
                                <tr>
                                    <td><span style="font-family:monospace; font-size:12px; background:#f4f6fb; padding:2px 8px; border-radius:5px;"><%= d.getProducto().getCodigo() %></span></td>
                                    <td><%= d.getProducto().getDescripcion() %></td>
                                    <td style="text-align:right;"><%= df.format(d.getCantidad()) %></td>
                                    <td style="text-align:right;">S/ <%= df.format(d.getPrecioUnitario()) %></td>
                                    <td style="text-align:right; font-weight:600;">S/ <%= df.format(d.getSubtotal()) %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <div class="total-final">Total: S/ <%= df.format(oc.getTotal()) %></div>
                    </div>

                    <div class="d-flex justify-content-between" style="margin-top:10px;">
                        <a href="ListarOrdenCompra.jsp" class="btn-accion-grande btn-back">
                            <i class="fas fa-arrow-left"></i> Volver al listado
                        </a>
                        <div style="display:flex; gap:10px;">
                            <% if ("Pendiente".equalsIgnoreCase(oc.getEstado())) { %>
                                <button class="btn-accion-grande btn-cancel" onclick="anularOC(<%= oc.getIdordencompra() %>)">
                                    <i class="fas fa-times"></i> Anular
                                </button>
                                <button class="btn-accion-grande btn-approve" onclick="aprobarOC(<%= oc.getIdordencompra() %>)">
                                    <i class="fas fa-check"></i> Aprobar Orden
                                </button>
                            <% } else if ("Aprobado".equalsIgnoreCase(oc.getEstado())) { %>
                                <button class="btn-accion-grande btn-complete" onclick="completarOC(<%= oc.getIdordencompra() %>)">
                                    <i class="fas fa-box-open"></i> Marcar como Completada
                                </button>
                            <% } %>
                        </div>
                    </div>

                </div>
            </section>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <script src="plugins/toastr/toastr.min.js"></script>
        <script>
            function aprobarOC(id) {
                if (!confirm('¿Aprobar esta orden de compra?')) return;
                $.post('OrdenCompraController', { accion: 'aprobar', id: id }, function (resp) {
                    if (resp.trim() === 'ok') {
                        toastr.success('Orden aprobada');
                        setTimeout(function () { location.reload(); }, 800);
                    } else { toastr.error('Error al aprobar'); }
                });
            }
            function anularOC(id) {
                if (!confirm('¿Anular esta orden de compra?')) return;
                $.post('OrdenCompraController', { accion: 'anular', id: id }, function (resp) {
                    if (resp.trim() === 'ok') {
                        toastr.warning('Orden anulada');
                        setTimeout(function () { window.location.href = 'ListarOrdenCompra.jsp'; }, 800);
                    } else { toastr.error('Error al anular'); }
                });
            }
            function completarOC(id) {
                if (!confirm('¿Marcar como completada (mercadería recibida)?')) return;
                $.post('OrdenCompraController', { accion: 'completar', id: id }, function (resp) {
                    if (resp.trim() === 'ok') {
                        toastr.success('Orden completada');
                        setTimeout(function () { location.reload(); }, 800);
                    } else { toastr.error('Error al completar'); }
                });
            }
        </script>

    </body>
</html>
