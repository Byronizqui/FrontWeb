/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
   $('#busquedaNombre').click(function(){
       $('#modalNombre').modal('show');
   }); 
   $('#busquedaCedula').click(function(){
       $('#modalCedula').modal('show');
   }); 
   $('#busquedaCarrera').click(function(){
       $('#modalCodigo').modal('show');
   }); 
   $('#editarAlumno').click(function(){
       $('#alumnoEdit').modal('show');
   }); 
   $('#agregarAlumno').click(function(){
       $('#addAlumno').modal('show');
   }); 
   $('#matricularAlumno').click(function(){
       $('#modalMatricula').modal('show');
   }); 
   $('#consultaHistorial').click(function(){
       $('#modalCedulaHistorial').modal('show');
   }); 
});
