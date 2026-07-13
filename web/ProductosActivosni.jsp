<%@page import="com.pe.DAO.ClasificacionDAO"%>
<%@page import="com.pe.DAO.SubcategoriaDAO"%>
<%@page import="com.pe.DAO.CategoriaDAO"%>
<%@page import="com.pe.DAO.UnidadVentaDAO"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="com.pe.model.entity.Producto"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista de documentos</title>
        <%@include file="css-plantilla.jsp"%> 
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
    </head>
    <body class="hold-transition sidebar-mini">
        <!-- Navbar -->
        <%@include file="Frmmenu.jsp" %>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 col-sm-12">
                            <div class="card card-primary card-tabs">
                                <div class="card-header">
                                    <h3 class="card-title" style="color: white;">ALMACEN GENERAL</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <br>
                                </div>
                                <div class="card-body">
                                    <div class="tab-content" id="custom-tabs-one-tabContent">
                                        <div class="tab-pane fade show active" id="custom-tabs-one-home" role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">
                                            <div class="table-wrapper">
                                                <table id="B" class="table table-striped table-bordered table-sm " cellspacing="0"
                                                       width="100%">
                                                    <thead style="text-align: center">
                                                        <tr>
                                                            <th style="display:none;">Id</th>
                                                            <th style="width:5px">OK</th>
                                                            <th>Código</th>
                                                            <th style="width:450px">Descripción</th>
                                                            <th style="width:50px">U.medida</th>
                                                            <th>Stock</th>
                                                            <th>Clasificación</th>
                                                            <th>Categoría</th>
                                                            <th>SubCategoria</th>
                                                            <th>Estado</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%ProductoDAO pdao = new ProductoDAO();
                                                            List<Producto> listS = pdao.ListadoEstadoActivo();
                                                            Iterator<Producto> iterr = listS.iterator();
                                                            Producto pro = null;
                                                            while (iterr.hasNext()) {
                                                                pro = iterr.next();%>
                                                        <tr>
                                                            <td style="display:none;;"><%= pro.getIdproducto()%></td>
                                                            <td style="width:50px">
                                                                <a  href="ControllerdatosModal?accion=Cantidadni&id=<%=pro.getIdproducto()%>"  data-toggle="modal" data-target="#myModalEdit"><i class="glyphicon glyphicon-plus-sign" style="color: #09bb04" data-toggle="tooltip" title="agregar"></i></a>

                                                            </td>
                                                            <td><%=pro.getCodigo()%></td>
                                                            <td style="width:450px"><%=pro.getDescripcion()%></td>
                                                            <td style="width:5px"><%=UnidadVentaDAO.getUndVenta(pro.getIdproducto())%></td>
                                                            <td align="right"><%=String.format("%.2f", pro.getStock())%></td>
                                                            <td><%=ClasificacionDAO.getNombreClasificacion(pro.getIdproducto())%></td>
                                                            <td><%=CategoriaDAO.getNombreCategoria(pro.getIdproducto())%></td>
                                                            <td><%=SubcategoriaDAO.getNombreSubcaregoria(pro.getIdproducto())%></td>
                                                            <% String Estado = pro.getEstado();
                                                            if (Estado.equalsIgnoreCase("Activo")) {%>
                                                            <td><markactivo><%= Estado%></markactivo></td>   
                                                            <%   } else {%>
                                                    <td><markdesactivado><%= Estado%></markdesactivado></td>    
                                                        <%     }
                                                        %>

                                                    </tr>
                                                    <%}%>

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.card -->
                            </div>
                        </div>

                    </div>

                </div>
                <!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!--Formulario de Modificar-->
        <div class="modal fade" id="myModalEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document" style="z-index: 9999; width: 450px">
                <div class="modal-content">

                    <div class="modal-body">

                    </div>
                </div>                    
            </div>
        </div>
    </body>
    <script src="assets/jqueryy.js" type="text/javascript"></script>
    <script src="dist/js/bootstrap.min.js" type="text/javascript"></script>
    <%@include file="js-plantilla.jsp"%>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>                   
    <script src="plugins/toastr/toastr.min.js"></script>
    <script src="assets/libs/js/Datatable.js" type="text/javascript"></script>
</html>
