<%@page import="com.pe.model.entity.Categoria"%>
<%@page import="com.pe.DAO.CategoriaDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Categor&iacute;a | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <%@include file="css-datatable.jsp"%>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
        <style>
            .modal-alicorp .modal-content { border:none; border-radius:14px; overflow:hidden; box-shadow:0 12px 40px rgba(0,0,0,0.2); }
            .modal-alicorp .modal-header { background:#C8102E; color:#fff; border-bottom:none; padding:18px 22px; }
            .modal-alicorp .modal-header .modal-title { font-size:16px; font-weight:600; }
            .modal-alicorp .modal-header .close { color:#fff; opacity:0.85; text-shadow:none; }
            .modal-alicorp .modal-header .close:hover { opacity:1; }
            .modal-alicorp .modal-body { padding:22px; }
            .modal-alicorp .form-group label { font-size:12.5px; font-weight:500; color:#555; margin-bottom:5px; }
            .modal-alicorp .form-control { border:1.5px solid #e0e0e0; border-radius:8px; height:42px; font-size:13.5px; }
            .modal-alicorp .form-control:focus { border-color:#C8102E; box-shadow:0 0 0 3px rgba(200,16,46,0.10); }
            .modal-alicorp .modal-footer { border-top:1px solid #f0f0f0; padding:16px 22px; }
            .modal-alicorp .btn-default { background:#f0f0f0; color:#555; border:none; border-radius:8px; font-size:13px; padding:9px 18px; }
            .modal-alicorp .btn-success { background:#C8102E; border:none; border-radius:8px; font-size:13px; padding:9px 22px; font-weight:500; }
            .modal-alicorp .btn-success:hover { background:#a50d25; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                                <i class="fas fa-tags" style="color:#C8102E; margin-right:10px;"></i>
                                Administrar Categor&iacute;a
                            </h3>
                            <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Configuraci&oacute;n de inventario</p>
                        </div>
                        <a href="#addCategoria" class="btn-nuevo-alicorp" data-toggle="modal">
                            <i class="fas fa-plus"></i> Agregar
                        </a>
                    </div>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center"><i class="fas fa-list" style="color:#C8102E; margin-right:8px;"></i><h3 class="card-title mb-0">Lista de Categor&iacute;as</h3></div>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="card-body" style="padding:20px;">
                            <table id="example" class="table table-striped table-bordered second" style="width:100%">
                                <thead>
                                    <tr>
                                        <th style="display:none;">codigo</th>
                                        <th style="width:120px;">C&oacute;digo</th>
                                        <th>Nombre</th>
                                        <th style="width:110px; text-align:center;">Estado</th>
                                        <th style="width:130px; text-align:center;">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% CategoriaDAO dao = new CategoriaDAO();
                                       List<Categoria> list = dao.ListadoCategoria();
                                       Iterator<Categoria> iter = list.iterator();
                                       Categoria per = null;
                                       while (iter.hasNext()) {
                                           per = iter.next(); %>
                                    <tr>
                                        <td style="display:none;" id="idcat"><%= per.getIdcategoria() %></td>
                                        <td style="text-align:center;"><span style="font-family:monospace; font-size:12px; background:#f4f6fb; padding:2px 8px; border-radius:5px;"><%= per.getCodigo() %></span></td>
                                        <td style="font-weight:500; color:#1a1f2e;"><%= per.getNombre() %></td>
                                        <% String Estado = CategoriaDAO.getCategoriaEstado(per.getIdcategoria());
                                           if (Estado.equalsIgnoreCase("Activo")) { %>
                                        <td style="text-align:center;"><markactivo><%= Estado %></markactivo></td>
                                        <% } else { %>
                                        <td style="text-align:center;"><markdesactivado><%= Estado %></markdesactivado></td>
                                        <% } %>
                                        <td style="text-align:center;">
                                            <a class="btn-accion btn-edit editbtn" data-toggle="modal" data-target="#editar" title="Editar"><i class="fas fa-pencil-alt"></i></a>
                                            <a id="btn-estado" class="btn-accion btn-state" title="Cambiar estado"><i class="fas fa-sync-alt"></i></a>
                                            <a id="btn-eliminar" class="btn-accion btn-del" title="Eliminar"><i class="fas fa-trash-alt"></i></a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- Modal Agregar -->
        <div id="addCategoria" class="modal fade modal-alicorp">
            <div class="modal-dialog" role="document" style="z-index:9999; width:450px;">
                <div class="modal-content">
                    <form id="newcategoria" action="CategoriaController" method="Post" name="frm_nuevo">
                        <div class="modal-header">
                            <h4 class="modal-title"><i class="fas fa-plus-circle"></i> Agregar Categor&iacute;a</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <% CategoriaDAO com = new CategoriaDAO();
                               String numserie = com.Numserie(); %>
                            <div class="form-group">
                                <label>C&oacute;digo</label>
                                <input type="text" name="txtCod" value="<%= numserie %>" class="form-control" readonly>
                            </div>
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" name="txtNom" class="form-control" placeholder="Ej: Aceites y Grasas">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input onclick="return validarcategoria()" class="btn btn-success" type="submit" name="accion" value="Agregar">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Editar -->
        <div id="editar" class="modal fade modal-alicorp">
            <div class="modal-dialog" role="document" style="z-index:9999; width:450px;">
                <div class="modal-content">
                    <form id="editcategoria" method="post" action="CategoriaController" name="frm_edit">
                        <div class="modal-header">
                            <h4 class="modal-title"><i class="fas fa-pencil-alt"></i> Editar Categor&iacute;a</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="txtid" id="id">
                            <div class="form-group">
                                <label>C&oacute;digo</label>
                                <input type="text" class="form-control" name="TxtCod" id="cod" readonly>
                            </div>
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" class="form-control" name="Txtnombre" id="nombre">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="Categoria.jsp" class="btn btn-default">Cancelar</a>
                            <input onclick="return valeditarcategoria()" class="btn btn-success" type="submit" name="accion" value="Actualizar">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <%@include file="js-datatable.jsp"%>
        <script src="plugins/toastr/toastr.min.js"></script>
        <script src="Validacionysweetalert/Categoria.js" type="text/javascript"></script>
        <script>
            $('.editbtn').on('click', function () {
                $tr = $(this).closest('tr');
                var datos = $tr.children('td').map(function () { return $(this).text(); });
                $('#id').val(datos[0]);
                $('#cod').val(datos[1]);
                $('#nombre').val(datos[2]);
            })

            function confirmarEliminacion(idCategoria) {
                if (confirm("¿Estás seguro de eliminar esta categoría?")) {
                    window.location.href = "CategoriaController?accion=Estado&id=" + idCategoria;
                    setTimeout(function () {
                        var filaAEliminar = document.getElementById("fila_" + idCategoria);
                        if (filaAEliminar) {
                            filaAEliminar.remove();
                            parent.location.href = "Categoria.jsp";
                        }
                    }, 1000);
                }
            }
        </script>
    </body>
</html>
