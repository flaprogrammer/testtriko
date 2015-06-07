var scroll_cat = {}, scroll_api_cat = {};
var rows = 0;
var sort = '', sort2 = 'code', order = 'ascending', order2 = 'ascending';
var pageLoader = {};
var startGood = 0;
var orderLoader = $('<img src="/templates/triko/img/loading.gif" alt="Добавление"/>');
var orderLoader2 = $('<img src="/templates/triko/img/loading.gif" style="float:right; padding-right:30px;" alt="Добавление"/>');
var addFav = $('<a class="toFavorites" fav="false" href="#favorites"> В избранное </a>');
var delFav = $('<a class="toFavorites" fav="true" href="#favorites"> В избранном </a>');
var cat = '/categories/';
var updater = {};

/*$.extend({

  getUrlVars: function(){

    var vars = [], hash;

    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

    for(var i = 0; i < hashes.length; i++)

    {

      hash = hashes[i].split('=');

      vars.push(hash[0]);

      vars[hash[0]] = hash[1];

    }

    return vars;

  },

  getUrlVar: function(name){

    return $.getUrlVars()[name];

  }
});*/

$(function()
{
	if ($('#table').length == 0)
	{
		return null;
	}
	
	$('#table').height(function () {return $('#goodInfo').outerHeight() - $('#filter').outerHeight() - parseInt($(this).css('marginTop'))});
	updateTable(1);
	
	$('#filter select').selectBox({menuTransition: 'fade', loopOptions: true, menuSpeed: 'fast'});
	
	$('#materialSelect').change(function()
	{
		$('#table tr.good').show();
		
		material = $(this).val();
		
		updateTable(1);
	});
	
	$('#sizeSelect').change(function()
	{
		$('#table tr.good').show();
		
		size = $(this).val();
		
		updateTable(1);
	});
	
	/*        my custom       
	_____________________________________*/
	
	$('#mashuk_brend').change(function()
	{
		$('#table tr.good').show();
		
		    if($('#mashuk_brend').attr("checked") == 'checked')
			{
			 $('#bossa_nova_brend').removeAttr("checked");
			 $('#roly_poly_brend').removeAttr("checked");
			}
		
			if($('#mashuk_brend').attr("checked") == 'checked' 
			&& $('#bossa_nova_brend').attr("checked") != 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked'){ 
			  brands = 1782514;
			  $.cookie('brands', '1782514', { path: '/'});
			  $.cookie('check', '1', { path: '/'});
			  
			} else if($('#bossa_nova_brend').attr("checked") == 'checked' 
			&& $('#mashuk_brend').attr("checked") != 'checked'			
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			) { 
			  brands = 1782513;
			  $.cookie('brands', '1782513', { path: '/'});
			  
			  $.cookie('check', '2', { path: '/'});

			} 
			else if($('#bossa_nova_brend').attr("checked") == 'checked' 
			&& $('#mashuk_brend').attr("checked") == 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '3', { path: '/'});

			} 
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '4', { path: '/'});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600';
			  $.cookie('brands', '1782600', { path: '/'});
			  $.cookie('check', '5', { path: '/'});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '6', { path: '/'});

			}	
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '7', { path: '/'});

			}			
			else {
			$(this).attr('checked', 'checked');

			}
			
		
		
		updateTable(1);
		hideBrend();
	});
	
	$('#bossa_nova_brend').change(function()
	{
	
		if($('#bossa_nova_brend').attr("checked") == 'checked')
		{
		 $('#mashuk_brend').removeAttr("checked");
		 $('#roly_poly_brend').removeAttr("checked");
		}
			
		$('#table tr.good').show();
			if($('#mashuk_brend').attr("checked") == 'checked' && $('#bossa_nova_brend').attr("checked") != 'checked' 
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			){ 
			  brands = 1782514;
			  $.cookie('brands', '1782514', { path: '/'});
			  
			  $.cookie('check', '1', { path: '/'});
			  

			} else if($('#bossa_nova_brend').attr("checked") == 'checked' && $('#mashuk_brend').attr("checked") != 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked') { 
			  brands = 1782513;
			  $.cookie('brands', '1782513', { path: '/'});
			  
			  $.cookie('check', '2', { path: '/'});
			  

			} else if($('#bossa_nova_brend').attr("checked") == 'checked' && $('#mashuk_brend').attr("checked") == 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked') {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '3', { path: '/'});
			}	
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '4', { path: '/'});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600';
			  $.cookie('brands', '1782600', { path: '/'});
			  $.cookie('check', '5', { path: '/'});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '6', { path: '/'});

			}	
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '7', { path: '/'});

			}
			else {
			   $(this).attr('checked', 'checked');

			}
		updateTable(1);
		hideBrend();
	});
	
	$('#roly_poly_brend').change(function()
	{
	
		if($('#roly_poly_brend').attr("checked") == 'checked')
		{
		 $('#bossa_nova_brend').removeAttr("checked");
		 $('#mashuk_brend').removeAttr("checked");
		}
		
		$('#table tr.good').show();
			if($('#mashuk_brend').attr("checked") == 'checked' && $('#bossa_nova_brend').attr("checked") != 'checked' 
			&& $('#roly_poly_brend').attr("checked") != 'checked'
			){ 
			  brands = 1782514;
			  $.cookie('brands', '1782514', { path: '/'});
			  
			  $.cookie('check', '1', { path: '/'});
			  

			} else if($('#bossa_nova_brend').attr("checked") == 'checked' && $('#mashuk_brend').attr("checked") != 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked') { 
			  brands = 1782513;
			  $.cookie('brands', '1782513', { path: '/'});
			  
			  $.cookie('check', '2', { path: '/'});
			  

			} else if($('#bossa_nova_brend').attr("checked") == 'checked' && $('#mashuk_brend').attr("checked") == 'checked'
			&& $('#roly_poly_brend').attr("checked") != 'checked') {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '3', { path: '/'});
			}	
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '4', { path: '/'});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '1782600';
			  $.cookie('brands', '1782600', { path: '/'});
			  $.cookie('check', '5', { path: '/'});

			}
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") == 'checked' && 
					$('#bossa_nova_brend').attr("checked") != 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '6', { path: '/'});

			}	
			else if($('#roly_poly_brend').attr("checked") == 'checked' && 
					$('#mashuk_brend').attr("checked") != 'checked' && 
					$('#bossa_nova_brend').attr("checked") == 'checked'
					) {
			  brands = '';
			  $.cookie('brands', '', { path: '/'});
			  $.cookie('check', '7', { path: '/'});

			}
			else {
			   $(this).attr('checked', 'checked');

			}
		updateTable(1);
		hideBrend();
	});	
	
	/*        end my custom
	_____________________________________*/
	
	$('#filter .sort').click(function(event)
	{
		event.preventDefault();
		if ($(this).attr('field') == sort)
		{
			switch (order)
			{
				case 'ascending':
					order = 'descending';
					break;
				case 'descending':
					order = 'ascending';
					sort = '';
					break;
				default:
					order = 'ascending';
			}
		}
		else
		{
			order = 'ascending';
			sort = $(this).attr('field');
		}
		
		updateTable(1);
		
		makeSorting();
	});
	
	$('#tableHeader th').click(function(event)
	{
		event.preventDefault();
		if ($(this).attr('field') == sort2)
		{
			order2 = order2 == 'ascending' ? 'descending' : 'ascending';
		}
		else
		{
			order2 = 'ascending';
			sort2 = $(this).attr('field');
		}
		
		updateTable(1);
		
		makeSorting2();
	});
	
	makeSorting();
	makeSorting2();
	
	$('.leftSubmenu li').click(function(event)
	{
		event.preventDefault();
		
		$('li', $(this).parent()).not(this).removeClass('active');
		
		if ($(this).hasClass('active') == false)
		{
			$(this).addClass('active');
			cat = $('a', this).attr('href').substring(4);
		}
		else
		{
			$(this).removeClass('active');
			cat = $(this).parent().parent().attr('catId');
		}
		
		updateTable(1);
	});
	
	/*var goodId = $.getUrlVar('id');
	if(goodId>0)
	{
		$('#table tr.good').removeClass("act");	
		$('#tr' + id).addClass("act");		
		doRowClick(goodId);	
	}	*/
	
	return null;
});

$.fn.zebrafy = function()
{
	$(this).removeClass('odd').removeClass('even').filter(":odd").addClass('odd').end().filter(":even").addClass('even');
}

function makeSorting()
{
	$('#filter .sort img.arrow').remove();
	
	if (sort != '')
	{
		sortImg = order == 'ascending' ? ascImg : descImg;
		$('#filter .sort[field="'+sort+'"] a').append(sortImg.clone());
	}
}

function makeSorting2()
{
	$('#tableHeader th img.arrow').remove();
	
	if (sort2 != '')
	{
		sortImg2 = order2 == 'ascending' ? ascImg : descImg;
		$('#tableHeader th[field="'+sort2+'"] a').append(sortImg2.clone());
	}
}

function makeQuery(add)
{
	add = add || '';
	
	return base+'&cat='+cat+'&material='+material+'&size='+size+'&brands='+brands+'&sort='+sort+'&order='+order+'&sort2='+sort2+'&order2='+order2+'&start='+rows+add;
}

function selectGood()
{
	if (startGood == 0)
	{
		$('#table tr.good:first').click();
	}
	else
	{
		$('#table tr.good').removeClass("act");	
		$('#tr'+startGood).addClass("act");	
		
		doRowClick(startGood);
		
		startGood = 0;
	}
}

function updateTable(clear, add)
{
	$('#tableEmpty').hide();
	clear = clear || 0;
	add = add || '';
	
	if (clear == 1)
	{
		$('#table table').css('visibility', 'hidden');
		$('#table table tr:gt(0)').remove();
		rows = 0;
	}
	else
	{
		$('#tableLoader').addClass('bottom');
	}
	
	$('#tableLoader').show();
	
	//$('#carousel_2').empty();
	
	//alert("makeCarousel: updateTable();");
	makeCarousel(-1);
	
	if ('readyState' in updater && updater.readyState != 4)
	{
		updater.abort();
	}
	
	updater = $.get(makeQuery(add), function(data)
	{
		if (clear == 1)
		{
			$('#goodInfo').empty();
		}
		var responce = $('<div></div>').append(data);
		
		if ($('tr', responce).length > 0 || ($('tr', responce).length == 0 && clear != 1))
		{
			
			$('tr', responce).appendTo('#table table');
			
			rowClick();
				
			if (clear == 1)
			{
				selectGood();
			}
			
			makeCatalog();
			
			$('#table table').css('visibility', 'visible');
		}
		else
		{			
			$('#tableEmpty').show();
		}
		
		$('#tableLoader').removeClass('bottom').hide();
		
	}, 'html');
}

function rowClick()
{
	$('#table tr.good').unbind('click').click(function(event)
	{
		event.preventDefault();
		var id = $('a', this).attr('pageId');
		
		//dvm
		$('#table tr.good').removeClass("act");	
		$(this).addClass("act");	
		
		doRowClick(id);
	});
}

function doRowClick(id)
{
	$('#goodInfo').html('<div id="goodInfoLoader"><img src="/images/loader.gif" alt="Загрузка" /></div>');
		
	if ('readyState' in pageLoader && pageLoader.readyState != 4)
	{
		pageLoader.abort();
	}
	
	$.get('/udata/custom/setVisited/' + id);
	
	
	
	pageLoader = $.get('/upage/'+id+'?transform=good.xsl', function(data)
	{
		clearInterval(timer);
		var responce = $('<div></div>').append(data);
		
		var info = $('#goodInfo', responce);
		var carousel = $('#carousel_2', responce);
		var visIndex = $('#carousel ul').index($('#carousel ul:visible'));
		//alert(visIndex);
	//	var visIndex = 1;
		//var buttonShouldBeClicked = $('#carouselMenu li').eq(visIndex).find('a');
		
		$('#goodInfo').replaceWith(info);	
		
		
		//alert(carousel);
		
		$('#carousel_2').replaceWith(carousel);
			
		$.get('/udata/custom/getVisited/?transform=visited.xsl', function(data)
		{
			$('#carousel_3').replaceWith(data);
			var listItem = $('#carouselMenu li').eq(visIndex);
			
			show_carousel(listItem, visIndex); 
			
			//alert("makeCarousel: doRowClick()");
			makeCarousel(carouselAct);
			
			//var listItem2 = $('#carouselMenu li').eq(1);
			
			//show_carousel(listItem2, 1); 			
		}, 'html');
		
		var current = $('#table table tr').has('a[href = "#'+id+'"]');
		var prev = current.prevAll('.good').first();
		var next = current.nextAll('.good').first();
		
		if (prev.length > 0)
		{
			$('#goodCaption a[href = "#prev"]').show().unbind('click').click(function(event)
			{
				event.preventDefault();
				$('#table table tr').has('a[href = "#'+id+'"]').prevAll('.good').first().click();
			});
		}
		else
		{
			$('#goodCaption a[href = "#prev"]').hide();
		}
		
		if (next.length > 0)
		{
			$('#goodCaption a[href = "#next"]').unbind('click').click(function(event)
			{
				event.preventDefault();
				$('#table table tr').has('a[href = "#'+id+'"]').nextAll('.good').first().click();
			});
		}
		else
		{
			$('#goodCaption a[href = "#next"]').hide();
		}
		
		$('#goodSizes input[name ^= "amount"]').bind('change keyup', function()
		{
			var val = parseInt($(this).val());
			if (isNaN(val)) val = 1;
			var amount = $('span.in_pack', this.parentNode.parentNode);
			amount.html(amount.attr('defvalue') * val);
		});
		
		$('#goodSizes a').click(function(event)
		{
			event.preventDefault();
			
			var button = $(this);
			var row = button.parents('tr');
			var id = row.attr('id').substring(5);
			var amount = $('input[name="amount"]', row).val();
			var pack = row.find('span.in_pack').text();
			
			button.hide();
			orderLoader.appendTo(button.parent());
			
			$.get('/udata/emarket/purchaseGood/' + id + '/' + amount + '/', function()
			{
				orderLoader.remove();
				refreshSummary(function() {$('#goodSizes a:hidden').fadeIn(1)});
				button.html('В заказе');
				$.ajax({
			type: "GET",
			url: '/emarket/cart.xml',
			dataType: "xml",
			success: function(xml) {
				var amount = jQuery(xml).find('page[id =' + id + ']').parent('item').children('amount').text();
				jQuery(row).find('span.totalPack').html(pack * amount);
			}
			});
			
			
		 });
			
		});
		
		$('#goodPrice .toFavorites').click(function(event)
		{
			event.preventDefault();
			alert
			
			var button = $(this);
			
			button.hide();
			orderLoader2.appendTo(button.parent());
			
			var method = $(this).attr('fav') == 'true' ? 'delFavorite' : 'addFavorite';
			
			$.get('/udata/custom/' + method + '/' + $('#goodInfo').attr('goodId'), function()
			{
				orderLoader2.remove();
				
				/*if(method=='delFavorite')
				 addFav.appendTo(button.parent());
				else
				 delFav.appendTo(button.parent());
				 
				 button.remove();*/
				 
				
				 
				if(method=='delFavorite')
				{
				 button.attr('fav', 'false');
				 button.text('В избранное');
				}
				else
				{
				 button.attr('fav', 'true');
				 button.text('В избранном');
				}
				 
				  button.show();
				 

				//doRowClick($('#goodInfo').attr('goodId'));
			});
		});
		
		makeLightbox();
		
		
		//   custom
	
		if ($('#carousel_2 li').length == 0)
		{
			$('#carousel_2').html('<div class="recError">Рекомендованные не назначены.</div>');
		}
		
		//   custom
	}, 'html')
	
}




function refreshSummary(callback)
{
	$.get('/udata/emarket/getSummary/', function(data)
	{		
		var summary = parseInt($('price', data).text());
		summary = isNaN(summary) ? 0 : summary;
		
		$('#cart .summary span').text(summary);
		$('#myOrder span').text(summary);
		callback();
	}, 'xml');
	
}

function makeCatalog()
{
	if (jQuery.browser.mobile == true)
	{
		$('#table').bind('scroll', function(event)
		{
			if ($(this).scrollTop() >= $(this).get(0).scrollHeight - $(this).height())
			{
				rows = $('#table tr.good').length;
				
				var lastHeader = $('#table tr.header:last').attr('id').substring(7);
				
				updateTable(0, '&header='+lastHeader);
			}
			
		})
	}
	else
	{
		if ('destroy' in scroll_api_cat)
		{
			scroll_api_cat.destroy();
		}
		
		if ('reinitialise' in scroll_cat)
		{
			scroll_cat.reinitialise();
		}
		else
		{
			scroll_cat = $('#table')
			.unbind('jsp-arrow-change')
			.bind('jsp-arrow-change', function(event, isAtTop, isAtBottom, isAtLeft, isAtRight)
			{
				if (isAtBottom == true && rows != $('#table tr.good').length)
				{
					rows = $('#table tr.good').length;
					
					var lastHeader = $('#table tr.header:last').attr('id').substring(7);
					
					updateTable(0, '&header='+lastHeader);
				}
			})
			.jScrollPane({showArrows: true, verticalDragMinWidth: 50});
			
			//if (jQuery.browser.mobile == true) return true;
			scroll_api_cat = scroll_cat.data('jsp');
		}
	}
	
	
	$('#table tr.header').not('.category').each(function()
	{
		var row = $(this);
		
		if ($('#header_' + row.attr('parent')).length == 0)
		{
			$('<tr class="header category" id="header_' + row.attr('parent') + '">\
				<td colspan="4">' + row.attr('parentH1') + '</td>\
			 </tr>').insertBefore(row);
		}		
		
		$(this).nextUntil('tr.header').zebrafy();
	});
	
	spacer = $('<tr class="spacer"><td></td><td></td><td></td><td></td></tr>');
		
	$('#table tr.odd + tr.header, #tableHeader + tr.header, tr.header + tr.header').each(function()
	{
		spacer.clone().insertBefore(this);
	});
	
	return true;
}