<%@page import="com.pe.model.entity.KardexMovimiento"%>
<%@page import="com.pe.DAO.DashboardDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <title>Detalle de Movimientos por Producto | Alicorp</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"/>
        <%@include file="css-plantilla.jsp"%>
        <style>
            .content-header { padding: 18px 24px 6px; }
            .content { padding: 0 24px 24px; }
            .card.card-default { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,.07); }
            .card.card-default > .card-header { background: #fff !important; border-bottom: 1px solid #f0f0f0; padding: 16px 20px; }
            table.dataTable thead th { background: #f8f9fc !important; color: #555; font-size: 11px; text-transform: uppercase; letter-spacing: .4px; }
            .dt-buttons .btn { background: #C8102E !important; border-color: #C8102E !important; color: #fff !important; border-radius: 6px !important; font-size: 12px !important; }
            .dt-buttons .btn:hover { background: #a50d25 !important; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <%
            String tipo = request.getParameter("tipo");
            boolean esIngreso = !"salida".equals(tipo);
            DashboardDAO dao = new DashboardDAO();
            List<KardexMovimiento> lista = esIngreso ? dao.consultaDetalleIngresos() : dao.consultaDetalleSalidas();
        %>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas <%=esIngreso ? "fa-arrow-up" : "fa-arrow-down"%>" style="color:<%=esIngreso ? "#2e9e4f" : "#C8102E"%>; margin-right:10px;"></i>
                        Detalle de Productos con M&aacute;s <%=esIngreso ? "Ingresos" : "Salidas"%>
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Cada movimiento individual, con fecha, hora y documento de respaldo</p>
                </div>
            </section>
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card card-default">
                            <div class="card-header">
                                <h3 class="card-title">Movimientos registrados</h3>
                            </div>
                            <div class="card-body">
                                <table id="B" class="table table-striped table-bordered" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>C&oacute;digo</th>
                                            <th>Descripci&oacute;n</th>
                                            <th style="text-align:center;">Cantidad</th>
                                            <th style="text-align:center;">Fecha y Hora</th>
                                            <th>Documento</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (KardexMovimiento k : lista) { %>
                                        <tr>
                                            <td><span style="font-family:monospace; font-size:12px; background:#f4f6fb; padding:2px 8px; border-radius:5px;"><%=k.getSerie()%></span></td>
                                            <td style="font-weight:500; color:#1a1f2e;"><%=k.getTipocomprobante()%></td>
                                            <td style="text-align:center; font-weight:600;"><%=String.format("%.2f", k.getIngreso())%></td>
                                            <td style="text-align:center;"><%=k.getFecha()%></td>
                                            <td><%=k.getCorrelativo()%></td>
                                        </tr>
                                        <% } %>
                                        <% if (lista.isEmpty()) { %>
                                        <tr><td colspan="5" style="text-align:center; color:#999;">A&uacute;n no hay movimientos registrados</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <%@include file="js-plantilla.jsp"%>
        <script>
            $(document).ready(function () {
                $('#B').DataTable({
                    dom: 'Bfrtip',
                    order: [[2, 'desc']],
                    buttons: [
                        {extend: 'copyHtml5', text: 'Copiar tabla'},
                        {extend: 'excelHtml5', text: 'Exportar Excel'},
                        {extend: 'print', text: 'Imprimir Reporte', title: ''}
                    ]
                });
            });
        </script>
    </body>
</html>
