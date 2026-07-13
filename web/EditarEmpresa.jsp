<%@page import="com.pe.model.entity.Empresa"%>
<%@page import="com.pe.DAO.EmpresaDAO"%>
<%@page import="com.pe.DAO.UsuarioDAO"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="java.util.List"%>
<%@page import="com.pe.model.entity.Usuario"%>
<%@page import="com.pe.model.entity.TipoDocumento"%>
<%@page import="com.pe.DAO.TipoDocumentoDAO"%>
<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
    EmpresaDAO dao = new EmpresaDAO();
    int id = Integer.parseInt((String) request.getAttribute("idemp"));
    Empresa u = (Empresa) dao.list(id);
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editar Empresa | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <style>
            .form-card { background:#fff; border-radius:12px; box-shadow:0 2px 12px rgba(0,0,0,0.07); padding:24px; margin-bottom:20px; }
            .form-card h3 { font-size:13px; font-weight:600; color:#555; text-transform:uppercase; letter-spacing:0.5px; margin-bottom:18px; padding-bottom:10px; border-bottom:1px solid #f0f0f0; }
            .form-label { font-size:13px; font-weight:500; color:#444; margin-bottom:5px; }
            .form-control-ali { border:1.5px solid #e0e0e0; border-radius:8px; height:44px; font-size:13.5px; padding:0 14px; width:100%; transition:border-color 0.15s; }
            .form-control-ali:focus { border-color:#C8102E; box-shadow:0 0 0 3px rgba(200,16,46,0.10); outline:none; }
            .form-control-ali[readonly] { background:#f8f9fc; color:#888; }
            .logo-preview { border:2px dashed #e0e0e0; border-radius:10px; padding:16px; background:#fafafa; text-align:center; }
            .logo-preview img { max-height:90px; object-fit:contain; border-radius:6px; }
            .radio-option { display:flex; align-items:center; gap:10px; padding:10px 14px; border:1.5px solid #e0e0e0; border-radius:8px; cursor:pointer; margin-bottom:8px; transition:border-color 0.15s; }
            .radio-option:hover { border-color:#C8102E; background:#fff5f6; }
            .radio-option input[type="radio"] { accent-color:#C8102E; width:16px; height:16px; }
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-building" style="color:#C8102E; margin-right:10px;"></i>
                        Editar Datos de Empresa
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Informaci&oacute;n corporativa</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">

                    <form id="editemp" method="post" action="EmpresaController" name="frm_edit" enctype="multipart/form-data">
                        <input type="hidden" name="txtid" value="<%= u.getId() %>">

                        <!-- Datos principales -->
                        <div class="form-card">
                            <h3><i class="fas fa-info-circle" style="color:#C8102E; margin-right:6px;"></i>Datos Corporativos</h3>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Raz&oacute;n Social</label>
                                    <input type="text" name="Txtnombre" value="<%= u.getNombre() %>" class="form-control-ali" required>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="form-label">RUC</label>
                                    <input type="text" name="TxtNro" value="<%= u.getNro() %>" class="form-control-ali" required>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="form-label">Eslogan / Email</label>
                                    <input type="text" name="Txtadicional" value="<%= u.getAdicional() %>" class="form-control-ali">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Direcci&oacute;n</label>
                                    <input type="text" name="Txtdireccion" value="<%= u.getDireccion() %>" class="form-control-ali" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Direcci&oacute;n Adicional / Ubigeo</label>
                                    <input type="text" name="Txtubigeo" value="<%= u.getUbigeo() %>" class="form-control-ali">
                                </div>
                            </div>
                        </div>

                        <!-- Logo -->
                        <div class="form-card">
                            <h3><i class="fas fa-image" style="color:#C8102E; margin-right:6px;"></i>Logo de la Empresa</h3>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="logo-preview mb-3">
                                        <p style="font-size:11px; color:#aaa; text-transform:uppercase; letter-spacing:0.5px; margin-bottom:8px;">Logo actual</p>
                                        <img src="<%= u.getFilename1() %>" alt="Logo actual">
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <label class="radio-option">
                                        <input type="radio" name="selected" value="SelectImagenActual" checked>
                                        <div>
                                            <div style="font-size:13px; font-weight:500; color:#333;">Mantener logo actual</div>
                                            <div style="font-size:12px; color:#888;">Conserva la imagen ya registrada</div>
                                        </div>
                                    </label>
                                    <input type="hidden" name="txtImagen" id="txtImagen" value="<%= u.getFilename1() %>">

                                    <label class="radio-option">
                                        <input type="radio" name="selected" value="SelectModificarImagen">
                                        <div style="flex:1;">
                                            <div style="font-size:13px; font-weight:500; color:#333;">Cambiar logo</div>
                                            <div style="font-size:12px; color:#888; margin-bottom:8px;">Selecciona un nuevo archivo de imagen</div>
                                            <input type="file" name="txtModificarImagen" id="txtModificarImagen"
                                                   class="form-control-ali" style="height:auto; padding:8px;">
                                        </div>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between" style="margin-top:10px;">
                            <a href="Empresa.jsp" style="background:#f0f0f0; color:#555; border:none; border-radius:8px; padding:10px 22px; font-size:13.5px; text-decoration:none; display:inline-flex; align-items:center; gap:6px;">
                                <i class="fas fa-arrow-left"></i> Cancelar
                            </a>
                            <input type="submit" name="accion" value="Actualizar"
                                   style="background:#C8102E; color:#fff; border:none; border-radius:8px; padding:10px 28px; font-size:13.5px; font-weight:500; cursor:pointer;">
                        </div>
                    </form>

                </div>
            </section>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <script src="plugins/toastr/toastr.min.js"></script>
        <script src="Validacionysweetalert/Empresa.js" type="text/javascript"></script>
    </body>
</html>
