<%@page import="com.pe.model.entity.Conductor"%>
<%@page import="com.pe.DAO.ConductorDAO"%>
<%@page import="com.pe.model.entity.Vehiculo"%>
<%@page import="com.pe.DAO.VehiculoDAO"%>
<%@page import="com.pe.model.entity.Transporte"%>
<%@page import="com.pe.DAO.TransporteDAO"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="com.pe.DAO.UnidadVentaDAO"%>
<%@page import="com.pe.model.entity.DetalleMovimiento"%>
<%@page import="com.pe.model.entity.Motivo"%>
<%@page import="com.pe.DAO.MotivoDAO"%>
<%@page import="com.pe.DAO.MovimientoDAO"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Emitir Gu&iacute;a de Remisi&oacute;n | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <style>
            .form-card{background:#fff;border-radius:12px;box-shadow:0 2px 12px rgba(0,0,0,.07);padding:24px;margin-bottom:20px}
            .form-card h3{font-size:13px;font-weight:600;color:#555;text-transform:uppercase;letter-spacing:.5px;margin-bottom:18px;padding-bottom:10px;border-bottom:1px solid #f0f0f0}
            .form-label{font-size:13px;font-weight:500;color:#444;margin-bottom:5px;display:block}
            .form-ali{border:1.5px solid #e0e0e0;border-radius:8px;height:42px;font-size:13.5px;padding:0 14px;width:100%;transition:border-color .15s;color:#1a1f2e;background:#fff}
            .form-ali:focus{border-color:#C8102E;box-shadow:0 0 0 3px rgba(200,16,46,.1);outline:none}
            .form-ali[readonly]{background:#f8f9fc;color:#888}
            .prod-table{width:100%;border-collapse:collapse;font-size:13.5px;}
            .prod-table th{background:#f8f9fc;color:#555;font-size:11.5px;text-transform:uppercase;letter-spacing:.4px;padding:10px 12px;text-align:left;border-bottom:2px solid #eee;}
            .prod-table td{padding:10px 12px;border-bottom:1px solid #f2f2f2;vertical-align:middle;}
            .prod-table tr:hover td{background:#fafbfd;}
            .qty-input{width:100px;text-align:center;}
            .btn-outline-ali{background:#fff;color:#C8102E;border:1.5px solid #C8102E;border-radius:8px;padding:9px 18px;font-size:13px;font-weight:500;text-decoration:none;display:inline-flex;align-items:center;gap:6px;}
            .btn-outline-ali:hover{background:#fff5f6;color:#C8102E;}
            .btn-ali{background:#C8102E;color:#fff;border:none;border-radius:8px;padding:9px 22px;font-size:13px;font-weight:500;cursor:pointer;}
            .btn-ali:hover{background:#a50d25;color:#fff;}
            .btn-ghost{background:#f0f0f0;color:#555;border:none;border-radius:8px;padding:9px 18px;font-size:13px;text-decoration:none;}
            .empty-cart{text-align:center;color:#999;font-size:13px;padding:28px 0;}
        </style>
    </head>
    <%  Auxiliar objClienteGRC = null;
        if (request.getSession().getAttribute("clienteGRC") != null) {
            objClienteGRC = (Auxiliar) request.getSession().getAttribute("clienteGRC");
        } else {
            objClienteGRC = new Auxiliar();
            objClienteGRC.setIdauxiliar(0);
            objClienteGRC.setCorreo("");
            objClienteGRC.setNumerodocumento("0");
            objClienteGRC.setNombre("");
            objClienteGRC.setDireccion("");
        }
    %>
    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-truck-loading" style="color:#C8102E; margin-right:10px;"></i>
                        Emitir Gu&iacute;a de Remisi&oacute;n
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Documento que acompa&ntilde;a el transporte de la mercader&iacute;a</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <form id="newventa" method="post" name="accion" action="GuiaremisionclienteController">
                    <input type="hidden" name="accion" value="Registrarguiaremisoncliente" />

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-card">
                                <h3><i class="fas fa-file-invoice" style="color:#C8102E;margin-right:6px;"></i>Datos del Documento</h3>
                                <div class="mb-3">
                                    <label class="form-label">Tipo de Documento</label>
                                    <select name="txtTipodoc" id="tipo_comprobante" required class="form-ali">
                                        <option value="Guia de Remision">Gu&iacute;a de Remisi&oacute;n</option>
                                    </select>
                                </div>
                                <% MovimientoDAO com = new MovimientoDAO();
                                   String numserie = com.NumserieGRC(); %>
                                <div class="row">
                                    <div class="col-4">
                                        <label class="form-label">Serie</label>
                                        <input class="form-ali" name="txtSerie" value="GR02" readonly>
                                    </div>
                                    <div class="col-8">
                                        <label class="form-label">N&uacute;mero</label>
                                        <input class="form-ali" name="txtCorrelativo" value="<%=numserie%>">
                                    </div>
                                </div>
                                <div class="mb-3" style="margin-top:14px;">
                                    <label class="form-label">Cliente / Destino <span style="color:#aaa;font-weight:400;">(a qui&eacute;n o a d&oacute;nde se transporta)</span></label>
                                    <div style="display:flex; gap:8px;">
                                        <input type="hidden" name="txtIdcli" value="<%=objClienteGRC.getIdauxiliar() == 0 ? "" : objClienteGRC.getIdauxiliar()%>">
                                        <input type="text" name="txtNombre" value=" <%=objClienteGRC.getNombre()%>" class="form-ali" placeholder="Ning&uacute;n destino seleccionado" readonly required>
                                        <a href="#Buscarcliente" class="btn-outline-ali editbtn" data-toggle="modal" style="white-space:nowrap;"><i class="fas fa-search"></i> Buscar</a>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">RUC / DNI</label>
                                    <input class="form-ali" name="txtI" value="<%=objClienteGRC.getNumerodocumento()%>">
                                </div>

                                <h3 style="margin-top:20px;"><i class="fas fa-truck" style="color:#C8102E;margin-right:6px;"></i>Datos del Transporte</h3>
                                <p style="font-size:11.5px;color:#999;margin:-10px 0 12px;">Obligatorio por normativa SUNAT: toda gu&iacute;a de remisi&oacute;n debe identificar qui&eacute;n transporta la mercader&iacute;a.</p>
                                <div class="mb-3">
                                    <label class="form-label">Empresa de Transporte</label>
                                    <select name="txtTransporte" id="txtTransporte" required class="form-ali">
                                        <option value="" disabled selected>Seleccione transportista</option>
                                        <% TransporteDAO t = new TransporteDAO();
                                           List<Transporte> listt = t.ListadoEstadoActivos();
                                           Iterator<Transporte> ittt = listt.iterator();
                                           Transporte tr = null;
                                           while (ittt.hasNext()) { tr = ittt.next(); %>
                                        <option value="<%=tr.getIdtrans()%>"><%=tr.getNombre()%></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <label class="form-label">Veh&iacute;culo (placa)</label>
                                        <select name="txtVehiculo" id="txtVehiculo" required class="form-ali">
                                            <option value="" disabled selected>Seleccione</option>
                                            <% VehiculoDAO v = new VehiculoDAO();
                                               List<Vehiculo> lisv = v.ListadoEstadoActivos();
                                               Iterator<Vehiculo> itv = lisv.iterator();
                                               Vehiculo tvr = null;
                                               while (itv.hasNext()) { tvr = itv.next(); %>
                                            <option value="<%=tvr.getIdvehi()%>"><%=tvr.getPlaca()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-6">
                                        <label class="form-label">Conductor</label>
                                        <select name="txtConductor" id="txtConductor" required class="form-ali">
                                            <option value="" disabled selected>Seleccione</option>
                                            <% ConductorDAO tc = new ConductorDAO();
                                               List<Conductor> listc = tc.ListadoEstadoActivos();
                                               Iterator<Conductor> ittc = listc.iterator();
                                               Conductor trc = null;
                                               while (ittc.hasNext()) { trc = ittc.next(); %>
                                            <option value="<%=trc.getIdcond()%>"><%=trc.getChofer()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-card">
                                <h3><i class="fas fa-warehouse" style="color:#C8102E;margin-right:6px;"></i>Almac&eacute;n y Responsable</h3>
                                <div class="row">
                                    <div class="col-6">
                                        <label class="form-label">Tienda</label>
                                        <input class="form-ali" name="txtTienda" value="<%=EmpresaDAO.Nombre()%>" required>
                                    </div>
                                    <div class="col-6">
                                        <label class="form-label">Almac&eacute;n</label>
                                        <select class="form-ali" name="txtAlmacen" required>
                                            <option value="" disabled selected>Seleccione almac&eacute;n</option>
                                            <% com.pe.DAO.AlmacenDAO almDao = new com.pe.DAO.AlmacenDAO();
                                               for (com.pe.model.entity.Almacen alm : almDao.listarActivos()) { %>
                                            <option value="<%=alm.getNombre()%>"><%=alm.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                </div>
                                <div class="row" style="margin-top:14px;">
                                    <div class="col-6">
                                        <label class="form-label">Responsable</label>
                                        <input class="form-ali" type="text" name="txtIdusuario" value="<%=session.getAttribute("usuario")%>">
                                    </div>
                                    <% Date dNow = new Date();
                                       SimpleDateFormat ft = new SimpleDateFormat("dd/MM/yyyy");
                                       String currentDate = ft.format(dNow); %>
                                    <div class="col-6">
                                        <label class="form-label">Fecha Emisi&oacute;n</label>
                                        <input class="form-ali" value="<%=currentDate%>" id="fecha" name="txtfecha">
                                    </div>
                                </div>
                                <div class="mb-3" style="margin-top:14px;">
                                    <label class="form-label">Motivo <span style="color:#aaa;font-weight:400;">(por qu&eacute; se transporta)</span></label>
                                    <select name="txtMotivo" id="txtMotivo" required class="form-ali">
                                        <option value="" disabled selected>Seleccione un motivo</option>
                                        <% MotivoDAO mot = new MotivoDAO();
                                           List<Motivo> lism = mot.ListadoSalidaActivo();
                                           Iterator<Motivo> itt = lism.iterator();
                                           Motivo mo = null;
                                           while (itt.hasNext()) { mo = itt.next(); %>
                                        <option value="<%=mo.getIdmotivo()%>"><%=mo.getNombre()%></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Punto de Partida</label>
                                    <input type="text" name="txtCondicion" value="Jr. Ancash Nro. 919 int. 9 Lima - Lima - Lima" class="form-ali">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Punto de Llegada</label>
                                    <input class="form-ali" type="text" name="txtdirecc" value="<%=objClienteGRC.getDireccion()%>">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-card">
                        <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:10px; border-bottom:1px solid #f0f0f0; padding-bottom:10px;">
                            <h3 style="margin:0; padding:0; border:none;"><i class="fas fa-boxes" style="color:#C8102E;margin-right:6px;"></i>Productos a Transportar</h3>
                            <div style="display:flex; gap:8px;">
                                <a href="ProductosActivosguiaremisioncliente.jsp" class="btn-outline-ali"><i class="fas fa-plus"></i> Agregar Producto</a>
                                <a href="GuiaremisionclienteController?accion=Limpiargrc" class="btn-ghost" style="display:inline-flex;align-items:center;gap:6px;"><i class="fas fa-broom"></i> Limpiar</a>
                            </div>
                        </div>

                        <% ArrayList<DetalleMovimiento> listar = (ArrayList<DetalleMovimiento>) session.getAttribute("cargrc");
                           int fila = 0; %>
                        <% if (listar == null || listar.isEmpty()) { %>
                        <div class="empty-cart"><i class="fas fa-inbox" style="font-size:22px;display:block;margin-bottom:8px;color:#ccc;"></i>A&uacute;n no agregaste ning&uacute;n producto. Usa "Agregar Producto" para empezar.</div>
                        <% } else { %>
                        <table class="prod-table">
                            <thead>
                                <tr>
                                    <th>C&oacute;digo</th>
                                    <th>Nombre</th>
                                    <th style="text-align:center;">Cantidad</th>
                                    <th style="text-align:center;">Und.</th>
                                    <th style="text-align:center;">Quitar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (DetalleMovimiento ni : listar) { %>
                                <tr>
                                    <td><span style="font-family:monospace; font-size:12px; background:#f4f6fb; padding:2px 8px; border-radius:5px;"><%= ni.getProducto().getCodigo()%></span></td>
                                    <td style="font-weight:500; color:#1a1f2e;"><%= ni.getProducto().getDescripcion()%></td>
                                    <td style="text-align:center;">
                                        <input class="form-ali qty-input" type="number" value="<%=String.format("%.2f", ni.getCantidad())%>" placeholder="1.00" step="0.01" min="0.01" max="<%=ProductoDAO.getValidarstock(ni.getIdproducto())%>" id="txtPro_cantidad<%=fila%>" name="txtPro_cantidad" onchange="actualizarcantidad(<%= fila%>)" required>
                                    </td>
                                    <td style="text-align:center;"><%=UnidadVentaDAO.getUndVenta(ni.getIdproducto())%></td>
                                    <td style="text-align:center;">
                                        <span id="idarticulo" style="display:none;"><%= ni.getProducto().getIdproducto()%></span>
                                        <button type="button" style="background:none;color:#C8102E;border:none;font-size:16px;cursor:pointer;" id="deleteitem" class="delete" title="Quitar producto">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </td>
                                </tr>
                                <% fila++; } %>
                            </tbody>
                        </table>
                        <p style="font-size:11.5px;color:#999;margin-top:10px;">La cantidad m&aacute;xima permitida por producto respeta el stock disponible en almac&eacute;n.</p>
                        <% } %>

                        <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:20px; padding-top:16px; border-top:1px solid #f0f0f0;">
                            <a class="btn-ghost" href="ListarGuiaremisioncliente.jsp" style="display:inline-flex;align-items:center;gap:6px;"><i class="fas fa-times"></i> Salir</a>
                            <button class="btn-ali" type="submit" value="Grabar" name="btnVenta" style="display:inline-flex;align-items:center;gap:6px;"><i class="fas fa-save"></i> Guardar Gu&iacute;a de Remisi&oacute;n</button>
                        </div>
                    </div>
                </form>

                <!-- Modal Buscar Cliente -->
                <div class="modal fade" id="Buscarcliente">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content" style="border:none; border-radius:14px; overflow:hidden;">
                            <div class="modal-header" style="background:#C8102E; color:#fff; border-bottom:none;">
                                <h4 class="modal-title"><i class="fas fa-user"></i> Seleccionar Cliente</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:#fff; opacity:0.9;">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="padding:20px;">
                                <input type="text" id="filtroClienteModal" class="form-ali" placeholder="Buscar por nombre, c&oacute;digo o documento..." style="margin-bottom:14px;">
                                <div class="table-responsive">
                                    <table id="m" class="table table-bordered table-hover projects" width="100%">
                                        <thead>
                                            <tr>
                                                <th style="display:none; width:0%;"></th>
                                                <th style="width:8%">Elegir</th>
                                                <th>C&oacute;digo</th>
                                                <th>Nombre</th>
                                                <th>Nro Documento</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% AuxiliarDAO prov = new AuxiliarDAO();
                                               List<Auxiliar> list = prov.ListadeClientesActivos();
                                               Iterator<Auxiliar> ite = list.iterator();
                                               Auxiliar p = null;
                                               while (ite.hasNext()) { p = ite.next(); %>
                                            <tr>
                                                <td style="display:none;width:0;" id="idcat"><%=p.getIdauxiliar()%></td>
                                                <td style="width:8%; text-align:center;">
                                                    <a href="ClienteController?accion=BuscarPorIdGRC&idClientegrc=<%=p.getIdauxiliar()%>" title="Elegir este cliente"><i class="fas fa-check-circle" style="color:#2e7d32; font-size:16px;"></i></a>
                                                </td>
                                                <td><%=p.getCodigo()%></td>
                                                <td><%=p.getNombre()%></td>
                                                <td><%=p.getNumerodocumento()%></td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn-ghost" data-dismiss="modal">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <script src="plugins/toastr/toastr.min.js"></script>
        <%@include file="js-plantilla.jsp"%>
        <script src="Validacionysweetalert/Guiaremisioncliente.js" type="text/javascript"></script>
        <script>
            document.getElementById('filtroClienteModal').addEventListener('keyup', function () {
                var texto = this.value.toLowerCase();
                document.querySelectorAll('#m tbody tr').forEach(function (fila) {
                    fila.style.display = fila.textContent.toLowerCase().includes(texto) ? '' : 'none';
                });
            });
        </script>
    </body>
</html>
