<%@page import="com.pe.model.entity.Usuario"%>
<%@page import="com.pe.DAO.UsuarioDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Usuarios | Alicorp</title>
        <%@include file="css-plantilla.jsp"%>
        <%@include file="css-datatable.jsp"%>
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
        <link href="dist/css/ColordeEstado.css" rel="stylesheet" type="text/css"/>
        <style>
            .avatar-cell img { width:46px; height:46px; border-radius:50%; border:2px solid #f0f0f0; object-fit:cover; background:#f8f9fc; }
            .role-badge { display:inline-block; font-size:11px; font-weight:600; padding:3px 10px; border-radius:20px; letter-spacing:0.3px; }
            .role-admin   { background:#fce4e4; color:#c62828; }
            .role-almacen { background:#e3f2fd; color:#1565c0; }
            .role-compra  { background:#e8f5e9; color:#2e7d32; }
            .role-venta   { background:#fff3e0; color:#e65100; }
            .role-default { background:#eceff1; color:#455a64; }
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
                                <i class="fas fa-users-cog" style="color:#C8102E; margin-right:10px;"></i>
                                Administrar Usuarios
                            </h3>
                            <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Control de acceso y roles</p>
                        </div>
                        <a href="InsertarUsuario.jsp" class="btn-nuevo-alicorp">
                            <i class="fas fa-user-plus"></i> Agregar Usuario
                        </a>
                    </div>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-list" style="color:#C8102E; margin-right:8px;"></i>
                                <h3 class="card-title mb-0">Lista de Usuarios</h3>
                            </div>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="card-body" style="padding:20px;">
                            <table id="example" class="table table-striped table-bordered usuarios-table" style="width:100%">
                                <thead>
                                    <tr>
                                        <th style="display:none;">#</th>
                                        <th style="width:70px; text-align:center;">Foto</th>
                                        <th>Empleado</th>
                                        <th style="width:180px;">Usuario</th>
                                        <th style="width:130px; text-align:center;">Rol</th>
                                        <th style="width:100px; text-align:center;">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% UsuarioDAO dao = new UsuarioDAO();
                                       List<Usuario> list = dao.ListadoUsuario();
                                       Iterator<Usuario> iter = list.iterator();
                                       Usuario per = null;
                                       while (iter.hasNext()) {
                                           per = iter.next();
                                           String rol = per.getRol() != null ? per.getRol() : "";
                                           String rolClass = "role-default";
                                           if (rol.equalsIgnoreCase("Administrador")) rolClass = "role-admin";
                                           else if (rol.equalsIgnoreCase("Almacen")) rolClass = "role-almacen";
                                           else if (rol.equalsIgnoreCase("Compra")) rolClass = "role-compra";
                                           else if (rol.equalsIgnoreCase("Venta")) rolClass = "role-venta";
                                    %>
                                    <tr>
                                        <td id="idusu" style="display:none;"><%= per.getId() %></td>
                                        <td class="avatar-cell" style="text-align:center; vertical-align:middle;">
                                            <img src="<%= per.getFilename1() %>" alt="<%= per.getNombre() %>">
                                        </td>
                                        <td style="font-weight:500; color:#1a1f2e; vertical-align:middle;"><%= per.getNombre() %></td>
                                        <td style="vertical-align:middle; font-size:13px; color:#555;"><%= per.getUsu() %></td>
                                        <td style="text-align:center; vertical-align:middle;">
                                            <span class="role-badge <%= rolClass %>"><%= rol %></span>
                                            <% if (per.isBloqueado()) { %>
                                            <br><span style="background:#fce4e4; color:#c62828; font-weight:600; font-size:10.5px; padding:2px 8px; border-radius:12px; display:inline-block; margin-top:4px;"><i class="fas fa-lock"></i> Bloqueado</span>
                                            <% } %>
                                        </td>
                                        <td style="text-align:center; vertical-align:middle;">
                                            <a href="UsuarioController?accion=editar&id=<%= per.getId() %>"
                                               class="btn-accion btn-edit" title="Editar">
                                                <i class="fas fa-pencil-alt"></i>
                                            </a>
                                            <a href="#" class="btn-accion btn-reset-pass" data-id="<%= per.getId() %>" data-nombre="<%= per.getNombre() %>" title="Restablecer contrase&ntilde;a" style="color:#9c6f00;">
                                                <i class="fas fa-key"></i>
                                            </a>
                                            <% if (per.isBloqueado()) { %>
                                            <a href="#" class="btn-accion btn-desbloquear" data-id="<%= per.getId() %>" data-nombre="<%= per.getNombre() %>" title="Desbloquear cuenta" style="color:#1e7a3d;">
                                                <i class="fas fa-unlock"></i>
                                            </a>
                                            <% } %>
                                            <a id="btn-eliminar" class="btn-accion btn-del" title="Eliminar">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
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

        <!-- Modal: contraseña generada al restablecer -->
        <div class="modal fade" id="modalPassGenerada" tabindex="-1">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="border:none; border-radius:14px; overflow:hidden;">
                    <div class="modal-header" style="background:#C8102E; color:#fff; border-bottom:none;">
                        <h4 class="modal-title"><i class="fas fa-key"></i> Contrase&ntilde;a restablecida</h4>
                        <button type="button" class="close" data-dismiss="modal" style="color:#fff; opacity:0.9;"><span>&times;</span></button>
                    </div>
                    <div class="modal-body" style="padding:22px;">
                        <p style="font-size:13.5px; color:#444;">Nueva contrase&ntilde;a para <b id="passUsuNombre"></b>:</p>
                        <div style="display:flex; gap:8px; align-items:center;">
                            <input type="text" id="passGenerada" readonly style="flex:1; font-family:monospace; font-size:16px; font-weight:600; text-align:center; border:1.5px solid #C8102E; border-radius:8px; padding:10px; background:#fff5f6; color:#a50d25;">
                            <button type="button" id="btnCopiarPass" class="btn" style="background:#f0f0f0; border:none; border-radius:8px; padding:10px 14px;" title="Copiar"><i class="fas fa-copy"></i></button>
                        </div>
                        <div style="background:#fff8e1; border:1px solid #ffe08a; color:#7a5a00; padding:10px 14px; border-radius:8px; font-size:12px; margin-top:14px;">
                            <i class="fas fa-exclamation-triangle"></i> Esta contrase&ntilde;a solo se muestra una vez. Comp&aacute;rtela con el usuario por un medio seguro (nunca por correo sin cifrar) y p&iacute;dele que la cambie apenas inicie sesi&oacute;n.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn" data-dismiss="modal" style="background:#C8102E; color:#fff; border:none; border-radius:8px; padding:9px 22px;">Listo</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="assets/jqueryy.js" type="text/javascript"></script>
        <script src="dist/js/bootstrap.min.js" type="text/javascript"></script>
        <%@include file="js-plantilla.jsp"%>
        <%@include file="js-datatable.jsp"%>
        <script src="plugins/toastr/toastr.min.js"></script>
        <script src="Validacionysweetalert/Usuario.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                $(document).on('click', '.btn-reset-pass', function (e) {
                    e.preventDefault();
                    var id = $(this).data('id');
                    var nombre = $(this).data('nombre');
                    swal({
                        title: '\u00bfRestablecer contrase\u00f1a?',
                        text: 'Se generar\u00e1 una nueva contrase\u00f1a aleatoria para ' + nombre + '. La contrase\u00f1a actual dejar\u00e1 de funcionar.',
                        icon: 'warning',
                        buttons: ['Cancelar', 'S\u00ed, restablecer'],
                        dangerMode: true
                    }).then(function (confirmado) {
                        if (!confirmado) return;
                        $.post('UsuarioController', {accion: 'resetPassword', id: id}, function (res) {
                            if (res.indexOf('ok:') === 0) {
                                $('#passUsuNombre').text(nombre);
                                $('#passGenerada').val(res.replace('ok:', ''));
                                $('#modalPassGenerada').modal('show');
                            } else if (res === 'no_autorizado') {
                                swal('Solo un Administrador puede restablecer contrase\u00f1as', {icon: 'warning'});
                            } else {
                                swal('No se pudo restablecer la contrase\u00f1a', {icon: 'error'});
                            }
                        });
                    });
                });

                $('#btnCopiarPass').on('click', function () {
                    var campo = document.getElementById('passGenerada');
                    campo.select();
                    document.execCommand('copy');
                    toastr.success('Contrase\u00f1a copiada');
                });

                $(document).on('click', '.btn-desbloquear', function (e) {
                    e.preventDefault();
                    var id = $(this).data('id');
                    var nombre = $(this).data('nombre');
                    swal({
                        title: '\u00bfDesbloquear cuenta?',
                        text: nombre + ' podr\u00e1 volver a iniciar sesi\u00f3n con su contrase\u00f1a actual.',
                        icon: 'warning',
                        buttons: ['Cancelar', 'S\u00ed, desbloquear']
                    }).then(function (confirmado) {
                        if (!confirmado) return;
                        $.post('UsuarioController', {accion: 'desbloquear', id: id}, function (res) {
                            if (res === 'ok') {
                                swal('Cuenta desbloqueada', {icon: 'success'}).then(function () {
                                    location.reload();
                                });
                            } else {
                                swal('No se pudo desbloquear la cuenta', {icon: 'error'});
                            }
                        });
                    });
                });

                $('#example').DataTable({
                    lengthChange: false,
                    dom: 'Bfrtip',
                    columnDefs: [
                        {targets: [0, 1, 5], visible: true}
                    ],
                    buttons: [
                        {extend: 'copyHtml5', text: 'Copiar tabla', exportOptions: {columns: [2, 3, 4]}},
                        {extend: 'excelHtml5', text: 'Exportar Excel', title: 'Usuarios - Alicorp', exportOptions: {columns: [2, 3, 4]}},
                        {
                            extend: 'print',
                            text: 'Imprimir Reporte',
                            title: '',
                            exportOptions: {columns: [2, 3, 4]},
                            customize: function (win) {
                                $(win.document.body)
                                    .css('font-family', 'Arial, Helvetica, sans-serif')
                                    .css('color', '#2C2C2A')
                                    .prepend(
                                        '<div style="background:#C8102E;color:#fff;padding:16px 22px;margin-bottom:6px;">' +
                                        '<h1 style="margin:0;font-size:20px;">Alicorp S.A.A.</h1>' +
                                        '<p style="margin:2px 0 0;font-size:12px;">Usuarios del Sistema &mdash; SIGA v1.0</p>' +
                                        '</div>' +
                                        '<p style="font-size:11px;color:#888;margin:0 0 16px 22px;">Generado el ' + new Date().toLocaleDateString('es-PE') + '</p>'
                                    );
                                $(win.document.body).find('table')
                                    .css('border-collapse', 'collapse')
                                    .css('width', '92%')
                                    .css('margin', '0 auto')
                                    .css('font-size', '12px');
                                $(win.document.body).find('table thead th')
                                    .css('background', '#f2f2f2')
                                    .css('border', '1px solid #999')
                                    .css('padding', '7px 10px')
                                    .css('text-align', 'left');
                                $(win.document.body).find('table tbody td')
                                    .css('border', '1px solid #ccc')
                                    .css('padding', '7px 10px');
                            }
                        }
                    ]
                });
            });
        </script>
    </body>
</html>
