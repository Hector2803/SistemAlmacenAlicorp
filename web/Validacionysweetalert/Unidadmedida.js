//Data table
$(document).ready(function () {
    $('#Datatable').DataTable();
});

//Valiaciones de campos nueva categoria
function validarunidadVnew() {
    var nombre = document.frm_nuevo.txtNom.value;
    if (nombre === '') {
        swal("Ingrese Nombre!", {
            icon: "warning"
        });
        return false;
    } else if (nombre.length > 14) {
        swal("Error demaciados caracteres!", {
            icon: "warning"
        });
        return false;
    }
}
////Valiaciones de campos Editar
function valeditarunidadV() {
    var nombre = document.frm_edit.TxtNom.value;
    if (nombre === '') {
        swal("Ingrese Nombre!", {
            icon: "warning"
        });
        return false;
    } else if (nombre.length > 14) {
        swal("Error demaciados caracteres!", {
            icon: "warning"
        });
        return false;
    }
}
//sweetalert para Editar
$(function () {
    $("#edituv").on("submit", function (e) {
        e.preventDefault();
        var data = $('#edituv').serialize();
        $.post("UnidadmedidaController?accion=Editar", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Unidadmedida.jsp";
                            }
                        });
                ;
            } else {
                swal("Hubo un error", "Intente nuevamente", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Unidadmedida.jsp";
                            }
                        });
                ;
            }
        });
    });
});
//sweetalert para guardar nuevo
$(function () {
    $("#newuv").on("submit", function (e) {
        e.preventDefault();
        var data = $('#newuv').serialize();
        $.post("UnidadmedidaController?accion=adduventa", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Unidadmedida.jsp";
                            }

                        });
                ;
            } else {

                swal("Ya existe, ingrese uno nuevo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Unidadmedida.jsp";
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
            text:"Desea eliminar la UM seleccionado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var iduv = fila.find('#iduv').text();
                        console.log(iduv);
                        var data = {"accion": "eliminaruventa", idUv: iduv};
                        $.post("UnidadmedidaController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Unidadmedida.jsp";
                                    }

                                });
                                ;
                            }
                            console.log(jqXHR);
                            fila.remove();
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
            text:"Estas seguro de cambiar el estado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var iduv = fila.find('#iduv').text();
                        console.log(iduv);
                        var data = {"accion": "Estadouventa", id: iduv};
                        $.post("UnidadmedidaController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Unidadmedida.jsp";
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



