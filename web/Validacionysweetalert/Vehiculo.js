//Valiaciones de campos nueva vehiculo
function validarvehiculo() {
    var nombre = document.frm_nuevo.txtNom.value;
    if (nombre === '') {
        swal("Ingrese Nombre!", {
            icon: "warning"
        });
        return false;
    } else if ( nombre.length > 30) {
        swal("Error demaciados caracteres!", {
            icon: "warning"
        });
        return false;
    }
}
////Valiaciones de campos Editar
function valeditarvehiculo() {
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
    $("#editvehiculo").on("submit", function (e) {
        e.preventDefault();
        var data = $('#editvehiculo').serialize();
        $.post("VehiculoController?accion=Actualizar", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Vehiculo.jsp";
                            }

                        });
                ;
            } else {

                swal("Revise la informacion y vuelva a intentarlo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Vehiculo.jsp";
                            }

                        });
                ;
            }
        });
    });
});
//sweetalert para guardar nuevo
$(function () {
    $("#newvehiculo").on("submit", function (e) {
        e.preventDefault();
        var data = $('#newvehiculo').serialize();
        $.post("VehiculoController?accion=add", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Vehiculo.jsp";
                            }

                        });
                ;
            }else if (res === "yaexiste") {
                debugger;
                swal("Vehiculo ya existe", {
                    icon: "warning"
                });
                return false;
            } else {

                swal("Revise la informacion y vuelva a intentarlo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Vehiculo.jsp";
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
            text: "Desea eliminar la Vehiculo seleccionado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idcat = fila.find('#idcat').text();
                        console.log(idcat);
                        var data = {"accion": "eliminar", idCat: idcat};
                        $.post("VehiculoController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Vehiculo.jsp";
                                    }

                                });;
                            }
                            console.log(jqXHR);
                            fila.remove();
                             if (res === "tienemovi") {
                                swal("Tiene movimientos, no se puede eliminar", {
                                    icon: "warning"
                                })
                                        .then((willDelete) => {
                                            if (willDelete) {
                                                parent.location.href = "Vehiculo.jsp";
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
                        var idcat = fila.find('#idcat').text();
                        console.log(idcat);
                        var data = {"accion": "Estado", id: idcat};
                        $.post("VehiculoController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Vehiculo.jsp";
                                    }
                                });;
                            }
                        });
                        // }
                    } else {
                    }
                });
    });

});



