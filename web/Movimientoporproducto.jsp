

<%@page import="com.pe.model.entity.DetalleMovimiento"%>
<%@page import="com.pe.model.entity.Producto"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
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
        <title>Documentos de Compra Plastitex"</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/tabletools/2.2.4/css/dataTables.tableTools.min.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.css">
        <link rel="stylesheet" type="text/css" href="" id="css">
        <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
        <%--Buscador select.---%>
        <link rel="//cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
        <script src="//cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>

        <%-- finBuscador select.---%>
        <%@include file="css-plantilla.jsp"%> 
    </head>
    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <%            ProductoDAO dao = new ProductoDAO();
            int id = Integer.parseInt((String) request.getAttribute("idmovi"));
            Producto p = (Producto) dao.BuscarPorId(id);
        %>
        <!-- pageContent -->
        <div class="content-wrapper">
            <section class="content-header">
            </section>
            <section class="content">
                <form id="newmovimiento" method="post" name="accion">
                    <div class="row">
                        <div class="col-md-12">
                            <!--modal listar-->
                            <div class="card card-default">
                                <div class="card-header">
                                    <h3 class="card-title" style="color: white;">Movimiento de productos</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body"> 
                                    <div class="row">
                                        <div class="form-group col-md-3"> 
                                            <label>Fechas:</label>
                                            <input class="form-control" type="text" name="fecha2" value="" id="fec2" disabled="true" readonly="true"/>
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label>Hasta:</label>
                                            <input class="form-control" type="text" name="fecha3" value="" id="fec3" disabled="true" readonly="true"/>
                                        </div>
                                    </div>  
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card card-outline card-info">
                                <div class="card-body  ">
                                    <div class="full-width panel-content" id="div1">
                                        <table id="B" class="table table-striped table-bordered second" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th style="display:none;">Id</th>
                                                    <th>Razón social</th>
                                                    <th style="display:none;">Documento</th>
                                                    <th style="width:30px; text-align: center">Numeración</th>
                                                    <th style="width:10px; text-align: center">Fecha</th>
                                                    <th>Ingreso</th>
                                                    <th>Salida</th>
                                                    <th>Stock actual</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <%  MovimientoDAO pdao = new MovimientoDAO();
                                                    List<DetalleMovimiento> listS = pdao.Detallemovimientoporproducto(id);
                                                    Iterator<DetalleMovimiento> iterr = listS.iterator();
                                                    DetalleMovimiento pro = null;
                                                    double total = 0, igv = 0, subtotal = 0;
                                                    DecimalFormat formatea = new DecimalFormat("###,###.##");
                                                    String Msubtotal = "";
                                                    String Migv = "";
                                                    while (iterr.hasNext()) {
                                                        pro = iterr.next();
                                                %>
                                                <tr>
                                                    <td style="display:none;"><%= pro.getIddetalle()%></td>
                                                    <td ><%= AuxiliarDAO.getNombremostrarendetalle(pro.getIdmovimiento())%></td>
                                                    <td style="display:none;"><%=MovimientoDAO.getNombredocumento(pro.getIdmovimiento())%></td>
                                                    <td style="width:40px; text-align: center"><%=MovimientoDAO.getseriedocumento(pro.getIdmovimiento())%>-<%=MovimientoDAO.getcorrelativodocumento(pro.getIdmovimiento())%></td>
                                                    <td style="width:10px; text-align: center"><%=MovimientoDAO.getfechadocumento(pro.getIdmovimiento())%></td>
                                                    <td style=" text-align: center"><%=pro.getCantidad()%></td>
                                                    <td style=" text-align: center"><%=pro.getCosto()%></td>
                                                    <td style=" text-align: center"><%=pro.getSubtotal()%></td>
                                                    <%
                                                        }
                                                    %>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th style="display:none;" style="text-align:right; font-size:18px;color: #000"></th>
                                                    <th style="text-align:right; font-size:18px;color: #000"></th>
                                                    <th style="display:none;" style="text-align:right; font-size:18px;color: #000"></th>
                                                    <th style="text-align:right; font-size:18px;color: #000"></th>
                                                    <th style="text-align:right; font-size:18px;color: #000;" >Producto:</th>
                                                    <th style="text-align:right; font-size:18px;color: #000"></th>
                                                    <th style="text-align:right; font-size:18px;color: #000"></th>
                                                    <th style="text-align:right; font-size:18px;color: #000"></th>

                                                </tr>
                                            </tfoot>
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
        function anularcss() {
            document.getElementById("css").href = "";
        }
        function retornarcss() {
            document.getElementById("css").href = "https://cdn.datatables.net/datetime/1.1.0/css/dataTables.dateTime.min.css";
        }
    </script>
    <script>
        var minDate, maxDate;
        // Custom filtering function which will search data in column four between two values
        $.fn.dataTable.ext.search.push(
                function (settings, data, dataIndex) {
                    var min = minDate.val();
                    var max = maxDate.val();
                    var date = new Date(data[6]);
                    if (
                            (min === null && max === null) ||
                            (min === null && date <= max) ||
                            (min <= date && max === null) ||
                            (min <= date && date <= max)
                            ) {
                        return true;
                    }
                    return false;
                }
        );
        $(document).ready(function () {
            // Create date inputs
            minDate = new DateTime($('#fec2'), {
                format: 'MM/DD/YYYY'
            });
            maxDate = new DateTime($('#fec3'), {
                format: 'MM/DD/YYYY'
            });
            // DataTables initialisation
            var table = $('#B').DataTable({
                dom: 'Bfrtip',
                pageLength: 15,
                lengthMenu: [[5, 10, 15, 20, -1], [5, 10, 15, 20, 'Todos']],
                buttons: [
                    {extend: 'copyHtml5', text: 'Copiar tabla', footer: true},
                    {extend: 'excelHtml5', text: 'Exportar Excel', footer: true},
                    {extend: 'pdfHtml5', text: 'Exportar PDF', footer: true},
                    {extend: 'print', text: 'Imprimir Reporte', footer: true}
                ],
                "footerCallback": function (row, data, start, end, display) {
                    var api = this.api(), data;
                    // Remove the formatting to get integer data for summation
                    var intVal = function (i) {
                        return typeof i === 'string' ?
                                i.replace(/(S\/.)/g, '') * 1 :
                                typeof i === 'number' ?
                                i : 0;
                    };
                    // Base imponible imponible de toda la pagina
                    total = api
                            .column(5)
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);
                    // Total over this page
                    pageTotal = api
                            .column(5, {page: 'current'})
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);
                    // Update footer
                    $(api.column(5).footer()).html(
                            '' + pageTotal.toFixed(2)/*+ ' ( S/.' + total + ' en total)'*/
                            );
                    // IGV imponible de toda la pagina
                    total = api
                            .column(6)
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);
                    // Total over this page
                    pageTotal = api
                            .column(6, {page: 'current'})
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);
                    // Update footer
                    $(api.column(6).footer()).html(
                            '' + pageTotal.toFixed(2)/*+ ' ( S/.' + total + ' en total)'*/

                            );
                }

            });


            // Refilter the table
            $('#fec2, #fec3').on('focus', function () {
                table.draw();
            });

            $('#selInfo').on('focus', function () {
                table.search(this.value).draw();
            });
        });

    </script>
    <script type="text/javascript">
        function func() {
            var cbCli = document.getElementById("cbCli");
            var textCli = cbCli.options[cbCli.selectedIndex].text;
            alert(textCli);

        }
    </script>
</html>
