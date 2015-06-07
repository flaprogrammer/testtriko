 function simple_tooltip(target_items, name){
    $(target_items).each(function(i){
       $("body").append("<div class='"+name+"' id='"+name+i+"'><img src="+$(this).children('td').text()+"></img></div>");
       var my_tooltip = $("#"+name+i);

       $(this).mouseover(function(){
         my_tooltip.css({opacity:0.9, display:"none"}).fadeIn(400);
        
       }).mousemove(function(kmouse){
         my_tooltip.css({left:kmouse.pageX+15, top:kmouse.pageY+15});
       }).mouseout(function(){
         my_tooltip.fadeOut(400);
       });
    });
}


