<%@page import="com.pe.model.entity.Transporte"%>
<%@page import="com.pe.DAO.TransporteDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista de Transporte</title>

        <%@include file="css-plantilla.jsp"%> 
        <%@include file="css-datatable.jsp"%>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
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
                            <h2>Gestionar Transporte</h2>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <a href="#addalmacen" class="bluefacturactivaFocus js-customer-action-add btn-primary btn btn-default"  data-toggle="modal"><i class="fas fa-folder-plus"></i> &nbsp; AGREGAR</a>
                            </ol>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Transporte</h2>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body">
                                    <table id="example"  class="table table-striped table-bordered second" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th style="display:none;">codigo</th>
                                                <th>Código</th>
                                                <th>Nombre</th>
                                                <th style="text-align: center">Tipo</th>
                                                <th style="text-align: center">Estado</th>
                                                <th style="text-align: center">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%   TransporteDAO dao = new TransporteDAO();
                                                List<Transporte> list = dao.ListadoTransporte();
                                                Iterator<Transporte> iterr = list.iterator();
                                                Transporte mat = null;
                                                while (iterr.hasNext()) {
                                                    mat = iterr.next();
                                            %>
                                            <tr>
                                                <td  style="display:none;;" id="idmat"><%=mat.getIdtrans()%></td>
                                                <td><%= mat.getCodigo()%></td> 
                                                <td><%= mat.getNombre()%></td>
                                                <td><%= mat.getTipo()%></td>
                                                <% String Estado = TransporteDAO.estado(mat.getIdtrans());
                                                    if (Estado.equalsIgnoreCase("Activo")) {%>

                                                <td style="text-align: center"><markactivo><%= Estado%></markactivo></td>   
                                                <%   } else {%>

                                        <td style="text-align: center"><markdesactivado><%= Estado%></markdesactivado></td>    
                                            <%     }
                                            %> 
                                        <td style="text-align: center">
                                            <a class="btn-warning btn-sm editbtn"  data-toggle="modal" data-target="#editar"><i class="glyphicon glyphicon-pencil" data-toggle="tooltip" title="Edit"></i></a>
                                            <a id='btn-estado' class="btn-sm btn-primary"   class="edit"><i class="glyphicon glyphicon-refresh" data-toggle="tooltip" title="Estado"></i></a>
                                            <a id='btn-eliminar' class="btn-sm btn-danger"    class="edit"><i class="glyphicon glyphicon-trash" data-toggle="tooltip" title="Eliminar"></i></a>
                                        </td>
                                        </tr>
                                        <%}%>
                                        </tbody> 
                                    </table>
                                </div>
                                <!-- /.card-body -->
                            </div>
                            <!-- /.card -->
                            <!-- /.card -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- add Modal HTML -->
        <div id="addalmacen" class="modal fade" >
            <div class="modal-dialog" role="document" style="z-index: 9999; width: 450px">
                <div class="modal-content">
                    <form id="newalmacen" action="AlmacenController" method="Post" name="frm_nuevo">
                        <div class="modal-header">      
                            <h4 class="modal-title">Agregar Transporte</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">  
                            <%
                                TransporteDAO com = new TransporteDAO();
                                String numserie = com.Numserie();
                            %>
                            <div class="form-group">
                                <label>Código</label>
                                <input type="text" name="txtCod" value="<%=numserie%>"  class="form-control" readonly="" >
                            </div>
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" name="txtNom" class="form-control" placeholder="Nombre">
                            </div>  
                            <div class="form-group">
                                <label>Tipo</label>
                                <select type="text" name="txtTipo" class="form-control">
                                    <option value="">Selecciona transporte</option>
                                    <option value="Privado">Privado</option>
                                    <option value="Publico">Publico</option>

                                </select>
                            </div> 
                        </div>
                        <div class="modal-footer">
                            <input type="button"  class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input onclick="return validarTransporte()"  class="btn btn-success" type="submit" name="accion" value="Agregar">
                        </div>
                    </form>
                </div>
            </div>
        </div> 
        <!--Formulario de Modificar-->
        <div id="editar" class="modal fade" >
            <div class="modal-dialog" role="document" style="z-index: 9999; width: 450px">
                <div class="modal-content">
                    <form id="editalmacen"  method="post" action="AlmacenController" name="frm_edit">
                        <div class="modal-body">  
                            <div class="form-group">
                                <input  type="hidden" type="text"  name="txtid" id="id" readonly="">
                            </div> 
                            <div class="form-group">
                                <label>Código</label>
                                <input type="text" class="form-control"  name="TxtCod" id="cod" readonly="">
                            </div> 
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" class="form-control" name="TxtNom" id="nombre">
                            </div>  
                        </div>
                        <div class="modal-footer">
                            <a href="Transporte.jsp" class="btn btn-default" >Cancelar</a> 
                            <input onclick="return validareditTransporte()" class="btn btn-success" type="submit" name="accion" value="Actualizar">
                        </div>
                    </form>
                </div>
            </div>
        </div> 
        <!-- ./wrapper -->
        <%@include file="js-plantilla.jsp"%> 
        <%@include file="js-datatable.jsp"%> 
        <script src="plugins/toastr/toastr.min.js"></script>
        <script src="Validacionysweetalert/Transporte.js" type="text/javascript"></script>
        <script >
                                $('.editbtn').on('click', function () {
                                    $tr = $(this).closest('tr');
                                    var datos = $tr.children('td').map(function () {
                                        return $(this).text();
                                    });
                                    $('#id').val(datos[0]);
                                    $('#cod').val(datos[1]);
                                    $('#nombre').val(datos[2]);
                                });
        </script>
        <!-- AdminLTE for demo purposes -->
        <!-- Page specific script -->

    </body>
</html>
