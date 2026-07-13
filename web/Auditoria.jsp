<%@page import="com.pe.model.entity.Auditoria"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Auditor&iacute;a | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <style>
            .filtro-box { display:flex; gap:10px; margin-bottom:14px; flex-wrap:wrap; }
            .filtro-box input, .filtro-box select { height:40px; border-radius:8px; border:1.5px solid #e0e0e0; padding:0 12px; font-size:13.5px; }
            .filtro-box button { height:40px; border:none; border-radius:8px; background:#C8102E; color:#fff; padding:0 18px; font-weight:600; cursor:pointer; }
            .badge-accion { font-size:11px; font-weight:700; padding:3px 9px; border-radius:14px; background:#f4f4f4; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-clipboard-list" style="color:#C8102E; margin-right:10px;"></i>
                        Auditor&iacute;a del Sistema
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Registro de acciones de los usuarios (creaciones, ediciones, movimientos y sesi&oacute;n)</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <div class="card" style="border-radius:12px; overflow:hidden; border:none; box-shadow:0 2px 12px rgba(0,0,0,.07); margin-bottom:20px;">
                        <div class="card-header" style="background:#fff; border-bottom:1px solid #f0f0f0;">
                            <h3 class="card-title" style="color:#1a1f2e; font-size:14px; font-weight:600;"><i class="fas fa-filter" style="color:#C8102E;margin-right:6px;"></i>Filtros</h3>
                        </div>
                        <div class="card-body">
                            <form class="filtro-box" action="AuditoriaController" method="GET">
                                <input type="text" name="usuario" placeholder="Buscar por usuario..."
                                       value="<%= request.getAttribute("filtroUsuario") != null ? request.getAttribute("filtroUsuario") : "" %>">
                                <select name="modulo">
                                    <option value="">-- Todos los m&oacute;dulos --</option>
                                    <%
                                        String[] modulos = {"Auth", "Usuarios", "Productos", "Log&iacute;stica", "Compras", "Configuraci&oacute;n"};
                                        String[] modulosValor = {"Auth", "Usuarios", "Productos", "Logistica", "Compras", "Configuracion"};
                                        String modActual = (String) request.getAttribute("filtroModulo");
                                        for (int i = 0; i < modulosValor.length; i++) {
                                            String sel = modulosValor[i].equals(modActual) ? "selected" : "";
                                    %>
                                    <option value="<%=modulosValor[i]%>" <%=sel%>><%=modulos[i]%></option>
                                    <% } %>
                                </select>
                                <button type="submit"><i class="fas fa-search"></i> Filtrar</button>
                                <a href="AuditoriaController" style="align-self:center; font-size:13px; color:#666; text-decoration:none;">Limpiar filtro</a>
                            </form>
                        </div>
                    </div>

                    <div class="card" style="border-radius:12px; overflow:hidden; border:none; box-shadow:0 2px 12px rgba(0,0,0,.07);">
                        <div class="card-header" style="background:#fff; border-bottom:1px solid #f0f0f0;">
                            <h3 class="card-title" style="color:#1a1f2e; font-size:14px; font-weight:600;"><i class="fas fa-list" style="color:#C8102E;margin-right:6px;"></i>Registro de Actividad</h3>
                        </div>
                        <div class="card-body" style="padding:20px;">
                            <table id="example" class="table table-striped table-bordered auditoria-table" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Usuario</th>
                                        <th>Acci&oacute;n</th>
                                        <th>M&oacute;dulo</th>
                                        <th>Detalle</th>
                                        <th>Fecha</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<Auditoria> registros = (List<Auditoria>) request.getAttribute("registros");
                                        if (registros != null) {
                                            for (Auditoria a : registros) {
                                    %>
                                    <tr>
                                        <td><%= a.getUsuario() %></td>
                                        <td><span class="badge-accion" style="color:<%= a.getColorAccion() %>;"><%= a.getAccion() %></span></td>
                                        <td><%= a.getModulo() %></td>
                                        <td><%= a.getDetalle() != null ? a.getDetalle() : "" %></td>
                                        <td><%= a.getFechaHora() %></td>
                                    </tr>
                                    <% } } %>
                                </tbody>
                            </table>
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
                    lengthChange: false,
                    order: [],
                    dom: 'Bfrtip',
                    buttons: [
                        {extend: 'copyHtml5', text: 'Copiar tabla'},
                        {extend: 'excelHtml5', text: 'Exportar Excel', title: 'Auditoria - Alicorp'},
                        {
                            extend: 'print',
                            text: 'Imprimir Reporte',
                            title: '',
                            customize: function (win) {
                                $(win.document.body)
                                    .css('font-family', 'Arial, Helvetica, sans-serif')
                                    .prepend(
                                        '<div style="background:#C8102E;color:#fff;padding:16px 22px;margin-bottom:6px;">' +
                                        '<h1 style="margin:0;font-size:20px;">Alicorp S.A.A.</h1>' +
                                        '<p style="margin:2px 0 0;font-size:12px;">Auditoria del Sistema &mdash; SIGA v1.0</p>' +
                                        '</div>'
                                    );
                                $(win.document.body).find('table').css('width', '92%').css('margin', '0 auto').css('font-size', '11px');
                                $(win.document.body).find('table thead th').css('background', '#f2f2f2').css('border', '1px solid #999').css('padding', '6px 8px');
                                $(win.document.body).find('table tbody td').css('border', '1px solid #ccc').css('padding', '6px 8px');
                            }
                        }
                    ]
                });
            });
        </script>
    </body>
</html>
