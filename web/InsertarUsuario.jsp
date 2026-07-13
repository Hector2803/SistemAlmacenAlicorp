<%@page import="com.pe.model.entity.TipoDocumento"%>
<%@page import="com.pe.DAO.UsuarioDAO"%>
<%@page import="com.pe.DAO.TipoDocumentoDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Agregar Usuario | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
        <style>
            .form-card{background:#fff;border-radius:12px;box-shadow:0 2px 12px rgba(0,0,0,.07);padding:24px;margin-bottom:20px}
            .form-card h3{font-size:13px;font-weight:600;color:#555;text-transform:uppercase;letter-spacing:.5px;margin-bottom:18px;padding-bottom:10px;border-bottom:1px solid #f0f0f0}
            .form-label{font-size:13px;font-weight:500;color:#444;margin-bottom:5px;display:block}
            .form-ali{border:1.5px solid #e0e0e0;border-radius:8px;height:44px;font-size:13.5px;padding:0 14px;width:100%;transition:border-color .15s;color:#1a1f2e;background:#fff}
            .form-ali:focus{border-color:#C8102E;box-shadow:0 0 0 3px rgba(200,16,46,.1);outline:none}
            .form-ali[readonly]{background:#f8f9fc;color:#888}
            select.form-ali{-webkit-appearance:none}
            .foto-preview{width:90px;height:90px;border-radius:50%;object-fit:cover;border:3px solid #f0f0f0;background:#f8f9fc;display:block;margin:0 auto}
            .upload-box{border:2px dashed #e0e0e0;border-radius:10px;padding:16px;text-align:center;background:#fafafa}
        </style>
    </head>
    <body class="hold-transition sidebar-mini">
        <%@include file="Frmmenu.jsp" %>
        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px;font-weight:600;color:#1a1f2e;margin:0;">
                        <i class="fas fa-user-plus" style="color:#C8102E;margin-right:10px;"></i>Registrar Nuevo Usuario
                    </h3>
                    <p style="font-size:12px;color:#888;margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Control de acceso y roles</p>
                </div>
            </section>
            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <form id="newusu" action="UsuarioController" method="Post" name="frm_nuevo" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-card">
                                    <h3><i class="fas fa-id-card" style="color:#C8102E;margin-right:6px;"></i>Datos Personales</h3>
                                    <div class="mb-3">
                                        <label class="form-label">Nombre completo</label>
                                        <input type="text" name="txtNombre" class="form-ali" placeholder="Ej: Hector Crisostomo">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tipo de Documento</label>
                                        <select name="Txtidtipodocumento" id="Txtidtipodocumento" class="form-ali">
                                            <option value="" disabled selected>Seleccione tipo de documento</option>
                                            <% TipoDocumentoDAO tdoc = new TipoDocumentoDAO();
                                               List<TipoDocumento> lista = tdoc.listarTipodocumento();
                                               Iterator<TipoDocumento> iterr = lista.iterator();
                                               TipoDocumento doc = null;
                                               while (iterr.hasNext()) { doc = iterr.next();
                                                   // Un usuario del sistema es una persona, no una empresa: se excluyen RUC y Pasaporte.
                                                   String nombreDoc = doc.getTipoDocumento() != null ? doc.getTipoDocumento().toUpperCase() : "";
                                                   if (nombreDoc.contains("RUC") || nombreDoc.contains("PASAPORTE")) { continue; }
                                               %>
                                            <option value="<%=doc.getIdtipodocumento()%>"><%=doc.getTipoDocumento()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">N&uacute;mero de Documento</label>
                                        <input type="text" name="Txtdni" onkeypress="return soloNumeros(event)" maxlength="13" id="input_ruc" class="form-ali" placeholder="DNI / RUC">
                                        <span id="resultado"></span><span id="existente"></span><div id="respuesta"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-card">
                                    <h3><i class="fas fa-key" style="color:#C8102E;margin-right:6px;"></i>Datos de Acceso</h3>
                                    <div class="mb-3">
                                        <% Date dNow = new Date();
                                           SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                                           String currentDate = ft.format(dNow); %>
                                        <label class="form-label">Fecha de Registro</label>
                                        <input type="text" name="Txtfechaderegistro" value="<%=currentDate%>" class="form-ali" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="Txtemail" id="Txtemail" class="form-ali" placeholder="correo@alicorp.pe" pattern="^[A-Za-z0-9._%+-]+@alicorp\.pe$" title="Solo se permiten correos corporativos con dominio @alicorp.pe" oninput="autocompletarUsuario(this.value)" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tel&eacute;fono</label>
                                        <input type="text" maxlength="9" name="Txttelefono" class="form-ali" placeholder="9XXXXXXXX">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Rol</label>
                                        <select name="txtrol" class="form-ali" required>
                                            <option value="" disabled selected>Seleccione un rol</option>
                                            <option value="Administrador">Administrador</option>
                                            <option value="Supervisor">Supervisor</option>
                                            <option value="Logistico">Log&iacute;stico</option>
                                        </select>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <label class="form-label">Usuario</label>
                                            <input type="text" name="txtusu" id="txtusu" class="form-ali" placeholder="Se completa autom&aacute;ticamente" readonly required>
                                            <small style="color:#999;font-size:11px;">Se copia autom&aacute;ticamente del correo corporativo. No se puede editar a mano.</small>
                                        </div>
                                        <div class="col-6">
                                            <label class="form-label">Contrase&ntilde;a</label>
                                            <input type="password" name="txtpassword" class="form-ali" placeholder="Min. 8 caracteres: mayúscula, minúscula, número y símbolo" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$" title="Debe tener mínimo 8 caracteres, con mayúsculas, minúsculas, números y un símbolo especial" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-card">
                                    <h3><i class="fas fa-camera" style="color:#C8102E;margin-right:6px;"></i>Foto de Perfil</h3>
                                    <div class="upload-box">
                                        <i class="fas fa-cloud-upload-alt" style="font-size:28px;color:#ccc;margin-bottom:8px;display:block;"></i>
                                        <p style="font-size:12px;color:#aaa;margin-bottom:10px;">Selecciona una imagen de perfil</p>
                                        <input type="file" name="file1" class="form-ali" style="height:auto;padding:8px;" accept="image/*" onchange="previewFoto(this)">
                                    </div>
                                    <div style="text-align:center;margin-top:14px;">
                                        <img id="fotoPreview" src="#" alt="Vista previa" class="foto-preview" style="display:none;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between" style="margin-top:4px;">
                            <a href="Usuario.jsp" style="background:#f0f0f0;color:#555;border:none;border-radius:8px;padding:11px 22px;font-size:13.5px;text-decoration:none;display:inline-flex;align-items:center;gap:6px;">
                                <i class="fas fa-times"></i> Cancelar
                            </a>
                            <button type="submit" name="accion" class="btn" style="background:#C8102E;color:#fff;border:none;border-radius:8px;padding:11px 28px;font-size:13.5px;font-weight:500;">
                                <i class="fas fa-save"></i> Guardar Usuario
                            </button>
                        </div>
                    </form>
                </div>
            </section>
        </div>
        <%@include file="js-plantilla.jsp"%>
        <script src="plugins/toastr/toastr.min.js"></script>
        <script src="Validacionysweetalert/Usuario.js" type="text/javascript"></script>
        <script>
            function previewFoto(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var img = document.getElementById('fotoPreview');
                        img.src = e.target.result;
                        img.style.display = 'block';
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
            // El campo "Usuario" siempre es una copia exacta del correo corporativo (de solo lectura),
            // así nunca puede terminar con solo un nombre sin dominio.
            function autocompletarUsuario(email) {
                var campoUsu = document.getElementById('txtusu');
                campoUsu.value = email.toLowerCase();
            }
            $(document).ready(function () {
                $("#cedula").on("keyup", function () {
                    var cedula = $("#cedula").val();
                    $.ajax({ url:'ValidarRuc', type:"GET", data:'cedula='+cedula, dataType:"JSON",
                        success: function(datos) { $("#respuesta").html(datos.message); }
                    });
                });
            });
        </script>
    </body>
</html>
