<%@page import="com.pe.model.entity.Producto"%>
<%@page import="com.pe.model.entity.UnidadVenta"%>
<%@page import="com.pe.DAO.UnidadVentaDAO"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="com.pe.model.entity.Subcategoria"%>
<%@page import="com.pe.DAO.SubcategoriaDAO"%>
<%@page import="com.pe.model.entity.Categoria"%>
<%@page import="com.pe.DAO.CategoriaDAO"%>
<%@page import="com.pe.model.entity.Clasificacion"%>
<%@page import="com.pe.DAO.ClasificacionDAO"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <!--BOOSTRAP PARA DIV-->
        <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
        <%@include file="css-plantilla.jsp" %>
        <!--Estilo tabla-->
        <style>
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
                color:#000;
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
                color:#000;
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
        <!--cabecera de Menu -->
        <%@include file="Frmmenu.jsp" %>
        <div class="content-wrapper">
            <section class="content-header">
            </section>
            <!-- pageContent -->
            <%ProductoDAO dao = new ProductoDAO();
                int id = Integer.parseInt((String) request.getAttribute("idpro"));
                Producto prod = (Producto) dao.list(id);
            %>
            <section class="content">
                <div class="container-fluid">

                    <!-- SELECT2 EXAMPLE -->
                    <div class="card card-default">
                        <form id="editproducto"  action="ControllerProducto" method="Post" name="frm_nuevo" >
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-4 col-md-7 col-sm-7 col-xs-12">
                                        <h1 class="h3" style="margin-bottom: 30px;">
                                            <!-- react-text: 408 -->Administrar <!-- /react-text -->
                                            <span class="h4"><!-- react-text: 410 --><!-- /react-text --><!-- react-text: 411 --> Producto<!-- /react-text --></span>
                                        </h1>
                                    </div>
                                </div>
                                <div class="card-header" style="color: #FFF">
                                    <h1 class="card-title">Editar de Producto</h1>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label" style="text-align:right">Código:</label>
                                            <div class="col-sm-8">
                                                <input type="hidden" value="<%=prod.getIdproducto()%>" name="txtid" class="form-control">
                                                <input class="form-control" type="text" name="Txtcodigo" value="<%=prod.getCodigo()%>" style="width: 30%;" readonly="">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label" style="text-align:right">Descripción:</label>
                                            <div class="col-sm-8">
                                                <textarea cols="10" rows="2" name="Txtdescripcion" class="form-control" rows="3" required=""><%=prod.getDescripcion()%></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 " style="text-align:right">Clasificación:</label>
                                            <div class="col-sm-8">
                                                <select class="form-control select2" name="Txtmarca" style="width: 100%;">
                                                    <% ClasificacionDAO mar = new ClasificacionDAO();
                                                        List<Clasificacion> list = mar.ListadoEstadoActivos();
                                                        for (Clasificacion marca : list) {
                                                            if (marca.getIdclasi() == prod.getIdclasi()) {
                                                                out.println("<option   value='" + marca.getIdclasi()
                                                                        + "'selected>" + marca.getNombre() + "</option>");
                                                            } else {
                                                                out.println("<option   value='" + marca.getIdclasi()
                                                                        + "'>" + marca.getNombre() + "</option>");
                                                            }

                                                        }

                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label" style="text-align:right">Categoría:</label>
                                            <div class="col-sm-8">
                                                <select class="form-control select2" name="Txtcategoria">
                                                    <% CategoriaDAO tdoc = new CategoriaDAO();
                                                        List<Categoria> lista = tdoc.ListadoEstadoActivos();
                                                        for (Categoria categoria : lista) {
                                                            if (categoria.getIdcategoria() == prod.getIdcategoria()) {
                                                                out.println("<option   value='" + categoria.getIdcategoria()
                                                                        + "'selected>" + categoria.getNombre() + "</option>");
                                                            } else {
                                                                out.println("<option   value='" + categoria.getIdcategoria()
                                                                        + "'>" + categoria.getNombre() + "</option>");
                                                            }

                                                        }

                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label  class="col-sm-3 col-form-label" style="text-align:right">Sub Categoría:</label>
                                            <div class="col-sm-8">
                                                <select class="form-control select2" name="TxtIdpublico" style="width: 100%;">
                                                    <% SubcategoriaDAO publ = new SubcategoriaDAO();
                                                        List<Subcategoria> listoa = publ.ListadoEstadoActivos();
                                                        for (Subcategoria subcategoria : listoa) {
                                                            if (subcategoria.getIdsubc() == prod.getIdsubc()) {
                                                                out.println("<option   value='" + subcategoria.getIdsubc()
                                                                        + "'selected>" + subcategoria.getNombre() + "</option>");
                                                            } else {
                                                                out.println("<option   value='" + subcategoria.getIdsubc()
                                                                        + "'>" + subcategoria.getNombre() + "</option>");
                                                            }

                                                        }

                                                    %>
                                                </select>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>                                        
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label" style="text-align:right">Código Anexo:</label>
                                            <div class="col-sm-8">
                                                <input type="text" name="Txtcodanexo" maxlength="12" value="<%=prod.getCodigoanexo()%>" class="form-control">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label" style="text-align:right">U. Medida:</label>
                                            <div class="col-sm-8">
                                                <select class="form-control select2" name="Txtunidadv">
                                                    <% UnidadVentaDAO uv = new UnidadVentaDAO();
                                                        List<UnidadVenta> lv = uv.ListaUnidadVenta();
                                                        for (UnidadVenta unidadventa : lv) {
                                                            if (unidadventa.getIduventa() == prod.getIduventa()) {
                                                                out.println("<option   value='" + unidadventa.getIduventa()
                                                                        + "'selected>" + unidadventa.getNombre() + "</option>");
                                                            } else {
                                                                out.println("<option   value='" + unidadventa.getIduventa()
                                                                        + "'>" + unidadventa.getNombre() + "</option>");
                                                            }

                                                        }

                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group row">

                                            <label for="inputEmail3" class="col-sm-3 col-form-label" style="text-align:right">F. Registro:</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" name="Txtfechaderegistro" value="<%=prod.getFechaRegistro()%>" style="width: 100%;">
                                            </div>
                                        </div>
                                        <!-- /.form-group -->
                                        <div class="form-group row">
                                            <div class="col-sm-8">
                                                <input type="hidden" name="Txtmoneda" value="soles" class="form-control" readonly="">    

                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label  class="col-sm-3 col-form-label" style="text-align:right">Costo:</label>
                                            <div class="col-sm-8">
                                                <input type="number" placeholder="1.00" step="0.01" value="0.00" class="form-control"  name="Txtpcompra" value="<%=String.format("%.2f", prod.getPreciocompra())%>" readonly="">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label" style="text-align:right">Precio:</label>
                                            <div class="col-sm-8">
                                                <input type="number" placeholder="1.00" step="0.01"  class="form-control"  name="Txtpventa" value="<%=String.format("%.2f", prod.getPrecioVenta())%>">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label" style="text-align:right">Observación:</label>
                                            <div class="col-sm-8">
                                                <textarea name="Txtobser" class="form-control" rows="3"><%=prod.getObser()%></textarea>
                                            </div>
                                        </div>
                                        <!-- /.form-group -->
                                    </div>
                                </div>
                                <div class="modal-footer"> 
                                    <a class="btn btn-app bg-secondary" href="Producto.jsp"><i class="fa fa-window-close"></i> Cancelar</a>
                                    <button onclick="return validareditarproductos()" type="submit" class="btn btn-app bg-cyan" name="accion"><i class="fas fa-check-square"></i>Actualizar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
        </div>
    </body>
    <%@include file="js-plantilla.jsp"%> 
    <!-- Select2 -->
    <script src="plugins/select2/js/select2.full.min.js"></script>
    <!-- Page specific script -->
    <script src="Validacionysweetalert/Producto.js" type="text/javascript"></script>
    <script>
                                        $(document).ready(function () {
                                            $('.select2').select2();
                                        });
    </script>                      


</html>