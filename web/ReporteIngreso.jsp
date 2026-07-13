<%@page import="com.pe.model.entity.Motivo"%>
<%@page import="com.pe.DAO.MotivoDAO"%>
<%@page import="com.pe.model.entity.Movimiento"%>
<%@page import="com.pe.DAO.MovimientoDAO"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Registro de Ingreso | Alicorp</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/tabletools/2.2.4/css/dataTables.tableTools.min.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.css">
        <link rel="stylesheet" type="text/css" href="" id="css">
        <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
        <%--Buscador select.---%>
        <link rel="//cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
        <script src="//cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
        <%@include file="css-plantilla.jsp"%> 
        <%-- finBuscador select.---%>
        <style>
            /* Estilo Alicorp aplicado sin tocar la estructura ni la lógica de los filtros */
            .card.card-default { border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,.07); }
            .card.card-default > .card-header { background: #fff !important; border-bottom: 1px solid #f0f0f0; padding: 16px 20px; }
            .card.card-default > .card-header .card-title { color: #1a1f2e !important; font-size: 15px; font-weight: 600; }
            .card.card-default > .card-header .card-title::before { content: "\f0b0"; font-family: "Font Awesome 5 Free"; font-weight: 900; color: #C8102E; margin-right: 8px; }
            .card-outline.card-info { border: none !important; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,.07); }
            .content-header { padding: 18px 24px 6px; }
            .content { padding: 0 24px 24px; }
            .form-control:focus, .select2-container--default.select2-container--focus .select2-selection { border-color: #C8102E !important; box-shadow: 0 0 0 3px rgba(200,16,46,.1) !important; }
            input[type="radio"] { accent-color: #C8102E; margin-right: 4px; }
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
                        <i class="fas fa-file-import" style="color:#C8102E; margin-right:10px;"></i>
                        Registro de Ingreso
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Reporte de Notas de Ingreso</p>
                </div>
            </section>
            <section class="content">
                <form id="newmovimiento" method="post" name="accion">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-default">
                                <div class="card-header">
                                    <h3 class="card-title">Filtros de Reporte</h3>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="form-group col-md-3">
                                            <label>Proveedor</label>
                                            <select class="form-control select2" id="fProveedor">
                                                <option value="">-- Todos --</option>
                                                <% AuxiliarDAO cdao = new AuxiliarDAO();
                                                   List<Auxiliar> clist = cdao.ListadoProveedor();
                                                   Iterator<Auxiliar> itclient = clist.iterator();
                                                   Auxiliar cli = null;
                                                   while (itclient.hasNext()) {
                                                       cli = itclient.next(); %>
                                                <option value="<%=cli.getNombre()%>"><%=cli.getNombre()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label>N&uacute;mero de Documento</label>
                                            <select class="form-control select2" id="fDocumento">
                                                <option value="">-- Todos --</option>
                                                <% MovimientoDAO vddao = new MovimientoDAO();
                                                   List<Movimiento> vdlist = vddao.ListadoNotaIngresoNI();
                                                   Iterator<Movimiento> iitvent = vdlist.iterator();
                                                   Movimiento dvent = null;
                                                   while (iitvent.hasNext()) {
                                                       dvent = iitvent.next(); %>
                                                <option value="<%=dvent.getSerie()%>-<%=dvent.getCorrelativo()%>"><%=dvent.getSerie()%>-<%=dvent.getCorrelativo()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label>Motivo</label>
                                            <select class="form-control select2" id="fMotivo">
                                                <option value="">-- Todos --</option>
                                                <% MotivoDAO vvddao = new MotivoDAO();
                                                   List<Motivo> vdlistv = vvddao.ListadoIngresoActivo();
                                                   Iterator<Motivo> iitventv = vdlistv.iterator();
                                                   Motivo dventv = null;
                                                   while (iitventv.hasNext()) {
                                                       dventv = iitventv.next(); %>
                                                <option value="<%=dventv.getNombre()%>"><%=dventv.getNombre()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label>Desde</label>
                                            <input class="form-control" type="date" id="fDesde">
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label>Hasta</label>
                                            <input class="form-control" type="date" id="fHasta">
                                        </div>
                                        <div class="form-group col-md-1" style="display:flex; align-items:flex-end;">
                                            <button type="button" id="btnLimpiarFiltros" class="btn" style="background:#f0f0f0;color:#555;border:none;border-radius:6px;width:100%;">Limpiar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card card-outline card-info">
                                <!--   <div class="card card-primary">
                              <div class="card-header">
                                     <h3 class="card-title">Ion Slider</h3>
                                     <div class="card-tools">
                                         <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                             <i class="fas fa-minus"></i>
                                         </button>
                                         <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
                                             <i class="fas fa-times"></i>
                                         </button>
                                     </div>
                                 </div>-->

                                <div class="card-body  ">

                                    <div class="full-width panel-content" id="div1">
                                        <table id="B" class="table table-striped table-bordered second" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th style="display:none;">N°</th>
                                                    <th>Proveedor</th>
                                                    <th>Nro Identidad</th>
                                                    <th style="display:none;">Doc</th>
                                                    <th>Numeracion</th>
                                                    <th >Motivo</th>
                                                    <th>Fecha (D/M/A)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%  MovimientoDAO vdao = new MovimientoDAO();
                                                    List<Movimiento> vlist = vdao.ListadoNotaIngresoNI();
                                                    Iterator<Movimiento> itvent = vlist.iterator();
                                                    Movimiento vent = null;
                                                    double tot = 0.00;
                                                    while (itvent.hasNext()) {
                                                        vent = itvent.next();

                                                %>
                                                <tr>
                                                    <td style="display:none;" id="idni"><%= vent.getIdmovimiento()%></td>
                                                    <td><%= AuxiliarDAO.getNombre(vent.getIdauxiliar())%></td>
                                                    <td><%= AuxiliarDAO.getnrodocumento(vent.getIdauxiliar())%></td>
                                                    <td style="display:none;"><%= vent.getTipocomprobante()%></td>
                                                    <td><%= vent.getSerie()%>-<%= vent.getCorrelativo()%></td>
                                                    <td><%= MotivoDAO.getNombreMotivo(vent.getIdmotivo())%></td>
                                                    <%
                                                        String da = vent.getFecha();
                                                        String newdd = da;
                                                        try {
                                                            if (da != null && da.length() >= 10) {
                                                                String soloFecha = da.substring(0, 10);
                                                                if (soloFecha.charAt(4) == '-') {
                                                                    String[] partes = da.split(" ")[0].split("-");
                                                                    newdd = String.format("%02d/%02d/%04d", Integer.parseInt(partes[2]), Integer.parseInt(partes[1]), Integer.parseInt(partes[0]));
                                                                } else if (soloFecha.charAt(2) == '/') {
                                                                    newdd = soloFecha;
                                                                }
                                                            }
                                                        } catch (Exception ex) {
                                                            newdd = da;
                                                        }
                                                    %>
                                                    <td><%= newdd%></td>
                                                    <%
                                                        }
                                                    %>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>                                                             
                        </div>
                    </div>
                </form>   
            </section> 
        </div>
    </body>
    <%@include file="js-plantilla.jsp"%> 

    <script src="dist/js/search.js" type="text/javascript"></script>
    <script src ="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
    <script src ="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>

    <script src ="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
    <script src ="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
    <script src ="//cdn.datatables.net/tabletools/2.2.4/js/dataTables.tableTools.min.js"></script>
    <script src ="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
    <script src ="https://cdn.datatables.net/datetime/1.1.0/js/dataTables.dateTime.min.js"></script>
    <script src="plugins/select2/js/select2.full.min.js"></script>
    <script src="Validacionysweetalert/NotaIngreso.js" type="text/javascript"></script>
    <script>
                                                $(function () {
                                                    //Initialize Select2 Elements
                                                    $('.select2').select2()

                                                    //Initialize Select2 Elements
                                                    $('.select2bs4').select2({
                                                        theme: 'bootstrap4'
                                                    })
                                                })

    </script>
    <script>
        function parseFechaDMA(str) {
            if (!str) return null;
            var partes = str.split('/');
            if (partes.length !== 3) return null;
            return new Date(partes[2], partes[1] - 1, partes[0]);
        }

        function parseFechaISO(str) {
            if (!str) return null;
            var partes = str.split('-');
            if (partes.length !== 3) return null;
            return new Date(partes[0], partes[1] - 1, partes[2]);
        }

        $.fn.dataTable.ext.search.push(function (settings, data) {
            var fProv = $('#fProveedor').val();
            var fDoc = $('#fDocumento').val();
            var fMot = $('#fMotivo').val();
            var desde = parseFechaISO($('#fDesde').val());
            var hasta = parseFechaISO($('#fHasta').val());

            if (fProv && data[1] !== fProv) return false;
            if (fDoc && data[4] !== fDoc) return false;
            if (fMot && data[5] !== fMot) return false;

            if (desde || hasta) {
                var fFila = parseFechaDMA(data[6]);
                if (!fFila) return false;
                if (desde && fFila < desde) return false;
                if (hasta && fFila > hasta) return false;
            }
            return true;
        });

        $(document).ready(function () {
            var table = $('#B').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    {extend: 'copyHtml5', text: 'Copiar tabla', footer: true},
                    {extend: 'excelHtml5', text: 'Exportar Excel', footer: true, title: 'Registro de Ingreso - Alicorp'},
                    {extend: 'pdfHtml5', text: 'Exportar PDF', footer: true, title: 'Registro de Ingreso - Alicorp'},
                    {
                        extend: 'print',
                        text: 'Imprimir Reporte',
                        footer: true,
                        title: '',
                        customize: function (win) {
                            $(win.document.body)
                                .css('font-family', 'Arial, Helvetica, sans-serif')
                                .css('color', '#2C2C2A')
                                .prepend(
                                    '<div style="background:#C8102E;color:#fff;padding:16px 22px;margin-bottom:6px;">' +
                                    '<h1 style="margin:0;font-size:20px;">Alicorp S.A.A.</h1>' +
                                    '<p style="margin:2px 0 0;font-size:12px;">Registro de Ingreso &mdash; Sistema SIGA v1.0</p>' +
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

            $('#fProveedor, #fDocumento, #fMotivo').on('change', function () { table.draw(); });
            $('#fDesde, #fHasta').on('change', function () { table.draw(); });
            $('#btnLimpiarFiltros').on('click', function () {
                $('#fProveedor, #fDocumento, #fMotivo').val('').trigger('change');
                $('#fDesde, #fHasta').val('');
                table.draw();
            });
        });
    </script>
</html>
