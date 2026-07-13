$(document).ready(function () {

    var now = new Date();
    var day = ("0" + now.getDate()).slice(-2);
    var month = ("0" + (now.getMonth() + 1)).slice(-2);

    var today = now.getFullYear() + "-" + (month) + "-" + (day);
    $("#fecha").val(today);
});

function comprobarRadio(radio)
{
    for (i = 0; i < radio.length; i++)
    {
        if (radio[i].checked)
        {
            return true;
        }
    }
    return false;
}

function soloLetras(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyz";
    especiales = [8, 37, 39, 46];

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}

function soloNumeros(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "0123456789";
    especiales = [8, 37, 39, 46];

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}


//Valiaciones de campos nuevo cliente
function validarnewproveedor() {
    var nombre = document.frm_nuevo.Txtapellidos.value;
    var documento = document.frm_nuevo.Txtnumerodocumento.value;
    var direc = document.frm_nuevo.Txtdireccion.value;
    var correo = document.frm_nuevo.Txtcorreo.value;

    if (nombre === '') {
        swal("Ingrese la Raz\u00f3n Social!", {
            icon: "warning"
        });
        return false;
    } else if (nombre.length > 50) {
        swal("Demasiados caracteres", {
            icon: "warning"
        });
        return false;
    } else if (documento === '' || documento.length !== 11) {
        swal("Ingrese un RUC v\u00e1lido de 11 d\u00edgitos", {
            icon: "warning"
        });
        return false;
    } else if (direc === '') {
        swal("Ingrese direcci\u00f3n", {
            icon: "warning"
        });
        return false;
    } else if (correo !== '' && !/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i.test(correo)) {
        swal("Ingrese un correo v\u00e1lido", {
            icon: "warning"
        });
        return false;
    }
}


//Valiaciones de campos editar cliente
function validareditproveedores() {
    var nombre = document.frm_edit.Txtapellidos.value;
    var docu = document.frm_edit.Txtnumerodocumento.value;
    var direc = document.frm_edit.Txtdireccion.value;
    var correo = document.frm_edit.Txtcorreo.value;

    if (nombre === '') {
        swal("Ingrese la Raz\u00f3n Social!", {
            icon: "warning"
        });
        return false;
    } else if (nombre.length > 50) {
        swal("Demasiados caracteres", {
            icon: "warning"
        });
        return false;
    } else if (docu === '' || docu.length !== 11) {
        swal("Ingrese un RUC v\u00e1lido de 11 d\u00edgitos", {
            icon: "warning"
        });
        return false;
    } else if (direc === '') {
        swal("Ingrese direcci\u00f3n", {
            icon: "warning"
        });
        return false;
    } else if (correo !== '' && !/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i.test(correo)) {
        swal("Ingrese un correo v\u00e1lido", {
            icon: "warning"
        });
        return false;
    }
}

//Elimina cualquier caracter espacio o signos habituales y comprueba validez
function validarInput(input) {
    var ruc = input.value.replace(/[-.,[\]()\s]+/g, ""),
            resultado = document.getElementById("resultado"),
            existente = document.getElementById("existente"),
            valido;

    existente.innerHTML = "";

    //Es entero?    
    if ((ruc = Number(ruc)) && ruc % 1 === 0
            && rucValido(ruc)) { // ⬅️ ⬅️ ⬅️ ⬅️ Acá se comprueba
        valido = "Válido";
        resultado.classList.add("ok");
        obtenerDatosSUNAT(ruc);
    } else {
        valido = "No válido";
        resultado.classList.remove("ok");
    }

    resultado.innerText = "RUC: " + ruc + "\nFormato: " + valido;
}

// Devuelve un booleano si es un RUC válido
// (deben ser 11 dígitos sin otro caracter en el medio)
function rucValido(ruc) {
    //11 dígitos y empieza en 10,15,16,17 o 20
    if (!(ruc >= 1e10 && ruc < 11e9
            || ruc >= 15e9 && ruc < 18e9
            || ruc >= 2e10 && ruc < 21e9))
        return false;

    for (var suma = -(ruc % 10 < 2), i = 0; i < 11; i++, ruc = ruc / 10 | 0)
        suma += (ruc % 10) * (i % 7 + (i / 7 | 0) + 1);
    return suma % 11 === 0;

}

//Buscar datos del RUC y si existe
function obtenerDatosSUNAT(ruc) {
    //Init
    var url = "https://cors-anywhere.herokuapp.com/wmtechnology.org/Consultar-RUC/?modo=1&btnBuscar=Buscar&nruc=" + ruc,
            existente = document.getElementById("existente"),
            xhr = false;
    if (window.XMLHttpRequest) //Crear XHR
        xhr = new XMLHttpRequest();
    else if (window.ActiveXObject)
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    else
        return false;
    //handler para respuesta
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) { //200 OK
            var doc = document.implementation.createHTMLDocument()
                    .documentElement,
                    res = "",
                    txt, campos,
                    ok = false;

            doc.innerHTML = xhr.responseText;
            //Sólo el texto de las clases que nos interesa
            campos = doc.querySelectorAll(".list-group-item");
            if (campos.length) {
                for (txt of campos)
                    res += txt.innerText + "\n";
                //eliminar blancos por demás
                res = res.replace(/^\s+\n*|(:) *\n| +$/gm, "$1");
                //buscar si está el texto "ACTIVO" en el estado
                ok = /^Estado: *ACTIVO *$/m.test(res);
            } else
                res = "RUC: " + ruc + "\nNo existe.";

            //mostrar el texto formateado
            if (ok)
                existente.classList.add("ok");
            else
                existente.classList.remove("ok");
            existente.innerText = res;
        }
    } //falta verificar errores en conexión
    xhr.open("POST", url, true);
    xhr.send(null);
}
//sweetalert para guardar nuevo
//sweetalert para guardar nuevo
$(function () {
    $("#newproveedor").on("submit", function (e) {
        e.preventDefault();
        var data = $('#newproveedor').serialize();
        $.post("ProveedorController?accion=add", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Proveedor.jsp";
                            }
                        });
                ;
            } else if (res === "yaexiste") {
                debugger;
                swal("Ya existe Proveedor", {
                    icon: "warning"
                });
                return false;
            } else {
                swal("Revise la informacion y vuelva a intentarlo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Proveedor.jsp";
                            }
                        });
                ;
            }
        });
    });
});
//sweetalert para Editar
$(function () {
    $("#editproveedor").on("submit", function (e) {
        e.preventDefault();
        var data = $('#editproveedor').serialize();
        $.post("ProveedorController?accion=Actualizar", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Se ha guardado la informacion", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Proveedor.jsp";
                            }

                        });
                ;
            } else {

                swal("Revise la informacion y vuelva a intentarlo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "EditarProveedores.jsp";
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
            text: "Desea eliminar el proveedor seleccionado?",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idcli = fila.find('#idcliet').text();
                        console.log(idcli);
                        var data = {"accion": "eliminar", idprove: idcli};
                        $.post("ProveedorController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Proveedor.jsp";
                                    }

                                });
                                ;
                            }
                            console.log(jqXHR);
                            fila.remove();
                            if (res === "tienemovi") {
                                swal("El proveedor tiene movimientos, no se puede eliminar", {
                                    icon: "warning"
                                })
                                        .then((willDelete) => {
                                            if (willDelete) {
                                                parent.location.href = "Proveedor.jsp";
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
                        var idcat = fila.find('#idcliet').text();
                        console.log(idcat);
                        var data = {"accion": "Estado", id: idcat};
                        $.post("ProveedorController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Proveedor.jsp";
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

