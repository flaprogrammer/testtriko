//var scroll_cat = {}, scroll_api_cat = {};
//var rows = 0;
//var sort = '', sort2 = 'code', order = 'ascending', order2 = 'ascending';
//var pageLoader = {};
//var startGood = 0;
//var orderLoader = $('<img src="/templates/triko/img/loading.gif" alt="Добавление"/>');
//var orderLoader2 = $('<img src="/templates/triko/img/loading.gif" style="float:right; padding-right:30px;" alt="Добавление"/>');
//var addFav = $('<a class="toFavorites" fav="false" href="#favorites"> В избранное </a>');
//var delFav = $('<a class="toFavorites" fav="true" href="#favorites"> В избранном </a>');
//var cat = '/categories/';
//var updater = {};
//var main_url = window.location.pathname;
//var hash_url_cat = window.location.hash;
var main_url = window.location.pathname;

jQuery.expr[':'].icontains = function(a, i, m) {
  return jQuery(a).text().toUpperCase()
      .indexOf(m[3].toUpperCase()) >= 0;
};


	var base = '/usel/all_goods/?transform=goods.xsl';
	var check_mashuk_brend = $('input#mashuk_brend:checked').val();
	var check_roly_poly_brend = $('input#roly_poly_brend:checked').val();
	var check_bossa_nova_brend = $('input#bossa_nova_brend:checked').val();
	
	if(!!!check_mashuk_brend || !!!check_roly_poly_brend || !!!check_bossa_nova_brend){
		var hash_tags = window.location.hash;
		if(!!check_mashuk_brend){
			var new_url = '#mashuk_brend';
		}if(!!!check_mashuk_brend){
			var new_url = '';
		}
		if(!!check_roly_poly_brend){
			var new_url_two = '#roly_poly_brend';
		}if(!!!check_roly_poly_brend){
			var new_url_two = '';
		}
		if(!!check_bossa_nova_brend){
			var new_url_three = '#bossa_nova_brend';
		}if(!!!check_bossa_nova_brend){
			var new_url_three = '';
		}
		if(!!check_mashuk_brend && !!check_roly_poly_brend && !!check_bossa_nova_brend){
			new_url = '#';
			new_url_two = '';
			new_url_three = '';
			history.pushState({}, '', new_url+new_url_two+new_url_three);
		}
		history.pushState({}, '', new_url+new_url_two+new_url_three);
			//	return false;
	}
	if(!!check_mashuk_brend && !!check_roly_poly_brend && !!check_bossa_nova_brend){
			
			new_url = '#';
			new_url_two = '';
			new_url_three = '';
			history.pushState({}, '', new_url+new_url_two+new_url_three);
			//	return false;
		}
	
	
	
	
	//	var hash_tags = window.location.hash;
		var new_hash = window.location.hash;
		if(!!new_hash){
		//	alert(new_hash);
			var mashuk_brand = new_hash.indexOf('mashuk_brend');
			var bossa_nova_brand = new_hash.indexOf('bossa_nova_brend');
			var roly_poly_brand = new_hash.indexOf('roly_poly_brend');
			if(mashuk_brand != -1 && bossa_nova_brand == -1 && roly_poly_brand == -1){
				brands = '1782514/';
				$.cookie('brands', '1782514/', { path: '/'});
				$.cookie('check', '1', { path: '/'});
				$('#mashuk_brend').attr("checked", 'checked');
				$('#bossa_nova_brend').removeAttr("checked");
				$('#roly_poly_brend').removeAttr("checked");
				$( document ).ready(function() {
					$('span.for_filter').html('Машук');
                                        $('li.last').removeClass('last');
                                        $('li.arrow_bread').addClass('last');
				});
			} else
			if(mashuk_brand == -1 && bossa_nova_brand != -1 && roly_poly_brand == -1){
				brands = '1782513/';
				$.cookie('brands', '1782513/', { path: '/'});			  
				$.cookie('check', '2', { path: '/'});
				
				$('#mashuk_brend').removeAttr("checked");
				$('#bossa_nova_brend').attr("checked", 'checked');
				$('#roly_poly_brend').removeAttr("checked");
				$( document ).ready(function() {
					$('span.for_filter').html('Bossa Nova');
                                        $('li.last').removeClass('last');
                                        $('li.arrow_bread').addClass('last');
				});
			}else
			if(mashuk_brand != -1 && bossa_nova_brand != -1 && roly_poly_brand == -1){
				brands = '1782513/1782514/';
				$.cookie('brands', '1782513/1782514/', { path: '/'});
				$.cookie('check', '3', { path: '/'});
				
				$('#mashuk_brend').attr("checked", 'checked');
				$('#bossa_nova_brend').attr("checked", 'checked');
				$('#roly_poly_brend').removeAttr("checked");
				$( document ).ready(function() {
					$('span.for_filter').html('Машук, Bossa Nova');
                                        $('li.last').removeClass('last');
                                        $('li.arrow_bread').addClass('last');
				});
			}
			
			else
			if(mashuk_brand !== -1 && bossa_nova_brand == -1 && roly_poly_brand == -1){
				brands = '1782600/1782514/1782513/';
				$.cookie('brands', '1782600/1782514/1782513/', { path: '/'});
				$.cookie('check', '4', { path: '/'});
				
				$('#mashuk_brend').attr("checked", 'checked');
				$('#bossa_nova_brend').attr("checked", 'checked');
				$('#roly_poly_brend').attr("checked", 'checked');
				
				$( document ).ready(function() {
					$('span.for_filter').html('');
                                        $('li.take_it').addClass('last');
                                        $('li.arrow_bread').removelass('last');
				});
			}else
			if(mashuk_brand == -1 && bossa_nova_brand == -1 && roly_poly_brand != -1){
				brands = '1782600/';
				$.cookie('brands', '1782600/', { path: '/'});
				$.cookie('check', '5', { path: '/'});
				
				$('#mashuk_brend').removeAttr("checked");
				$('#bossa_nova_brend').removeAttr("checked");
				$('#roly_poly_brend').attr("checked", 'checked');
				
				$( document ).ready(function() {
					$('span.for_filter').html('Roly Poly');
                                        $('li.last').removeClass('last');
                                        $('li.arrow_bread').addClass('last');
				});
			}else
			if(mashuk_brand != -1 && bossa_nova_brand == -1 && roly_poly_brand != -1){
				brands = '1782600/1782514/';
				$.cookie('brands', '1782600/1782514/', { path: '/'});
				$.cookie('check', '6', { path: '/'});
				
				$('#mashuk_brend').attr("checked", 'checked');
				$('#bossa_nova_brend').removeAttr("checked");
				$('#roly_poly_brend').attr("checked", 'checked');
				$( document ).ready(function() {
					$('span.for_filter').html('Машук, Roly Poly');
                                        $('li.last').removeClass('last');
                                        $('li.arrow_bread').addClass('last');
				});
			}else
			if(mashuk_brand == -1 && bossa_nova_brand != -1 && roly_poly_brand != -1){
				brands = '1782600/1782513/';
				$.cookie('brands', '1782600/1782513/', { path: '/'});
				$.cookie('check', '7', { path: '/'});
				
				$('#mashuk_brend').removeAttr("checked");
				$('#bossa_nova_brend').attr("checked", 'checked');
				$('#roly_poly_brend').attr("checked", 'checked');
				$( document ).ready(function() {
					$('span.for_filter').html('Bossa Nova, Roly Poly');
                                        $('li.last').removeClass('last');
                                        $('li.arrow_bread').addClass('last');
				});
			}
			if(bossa_nova_brand == -1 && roly_poly_brand == -1 && mashuk_brand == -1){
				brands = '1782600/1782514/1782513/';
				$.cookie('brands', '1782600/1782514/1782513/', { path: '/'});
				$.cookie('check', '4', { path: '/'});
				
				$('#mashuk_brend').attr("checked");
				$('#bossa_nova_brend').attr("checked", 'checked');
				$('#roly_poly_brend').attr("checked", 'checked');
				$( document ).ready(function() {
					$('span.for_filter').html('');
                                        $('li.take_it').addClass('last');
                                        $('li.arrow_bread').removeClass('last');
				});
			}
		
			
            
			
		}
	
	
	$( document ).ready(function() {
        hashOtherNews();
    });
	/* END Custom by Gluchnoglaz */
	
	
	/*        my custom       
	_____________________________________*/
	
       
        
        
	$('#mashuk_brend').change(function()
	{
		$('#table tr.good').show();
		
		    /*if($('#mashuk_brend').attr("checked") == 'checked')
			{
			 $('#bossa_nova_brend').removeAttr("checked");
			 $('#roly_poly_brend').removeAttr("checked");
			}*/
		
			if($('#mashuk_brend').attr("checked") == 'checked' 
			&& $('#bossa_nova_brend').attr("checked") != 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked'){ 
			  brands = '1782514/';
			  $.cookie('brands', '1782514/', { path: '/'});
			  $.cookie('check', '1', { path: '/'});
			  
			$(function() {
				history.pushState({}, '', '#mashuk_brend');
				return false;
			});
			  
			} else if($('#bossa_nova_brend').attr("checked") == 'checked' 
			&& $('#mashuk_brend').attr("checked") != 'checked'			
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			) { 
			  brands = '1782513/';
			  $.cookie('brands', '1782513/', { path: '/'});			  
			  $.cookie('check', '2', { path: '/'});
			  
			$(function() {
				history.pushState({}, '', '#bossa_nova_brend');
				return false;
			});

			} 
			else if($('#bossa_nova_brend').attr("checked") == 'checked' 
			&& $('#mashuk_brend').attr("checked") == 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			) {
			  brands = '1782513/1782514/';
			  $.cookie('brands', '1782513/1782514/', { path: '/'});
			  $.cookie('check', '3', { path: '/'});
				
				$(function() {
					history.pushState({}, '', '#bossa_nova_brend&#mashuk_brend');
					return false;
				});
				
			} 
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '1782600/1782514/1782513/';
			  $.cookie('brands', '1782600/1782514/1782513/', { path: '/'});
			  $.cookie('check', '4', { path: '/'});
				$(function() {
					history.pushState({}, '', '#');
					return false;
				});
			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600/';
			  $.cookie('brands', '1782600/', { path: '/'});
			  $.cookie('check', '5', { path: '/'});
				$(function() {
					history.pushState({}, '', '#roly_poly_brend');
					return false;
				});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600/1782514/';
			  $.cookie('brands', '1782600/1782514/', { path: '/'});
			  $.cookie('check', '6', { path: '/'});
				
				$(function() {
					history.pushState({}, '', '#roly_poly_brend&#mashuk_brend');
					return false;
				});
				
			}	
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '1782600/1782513/';
			  $.cookie('brands', '1782600/1782513/', { path: '/'});
			  $.cookie('check', '7', { path: '/'});
				$(function() {
					history.pushState({}, '', '#roly_poly_brend&#bossa_nova_brend');
					return false;
				});
			}			
			else {
			$(this).attr('checked', 'checked');

			}
                        hideOtherNews()
                       //   newUpdateTable(1);
                  //         updateTable(1); 
                    //    alert('boom');
	//	updateTable(1);
		hideBrend();
    
	});
	
	$('#bossa_nova_brend').change(function()
	{
	
		/*if($('#bossa_nova_brend').attr("checked") == 'checked')
		{
		 $('#mashuk_brend').removeAttr("checked");
		 $('#roly_poly_brend').removeAttr("checked");
		}*/
			
		$('#table tr.good').show();
			if($('#mashuk_brend').attr("checked") == 'checked' 
			&& $('#bossa_nova_brend').attr("checked") != 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked'){ 
			  brands = '1782514/';
			  $.cookie('brands', '1782514/', { path: '/'});
			  $.cookie('check', '1', { path: '/'});
			  
				$(function() {
					history.pushState({}, '', '#mashuk_brend');
					return false;
				});
			  
			} else if($('#bossa_nova_brend').attr("checked") == 'checked' 
			&& $('#mashuk_brend').attr("checked") != 'checked'			
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			) { 
			  brands = '1782513/';
			  $.cookie('brands', '1782513/', { path: '/'});			  
			  $.cookie('check', '2', { path: '/'});
			  
				$(function() {
					history.pushState({}, '', '#bossa_nova_brend');
					return false;
				});

			} 
			else if($('#bossa_nova_brend').attr("checked") == 'checked' 
			&& $('#mashuk_brend').attr("checked") == 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			) {
			  brands = '1782513/1782514/';
			  $.cookie('brands', '1782513/1782514/', { path: '/'});
			  $.cookie('check', '3', { path: '/'});
			  
				$(function() {
					history.pushState({}, '', '#mashuk_brend&#bossa_nova_brend');
					return false;
				});

			} 
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '1782600/1782514/1782513/';
			  $.cookie('brands', '1782600/1782514/1782513/', { path: '/'});
			  $.cookie('check', '4', { path: '/'});
			  
				$(function() {
					history.pushState({}, '', '#');
					return false;
				});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600/';
			  $.cookie('brands', '1782600/', { path: '/'});
			  $.cookie('check', '5', { path: '/'});
				$(function() {
					history.pushState({}, '', '#roly_poly_brend');
					return false;
				});
			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600/1782514/';
			  $.cookie('brands', '1782600/1782514/', { path: '/'});
			  $.cookie('check', '6', { path: '/'});
			  
				$(function() {
					history.pushState({}, '', '#roly_poly_brend&#mashuk_brend');
					return false;
				});

			}	
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '1782600/1782513/';
			  $.cookie('brands', '1782600/1782513/', { path: '/'});
			  $.cookie('check', '7', { path: '/'});
				$(function() {
					history.pushState({}, '', '#roly_poly_brend&#bossa_nova_brend');
					return false;
				});
			}			
			else {
			$(this).attr('checked', 'checked');

			}
                         hideOtherNews();
              //         newUpdateTable(1);
             //       updateTable(1); 
                
		hideBrend();
    
	});
	
	$('#roly_poly_brend').change(function()
	{
	
		/*if($('#roly_poly_brend').attr("checked") == 'checked')
		{
		 $('#bossa_nova_brend').removeAttr("checked");
		 $('#mashuk_brend').removeAttr("checked");
		}*/
		
		$('#table tr.good').show();
			if($('#mashuk_brend').attr("checked") == 'checked' 
			&& $('#bossa_nova_brend').attr("checked") != 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked'){ 
			  brands = '1782514/';
			  $.cookie('brands', '1782514/', { path: '/'});
			  $.cookie('check', '1', { path: '/'});
			  
			  
				$(function() {
					history.pushState({}, '', '#mashuk_brend');
					return false;
				});
				
			} else if($('#bossa_nova_brend').attr("checked") == 'checked' 
			&& $('#mashuk_brend').attr("checked") != 'checked'			
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			) { 
			  brands = '1782513/';
			  $.cookie('brands', '1782513/', { path: '/'});			  
			  $.cookie('check', '2', { path: '/'});
				
				
				$(function() {
					history.pushState({}, '', '#bossa_nova_brend');
					return false;
				});
				
			} 
			else if($('#bossa_nova_brend').attr("checked") == 'checked' 
			&& $('#mashuk_brend').attr("checked") == 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			) {
			  brands = '1782513/1782514/';
			  $.cookie('brands', '1782513/1782514/', { path: '/'});
			  $.cookie('check', '3', { path: '/'});
				
				$(function() {
					history.pushState({}, '', '#bossa_nova_brend&#mashuk_brend');
					return false;
				});
				
			} 
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '1782600/1782514/1782513/';
			  $.cookie('brands', '1782600/1782514/1782513/', { path: '/'});
			  $.cookie('check', '4', { path: '/'});
			  
				$(function() {
					history.pushState({}, '', '#');
					return false;
				});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600/';
			  $.cookie('brands', '1782600/', { path: '/'});
			  $.cookie('check', '5', { path: '/'});
				
				$(function() {
					history.pushState({}, '', '#roly_poly_brend');
					return false;
				});
			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600/1782514/';
			  $.cookie('brands', '1782600/1782514/', { path: '/'});
			  $.cookie('check', '6', { path: '/'});
				
				
				$(function() {
					history.pushState({}, '', '#roly_poly_brend&#mashuk_brend');
					return false;
				});
				
			}	
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '1782600/1782513/';
			  $.cookie('brands', '1782600/1782513/', { path: '/'});
			  $.cookie('check', '7', { path: '/'});
				$(function() {
					history.pushState({}, '', '#roly_poly_brend&#bossa_nova_brend');
					return false;
				});
			}			
			else {
			$(this).attr('checked', 'checked');

			}
                     hideOtherNews();
                    //newUpdateTable(1);
               //     updateTable(1); 
                
		hideBrend();
    
	});	
//	alert(main_url);
	/*        end my custom
	_____________________________________*/



function simple_tooltip(target_items, name){
    $(target_items).each(function(i){
        $("body").append("<div class='"+name+"' id='"+name+i+"'><p>"+$(this).attr('title')+"</p></div>");
        var my_tooltip = $("#"+name+i);

        $(this).removeAttr("title").mouseover(function(){
            my_tooltip.css({opacity:0.8, display:"none"}).fadeIn(400);
        }).mousemove(function(kmouse){
            my_tooltip.css({left:kmouse.pageX+15, top:kmouse.pageY+15});
        }).mouseout(function(){
            my_tooltip.fadeOut(400);
        });
    });
}

function  hideOtherNews(){
    if(main_url == '/collections/'){
        var mashuk = $('#mashuk_brend').prop("checked");
        var bossa = $('#bossa_nova_brend').prop("checked");
        var poly = $('#roly_poly_brend').prop("checked");
        if(mashuk != true || bossa != true || poly != true){
         //   if(mashuk == true && bossa == true){
                $('div.promolection').children('a:icontains("МАШУК")').parents('.promolection').hide();
                $('div.promolection').children('a:icontains("Bossa")').parents('.promolection').hide();
                $('div.promolection').children('a:icontains("Roly Poly")').parents('.promolection').hide();
                $('div.promolection').each(function(){
                    if(mashuk == true){
                        $(this).children('a:icontains("МАШУК")').parents('.promolection').show();
                    }
                    if(bossa == true){
                        $(this).children('a:icontains("Bossa")').parents('.promolection').show(); 
                    }
                    if(poly == true){
                        $(this).children('a:icontains("Roly Poly")').parents('.promolection').show(); 
                    }
                });
         //   }
        }
        if(mashuk == true && bossa == true && poly == true){
            $('div.promolection').show();
        }
        hashOtherNews();    
    }
    if(main_url == '/promo/'){
        
        var mashuk = $('#mashuk_brend').prop("checked");
        var bossa = $('#bossa_nova_brend').prop("checked");
        var poly = $('#roly_poly_brend').prop("checked");
        if(mashuk != true || bossa != true || poly != true){
         //   if(mashuk == true && bossa == true){
                $('div.promolection').children('a:icontains("МАШУК")').parents('.promolection').hide();
                $('div.promolection').children('a:icontains("Bossa")').parents('.promolection').hide();
                $('div.promolection').children('a:icontains("Roly Poly")').parents('.promolection').hide();
                $('div.promolection').each(function(){
                    if(mashuk == true){
                        $(this).children('a:icontains("МАШУК")').parents('.promolection').show();
                    }
                    if(bossa == true){
                        $(this).children('a:icontains("Bossa")').parents('.promolection').show(); 
                    }
                    if(poly == true){
                        $(this).children('a:icontains("Roly Poly")').parents('.promolection').show(); 
                    }
                });
         //   }
        }
        if(mashuk == true && bossa == true && poly == true){
            $('div.promolection').show();
        }
        hashOtherNews();    
    }
}


function hashOtherNews(){
    
	
    $('div.promolection').children('a:icontains("Машук")').parents('.promolection').hide();
    $('div.promolection').children('a:icontains("Bossa")').parents('.promolection').hide();
    $('div.promolection').children('a:icontains("Roly Poly")').parents('.promolection').hide();

    
    var mashuk = $('#mashuk_brend').prop("checked");
    var bossa = $('#bossa_nova_brend').prop("checked");
    var poly = $('#roly_poly_brend').prop("checked");
	
	
	var mashuk_brand = new_hash.indexOf('mashuk_brend');
    var bossa_nova_brand = new_hash.indexOf('bossa_nova_brend');
    var roly_poly_brand = new_hash.indexOf('roly_poly_brend');

    if(mashuk_brand != -1 || mashuk == true){
        $('div.promolection').children('a:icontains("МАШУК")').parents('.promolection').show();
		
    }    
    if(bossa_nova_brand != -1 || bossa == true){
        $('div.promolection').children('a:icontains("Bossa")').parents('.promolection').show();
		
    }   
    if(roly_poly_brand != -1 || poly  == true){
        $('div.promolection').children('a:icontains("Roly Poly")').parents('.promolection').show();
		
    }   

		
}