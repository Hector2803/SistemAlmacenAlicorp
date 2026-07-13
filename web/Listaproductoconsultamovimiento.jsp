<%@page import="com.pe.model.entity.KardexMovimiento"%>
<%@page import="com.pe.DAO.MovimientoDAO"%>
<%@page import="com.pe.model.entity.Producto"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Movimiento por Producto | Alicorp</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"/>
        <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
        <script src="//cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
        <%@include file="css-plantilla.jsp"%>
        <style>
            .card.card-default, .card.card-primary { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,.07); }
            .card.card-default > .card-header, .card.card-primary > .card-header { background: #fff !important; border-bottom: 1px solid #f0f0f0; padding: 16px 20px; }
            .card.card-default > .card-header .card-title, .card.card-primary > .card-header .card-title { color: #1a1f2e !important; font-size: 15px; font-weight: 600; }
            .content-header { padding: 18px 24px 6px; }
            .content { padding: 0 24px 24px; }
            .form-control:focus, .select2-container--default.select2-container--focus .select2-selection { border-color: #C8102E !important; box-shadow: 0 0 0 3px rgba(200,16,46,.1) !important; }
            label { font-size: 12.5px; font-weight: 500; color: #444; }
            table.dataTable thead th { background: #f8f9fc !important; color: #555; font-size: 11px; text-transform: uppercase; letter-spacing: .4px; }
            .badge-ingreso { background:#e8f5e9; color:#2e7d32; font-weight:600; font-size:11px; padding:3px 9px; border-radius:14px; }
            .badge-salida { background:#fce4e4; color:#c62828; font-weight:600; font-size:11px; padding:3px 9px; border-radius:14px; }
            .empty-state { text-align:center; color:#999; font-size:13px; padding:30px 0; }
        </style>
    </head>

    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-stream" style="color:#C8102E; margin-right:10px;"></i>
                        Movimiento por Producto
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Historial (kardex) de un producto: todos sus ingresos y salidas</p>
                </div>
            </section>
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card card-default">
                            <div class="card-header">
                                <h3 class="card-title">Seleccionar Producto</h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-8">
                                        <label>Producto</label>
                                        <select class="form-control select2" id="fProducto" onchange="location.href='Listaproductoconsultamovimiento.jsp?idproducto=' + this.value;">
                                            <option value="">-- Selecciona un producto --</option>
                                            <% ProductoDAO pdao = new ProductoDAO();
                                               List<Producto> listaProd = pdao.ListadoProducto();
                                               Iterator<Producto> itp = listaProd.iterator();
                                               Producto pr = null;
                                               String idSel = request.getParameter("idproducto");
                                               while (itp.hasNext()) {
                                                   pr = itp.next();
                                                   boolean sel = idSel != null && idSel.equals(String.valueOf(pr.getIdproducto())); %>
                                            <option value="<%=pr.getIdproducto()%>" <%=sel ? "selected" : ""%>><%=pr.getCodigo()%> - <%=pr.getDescripcion()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <% if (idSel != null && !idSel.trim().isEmpty()) {
                       int idProdSel = Integer.parseInt(idSel);
                       MovimientoDAO mdao = new MovimientoDAO();
                       List<KardexMovimiento> kardexList = mdao.ListadoKardexPorProducto(idProdSel);
                %>
                <div class="row">
                    <div class="col-12">
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Historial de Movimientos</h3>
                            </div>
                            <div class="card-body">
                                <% if (kardexList.isEmpty()) { %>
                                <div class="empty-state"><i class="fas fa-inbox" style="font-size:22px;display:block;margin-bottom:8px;color:#ccc;"></i>Este producto todav&iacute;a no tiene movimientos registrados.</div>
                                <% } else { %>
                                <table id="datatable" class="table table-striped table-bordered second" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>Fecha</th>
                                            <th>Documento</th>
                                            <th style="text-align:center;">Tipo</th>
                                            <th style="text-align:right;">Ingreso</th>
                                            <th style="text-align:right;">Salida</th>
                                            <th style="text-align:right;">Saldo</th>
                                            <th style="text-align:right;">Costo</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (KardexMovimiento k : kardexList) { %>
                                        <tr>
                                            <td><%=k.getFecha()%></td>
                                            <td><%=k.getSerie()%>-<%=k.getCorrelativo()%></td>
                                            <td style="text-align:center;">
                                                <% if (k.getIngreso() > 0) { %>
                                                <span class="badge-ingreso">Ingreso</span>
                                                <% } else { %>
                                                <span class="badge-salida">Salida</span>
                                                <% } %>
                                            </td>
                                            <td style="text-align:right;"><%=k.getIngreso() > 0 ? String.format("%.2f", k.getIngreso()) : "-"%></td>
                                            <td style="text-align:right;"><%=k.getSalida() > 0 ? String.format("%.2f", k.getSalida()) : "-"%></td>
                                            <td style="text-align:right; font-weight:600;"><%=String.format("%.2f", k.getSaldo())%></td>
                                            <td style="text-align:right;">S/ <%=String.format("%.2f", k.getCosto())%></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </section>
        </div>
    </body>
    <%@include file="js-plantilla.jsp"%>
    <script src="plugins/select2/js/select2.full.min.js"></script>
    <script>
        $(function () {
            $('.select2').select2();
            $('#datatable').DataTable();
        });
    </script>
</html>
