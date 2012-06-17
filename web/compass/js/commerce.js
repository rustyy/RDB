$(document).ready(function() {
  setTimeout(function(){
    $('#header').addClass('show');
    
    setTimeout(function(){
      $('#content, #sidebar').addClass('show');
    }, 500);
  }, 400);  
});