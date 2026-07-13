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
        <title>Nota de Salida Plastitex"</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/tabletools/2.2.4/css/dataTables.tableTools.min.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.css">
        <link rel="stylesheet" type="text/css" href="" id="css">
        <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
        <%--Buscador select.---%>
        <link rel="//cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
        <script src="//cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
                <%@include file="css-plantilla.jsp"%> 
        <%-- finBuscador select.---%>
    </head>
    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <!-- pageContent -->
        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                                <i class="fas fa-dolly" style="color:#C8102E; margin-right:10px;"></i>
                                Nota de Salida
                            </h3>
                            <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Movimientos de Almac&eacute;n</p>
                        </div>
                        <a href="InsertarNotadeSalida.jsp" style="background:#C8102E;color:#fff;border:none;border-radius:8px;padding:11px 22px;font-size:13.5px;font-weight:500;text-decoration:none;display:inline-flex;align-items:center;gap:6px;">
                            <i class="fas fa-plus"></i> Registrar Nueva Nota de Salida
                        </a>
                    </div>
                </div>
            </section>
            <section class="content" style="padding:0 24px 24px;">
                <form id="newmovimiento" method="post" name="accion">
                    <div class="row">
                        <div class="col-md-12">
                            <!--modal listar-->
                            <div class="card" style="border-radius:12px; overflow:hidden; border:none; box-shadow:0 2px 12px rgba(0,0,0,.07);">
                                <div class="card-header" style="background:#fff; border-bottom:1px solid #f0f0f0;">
                                    <h3 class="card-title" style="color:#1a1f2e; font-size:14px; font-weight:600;"><i class="fas fa-filter" style="color:#C8102E;margin-right:6px;"></i>Filtros de b&uacute;squeda</h3>
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
                                    <p style="font-size:12px; color:#888; margin:-6px 0 14px;">
                                        <i class="fas fa-info-circle" style="color:#C8102E;"></i>
                                        Filtra por <b>Cliente/Destino</b> (a qui&eacute;n sali&oacute; el producto), por su <b>N&uacute;mero de documento</b>,
                                        por el <b>N&uacute;mero de la nota</b> ya emitida, o por un <b>rango de fechas</b>. Puedes combinar varios filtros a la vez.
                                    </p>
                                    <div class="row">
                                        <div class="form-group col-md-3">
                                            <%                                        String clisel = "";
                                                String docsel = "";
                                                String fechSel = "";
                                                String sel = clisel + " " + docsel + " " + fechSel;
                                            %>
                                            <input type="hidden" id="todclisel" value="" />
                                            <input type="hidden" id="clisel" value="" />
                                            <input type="hidden" id="clirucsel" value="" />

                                            <input type="hidden" id="toddocsel" value="" />
                                            <input type="hidden" id="docsel" value="" />

                                            <input type="hidden" id="todpersel" value="" />
                                            <input type="hidden" id="persel" value="" />

                                            <input type="hidden" id="fechsel" value="" />


                                            <script>

                                                function validaciones() {
                                                    if (document.getElementById('rbTodCli').checked ||
                                                            document.getElementById('rbCli').checked ||
                                                            document.getElementById('rbRUC').checked ||
                                                            document.getElementById('rbTodDoc').checked ||
                                                            document.getElementById('rbDoc').checked
                                                            ) {
                                                        document.getElementById('todclisel').value = '';
                                                        document.getElementById('clisel').value = document.getElementById('cbCli').value.toLowerCase();
                                                        document.getElementById('clirucsel').value = document.getElementById('cbRU').value.toLowerCase();

                                                        document.getElementById('toddocsel').value = '';
                                                        document.getElementById('docsel').value = document.getElementById('cbDoc').value.toLowerCase();

                                                        document.getElementById('todpersel').value = '';

                                                        var fecha = '';

                                                    }

                                                    document.getElementById('selInfo').value = document.getElementById('todclisel').value.toLowerCase() + ' ' +
                                                            document.getElementById('clisel').value.toLowerCase() + ' ' +
                                                            document.getElementById('clirucsel').value.toLowerCase() + ' ' +
                                                            document.getElementById('toddocsel').value.toLowerCase() + ' ' +
                                                            document.getElementById('docsel').value.toLowerCase() + ' ' +
                                                            document.getElementById('todpersel').value.toLowerCase() + ' ' +
                                                            document.getElementById('persel').value.toLowerCase() + ' ' + fecha;

                                                    console.log(document.getElementById('selInfo').value.toLowerCase());
                                                }
                                            </script>


                                            <input type="radio" value="" id="rbTodCli" name = "cliente" onclick="
                                                    cbCliente.disabled = true;
                                                    cbRUC.disabled = true;
                                                    document.getElementById('cbCli').value = '';
                                                    document.getElementById('cbRU').value = '';
                                                    validaciones();
                                                    document.getElementById('selInfo').focus();

                                                   "checked="true"  
                                                   >
                                            <label>Todos:</label>

                                            <input type="radio" value="" id="rbCli" name = "cliente" onclick="
                                                    cbCliente.disabled = false;
                                                    cbRUC.disabled = true;
                                                    document.getElementById('cbRU').value = '';

                                                   ">
                                            <label style="text-align:right">Cliente:</label>
                                            <select class="form-control select2" name="cbCliente" id="cbCli" required="" disabled="true"
                                                    onchange="
                                                            validaciones();
                                                            document.getElementById('selInfo').focus();
                                                    ">
                                                <option value ="" selected ="" >Todos</option>
                                                <%  AuxiliarDAO pdao = new AuxiliarDAO();
                                                    List<Auxiliar> prov = pdao.ListadoCliente();
                                                    Iterator<Auxiliar> itclient = prov.iterator();
                                                    Auxiliar prove = null;

                                                    while (itclient.hasNext()) {
                                                        prove = itclient.next();
                                                %>
                                                <option value="<%=prove.getNombre()%>"><%=prove.getNombre()%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-3">
                                            <input type="radio"  value="" id="rbRUC" name = "cliente" onclick="
                                                    cbCliente.disabled = true;
                                                    cbRUC.disabled = false;
                                                    document.getElementById('cbCli').value = '';

                                                   ">
                                            <label  style="text-align:right">Nro Identidad:</label>
                                            <select class="form-control select2" name="cbRUC" id="cbRU" required="" disabled="true"
                                                    onchange="validaciones();
                                                            document.getElementById('selInfo').focus();">
                                                <option value =""  selected="" style="text-align: center">Todos</option>
                                                <%
                                                    Iterator<Auxiliar> itclien = prov.iterator();
                                                    while (itclien.hasNext()) {
                                                        prove = itclien.next();
                                                %>
                                                <option value="<%=prove.getNumerodocumento()%>"><%=prove.getNumerodocumento()%></option>
                                                <%}%>
                                            </select>
                                            <input type="text" value="" id="selInfo" placeholder="Resultados de la busqueda" 
                                                   readonly="true"
                                                   style="width: 0px;height: 0px; outline: none; border-color: transparent"
                                                   >
                                        </div>
                                        <div class="form-group col-md-2">
                                            <input type="radio" value="" id="rbTodDoc" name ="doc"style="align-items: center" onclick="
                                                    cbDocu.disabled = true;
                                                    document.getElementById('cbDoc').value = '';
                                                    validaciones();
                                                    document.getElementById('selInfo').focus();
                                                   " 
                                                   checked="true">
                                            <label>Todos</label>

                                            <input type="radio" value="" id="rbDoc" name = "doc"style="align-items: center" onclick="
                                                    cbDocu.disabled = false;

                                                   ">
                                            <label>Documentos:</label>
                                            <select class="form-control select2" name="cbDocu" id="cbDoc" required="" disabled="true"
                                                    onchange="validaciones();
                                                            document.getElementById('selInfo').focus();">
                                                <option value =""  selected="" style="text-align: center">Todos</option>
                                                <% MovimientoDAO vddao = new MovimientoDAO();
                                                    List<Movimiento> vdlist = vddao.ListadoNotaSalidaNS();
                                                    Iterator<Movimiento> iitvent = vdlist.iterator();
                                                    Movimiento dvent = null;
                                                    while (iitvent.hasNext()) {
                                                        dvent = iitvent.next();
                                                %>
                                                <option value="<%=dvent.getSerie()%>-<%=dvent.getCorrelativo()%>"><%=dvent.getSerie()%>-<%=dvent.getCorrelativo()%></option>
                                                <%}%>
                                            </select> 

                                        </div>

                                        <%Date date = new Date();
                                            DateFormat dfm = new SimpleDateFormat("yyyy-MM-dd");
                                            String d = dfm.format(date).toString();
                                            int year = date.getYear();
                                        %>
                                        <div class="form-group col-md-2">
                                            <input type="radio" name="periodo" id="rbPer3" style="align-items: center" onclick="

                                                    validaciones();
                                                    document.getElementById('selInfo').focus();
                                                    document.getElementById('fec2').focus();
                                                    document.getElementById('fec3').focus();
                                                    retornarcss()
                                                    fecha2.disabled = false;
                                                    fecha3.disabled = false;
                                                   ">
                                            <label >Desde:</label>
                                            <input class="form-control" type="text" name="fecha2" value="" id="fec2" disabled="true" readonly="true"/>
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label  >Hasta:</label>
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
                                                    <th>Cliente</th>
                                                    <th>Nro Identidad</th>
                                                    <th style="display:none;">Doc</th>
                                                    <th>Numeración</th>
                                                    <th style="display:none;">Correlativo</th>
                                                    <th>Fecha(M/D/A)</th>
                                                    <th>Estado</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%  MovimientoDAO vdao = new MovimientoDAO();
                                                    List<Movimiento> vlist = vdao.ListadoNotaSalidaNS();
                                                    Iterator<Movimiento> itvent = vlist.iterator();
                                                    Movimiento vent = null;
                                                    double tot = 0.00;
                                                    while (itvent.hasNext()) {
                                                        vent = itvent.next();

                                                %>
                                                <tr>
                                                    <td style="display:none;" id="idv"><%= vent.getIdmovimiento()%></td>
                                                    <td><%= AuxiliarDAO.getNombre(vent.getIdauxiliar())%></td>
                                                    <td><%= AuxiliarDAO.getnrodocumento(vent.getIdauxiliar())%></td>
                                                    <td style="display:none;"><%= vent.getTipocomprobante()%></td>
                                                    <td><%= vent.getSerie()%>-<%= vent.getCorrelativo()%></td>
                                                    <td style="display:none;"><%= vent.getCorrelativo()%></td>
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
                                                    <td><%=newdd%></td>
                                                    <% String Estado = vent.getEstado();
                                                        if (Estado.equalsIgnoreCase("Terminado")) {%>
                                                    <td style="width:2px"><markTerminado><%= Estado%></markTerminado></td>   
                                                    <%   } else {%>
                                            <td style="width:2px"><markanulado><%= Estado%></markanulado></td>    
                                                <%     }
                                                %>
                                            <td>
                                                <%
                                                    if (Estado.equalsIgnoreCase("Terminado")) {%>
                                                <a id='btn-anular' class="btn-sm btn-danger" class="anular"><i class="glyphicon glyphicon-remove-sign" data-toggle="tooltip" title="Anular"></i>Anular</a>
                                                <%   } else { %>
                                                <%     }
                                                %>
                                                <a href="DetallePDFController?accion=DetalleNS&id=<%= vent.getIdmovimiento()%>" class="btn-sm btn-success" >Detalle</a>
                                            </td>
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
    <!--script src ="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src ="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script-->
    <script src ="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src ="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
    <script src ="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
    <script src ="//cdn.datatables.net/tabletools/2.2.4/js/dataTables.tableTools.min.js"></script>
    <script src ="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
    <script src ="https://cdn.datatables.net/datetime/1.1.0/js/dataTables.dateTime.min.js"></script>
    <script src="plugins/select2/js/select2.full.min.js"></script>
    <script src="Validacionysweetalert/NotaSalida.js" type="text/javascript"></script>
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

