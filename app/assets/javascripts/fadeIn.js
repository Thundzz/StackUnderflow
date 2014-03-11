

     $('#ajoutTag').click(function()
            {

                      $('#black').attr('class',"black");
                      $('#black').fadeIn();
                      $('#black').stop().animate({opacity:'0.8',},1000);  
                      $("#div8").fadeIn("slow");
                     $("html, body").animate({ scrollTop: 0 }, "slow");
                    
                    

            });



$(document).keyup(function(e) {

  if (e.keyCode == 27) { 
    $('#black').delay(500).animate({opacity:'0',},500);
    $('#div8').fadeOut();
   
    $('#black').fadeOut();
  }   // esc
});
