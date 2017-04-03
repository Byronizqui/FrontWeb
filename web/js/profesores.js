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
   $('#editarProfesor').click(function(){
       $('#profesorEdit').modal('show');
   }); 
   $('#agregarProfesor').click(function(){
       $('#addProfesor').modal('show');
   }); 
   
   
});

function nota(alumno, grupo){
    $('#notaAlumno').val(alumno);
    $('#notaGrupo').val(grupo);
    $('#lGrupoP').modal('hide');
    $('#modalNota').modal('show');
}