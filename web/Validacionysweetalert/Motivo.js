//Valiaciones de campos nueva categoria
function validarmotivo() {
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
function valeditarmotivo() {
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
    $("#editcategoria").on("submit", function (e) {
        e.preventDefault();
        var data = $('#editcategoria').serialize();
        $.post("MotivoController?accion=Actualizar", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Motivo.jsp";
                            }

                        });
                ;
            } else {

                swal("Hubo un error", "Intente nuevamente", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Motivo.jsp";
                            }

                        });
                ;
            }
        });
    });
});
//sweetalert para guardar nuevo
$(function () {
    $("#newcategoria").on("submit", function (e) {
        e.preventDefault();
        var data = $('#newcategoria').serialize();
        $.post("MotivoController?accion=add", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Motivo.jsp";
                            }

                        });
                ;
            } else if (res === "yaexiste") {
                debugger;
                swal("Ya existe Motivo", {
                    icon: "warning"
                });
                return false;
            } else {

                swal("Error, intentar de nuevo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Motivo.jsp";
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
            text: "Desea eliminar el motivo seleccionado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idmot = fila.find('#idmot').text();
                        console.log(idmot);
                        var data = {"accion": "eliminar", idMot: idmot};
                        $.post("MotivoController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Motivo.jsp";
                                    }

                                });
                                ;
                            }
                            console.log(jqXHR);
                            fila.remove();
                            if (res === "tienemovi") {
                                swal("Tiene movimientos, No se puede eliminar", {
                                    icon: "warning"
                                })
                                        .then((willDelete) => {
                                            if (willDelete) {
                                                parent.location.href = "Motivo.jsp";
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
                        var idmot = fila.find('#idmot').text();
                        console.log(idmot);
                        var data = {"accion": "Estado", id: idmot};
                        $.post("MotivoController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Motivo.jsp";
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



