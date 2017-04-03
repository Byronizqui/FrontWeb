/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
   $('#busquedaNombre').click(function(){
       $('#modalNombre').modal('show');
   }) ;
   $('#busquedaCodigo').click(function(){
       $('#modalCodigo').modal('show');
   }) ;
   $('#busquedaCarrera').click(function(){
       $('#modalCarrera').modal('show');
   }) ;
   $('#editarCurso').click(function(){
       $('#modalEdit').modal('show');
   }) ;
   $('#agregarCurso').click(function(){
       $('#addCurso').modal('show');
   }) ;
});