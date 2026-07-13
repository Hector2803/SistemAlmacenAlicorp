
<%@page import="com.pe.model.entity.TipoDocumento"%>
<%@page import="com.pe.DAO.TipoDocumentoDAO"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>AdminLTE 3 | DataTables</title>
        <%@include file="css-plantilla.jsp"%> 
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <style>
            legend {
                display: block;
                width: 100%;
                padding: 0;
                margin-bottom: 25px;
                font-size: 21px;
                line-height: inherit;
                color: #333;
                border: 0;
                border-bottom: 1px solid #D4D4D4;
            }
            .col-sm-12, .col-md-12, .col-lg-12 {
                position: relative;
                min-height: 1px;
                padding-left: 25px;
                padding-right: 25px;
            }
            .form-horizontal .form-group {
                margin-left: 0!important;
                margin-right: 0!important;
            }
            .form-control {
                color: #000;
                height: 30px;
                padding: 0 12px;
                box-shadow: none !important;
                border-width: 2px;
                letter-spacing: 0.5px;
                border-radius: 0 !important;
            }
            .form-control {
                display: block;
                width: 100%;
                height: 38px;
                padding: 6px 12px;
                font-size: 16px;
                line-height: 1.78571;
                color: #000;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
                transition: border-color ease-in-out 0.15s,box-shadow ease-in-out 0.15s;
            }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">
        <!-- Navbar -->
        <%@include file="Frmmenu.jsp" %>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <%AuxiliarDAO dao = new AuxiliarDAO();
                        int id = Integer.parseInt((String) request.getAttribute("idprove"));
                        Auxiliar cl = (Auxiliar) dao.BuscarPorId(id);
                    %>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <!-- /.card-header --> 
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-4 col-md-7 col-sm-7 col-xs-12">
                                        </div>
                                    </div>
                                    <div class="card-header" style="color: #FFF">
                                        <h1 class="card-title">Detalle de Proveedor</h1>
                                    </div>
                                    <br>
                                    <form id="editproveedor" action="ProveedorController" method="Post" name="frm_edit">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                                                <fieldset>
                                                    <legend>Datos Personales
                                                    </legend>
                                                    <div class="form-group">
                                                        <input type="hidden" name="txtid" class="form-control" value="<%=cl.getIdauxiliar()%>">
                                                        <input type="hidden" name="txtTipoauxi" class="form-control" value="<%=cl.getTipoauxi()%>">
                                                        <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Código</label>
                                                        <div class="col-lg-4 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txtcodigo" value="<%=cl.getCodigo()%>" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Proveedor</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txtapellidos" onkeypress="return soloLetras(event)" value="<%=cl.getNombre()%>" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-6 col-md-4 col-sm-12 col-xs-12 control-label">Tipo de Doc. de Identidad</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <select class="border-focus-darkblue form-control" name="Txtidtipodocumento" id="Txtidtipodocumento" readonly="" disabled="disabled">
                                                                <% TipoDocumentoDAO tdoc = new TipoDocumentoDAO();
                                                                    List<TipoDocumento> lista = tdoc.listarTipodocumento();
                                                                    for (TipoDocumento tipodo : lista) {
                                                                        if (tipodo.getIdtipodocumento() == cl.getIdtipodocumento()) {
                                                                            out.println("<option   value='" + tipodo.getIdtipodocumento()
                                                                                    + "'selected>" + tipodo.getTipoDocumento() + "</option>");
                                                                        } else {
                                                                            out.println("<option   value='" + tipodo.getIdtipodocumento()
                                                                                    + "'>" + tipodo.getTipoDocumento() + "</option>");
                                                                        }

                                                                    }

                                                                %>
                                                            </select>
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-6 col-md-4 col-sm-12 col-xs-12 control-label">Documento de Identidad</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txtnumerodocumento" onkeypress="return soloNumeros(event)" value="<%= cl.getNumerodocumento()%>" maxlength="11" id="Txtnumerodocumento" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Dirección</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txtdireccion" value="<%= cl.getDireccion()%>" id="Txtdireccion" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Correo</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txtcorreo" value="<%= cl.getCorreo()%>" id="Txtcorreo" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                                                <fieldset>
                                                    <legend>Información de contacto</legend>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Fecha de Registro</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txtfechaderegistro" value="<%=cl.getFechaderegistro()%>" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">contacto</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txtcontacto" value="<%=cl.getContacto()%>" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Teléfono</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txttelefono" onkeypress="return soloNumeros(event)" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Celular</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12">
                                                            <input type="text" name="Txtcelular" value="<%= cl.getCelular()%>" onkeypress="return soloNumeros(event)"  id="Txtcelular" class="border-focus-darkblue form-control" readonly="">
                                                            <span class="help-block"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Txtsexo" class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Género</label>
                                                        <div class="col-lg-11 col-md-8 col-sm-12 col-xs-12" class="border-focus-darkblue form-control">
                                                            <% if (cl.getSexo().equalsIgnoreCase("M")) { %>
                                                            &nbsp;&nbsp;&nbsp;<input  type="radio" name="Txtsexo" value="M" checked="checked" readonly="" disabled="disabled">&nbsp;M
                                                            <% } else { %>
                                                            &nbsp;&nbsp;&nbsp;<input  type="radio" name="Txtsexo" value="M" readonly="">&nbsp;M 
                                                            <% } %>
                                                            <% if (cl.getSexo().equalsIgnoreCase("F")) { %>
                                                            &nbsp;&nbsp;&nbsp;<input type="radio" name="Txtsexo" value="F" checked="checked" readonly="" disabled="disabled">&nbsp;F
                                                            <% } else { %>
                                                            &nbsp;&nbsp;&nbsp;<input  type="radio" name="Txtsexo" value="F" readonly="">&nbsp;F
                                                            <% }%>
                                                        </div>
                                                        <span class="help-block"></span>
                                                    </div>
                                                </fieldset>
                                            </div>


                                        </div>
                                        <div class="modal-footer"> 
                                            <center>
                                                <a style="" class="btn btn-secondary" href="Proveedor.jsp">Regresar &nbsp;&nbsp;<i class="fa fa-reply-all"></i></a>
                                             </center>
                                        </div>
                                    </form>
                                </div>
                                <!-- /.card-body -->
                            </div>
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
        <%@include file="js-plantilla.jsp"%> 
        <script src="plugins/toastr/toastr.min.js"></script>
        <script src="Validacionysweetalert/Proveedor.js" type="text/javascript"></script>
    </body>
</html>
