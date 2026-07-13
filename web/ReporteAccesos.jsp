<%@page import="com.pe.model.entity.LogAcceso"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Reporte de Accesos | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <%@include file="css-datatable.jsp"%>
        <style>
            .badge-exito { background:#e8f5e9; color:#2e7d32; font-weight:600; font-size:11px; padding:4px 10px; border-radius:20px; }
            .badge-fallo { background:#fce4e4; color:#c62828; font-weight:600; font-size:11px; padding:4px 10px; border-radius:20px; }
            .filtro-box { display:flex; gap:10px; margin-bottom:16px; }
            .filtro-box input { height:40px; border-radius:8px; border:1.5px solid #e0e0e0; padding:0 12px; font-size:13.5px; }
            .filtro-box button { height:40px; border:none; border-radius:8px; background:#C8102E; color:#fff; padding:0 18px; font-weight:600; cursor:pointer; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-shield-alt" style="color:#C8102E; margin-right:10px;"></i>
                        Reporte de Accesos
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Historial de inicios de sesi&oacute;n (exitosos y fallidos)</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-list" style="color:#C8102E; margin-right:8px;"></i>
                                <h3 class="card-title mb-0">&Uacute;ltimos accesos</h3>
                            </div>
                        </div>
                        <div class="card-body" style="padding:20px;">

                            <form class="filtro-box" action="ReporteAccesosController" method="GET">
                                <input type="text" name="usuario" placeholder="Filtrar por usuario..."
                                       value="<%= request.getAttribute("filtroUsuario") != null ? request.getAttribute("filtroUsuario") : "" %>">
                                <button type="submit"><i class="fas fa-search"></i> Filtrar</button>
                                <a href="ReporteAccesosController" style="align-self:center; font-size:13px; color:#666; text-decoration:none;">Limpiar filtro</a>
                            </form>

                            <table id="example" class="table table-striped table-bordered accesos-table" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Usuario</th>
                                        <th>Resultado</th>
                                        <th>Fecha</th>
                                        <th>Hora</th>
                                        <th>IP de origen</th>
                                        <th>Detalle</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<LogAcceso> logs = (List<LogAcceso>) request.getAttribute("logs");
                                        if (logs != null) {
                                            for (LogAcceso log : logs) {
                                                String fechaHoraCompleta = log.getFechaHora() != null ? log.getFechaHora() : "";
                                                String soloFecha = "";
                                                String soloHora = "";
                                                try {
                                                    String[] partes = fechaHoraCompleta.split(" ");
                                                    if (partes.length >= 2) {
                                                        String[] fechaP = partes[0].split("-");
                                                        soloFecha = fechaP[2] + "/" + fechaP[1] + "/" + fechaP[0];
                                                        soloHora = partes[1].split("\\.")[0];
                                                    } else {
                                                        soloFecha = fechaHoraCompleta;
                                                    }
                                                } catch (Exception ex) {
                                                    soloFecha = fechaHoraCompleta;
                                                }
                                    %>
                                    <tr>
                                        <td><%= log.getUsuarioIntento() %></td>
                                        <td>
                                            <% if (log.isExito()) { %>
                                            <span class="badge-exito"><i class="fas fa-check-circle"></i> Correcto</span>
                                            <% } else { %>
                                            <span class="badge-fallo"><i class="fas fa-times-circle"></i> Fallido</span>
                                            <% } %>
                                        </td>
                                        <td><%= soloFecha %></td>
                                        <td><span style="font-family:monospace; color:#555;"><%= soloHora %></span></td>
                                        <td><%= log.getIpOrigen() != null ? log.getIpOrigen() : "-" %></td>
                                        <td><%= log.getMensaje() != null ? log.getMensaje() : "" %></td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </section>
        </div>

        <script src="assets/jqueryy.js" type="text/javascript"></script>
        <script src="dist/js/bootstrap.min.js" type="text/javascript"></script>
        <%@include file="js-plantilla.jsp"%>
        <%@include file="js-datatable.jsp"%>
        <script>
            $(document).ready(function () {
                $('#example').DataTable({
                    lengthChange: false,
                    order: [],
                    dom: 'Bfrtip',
                    buttons: [
                        {extend: 'copyHtml5', text: 'Copiar tabla'},
                        {extend: 'excelHtml5', text: 'Exportar Excel', title: 'Reporte de Accesos - Alicorp'},
                        {
                            extend: 'print',
                            text: 'Imprimir Reporte',
                            title: '',
                            customize: function (win) {
                                $(win.document.body)
                                    .css('font-family', 'Arial, Helvetica, sans-serif')
                                    .css('color', '#2C2C2A')
                                    .prepend(
                                        '<div style="background:#C8102E;color:#fff;padding:16px 22px;margin-bottom:6px;">' +
                                        '<h1 style="margin:0;font-size:20px;">Alicorp S.A.A.</h1>' +
                                        '<p style="margin:2px 0 0;font-size:12px;">Reporte de Accesos &mdash; Sistema SIGA v1.0</p>' +
                                        '</div>' +
                                        '<p style="font-size:11px;color:#888;margin:0 0 16px 22px;">Generado el ' + new Date().toLocaleDateString('es-PE') + '</p>'
                                    );
                                $(win.document.body).find('table')
                                    .css('border-collapse', 'collapse')
                                    .css('width', '92%')
                                    .css('margin', '0 auto')
                                    .css('font-size', '12px');
                                $(win.document.body).find('table thead th')
                                    .css('background', '#f2f2f2')
                                    .css('border', '1px solid #999')
                                    .css('padding', '7px 10px')
                                    .css('text-align', 'left');
                                $(win.document.body).find('table tbody td')
                                    .css('border', '1px solid #ccc')
                                    .css('padding', '7px 10px');
                            }
                        }
                    ]
                });
            });
        </script>
    </body>
</html>
