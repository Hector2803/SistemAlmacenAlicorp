<%@page import="com.pe.DAO.UnidadVentaDAO"%>
<%@page import="com.pe.model.entity.Producto"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Stock M&iacute;nimo / M&aacute;ximo | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <%@include file="css-datatable.jsp"%>
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
        <style>
            .badge-bajo { background:#fce4e4; color:#c62828; font-weight:600; font-size:11px; padding:4px 10px; border-radius:20px; }
            .badge-ok { background:#e8f5e9; color:#2e7d32; font-weight:600; font-size:11px; padding:4px 10px; border-radius:20px; }
            .modal-alicorp .modal-content { border:none; border-radius:14px; overflow:hidden; box-shadow:0 12px 40px rgba(0,0,0,0.2); }
            .modal-alicorp .modal-header { background:#C8102E; color:#fff; border-bottom:none; padding:18px 22px; }
            .modal-alicorp .modal-header .modal-title { font-size:16px; font-weight:600; }
            .modal-alicorp .modal-header .close { color:#fff; opacity:0.85; text-shadow:none; }
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
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-layer-group" style="color:#C8102E; margin-right:10px;"></i>
                        Stock M&iacute;nimo / M&aacute;ximo
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Almac&eacute;n General</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-list" style="color:#C8102E; margin-right:8px;"></i>
                                <h3 class="card-title mb-0">Lista de Productos</h3>
                            </div>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="card-body" style="padding:20px;">
                            <table id="example" class="table table-striped table-bordered second" style="width:100%">
                                <thead>
                                    <tr>
                                        <th style="display:none;">Id</th>
                                        <th style="width:110px;">C&oacute;digo</th>
                                        <th>Descripci&oacute;n</th>
                                        <th style="width:110px; text-align:center;">Stock M&iacute;n.</th>
                                        <th style="width:110px; text-align:center;">Stock M&aacute;x.</th>
                                        <th style="width:110px; text-align:center;">Stock Actual</th>
                                        <th style="width:120px; text-align:center;">Alerta</th>
                                        <th style="width:90px; text-align:center;">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% DecimalFormat df = new DecimalFormat("#.##");
                                       ProductoDAO pdao = new ProductoDAO();
                                       List<Producto> listS = pdao.ListadoProducto();
                                       Iterator<Producto> iterr = listS.iterator();
                                       Producto pro = null;
                                       while (iterr.hasNext()) {
                                           pro = iterr.next();
                                           boolean stockBajo = pro.getStock() < pro.getStockminimo(); %>
                                    <tr>
                                        <td style="display:none;" id="idpro"><%= pro.getIdproducto()%></td>
                                        <td style="text-align:center;"><span style="font-family:monospace; font-size:12px; background:#f4f6fb; padding:2px 8px; border-radius:5px;"><%= pro.getCodigo()%></span></td>
                                        <td style="font-weight:500; color:#1a1f2e;"><%= pro.getDescripcion()%></td>
                                        <td style="text-align:center;"><%= String.format("%.2f", pro.getStockminimo())%></td>
                                        <td style="text-align:center;"><%= String.format("%.2f", pro.getStockmaximo())%></td>
                                        <td style="text-align:center; font-weight:600;"><%= String.format("%.2f", pro.getStock())%></td>
                                        <td style="text-align:center;">
                                            <% if (stockBajo) { %>
                                            <span class="badge-bajo"><i class="fas fa-exclamation-triangle"></i> Stock bajo</span>
                                            <% } else { %>
                                            <span class="badge-ok"><i class="fas fa-check-circle"></i> OK</span>
                                            <% } %>
                                        </td>
                                        <td style="text-align:center;">
                                            <a class="btn-accion btn-edit editbtn" data-toggle="modal" data-target="#editar" title="Editar"><i class="fas fa-pencil-alt"></i></a>
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

        <!-- Modal Editar Stock Mín/Máx -->
        <div id="editar" class="modal fade modal-alicorp">
            <div class="modal-dialog" role="document" style="z-index:9999; width:450px;">
                <div class="modal-content">
                    <form id="editminmax" method="post" action="ProductoController" name="frm_edit">
                        <div class="modal-header">
                            <h4 class="modal-title"><i class="fas fa-layer-group"></i> Asignar Stock M&iacute;nimo / M&aacute;ximo</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="txtid" id="id" readonly>
                            <div class="form-group">
                                <label>C&oacute;digo</label>
                                <input type="text" class="form-control" name="Txtcodigo" id="1" readonly>
                            </div>
                            <div class="form-group">
                                <label>Descripci&oacute;n</label>
                                <input type="text" class="form-control" name="Txtdescripcion" id="2" readonly>
                            </div>
                            <div class="form-group">
                                <label>Stock m&iacute;nimo</label>
                                <input class="form-control" type="number" step="0.01" min="0" name="Txtpcompra" id="3" placeholder="0.00">
                            </div>
                            <div class="form-group">
                                <label>Stock m&aacute;ximo</label>
                                <input class="form-control" type="number" step="0.01" min="0" name="Txtpventa" id="4" placeholder="0.00">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="Stockminimoymaximo.jsp" class="btn btn-default">Cancelar</a>
                            <input class="btn btn-success" type="submit" name="accion" value="Actualizar">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <%@include file="js-datatable.jsp"%>
        <script src="Validacionysweetalert/Producto.js" type="text/javascript"></script>
        <script>
            $('.editbtn').on('click', function () {
                $tr = $(this).closest('tr');
                var datos = $tr.children('td').map(function () { return $(this).text(); });
                $('#id').val(datos[0]);
                $('#1').val(datos[1]);
                $('#2').val(datos[2]);
                $('#3').val(datos[3]);
                $('#4').val(datos[4]);
            })
        </script>
    </body>
</html>
