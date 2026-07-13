//Valiaciones de campos nueva categoria
function validarsubcategoria() {
    var nombre = document.frm_nuevo.txtNom.value;
    var categoria = document.frm_nuevo.txtIdCategoria.value;
    if (categoria === '') {
        swal("Selecciona una categor\u00eda", {
            icon: "warning"
        });
        return false;
    } else if (nombre === '') {
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
function valeditarsubcategoria() {
    var nombre = document.frm_edit.Txtnombre.value;
    var categoria = document.frm_edit.TxtIdCategoria.value;
    if (categoria === '') {
        swal("Selecciona una categor\u00eda", {
            icon: "warning"
        });
        return false;
    } else if (nombre === '') {
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
    $("#editsubcategoria").on("submit", function (e) {
        e.preventDefault();
        var data = $('#editsubcategoria').serialize();
        $.post("SubcategoriaController?accion=Actualizar", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Subcategoria.jsp";
                            }

                        });
                ;
            } else {

                swal("Hubo un error", "Intente nuevamente", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Subcategoria.jsp";
                            }

                        });
                ;
            }
        });
    });
});
//sweetalert para guardar nuevo
$(function () {
    $("#newsubcategoria").on("submit", function (e) {
        e.preventDefault();
        var data = $('#newsubcategoria').serialize();
        $.post("SubcategoriaController?accion=add", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Subcategoria.jsp";
                            }

                        });
                ;
            } else {
                swal("Ya existe, ingrese uno nuevo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Subcategoria.jsp";
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
            text: "Desea eliminar la sub categoria seleccionado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idcat = fila.find('#idsubc').text();
                        console.log(idcat);
                        var data = {"accion": "eliminar", idSubc: idcat};
                        $.post("SubcategoriaController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Subcategoria.jsp";
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
                        var idcat = fila.find('#idsubc').text();
                        console.log(idcat);
                        var data = {"accion": "Estado", id: idcat};
                        $.post("SubcategoriaController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Subcategoria.jsp";
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



