$(document).ready(function(){  
    /*Salir del sistema
    $('.btn-exit').on('click', function(){
    	swal({
		  	title: '¿Desea salir del Sistema?',
		 	text: "",
		  	type: 'warning',
		  	showCancelButton: true,
		  	confirmButtonText: 'Salir',
		  	closeOnConfirm: false
		},
		function(isConfirm) {
		  	if (isConfirm) {
		    	window.location='index.jsp'; 
		  	}
		});
    });*/
     $('.btn-exit').on('click', function(){  
    swal({
  text: "Desea Salir del sistema?",
  icon: "warning",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
    parent.location.href = "login.jsp";
  } /*else {
    swal("Your imaginary file is safe!");
  }*/
});
});
    
    
    
});
