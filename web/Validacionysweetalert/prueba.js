/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

//Confirmacion anulacion
$(function () {
    $('tr #btn-anular').click(function (e) {
        e.preventDefault();

        swal({
            title: "Estas seguro de anular el documento?",
            text: "Se ha detectado que el documento tiene movimiento",
            icon: "warning",
            buttons: ['Cancel', 'Ok'],
            dangerMode: true
        })
                .then((willDelete) => {
                    if (willDelete) {

                        //if (opcion) {
                        var fila = $(this).parent().parent();
                        console.log(fila);
                        var idv = fila.find('#idni').text();
                        console.log(idv);
                        var data = {"accion": "estadoanularni", id: idv};
                        $.post("NotadeIngresoController", data, function (res, est, jqXHR) {
                            //console.log('res ',res);


                            //console.log(est);  
                            if (jqXHR.status === 200) {
                                //success
                                //info
                                ///error
                                swal("Se anulo el documento correctamente!", {
                                    icon: "success"
                                }).then((willDelete) => {
                                    if (willDelete) {
                                        parent.location.href = "ListarBoleFac.jsp";
                                    }
                                });
                                ;
                            }
                        });
                        // }
                    } else {
                        swal("Your imaginary file is safe!");
                    }
                });
    });

});
