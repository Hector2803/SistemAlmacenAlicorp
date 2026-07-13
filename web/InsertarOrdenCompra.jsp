<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="com.pe.model.entity.Producto"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Nueva Orden de Compra | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <link href="dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <style>
            .form-card {
                background:#fff; border-radius:12px; box-shadow:0 2px 12px rgba(0,0,0,0.07);
                padding:24px; margin-bottom:20px;
            }
            .form-card h3 {
                font-size:13px; font-weight:600; color:#555; text-transform:uppercase;
                letter-spacing:0.5px; margin-bottom:18px; padding-bottom:10px; border-bottom:1px solid #f0f0f0;
            }
            .form-label { font-size:13px; font-weight:500; color:#444; margin-bottom:5px; }
            .form-control-alicorp {
                border:1.5px solid #e0e0e0; border-radius:8px; font-size:13.5px; height:42px;
            }
            .form-control-alicorp:focus { border-color:#C8102E; box-shadow:0 0 0 3px rgba(200,16,46,0.10); }
            textarea.form-control-alicorp { height:auto; }

            #tablaProductos th {
                background:#f8f9fc; font-size:11px; font-weight:600; color:#888;
                text-transform:uppercase; letter-spacing:0.4px; padding:10px; border-bottom:2px solid #eee;
            }
            #tablaProductos td { padding:8px 10px; vertical-align:middle; }
            .btn-add-row {
                background:#e8f5e9; color:#2e7d32; border:none; border-radius:6px;
                padding:6px 14px; font-size:12.5px; font-weight:500;
            }
            .btn-add-row:hover { background:#d3ecd5; }
            .btn-remove-row {
                background:#fce4e4; color:#c62828; border:none; border-radius:6px;
                width:30px; height:30px; font-size:12px;
            }
            .total-box {
                background:#fff5f6; border:1.5px solid #f8c9d0; border-radius:10px;
                padding:14px 20px; text-align:right; margin-top:14px;
            }
            .total-box .label { font-size:12px; color:#888; text-transform:uppercase; letter-spacing:0.5px; }
            .total-box .value { font-size:24px; font-weight:700; color:#C8102E; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-plus-circle" style="color:#C8102E; margin-right:10px;"></i>
                        Nueva Orden de Compra
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A.</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">

                    <form id="frmOC" method="post" action="OrdenCompraController">
                        <input type="hidden" name="accion" value="add">

                        <!-- Datos generales -->
                        <div class="form-card">
                            <h3>Datos Generales</h3>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Proveedor</label>
                                    <select name="Txtproveedor" id="Txtproveedor" class="form-control form-control-alicorp" required>
                                        <option value="">Seleccione un proveedor...</option>
                                        <%
                                            AuxiliarDAO auxDao = new AuxiliarDAO();
                                            List<Auxiliar> proveedores = auxDao.ListadeProveedoresActivos();
                                            for (Auxiliar p : proveedores) {
                                        %>
                                        <option value="<%= p.getIdauxiliar() %>"><%= p.getNombre() %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="form-label">Fecha de Entrega Estimada</label>
                                    <input type="date" name="Txtfechaentrega" class="form-control form-control-alicorp">
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="form-label">Origen</label>
                                    <input type="text" class="form-control form-control-alicorp" value="Manual" disabled>
                                </div>
                                <div class="col-md-12 mb-2">
                                    <label class="form-label">Observaci&oacute;n</label>
                                    <textarea name="Txtobservacion" class="form-control form-control-alicorp" rows="2" placeholder="Motivo de la orden, notas adicionales..."></textarea>
                                </div>
                            </div>
                        </div>

                        <!-- Productos -->
                        <div class="form-card">
                            <div class="d-flex align-items-center justify-content-between" style="margin-bottom:14px;">
                                <h3 style="margin:0; padding:0; border:none;">Productos a Solicitar</h3>
                                <button type="button" class="btn-add-row" onclick="agregarFila()">
                                    <i class="fas fa-plus"></i> Agregar producto
                                </button>
                            </div>

                            <table class="table" id="tablaProductos" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th style="width:35%;">Producto</th>
                                        <th style="width:15%;">Cantidad</th>
                                        <th style="width:20%;">Precio Unitario (S/)</th>
                                        <th style="width:20%;">Subtotal (S/)</th>
                                        <th style="width:10%;"></th>
                                    </tr>
                                </thead>
                                <tbody id="cuerpoTabla">
                                    <!-- las filas se agregan dinamicamente -->
                                </tbody>
                            </table>

                            <div class="total-box">
                                <span class="label">Total de la Orden:</span>
                                <span class="value">S/ <span id="totalGeneral">0.00</span></span>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2" style="margin-top:10px; gap:10px;">
                            <a href="ListarOrdenCompra.jsp" class="btn" style="background:#f0f0f0; color:#555; border-radius:8px; padding:10px 22px; font-size:13.5px;">Cancelar</a>
                            <button type="submit" class="btn" style="background:#C8102E; color:#fff; border-radius:8px; padding:10px 26px; font-size:13.5px; font-weight:500;">
                                <i class="fas fa-save"></i> Guardar Orden de Compra
                            </button>
                        </div>
                    </form>

                </div>
            </section>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <script src="plugins/toastr/toastr.min.js"></script>

        <!-- Productos disponibles, generados desde el servidor para el selector dinamico -->
        <script>
            var productosDisponibles = [
                <%
                    ProductoDAO prodDao = new ProductoDAO();
                    List<Producto> productos = prodDao.ListadoProducto();
                    boolean primero = true;
                    for (Producto p : productos) {
                        if (!primero) { out.print(","); }
                        primero = false;
                %>
                { id: <%= p.getIdproducto() %>, codigo: "<%= p.getCodigo() %>", descripcion: "<%= p.getDescripcion().replace("\"", "'") %>", precio: <%= p.getPreciocompra() %> }
                <% } %>
            ];

            var contadorFila = 0;

            function agregarFila() {
                contadorFila++;
                var opciones = '<option value="">Seleccione...</option>';
                productosDisponibles.forEach(function (p) {
                    opciones += '<option value="' + p.id + '" data-precio="' + p.precio + '">' + p.codigo + ' - ' + p.descripcion + '</option>';
                });

                var fila = '<tr id="fila' + contadorFila + '">' +
                    '<td><select name="idproducto[]" class="form-control form-control-sm" onchange="actualizarPrecio(this, ' + contadorFila + ')" required>' + opciones + '</select></td>' +
                    '<td><input type="number" step="0.01" min="0.01" name="cantidad[]" id="cantidad' + contadorFila + '" class="form-control form-control-sm" onkeyup="calcularSubtotal(' + contadorFila + ')" required></td>' +
                    '<td><input type="number" step="0.01" min="0" name="preciounitario[]" id="precio' + contadorFila + '" class="form-control form-control-sm" onkeyup="calcularSubtotal(' + contadorFila + ')" required></td>' +
                    '<td><input type="text" id="subtotal' + contadorFila + '" class="form-control form-control-sm" value="0.00" readonly></td>' +
                    '<td><button type="button" class="btn-remove-row" onclick="eliminarFila(' + contadorFila + ')"><i class="fas fa-trash"></i></button></td>' +
                    '</tr>';

                $('#cuerpoTabla').append(fila);
            }

            function actualizarPrecio(select, fila) {
                var precio = $(select).find(':selected').data('precio') || 0;
                $('#precio' + fila).val(parseFloat(precio).toFixed(2));
                calcularSubtotal(fila);
            }

            function calcularSubtotal(fila) {
                var cantidad = parseFloat($('#cantidad' + fila).val()) || 0;
                var precio = parseFloat($('#precio' + fila).val()) || 0;
                var subtotal = cantidad * precio;
                $('#subtotal' + fila).val(subtotal.toFixed(2));
                calcularTotalGeneral();
            }

            function calcularTotalGeneral() {
                var total = 0;
                $('[id^=subtotal]').each(function () {
                    total += parseFloat($(this).val()) || 0;
                });
                $('#totalGeneral').text(total.toFixed(2));
            }

            function eliminarFila(fila) {
                $('#fila' + fila).remove();
                calcularTotalGeneral();
            }

            // Agregar la primera fila automaticamente
            $(document).ready(function () {
                agregarFila();

                $('#frmOC').on('submit', function (e) {
                    e.preventDefault();
                    if ($('#cuerpoTabla tr').length === 0) {
                        toastr.error('Debe agregar al menos un producto');
                        return;
                    }
                    $.post('OrdenCompraController', $(this).serialize(), function (resp) {
                        if (resp.trim() === 'ok') {
                            toastr.success('Orden de compra registrada correctamente');
                            setTimeout(function () { window.location.href = 'ListarOrdenCompra.jsp'; }, 1000);
                        } else {
                            toastr.error('No se pudo registrar la orden de compra');
                        }
                    });
                });
            });
        </script>

    </body>
</html>
