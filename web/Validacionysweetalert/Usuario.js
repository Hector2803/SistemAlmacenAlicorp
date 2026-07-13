$(document).ready(function(){
    $('#txtModificarImagen').attr('disabled','disabled');
    
    $('#SelectImagenActual').click(function(){
        $('#txtImagen').removeAttr('disabled');
        $('#txtModificarImagen').attr('disabled','disabled');
    });
    
    $('#SelectModificarImagen').click(function(){
        $('#txtImagen').attr('disabled','disabled');
        $('#txtModificarImagen').removeAttr('disabled');
    });
});




//Valiaciones de campos nueva categoria
function validarcategoria() {
    var nombre = document.frm_nuevo.txtNom.value;
    if (nombre === '') {
        swal("Ingrese Nombre!", {
            icon: "warning"
        });
        return false;
    } else if (nombre.length > 30) {
        swal("Error demaciados caracteres!", {
            icon: "warning"
        });
        return false;
    }
}
////Valiaciones de campos Editar
function valeditarcategoria() {
    var nombre = document.frm_edit.Txtnombre.value;
    if (nombre === '') {
        swal("Ingrese Nombre!", {
            icon: "warning"
        });
        return false;
    } else if (nombre.length > 30) {
        swal("Error demaciados caracteres!", {
            icon: "warning"
        });
        return false;
    }
}
//sweetalert para Editar
$(function () {
    $("#editusu").on("submit", function (e) {
        e.preventDefault();

        // Crear un objeto FormData para recoger todos los datos del formulario
        var formData = new FormData(this);

        $.ajax({
            url: "UsuarioController?accion=Actualizar",
            type: "POST",
            data: formData,
            processData: false, // Evitar que jQuery procese los datos
            contentType: false, // Evitar que jQuery establezca el encabezado 'Content-Type'
            success: function (res) {
                if (res === "ok") {
                    swal("Usuario actualizado correctamente", {
                        icon: "success"
                    }).then((willDelete) => {
                        if (willDelete) {
                            parent.location.href = "Usuario.jsp";
                        }
                    });
                } else if (res === "yaexiste") {
                    swal("El trabajador ya tiene un usuario", {
                        icon: "warning"
                    });
                } else if (res === "password_debil") {
                    swal("La contrase\u00f1a debe tener m\u00ednimo 8 caracteres, con may\u00fasculas, min\u00fasculas, n\u00fameros y un s\u00edmbolo especial", {
                        icon: "warning"
                    });
                } else {
                    swal("Error, intentar de nuevo", {
                        icon: "warning"
                    }).then((willDelete) => {
                        if (willDelete) {
                            parent.location.href = "Usuario.jsp";
                        }
                    });
                }
            },
            error: function () {
                swal("Error en la solicitud", {
                    icon: "error"
                });
            }
        });
    });
});

//sweetalert para guardar nuevo
$(function () {
    $("#newusu").on("submit", function (e) {
        e.preventDefault();

        // Crear un objeto FormData para recoger todos los datos del formulario
        var formData = new FormData(this);

        $.ajax({
            url: "UsuarioController?accion=add",
            type: "POST",
            data: formData,
            processData: false, // Evitar que jQuery procese los datos
            contentType: false, // Evitar que jQuery establezca el encabezado 'Content-Type'
            success: function (res) {
                if (res === "ok") {
                    swal("Usuario creado correctamente", {
                        icon: "success"
                    }).then((willDelete) => {
                        if (willDelete) {
                            parent.location.href = "Usuario.jsp";
                        }
                    });
                } else if (res === "yaexiste") {
                    swal("El trabajador ya tiene un usuario", {
                        icon: "warning"
                    });
                } else if (res === "dominio_invalido") {
                    swal("Solo se permiten correos corporativos con dominio @alicorp.pe", {
                        icon: "warning"
                    });
                } else if (res === "usuario_invalido") {
                    swal("El campo Usuario debe ser un correo corporativo v\u00e1lido", {
                        icon: "warning"
                    });
                } else if (res === "email_existe") {
                    swal("Ya existe un usuario registrado con ese correo", {
                        icon: "warning"
                    });
                } else if (res === "password_debil") {
                    swal("La contrase\u00f1a debe tener m\u00ednimo 8 caracteres, con may\u00fasculas, min\u00fasculas, n\u00fameros y un s\u00edmbolo especial", {
                        icon: "warning"
                    });
                } else if (res === "rol_invalido") {
                    swal("Debes seleccionar un rol antes de guardar", {
                        icon: "warning"
                    });
                } else if (res === "tipodoc_invalido") {
                    swal("Debes seleccionar un tipo de documento v\u00e1lido", {
                        icon: "warning"
                    });
                } else if (res.indexOf("error_bd:") === 0) {
                    swal("No se pudo guardar el usuario: " + res.replace("error_bd:", "").trim(), {
                        icon: "error"
                    });
                } else {
                    swal("Error, intentar de nuevo", {
                        icon: "warning"
                    }).then((willDelete) => {
                        if (willDelete) {
                            parent.location.href = "Usuario.jsp";
                        }
                    });
                }
            },
            error: function () {
                swal("Error en la solicitud", {
                    icon: "error"
                });
            }
        });
    });
});

//Eliminar
$(function () {
    $('tr #btn-eliminar').click(function (e) {
        e.preventDefault();

        swal({
            text: "Desea eliminar el usuario seleccionado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idcli = fila.find('#idusu').text();
                        console.log(idcli);
                        var data = {"accion": "eliminar", idUsu: idcli};
                        $.post("UsuarioController", data, function (res, est, jqXHR) {
                            if (res === "ok") {
                                swal("Usuario eliminado correctamente", {
                                    icon: "success"
                                }).then((willDelete) => {
                                    if (willDelete) {
                                        parent.location.href = "Usuario.jsp";
                                    }
                                });
                                fila.remove();
                            } else if (res.indexOf("error_bd:") === 0) {
                                swal("No se pudo eliminar", res.replace("error_bd:", "").trim(), {
                                    icon: "warning"
                                });
                            } else {
                                swal("No se pudo eliminar el usuario", {
                                    icon: "warning"
                                });
                            }
                            //
                        }
                        );
                        // }

                    } else {
                    }
                });
    });

});




