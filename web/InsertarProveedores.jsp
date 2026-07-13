<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Nuevo Proveedor | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <style>
            .form-card{background:#fff;border-radius:12px;box-shadow:0 2px 12px rgba(0,0,0,.07);padding:24px;margin-bottom:20px}
            .form-card h3{font-size:13px;font-weight:600;color:#555;text-transform:uppercase;letter-spacing:.5px;margin-bottom:18px;padding-bottom:10px;border-bottom:1px solid #f0f0f0}
            .form-label{font-size:13px;font-weight:500;color:#444;margin-bottom:5px;display:block}
            .form-ali{border:1.5px solid #e0e0e0;border-radius:8px;height:44px;font-size:13.5px;padding:0 14px;width:100%;transition:border-color .15s;color:#1a1f2e;background:#fff}
            .form-ali:focus{border-color:#C8102E;box-shadow:0 0 0 3px rgba(200,16,46,.1);outline:none}
            .form-ali[readonly]{background:#f8f9fc;color:#888}
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-truck" style="color:#C8102E; margin-right:10px;"></i>
                        Registrar Nuevo Proveedor
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Log&iacute;stica y Compras</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <form id="newproveedor" action="ProveedorController" method="Post" name="frm_nuevo">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-card">
                                    <h3><i class="fas fa-building" style="color:#C8102E;margin-right:6px;"></i>Datos de la Empresa</h3>
                                    <% AuxiliarDAO cli = new AuxiliarDAO();
                                       String numserie = cli.Numserieproveedor(); %>
                                    <div class="mb-3">
                                        <label class="form-label">C&oacute;digo</label>
                                        <input type="text" name="txtCod" value="<%=numserie%>" class="form-ali" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Raz&oacute;n Social</label>
                                        <input type="text" name="Txtapellidos" class="form-ali" placeholder="Ej: OLPESA S.A.C." required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">RUC</label>
                                        <input type="text" name="Txtnumerodocumento" onkeypress="return soloNumeros(event)" maxlength="11" id="cedula" class="form-ali" placeholder="11 d&iacute;gitos" required>
                                        <span id="respuesta"></span>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Direcci&oacute;n</label>
                                        <input type="text" name="Txtdireccion" id="Txtdireccion" class="form-ali" placeholder="Direcci&oacute;n fiscal" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Correo</label>
                                        <input type="email" name="Txtcorreo" id="Txtcorreo" class="form-ali" placeholder="contacto@proveedor.com">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-card">
                                    <h3><i class="fas fa-address-book" style="color:#C8102E;margin-right:6px;"></i>Informaci&oacute;n de Contacto</h3>
                                    <% Date dNow = new Date();
                                       SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                                       String currentDate = ft.format(dNow); %>
                                    <div class="mb-3">
                                        <label class="form-label">Fecha de Registro</label>
                                        <input type="text" name="Txtfechaderegistro" value="<%=currentDate%>" class="form-ali" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Persona de Contacto</label>
                                        <input type="text" name="Txtcontacto" class="form-ali" placeholder="Nombre del representante o contacto comercial">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tel&eacute;fono</label>
                                        <input type="text" name="Txttelefono" class="form-ali" placeholder="01-XXXXXXX">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Celular</label>
                                        <input type="text" name="Txtcelular" id="Txtcelular" class="form-ali" placeholder="9XXXXXXXX">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between" style="margin-top:4px;">
                            <a href="Proveedor.jsp" style="background:#f0f0f0;color:#555;border:none;border-radius:8px;padding:11px 22px;font-size:13.5px;text-decoration:none;display:inline-flex;align-items:center;gap:6px;">
                                <i class="fas fa-times"></i> Cancelar
                            </a>
                            <button onclick="return validarnewproveedor()" type="submit" name="accion" class="btn" style="background:#C8102E;color:#fff;border:none;border-radius:8px;padding:11px 28px;font-size:13.5px;font-weight:500;">
                                <i class="fas fa-save"></i> Guardar Proveedor
                            </button>
                        </div>
                    </form>
                </div>
            </section>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <script src="Validacionysweetalert/Proveedor.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                $("#cedula").on("keyup", function () {
                    var cedula = $("#cedula").val();
                    $.ajax({
                        url: 'ValidarRuc', type: "GET", data: 'cedula=' + cedula, dataType: "JSON",
                        success: function (datos) { $("#respuesta").html(datos.message); }
                    });
                });
            });
        </script>
    </body>
</html>
