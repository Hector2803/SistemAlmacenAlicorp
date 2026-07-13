<%@page import="com.pe.model.entity.TipoDocumento"%>
<%@page import="com.pe.DAO.TipoDocumentoDAO"%>
<%@page import="com.pe.model.entity.Conductor"%>
<%@page import="com.pe.DAO.ConductorDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista de Conductores</title>

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
                            <h3>Gestionar Conductor</h3>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <a href="#addCategoria" class="bluefacturactivaFocus js-customer-action-add btn-primary btn btn-default"  data-toggle="modal"><i class="fas fa-folder-plus"></i> &nbsp; AGREGAR</a>
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
                                    <h2 class="card-title">LISTA DE CONDUCTORES</h2>
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
                                                <th>Conductor</th>
                                                <th>Nº Documento</th>
                                                <th>Licencia</th>
                                                <th>Estado</th>
                                                 <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%   ConductorDAO dao = new ConductorDAO();
                                                List<Conductor> list = dao.ListadoConductor();
                                                Iterator<Conductor> iter = list.iterator();
                                                Conductor per = null;
                                                while (iter.hasNext()) {
                                                    per = iter.next();
                                            %>
                                            <tr>
                                                <td style="display:none;" id="idcond"><%=per.getIdcond()%></td>
                                                <td><%= per.getCodigo()%></td>
                                                <td><%= per.getChofer()%></td>
                                                <td><%= per.getNumerodocumento()%></td>
                                                <td><%= per.getLicencia()%></td>
                                                <% String Estado = ConductorDAO.getConductorEstado(per.getIdcond());

                                                    if (Estado.equalsIgnoreCase("Activo")) {%>
                                                <td style="text-align: center"><markactivo><%= Estado%></markactivo></td>   
                                                <%   } else {%>
                                        <td style="text-align: center"><markdesactivado><%= Estado%></markdesactivado></td>    
                                            <%     }
                                            %> 
                                        <td style="text-align: center">
                                            <a href="ConductoresController?accion=editar&id=<%=per.getIdcond()%>" class="btn-warning btn-sm editbtn"><i class="glyphicon glyphicon-pencil"  data-toggle="tooltip" title="Edit"></i></a>
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
        <div id="addCategoria" class="modal fade" >
            <div class="modal-dialog" role="document" style="z-index: 9999; width: 450px">
                <div class="modal-content">
                    <form id="newconductor" action="ConductoresController" method="Post" name="frm_nuevo">
                        <div class="modal-header">      
                            <h4 class="modal-title">Agregar Conductor</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">  
                            <%
                                ConductorDAO com = new ConductorDAO();
                                String numserie = com.Numserie();
                            %>
                            <div class="form-group">
                                <label>Código</label>
                                <input type="text" name="txtcodigo" value="<%=numserie%>"  class="form-control" readonly="" >
                            </div>
                            <div class="form-group">
                                <label>Chofer</label>
                                <input type="text" name="txtchofer" class="form-control" placeholder="Nombre">
                            </div> 
                            <div class="form-group">
                                <label class="col-lg-6 col-md-4 col-sm-12 col-xs-12 control-label">Tipo de Doc. de Identidad</label>
                                <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                    <select class="border-focus-darkblue form-control" name="Txtidtipodocumento" id="Txtidtipodocumento">
                                        <option   value=""disabled="" selected="" >Documentos de Identidad</option>
                                        <% TipoDocumentoDAO tdoc = new TipoDocumentoDAO();
                                            List<TipoDocumento> lista = tdoc.listarTipodocumento();
                                            Iterator<TipoDocumento> iterr = lista.iterator();
                                            TipoDocumento doc = null;
                                            while (iterr.hasNext()) {
                                                doc = iterr.next();
                                        %>
                                        <option  value="<%=doc.getIdtipodocumento()%>"><%=doc.getTipoDocumento()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-6 col-md-4 col-sm-12 col-xs-12 control-label">Documento de Identidad</label>
                                <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                    <input type="text" name="Txtnumerodocumento" onkeypress="return soloNumeros(event)" maxlength="11" id="cedula" class="border-focus-darkblue form-control">
                                    <span class="help-block"></span>
                                </div>
                                <div id="respuesta"> </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-6 col-md-4 col-sm-12 col-xs-12 control-label">Licencia</label>
                                <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                    <input type="text" name="Txtlicencia" class="border-focus-darkblue form-control">
                                    <span class="help-block"></span>
                                </div>
                                <div id="respuesta"> </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button"  class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input onclick="return validarnewconductor()"  class="btn btn-success" type="submit" name="accion" value="Agregar">
                        </div>
                    </form>
                </div>
            </div>
        </div> 
        <!-- ./wrapper -->
        <%@include file="js-plantilla.jsp"%> 
        <%@include file="js-datatable.jsp"%> 
        <script src="plugins/toastr/toastr.min.js"></script>
        <script src="Validacionysweetalert/Conductor.js" type="text/javascript"></script>

    </body>
</html>
