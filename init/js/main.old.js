//console.log('---------------------------------------------------------------------');

var scroll = {}, scroll_api = {};
var ascImg = $('<img src="/templates/triko/img/sort_arrow_up.png" alt="По возрастанию" class="arrow" />');
var descImg = $('<img src="/templates/triko/img/sort_arrow_down.png" alt="По убыванию" class="arrow" />');
var material = 0, size = 0;

$(function()
{
	//preloadFromCss();
	
	make_scroll_carousel();
		
	$('input[placeholder]').placeholder();
	
	$('#sizes select').change(function()
	{
		var container = $('#sizes > div').has(this);
		
		$('select', container).attr('readonly', 'readonly');
		$('select').not(this).find('option', container).removeAttr('selected');
		
		$.get('/udata/custom/getSizes/'+container.attr('id')+'/'+$(this).attr('name')+'/'+escape($(this).val()), function(data)
		{
			$('field', data).each(function()
			{
				var value = $(this).text();
				var option = $('select[name="'+$(this).attr('name')+'"] option', container).filter(function()
				{
					if ($(this).text() == value)
					{
						return true;
					}
					else
					{
						return false;
					}
				}).eq(0);
				
				option.attr('selected', 'selected');
			});
			
			$('select', container).removeAttr('readonly');
		}, 'html');
	});
	
	$('form.restorable').submit(function ()
	{
		saveFormData(this);
	}).each(function ()
	{
		restoreFormData(this);
	});
	
	makeLightbox();
	
	$('.subpage > div.header span').click(function()
	{
		thisSubpage = $(this).parents('.subpage').find('> div.text');
		thisSubpage.slideToggle(50);
		$('.subpage div.text').not(thisSubpage).slideUp(200);
	});
	
	$('#sizes').tabs();
	
	makeCarousel();
	
	$('#carousel li .favorite').click(function(event)
	{
		event.preventDefault();
		
		var icon = $(this);
		
		icon.addClass('loading');
		icon.removeClass('loaded');
		
		$.get('/udata/custom/addFavorite/'+$('a', icon).attr('pageid'), function()
		{
			icon.addClass('loaded');
			icon.removeClass('loading');
		});
	});
	
	$('#mainMenu li').not('.active').hover(function()
	{
		$('img', this).attr('src', '/templates/triko/img/arrow_menu_active.png');
	},function()
	{
		$('img', this).attr('src', '/templates/triko/img/arrow_menu.png');
	});
	
	touchScroll('carousel');
});


function makeCarousel()
{	
	makeCarouselMenu();
	
	$('#carouselMenu li a').unbind('click').click(function(event)
	{
		event.preventDefault();
		
		var listItem = $(this).parents('li');
		var index = $('#carouselMenu li').index(listItem);
		
		if ($('#carouselMenu li').index($('#carouselMenu li.active')) == index)
		{
			return true;
		}

		if ($('#carousel ul:visible').length > 0)
		{
			$('#carousel ul:visible').fadeOut(50, function()
			{
				show_carousel(listItem, index);
			});
		}
		else
		{
			show_carousel(listItem, index);
		}
		
		return true;
	});
	
		if ($('#carouselMenu li').eq(2).has('a').length > 0)
	{
		console.log($('#carouselMenu li').eq(2).find('a').length);
		$('#carouselMenu li').eq(2).find('a').click();
	}
}

function show_carousel(listItem, index)
{	
	if ($('#carousel_' + index + ' li').length == 0)
	{
		index = 0;
		listItem = $('#carouselMenu li').eq(0);
	}
	
	$('#carouselMenu li.active').removeClass('active');
	listItem.addClass('active');
	
	$('#carousel_' + index).fadeIn('fast' ,function()
	{
		make_scroll_carousel();
	});
}

function makeCarouselMenu()
{
	$('#carouselMenu li').each(function()
	{
		if ($('li', '#carousel_' + $('#carouselMenu li').index(this)).length == 0)
		{
			$('a', this).replaceWith('<div>'+$('a', this).html()+'</div>');
		}
		else
		{
			$('div div', this).replaceWith('<a href="#">'+$('div div', this).html()+'</a>');
		}
	});
}

function make_scroll_carousel()
{
	if (jQuery.browser.mobile == true) return true;
	
	if ('destroy' in scroll_api)
	{
		scroll_api.scrollToX(0);
		scroll_api.destroy();
	}
	
	scroll = $('#carousel').jScrollPane({showArrows: true, horizontalDragMinWidth: 50});
	scroll_api = scroll.data('jsp');
	return true
}

function preloadFromCss()
{
	$('link[rel = "stylesheet"]').each(function()
	{
		var href = $(this).attr('href');
		
		$.get(href, function(data)
		{
			var cssImageRegExp = /background[^;]+url\('([^']+)'\);/ig;
			var result;
			while ((result = cssImageRegExp.exec(data)) != null)
			{
				var imageSrc = result[1];
				new Image().src = imageSrc;
			}
		}, 'html');
	});	
}

function makeLightbox()
{
	$('a[rel ^= "lightbox"]').prettyPhoto(
	{
		social_tools: '',
		theme: 'light_rounded',
		deeplinking: false,
		show_title: false,
		slideshow: false,
		overlay_gallery: false
	});
}