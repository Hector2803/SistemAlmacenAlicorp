<%@page import="com.pe.DAO.UnidadVentaDAO"%>
<%@page import="com.pe.model.entity.Producto"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="com.pe.model.entity.Subcategoria"%>
<%@page import="com.pe.DAO.SubcategoriaDAO"%>
<%@page import="com.pe.model.entity.Categoria"%>
<%@page import="com.pe.DAO.CategoriaDAO"%>
<%@page import="com.pe.model.entity.Clasificacion"%>
<%@page import="com.pe.DAO.ClasificacionDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Stock Máximo | Alicorp</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/tabletools/2.2.4/css/dataTables.tableTools.min.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.css">
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
            .dt-buttons .btn { background: #C8102E !important; border-color: #C8102E !important; color: #fff !important; border-radius: 6px !important; font-size: 12px !important; }
            .dt-buttons .btn:hover { background: #a50d25 !important; }
        </style>
    </head>

    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <!-- pageContent -->
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-arrow-up" style="color:#C8102E; margin-right:10px;"></i>
                        Stock Máximo
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Inventario actual del almac&eacute;n</p>
                </div>
            </section>
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card card-default">
                            <div class="card-header">
                                <h3 class="card-title">Filtros</h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Clasificaci&oacute;n</label>
                                        <select class="form-control select2" id="fClasificacion">
                                            <option value="">-- Todas --</option>
                                            <% ClasificacionDAO mar = new ClasificacionDAO();
                                               List<Clasificacion> list = mar.ListadoEstadoActivos();
                                               Iterator<Clasificacion> ite = list.iterator();
                                               Clasificacion m = null;
                                               while (ite.hasNext()) { m = ite.next(); %>
                                            <option value="<%=m.getNombre()%>"><%=m.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Categor&iacute;a</label>
                                        <select class="form-control select2" id="fCategoria">
                                            <option value="">-- Todas --</option>
                                            <% CategoriaDAO cat = new CategoriaDAO();
                                               List<Categoria> lista = cat.ListadoEstadoActivos();
                                               Iterator<Categoria> iter = lista.iterator();
                                               Categoria c = null;
                                               while (iter.hasNext()) { c = iter.next(); %>
                                            <option value="<%=c.getNombre()%>"><%=c.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label>Subcategor&iacute;a</label>
                                        <select class="form-control select2" id="fSubcategoria">
                                            <option value="">-- Todas --</option>
                                            <% SubcategoriaDAO pd = new SubcategoriaDAO();
                                               List<Subcategoria> listaa = pd.ListadoEstadoActivos();
                                               Iterator<Subcategoria> iterrr = listaa.iterator();
                                               Subcategoria pbl = null;
                                               while (iterrr.hasNext()) { pbl = iterrr.next(); %>
                                            <option value="<%=pbl.getNombre()%>"><%=pbl.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-1" style="display:flex; align-items:flex-end;">
                                        <button type="button" id="btnLimpiarFiltros" class="btn" style="background:#f0f0f0;color:#555;border:none;border-radius:6px;width:100%;">Limpiar</button>
                                    </div>
                                </div>
                                <p style="font-size:11.5px;color:#999;margin:-4px 0 0;">Usa el buscador de la tabla (arriba a la derecha) para encontrar un producto por c&oacute;digo o nombre.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Lista de Productos</h3>
                            </div>
                            <div class="card-body">
                                <%  ProductoDAO pddaoPreview = new ProductoDAO();
                                    boolean sinAlertas = pddaoPreview.ListadoStockmaximoyActivo().isEmpty();
                                    if (sinAlertas) { %>
                                <div style="background:#e8f5e9; border:1px solid #a9e0bb; color:#1e7a3d; padding:12px 16px; border-radius:8px; font-size:13px; margin-bottom:16px;">
                                    <i class="fas fa-check-circle"></i> Ning&uacute;n producto est&aacute; actualmente por encima de su stock m&aacute;ximo configurado. No hay sobrestock que reportar.
                                </div>
                                <% } %>
                                <table id="datatable" class="table table-striped table-bordered second" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>C&oacute;digo</th>
                                            <th style="width:280px">Descripci&oacute;n</th>
                                            <th style="width:90px">U. Medida</th>
                                            <th style="width:100px">Stock Máximo</th>
                                            <th>C&oacute;digo Anexo</th>
                                            <th>Clasificaci&oacute;n</th>
                                            <th>Categor&iacute;a</th>
                                            <th>Subcategor&iacute;a</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% ProductoDAO pddao = new ProductoDAO();
                                           List<Producto> listS = pddao.ListadoStockmaximoyActivo();
                                           Iterator<Producto> iterr = listS.iterator();
                                           Producto pro = null;
                                           while (iterr.hasNext()) {
                                               pro = iterr.next(); %>
                                        <tr>
                                            <td><%=pro.getCodigo()%></td>
                                            <td style="width:280px"><%=pro.getDescripcion()%></td>
                                            <td style="width:90px"><%=UnidadVentaDAO.getUndVenta(pro.getIdproducto())%></td>
                                            <td style="text-align:right;"><%=String.format("%.2f", pro.getStockmaximo())%></td>
                                            <td><%=pro.getCodigoanexo()%></td>
                                            <td><%=ClasificacionDAO.getNombreClasificacion(pro.getIdproducto())%></td>
                                            <td><%=CategoriaDAO.getNombreCategoria(pro.getIdproducto())%></td>
                                            <td><%=SubcategoriaDAO.getNombresubcategoria(pro.getIdproducto())%></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </body>
    <%@include file="js-plantilla.jsp"%>

    <script src="dist/js/search.js" type="text/javascript"></script>
    <script src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
    <script src="//cdn.datatables.net/tabletools/2.2.4/js/dataTables.tableTools.min.js"></script>
    <script src="plugins/select2/js/select2.full.min.js"></script>
    <script>
        $(function () {
            $('.select2').select2();
        });

        $.fn.dataTable.ext.search.push(function (settings, data) {
            var fCla = $('#fClasificacion').val();
            var fCat = $('#fCategoria').val();
            var fSub = $('#fSubcategoria').val();

            if (fCla && data[5] !== fCla) return false;
            if (fCat && data[6] !== fCat) return false;
            if (fSub && data[7] !== fSub) return false;
            return true;
        });

        $(document).ready(function () {
            var table = $('#datatable').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    {extend: 'copyHtml5', text: 'Copiar tabla', footer: true},
                    {extend: 'excelHtml5', text: 'Exportar Excel', footer: true},
                    {extend: 'pdfHtml5', text: 'Exportar PDF', footer: true},
                    {extend: 'print', text: 'Imprimir Reporte', footer: true}
                ]
            });

            $('#fClasificacion, #fCategoria, #fSubcategoria').on('change', function () { table.draw(); });
            $('#btnLimpiarFiltros').on('click', function () {
                $('#fClasificacion, #fCategoria, #fSubcategoria').val('').trigger('change');
                table.draw();
            });
        });
    </script>
</html>
