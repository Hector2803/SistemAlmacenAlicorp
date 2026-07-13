<%@page import="com.pe.model.entity.Empresa"%>
<%@page import="com.pe.DAO.EmpresaDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Empresa | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <%@include file="css-datatable.jsp"%>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-building" style="color:#C8102E; margin-right:10px;"></i>
                        Datos de la Empresa
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Informaci&oacute;n corporativa del sistema</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-list" style="color:#C8102E; margin-right:8px;"></i>
                                <h3 class="card-title mb-0">Registro de Empresa</h3>
                            </div>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="card-body" style="padding:20px;">
                            <table class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th style="display:none;">#</th>
                                        <th style="width:180px; text-align:center;">Logo</th>
                                        <th>Nombre</th>
                                        <th style="width:160px;">RUC</th>
                                        <th>Direcci&oacute;n</th>
                                        <th style="width:90px; text-align:center;">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% EmpresaDAO dao = new EmpresaDAO();
                                       List<Empresa> list = dao.ListadoEmpresa();
                                       Iterator<Empresa> iter = list.iterator();
                                       Empresa per = null;
                                       while (iter.hasNext()) {
                                           per = iter.next(); %>
                                    <tr>
                                        <td id="idemp" style="display:none;"><%= per.getId() %></td>
                                        <td style="text-align:center; padding:12px;">
                                            <img src="<%= per.getFilename1() %>" width="160" height="60"
                                                 style="object-fit:contain; border-radius:6px; border:1px solid #eee; padding:4px; background:#fafafa;"
                                                 alt="Logo empresa"/>
                                        </td>
                                        <td style="font-weight:600; color:#1a1f2e; font-size:14px; vertical-align:middle;">
                                            <%= per.getNombre() %>
                                            <div style="font-size:12px; color:#888; font-weight:400; margin-top:2px;"><%= per.getAdicional() %></div>
                                        </td>
                                        <td style="vertical-align:middle;">
                                            <span style="font-family:monospace; font-size:13px; background:#f4f6fb; padding:3px 10px; border-radius:6px; color:#333;">
                                                <%= per.getNro() %>
                                            </span>
                                        </td>
                                        <td style="vertical-align:middle; font-size:13px; color:#555;">
                                            <%= per.getDireccion() %>
                                            <% if (per.getUbigeo() != null && !per.getUbigeo().isEmpty()) { %>
                                            <div style="font-size:11.5px; color:#aaa; margin-top:2px;"><%= per.getUbigeo() %></div>
                                            <% } %>
                                        </td>
                                        <td style="text-align:center; vertical-align:middle;">
                                            <a href="EmpresaController?accion=editar&id=<%= per.getId() %>"
                                               class="btn-accion btn-edit" title="Editar empresa">
                                                <i class="fas fa-pencil-alt"></i>
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
        <script src="plugins/toastr/toastr.min.js"></script>
    </body>
</html>
