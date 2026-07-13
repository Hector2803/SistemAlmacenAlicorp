//sweetalert para Editar
$(function () {
    $("#editemp").on("submit", function (e) {
        e.preventDefault();

        // Crear un objeto FormData para recoger todos los datos del formulario
        var formData = new FormData(this);

        $.ajax({
            url: "EmpresaController?accion=Actualizar",
            type: "POST",
            data: formData,
            processData: false, // Evitar que jQuery procese los datos
            contentType: false, // Evitar que jQuery establezca el encabezado 'Content-Type'
            success: function (res) {
                if (res === "ok") {
                    swal("Se ha guardado la información", {
                        icon: "success"
                    }).then((willDelete) => {
                        if (willDelete) {
                            parent.location.href = "Empresa.jsp";
                        }
                    });
                } else if (res === "yaexiste") {
                    swal("El trabajador ya tiene un usuario", {
                        icon: "warning"
                    });
                } else {
                    swal("Error, intentar de nuevo", {
                        icon: "warning"
                    }).then((willDelete) => {
                        if (willDelete) {
                            parent.location.href = "Empresa.jsp";
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


