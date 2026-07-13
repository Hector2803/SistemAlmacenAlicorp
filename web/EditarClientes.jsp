<%@page import="com.pe.model.entity.TipoDocumento"%>
<%@page import="com.pe.DAO.TipoDocumentoDAO"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editar Cliente | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <style>
            .form-card{background:#fff;border-radius:12px;box-shadow:0 2px 12px rgba(0,0,0,.07);padding:24px;margin-bottom:20px}
            .form-card h3{font-size:13px;font-weight:600;color:#555;text-transform:uppercase;letter-spacing:.5px;margin-bottom:18px;padding-bottom:10px;border-bottom:1px solid #f0f0f0}
            .form-label{font-size:13px;font-weight:500;color:#444;margin-bottom:5px;display:block}
            .form-ali{border:1.5px solid #e0e0e0;border-radius:8px;height:44px;font-size:13.5px;padding:0 14px;width:100%;transition:border-color .15s;color:#1a1f2e;background:#fff}
            .form-ali:focus{border-color:#C8102E;box-shadow:0 0 0 3px rgba(200,16,46,.1);outline:none}
            .form-ali[readonly]{background:#f8f9fc;color:#888}
            .genero-opt{display:flex;gap:22px;align-items:center;height:44px;}
            .genero-opt label{font-size:13.5px;color:#444;display:flex;align-items:center;gap:6px;cursor:pointer;}
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <% AuxiliarDAO dao = new AuxiliarDAO();
           int id = Integer.parseInt((String) request.getAttribute("idcli"));
           Auxiliar cl = (Auxiliar) dao.BuscarPorId(id); %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-user-edit" style="color:#C8102E; margin-right:10px;"></i>
                        Editar Cliente
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Cartera de Clientes</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <form id="editcliente" action="ClienteController" method="Post" name="frm_edit">
                        <input type="hidden" name="txtid" value="<%=cl.getIdauxiliar()%>">
                        <input type="hidden" name="txtTipoauxi" value="<%=cl.getTipoauxi()%>">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-card">
                                    <h3><i class="fas fa-id-card" style="color:#C8102E;margin-right:6px;"></i>Datos del Cliente</h3>
                                    <div class="mb-3">
                                        <label class="form-label">C&oacute;digo</label>
                                        <input type="text" name="Txtcodigo" value="<%=cl.getCodigo()%>" class="form-ali" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Cliente</label>
                                        <input type="text" name="Txtapellidos" value="<%=cl.getNombre()%>" class="form-ali" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tipo de Doc. de Identidad</label>
                                        <select class="form-ali" name="Txtidtipodocumento" id="Txtidtipodocumento" required>
                                            <% TipoDocumentoDAO tdoc = new TipoDocumentoDAO();
                                               List<TipoDocumento> lista = tdoc.listarTipodocumento();
                                               Iterator<TipoDocumento> iterr = lista.iterator();
                                               TipoDocumento tipodo = null;
                                               while (iterr.hasNext()) {
                                                   tipodo = iterr.next();
                                                   if (tipodo.getIdtipodocumento() == cl.getIdtipodocumento()) { %>
                                            <option value="<%=tipodo.getIdtipodocumento()%>" selected><%=tipodo.getTipoDocumento()%></option>
                                            <% } else { %>
                                            <option value="<%=tipodo.getIdtipodocumento()%>"><%=tipodo.getTipoDocumento()%></option>
                                            <% } } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Documento de Identidad</label>
                                        <input type="text" name="Txtnumerodocumento" onkeypress="return soloNumeros(event)" value="<%= cl.getNumerodocumento()%>" maxlength="11" id="Txtnumerodocumento" class="form-ali" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Direcci&oacute;n</label>
                                        <input type="text" name="Txtdireccion" value="<%= cl.getDireccion()%>" id="Txtdireccion" class="form-ali">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Correo</label>
                                        <input type="email" name="Txtcorreo" value="<%= cl.getCorreo()%>" id="Txtcorreo" class="form-ali">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-card">
                                    <h3><i class="fas fa-address-book" style="color:#C8102E;margin-right:6px;"></i>Informaci&oacute;n de Contacto</h3>
                                    <div class="mb-3">
                                        <label class="form-label">Fecha de Registro</label>
                                        <input type="text" name="Txtfechaderegistro" value="<%=cl.getFechaderegistro()%>" class="form-ali" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Contacto</label>
                                        <input type="text" name="Txtcontacto" value="<%=cl.getContacto()%>" class="form-ali">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tel&eacute;fono</label>
                                        <input type="text" name="Txttelefono" value="<%= cl.getTelefono()%>" onkeypress="return soloNumeros(event)" id="Txttelefono" class="form-ali">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Celular</label>
                                        <input type="text" name="Txtcelular" value="<%= cl.getCelular()%>" onkeypress="return soloNumeros(event)" id="Txtcelular" class="form-ali">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">G&eacute;nero</label>
                                        <div class="genero-opt">
                                            <label><input type="radio" name="Txtsexo" value="M" <%= cl.getSexo() != null && cl.getSexo().equalsIgnoreCase("M") ? "checked" : "" %>> Masculino</label>
                                            <label><input type="radio" name="Txtsexo" value="F" <%= cl.getSexo() != null && cl.getSexo().equalsIgnoreCase("F") ? "checked" : "" %>> Femenino</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between" style="margin-top:4px;">
                            <a href="Cliente.jsp" style="background:#f0f0f0;color:#555;border:none;border-radius:8px;padding:11px 22px;font-size:13.5px;text-decoration:none;display:inline-flex;align-items:center;gap:6px;">
                                <i class="fas fa-times"></i> Cancelar
                            </a>
                            <button onclick="return validareditclientes()" type="submit" name="accion" class="btn" style="background:#C8102E;color:#fff;border:none;border-radius:8px;padding:11px 28px;font-size:13.5px;font-weight:500;">
                                <i class="fas fa-save"></i> Actualizar
                            </button>
                        </div>
                    </form>
                </div>
            </section>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <script src="Validacionysweetalert/Cliente.js" type="text/javascript"></script>
    </body>
</html>
