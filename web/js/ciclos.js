/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
    $('#busqueda').click(function(){
        $('#modalCiclos').modal('show');
    });
    
   $('#nuevoCiclo').click(function(){
        $('#addCiclo').modal('show');
    });
});