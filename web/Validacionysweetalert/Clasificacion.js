
//Valiaciones de campos Guardar
function validar() {
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
function valedit() {
    var nombre = document.frm_edit.TxtNom.value;
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
    $("#editclasi").on("submit", function (e) {
        e.preventDefault();
        var data = $('#editclasi').serialize();
        $.post("ControllerClasificacion?accion=Actualizar", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Clasificacion.jsp";
                            }

                        });
                ;
            } else {

                swal("Hubo un error", "Intente nuevamente", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Clasificacion.jsp";
                            }

                        });
                ;
            }
        });
    });
});

//sweetalert para guardar
$(function () {
    $("#newclasi").on("submit", function (e) {
        e.preventDefault();
        var data = $('#newclasi').serialize();
        $.post("ControllerClasificacion?accion=add", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Clasificacion.jsp";
                            }

                        });
                ;
            }else if (res === "yaexiste") {
                debugger;
                swal("Ya existe clasificación", {
                    icon: "warning"
                });
                return false;
            } else {

                swal("Error, ingrese uno nuevo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Clasificacion.jsp";
                            }

                        });
                ;
            }
        });
    });
});
//Eliminar
$(function () {
    $('tr #btn-eliminar').click(function (e) {
        e.preventDefault();

        swal({
            text: "Desea eliminar la clasificacion seleccionado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idmar = fila.find('#idmar').text();
                        console.log(idmar);
                        var data = {"accion": "eliminar", idMar: idmar};
                        $.post("ControllerClasificacion", data, function (res, est, jqXHR) {
                            //console.log('res ',res);


                            //console.log(est);  
                            if (jqXHR.status === 200) {
                                //success
                                //info
                                ///error
                                swal("Registro eliminado", {
                                    icon: "success"
                                }).then((willDelete) => {
                                    if (willDelete) {
                                        parent.location.href = "Clasificacion.jsp";
                                    }

                                });
                                ;
                            }
                            console.log(jqXHR);
                            fila.remove();
                            if (res === "tienemovi") {
                                swal("No se puede eliminar, tiene movimientos", {
                                    icon: "warning"
                                })
                                        .then((willDelete) => {
                                            if (willDelete) {
                                                parent.location.href = "Clasificacion.jsp";
                                            }

                                        });
                                ;
                            }
                        });
                        // }
                    } else {
                    }
                });
    });

});
//Confirmacion de cambio de estado
$(function () {
    $('tr #btn-estado').click(function (e) {
        e.preventDefault();

        swal({
            text: "Estas seguro de cambiar el estado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idmar = fila.find('#idmar').text();
                        console.log(idmar);
                        var data = {"accion": "Estado", id: idmar};
                        $.post("ControllerClasificacion", data, function (res, est, jqXHR) {
                            //console.log('res ',res);


                            //console.log(est);  
                            if (jqXHR.status === 200) {
                                //success
                                //info
                                ///error
                                swal("Estado actualizado correctamente", {
                                    icon: "success"
                                }).then((willDelete) => {
                                    if (willDelete) {
                                        parent.location.href = "Clasificacion.jsp";
                                    }
                                });
                                ;
                            }
                        });
                        // }
                    } else {
                    }
                });
    });

});



