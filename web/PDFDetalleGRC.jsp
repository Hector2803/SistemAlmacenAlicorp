<%@page import="com.pe.DAO.MotivoDAO"%>
<%@page import="com.pe.DAO.VehiculoDAO"%>
<%@page import="com.pe.DAO.TransporteDAO"%>
<%@page import="com.pe.DAO.ConductorDAO"%>
<%@page import="com.pe.DAO.UsuarioDAO"%>
<%@page import="com.pe.DAO.UnidadVentaDAO"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="com.pe.model.entity.DetalleMovimiento"%>
<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="com.pe.model.entity.Movimiento"%>
<%@page import="com.pe.DAO.MovimientoDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Gu&iacute;a de Remisi&oacute;n Electr&oacute;nica | Alicorp</title>
        <script src="dist/js/PDF.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
        <%@include file="css-plantilla.jsp"%>
        <style>
            body{background:#eee;}
            .gr-wrap{max-width:900px;margin:20px auto;padding:0 16px;}
            .gr-toolbar{text-align:right;margin-bottom:14px;}
            .gr-toolbar button{background:#C8102E;color:#fff;border:none;border-radius:8px;padding:10px 22px;font-size:13px;font-weight:500;cursor:pointer;}
            .gr-toolbar button:hover{background:#a50d25;}
            #invoice{background:#fff;border:1.5px solid #2255aa;padding:36px 42px;font-family:Arial,Helvetica,sans-serif;color:#000;font-size:12.5px;line-height:1.6;min-height:1050px;box-sizing:border-box;}
            .sn-top{display:flex;justify-content:space-between;align-items:flex-start;border-bottom:1px solid #ccc;padding-bottom:12px;margin-bottom:12px;}
            .sn-empresa{display:flex;gap:10px;align-items:flex-start;}
            #qrcode{width:82px;height:82px;}
            .sn-empresa-nombre{font-weight:700;font-size:14px;text-transform:uppercase;}
            .sn-docbox{border:1.5px solid #000;text-align:center;padding:8px 16px;min-width:230px;}
            .sn-docbox .t1{font-size:11px;font-weight:700;}
            .sn-docbox .t2{font-size:12px;font-weight:700;margin-top:2px;}
            .sn-docbox .t3{font-size:12px;font-weight:700;margin-top:2px;}
            .sn-row{margin-bottom:6px;}
            .sn-label{font-weight:700;display:inline;}
            .sn-two-col{display:grid;grid-template-columns:1fr 1fr;gap:2px 20px;margin-bottom:6px;}
            .sn-table{width:100%;border-collapse:collapse;margin:10px 0;font-size:11.5px;}
            .sn-table th,.sn-table td{border:1px solid #666;padding:5px 7px;text-align:left;}
            .sn-table th{background:#f2f2f2;font-weight:700;text-align:center;}
            .sn-section-title{font-weight:700;margin:10px 0 4px;}
            .sn-footer{margin-top:16px;padding-top:8px;border-top:1px solid #ccc;font-size:10px;color:#666;text-align:center;}
        </style>
    </head>
    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <%  MovimientoDAO dao = new MovimientoDAO();
            int id = Integer.parseInt((String) request.getAttribute("idGRC"));
            Movimiento p = (Movimiento) dao.Reporte(id);
            String qrData = EmpresaDAO.Nro() + "|" + p.getSerie() + "-" + p.getCorrelativo() + "|" + p.getFecha() + "|" + AuxiliarDAO.getnrodocumento(p.getIdauxiliar());
        %>
        <div class="content-wrapper">
            <div class="gr-wrap">
                <div class="gr-toolbar">
                    <button id="download"><i class="fas fa-download"></i> Descargar PDF</button>
                </div>

                <div id="invoice">
                    <div class="sn-top">
                        <div class="sn-empresa">
                            <div id="qrcode"></div>
                            <div>
                                <div class="sn-empresa-nombre"><%=EmpresaDAO.Nombre()%></div>
                                <div><%=EmpresaDAO.Direccion()%> &mdash; <%=EmpresaDAO.ubigeo()%></div>
                                <div style="margin-top:6px;">Fecha y hora de emisi&oacute;n: <b><%=p.getFecha()%></b></div>
                            </div>
                        </div>
                        <div class="sn-docbox">
                            <div class="t1">RUC <%=EmpresaDAO.Nro()%></div>
                            <div class="t2">GU&Iacute;A DE REMISI&Oacute;N ELECTR&Oacute;NICA</div>
                            <div class="t2">REMITENTE</div>
                            <div class="t3">N&deg; <%=p.getSerie()%> - <%=p.getCorrelativo()%></div>
                        </div>
                    </div>

                    <div class="sn-two-col">
                        <div class="sn-row"><span class="sn-label">Fecha de Inicio de Traslado:</span> <%=p.getFecha()%></div>
                        <div class="sn-row"><span class="sn-label">Punto de Partida:</span> Jr. Ancash Nro. 919 int. 9 Lima - Lima - Lima</div>
                        <div class="sn-row"><span class="sn-label">Motivo de Traslado:</span> <%= MotivoDAO.getNombreMotivo(p.getIdmotivo())%></div>
                        <div class="sn-row"><span class="sn-label">Punto de Llegada:</span> <%= AuxiliarDAO.getDireccion(p.getIdauxiliar())%></div>
                    </div>

                    <div class="sn-row">
                        <span class="sn-label">Datos del Destinatario:</span>
                        <%= AuxiliarDAO.getNombre(p.getIdauxiliar())%> &mdash; Registro &Uacute;nico de Contribuyentes N&deg; <%= AuxiliarDAO.getnrodocumento(p.getIdauxiliar())%>
                    </div>

                    <div class="sn-section-title">Bienes a Transportar:</div>
                    <table class="sn-table">
                        <thead>
                            <tr>
                                <th style="width:6%;">N&deg;</th>
                                <th style="width:14%;">C&oacute;digo</th>
                                <th>Descripci&oacute;n de la Mercader&iacute;a</th>
                                <th style="width:16%;">Cantidad</th>
                                <th style="width:14%;">Unidad de Medida</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  MovimientoDAO pdao = new MovimientoDAO();
                                List<DetalleMovimiento> listS = pdao.ticketDetalle(id);
                                Iterator<DetalleMovimiento> iterr = listS.iterator();
                                DetalleMovimiento pro = null;
                                int n = 1;
                                while (iterr.hasNext()) {
                                    pro = iterr.next(); %>
                            <tr>
                                <td style="text-align:center;"><%=n++%></td>
                                <td><%=ProductoDAO.getCodProd(pro.getIdproducto())%></td>
                                <td><%=ProductoDAO.getProducto(pro.getIdproducto())%></td>
                                <td style="text-align:center;"><%=String.format("%.2f", pro.getCantidad())%></td>
                                <td style="text-align:center;"><%=UnidadVentaDAO.getUndVenta(pro.getIdproducto())%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>

                    <div class="sn-section-title">Datos del Traslado:</div>
                    <div class="sn-two-col">
                        <div class="sn-row"><span class="sn-label">Modalidad de Traslado:</span> <%=TransporteDAO.getTipo(p.getIdtrans())%></div>
                        <div class="sn-row"><span class="sn-label">Transportista:</span> <%=TransporteDAO.getNombre(p.getIdtrans())%></div>
                        <div class="sn-row"><span class="sn-label">Placa de Veh&iacute;culo:</span> <%=VehiculoDAO.getPlaca(p.getIdvehi())%></div>
                        <div class="sn-row"><span class="sn-label">Marca de Veh&iacute;culo:</span> <%=VehiculoDAO.getMarca(p.getIdvehi())%></div>
                        <div class="sn-row"><span class="sn-label">Conductor:</span> Doc. <%=ConductorDAO.getNumerodocumento(p.getIdcond())%></div>
                        <div class="sn-row"><span class="sn-label">Responsable del Env&iacute;o:</span> <%= UsuarioDAO.getNombre(p.getIdusuario())%></div>
                    </div>

                    <div class="sn-footer">
                        Representaci&oacute;n interna del documento &mdash; generada por el Sistema de Log&iacute;stica de Alicorp S.A.A.<br>
                        Este documento es de uso interno del almac&eacute;n y no reemplaza la Gu&iacute;a de Remisi&oacute;n Electr&oacute;nica oficial emitida ante SUNAT.
                    </div>
                </div>
            </div>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <script>
            new QRCode(document.getElementById("qrcode"), {
                text: "<%=qrData%>",
                width: 82,
                height: 82,
                colorDark: "#000000",
                colorLight: "#ffffff"
            });
        </script>
    </body>
</html>
