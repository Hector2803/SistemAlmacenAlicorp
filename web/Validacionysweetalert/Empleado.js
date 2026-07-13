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
function valnewEmpleado() {
    var nom = document.frm_nuevo.Txtapellidos.value;
    var tipodocu = document.frm_nuevo.Txtidtipodocumento.value;
    var documentos = document.frm_nuevo.Txtdni.value;
    var sueldo = document.frm_nuevo.Txtsueldo.value;
    var direc = document.frm_nuevo.Txtdireccion.value;
    var correo = document.frm_nuevo.Txtemail.value;
    var celular = document.frm_nuevo.Txttelefono.value;
    
    if (tipodocu === "4") {
        if (documentos.length !== 11) {
            swal("falta caracteres  o demasiados caracteres RUC", {
                icon: "warning"
            });
            return false;
        }
    }
    
    if (tipodocu === "4") {
        if ((documentos.length = Number(documentos)) && documentos % 1 === 0
    	&& rucValido(documentos)) { 
        obtenerDatosSUNAT(documentos);
    }else  {
            swal("RUC Invalido", {
                icon: "warning"
            });
            return false;
        }
    }
    
    if (tipodocu === "2") {
        if (documentos.length !== 8) {
            swal("falta caracteres  o demasiados caracteres DNI", {
                icon: "warning"
            });
            return false;
        }
    }
    if (nom === '') {
        swal("Ingrese nombre!", {
            icon: "warning"
        });
        return false;
    } if (nom.length > 50)
    {
        swal("Demasiados caracteres", {
            icon: "warning"
        });
       return false;
    } if (tipodocu === "" || tipodocu === null)
    {
        debugger;
        swal("seleciona el tipo de documento", {
            icon: "warning"
        });
        return false;
    } if (documentos === '') {
        swal("Ingrese nro de doc", {
            icon: "warning"
        });
        return false;
    } if (sueldo === '') {
        swal("Ingrese Sueldo", {
            icon: "warning"
        });
        return false;
    } if (direc === '') {
        swal("Ingrese direccion", {
            icon: "warning"
        });
        return false;
    } if (correo === '') {
        swal("Ingrese correo", {
            icon: "warning"
        });
        return false;
    } if (!/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i.test(correo)) {
        swal("Ingrese correo válido", {
            icon: "warning"
        });
        return false;
    } if (celular === '') {
        swal("Ingrese nro", {
            icon: "warning"
        });
        return false;
    }  
}


//Valiaciones de campos editar cliente
function validareditempleados() {
    var nombre = document.frm_edit.Txtapellidos.value;
    var tipodocu = document.frm_edit.Txtidtipodocumento.value;
    var documentos = document.frm_edit.Txtdni.value;
    var sueldo = document.frm_edit.Txtsueldo.value;
    var direc = document.frm_edit.Txtdireccion.value;
    var correo = document.frm_edit.Txtemail.value;
    var celular = document.frm_edit.Txttelefono.value;
  
    if (nombre === '') {
        swal("Ingrese Nombre!", {
            icon: "warning"
        });
        return false;
    }
    if (tipodocu === "4") {
        if (documentos.length !== 11) {
            swal("falta caracteres  o demasiados caracteres RUC", {
                icon: "warning"
            });
            return false;
        }
    }
    if (tipodocu === "2") {
        if (documentos.length !== 8) {
            swal("falta caracteres  o demasiados caracteres DNI", {
                icon: "warning"
            });
            return false;
        }
    }
    if (nombre === '') {
        swal("Ingrese nombre!", {
            icon: "warning"
        });
        return false;
    } if (nombre.length > 50)
    {
        swal("Demasiados caracteres", {
            icon: "warning"
        });
        return false;
    } if (tipodocu === "" || tipodocu === null)
    {
        debugger;
        swal("seleciona el tipo de documento", {
            icon: "warning"
        });
        return false;
    } if (documentos === '') {
        swal("Ingrese nro de doc", {
            icon: "warning"
        });
        return false;
    }  if (sueldo === '') {
        swal("Ingrese Sueldo", {
            icon: "warning"
        });
        return false;
    }  if (direc === '') {
        swal("Ingrese direccion", {
            icon: "warning"
        });
        return false;
    }  if (correo === '') {
        swal("Ingrese correo", {
            icon: "warning"
        });
        return false;
    }  if (!/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i.test(correo)) {
        swal("Ingrese correo válido", {
            icon: "warning"
        });
        return false;
    }  if (celular === '') {
        swal("Ingrese nro", {
            icon: "warning"
        });
        return false;
    }  
}

//Handler para el evento cuando cambia el input
//Elimina cualquier caracter espacio o signos habituales y comprueba validez
function validarInput(input) {
    var ruc       = input.value.replace(/[-.,[\]()\s]+/g,""),
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
    
    for (var suma = -(ruc%10<2), i = 0; i<11; i++, ruc = ruc/10|0)
        suma += (ruc % 10) * (i % 7 + (i/7|0) + 1);
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
    else return false;
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
                res = res.replace(/^\s+\n*|(:) *\n| +$/gm,"$1");
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
$(function () {
    $("#newempleado").on("submit", function (e) {
        e.preventDefault();
        var data = $('#newempleado').serialize();
        $.post("EmpleadoController?accion=add", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Registrado correctamente", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Empleado.jsp";
                            }
                        });
                ;
            }else if (res === "yaexiste") {
                debugger;
                swal("Ya existe Trabajador", {
                    icon: "warning"
                });
                return false;
            } else {
                swal("Error, Intentar de nuevo", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Empleado.jsp";
                            }
                        });
                ;
            }
        });
    });
});
//sweetalert para Editar
$(function () {
    $("#editempleado").on("submit", function (e) {
        e.preventDefault();
        var data = $('#editempleado').serialize();
        $.post("EmpleadoController?accion=Actualizar", data, function (res, est, jqXHR) {
            if (res === "ok") {
                swal("Actualizado correctamente", {
                    icon: "success"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Empleado.jsp";
                            }

                        });
                ;
            } else {
                swal("Hubo un error", "Intente nuevamente", {
                    icon: "warning"
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "EditarEmpleado.jsp";
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
            title: "Estas seguro de eliminar?",
            text: "Una vez eliminado no podras recuperar el registro",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idemp = fila.find('#idempl').text();
                        console.log(idemp);
                        var data = {"accion": "eliminar", Idemp: idemp};
                        $.post("EmpleadoController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Empleado.jsp";
                                    }

                                });
                                ;
                            }
                            console.log(jqXHR);
                            fila.remove();
                        });
                        // }
                    } else {
                        swal("Se ha cancelado la operacion");
                    }
                });
    });

});
//Confirmacion de cambio de estado
$(function () {
    $('tr #btn-estado').click(function (e) {
        e.preventDefault();

        swal({
            title: "Estas seguro de cambiar el estado?",
            text: "Ya nose vizualizara en registrar producto",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idcat = fila.find('#idempl').text();
                        console.log(idcat);
                        var data = {"accion": "Estado", id: idcat};
                        $.post("EmpleadoController", data, function (res, est, jqXHR) {
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
                                        parent.location.href = "Empleado.jsp";
                                    }
                                });
                                ;
                            }
                        });
                        // }
                    } else {
                        swal("Se ha cancelado la operacion");
                    }
                });
    });

});