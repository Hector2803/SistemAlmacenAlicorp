<%@page import="com.pe.model.entity.Lote"%>
<%@page import="com.pe.DAO.LoteDAO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Trazabilidad por Lote | Alicorp</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"/>
        <%@include file="css-plantilla.jsp"%>
        <style>
            .content-header { padding: 18px 24px 6px; }
            .content { padding: 0 24px 24px; }
            .card.card-default { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,.07); }
            .card.card-default > .card-header { background: #fff !important; border-bottom: 1px solid #f0f0f0; padding: 16px 20px; }
            table.dataTable thead th { background: #f8f9fc !important; color: #555; font-size: 11px; text-transform: uppercase; letter-spacing: .4px; }
            .dt-buttons .btn { background: #C8102E !important; border-color: #C8102E !important; color: #fff !important; border-radius: 6px !important; font-size: 12px !important; }
            .estado-badge { font-size: 11px; font-weight: 700; padding: 3px 10px; border-radius: 14px; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-barcode" style="color:#C8102E; margin-right:10px;"></i>
                        Trazabilidad por Lote
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Lotes registrados y su fecha de vencimiento</p>
                </div>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <div class="card card-default">
                        <div class="card-header">
                            <h3 class="card-title">Lotes registrados</h3>
                        </div>
                        <div class="card-body">
                            <%
                                LoteDAO loteDAO = new LoteDAO();
                                List<Lote> lotes = loteDAO.listarTodos();
                                LocalDate hoy = LocalDate.now();
                            %>
                            <% if (lotes.isEmpty()) { %>
                            <div style="text-align:center; color:#999; font-size:13px; padding:30px 0;">
                                <i class="fas fa-inbox" style="font-size:22px;display:block;margin-bottom:8px;color:#ccc;"></i>
                                A&uacute;n no se ha registrado ning&uacute;n lote. Se agregan al emitir una Nota de Ingreso con "C&oacute;digo de Lote".
                            </div>
                            <% } else { %>
                            <table id="example" class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>C&oacute;digo Producto</th>
                                        <th>Descripci&oacute;n</th>
                                        <th>C&oacute;digo de Lote</th>
                                        <th>Cantidad</th>
                                        <th>Fecha de Ingreso</th>
                                        <th>Vencimiento</th>
                                        <th>Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Lote l : lotes) {
                                           String badgeColor = "background:#eceff1; color:#455a64;";
                                           String estadoTexto = "Sin vencimiento";
                                           if (l.getFechaVencimiento() != null && !l.getFechaVencimiento().isEmpty()) {
                                               LocalDate venc = LocalDate.parse(l.getFechaVencimiento());
                                               long dias = java.time.temporal.ChronoUnit.DAYS.between(hoy, venc);
                                               if (dias < 0) {
                                                   badgeColor = "background:#fce4e4; color:#c62828;";
                                                   estadoTexto = "Vencido";
                                               } else if (dias <= 30) {
                                                   badgeColor = "background:#fff3e0; color:#e65100;";
                                                   estadoTexto = "Vence en " + dias + " d\u00edas";
                                               } else {
                                                   badgeColor = "background:#e8f5e9; color:#2e7d32;";
                                                   estadoTexto = "Vigente";
                                               }
                                           }
                                    %>
                                    <tr>
                                        <td><span style="font-family:monospace; font-size:12px; background:#f4f6fb; padding:2px 8px; border-radius:5px;"><%=l.getCodigoProducto()%></span></td>
                                        <td><%=l.getDescripcionProducto()%></td>
                                        <td><%=l.getCodigoLote()%></td>
                                        <td style="text-align:center;"><%=String.format("%.2f", l.getCantidadInicial())%></td>
                                        <td><%=l.getFechaIngreso()%></td>
                                        <td><%=l.getFechaVencimiento() != null && !l.getFechaVencimiento().isEmpty() ? l.getFechaVencimiento() : "-"%></td>
                                        <td><span class="estado-badge" style="<%=badgeColor%>"><%=estadoTexto%></span></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <% } %>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <%@include file="js-plantilla.jsp"%>
        <%@include file="js-datatable.jsp"%>
        <script>
            $(document).ready(function () {
                $('#example').DataTable({
                    dom: 'Bfrtip',
                    order: [],
                    buttons: [
                        {extend: 'copyHtml5', text: 'Copiar tabla'},
                        {extend: 'excelHtml5', text: 'Exportar Excel', title: 'Trazabilidad por Lote - Alicorp'},
                        {extend: 'print', text: 'Imprimir Reporte', title: ''}
                    ]
                });
            });
        </script>
    </body>
</html>
