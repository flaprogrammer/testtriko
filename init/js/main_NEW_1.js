//console.log('---------------------------------------------------------------------');

var scroll = {}, scroll_api = {};
var ascImg = $('<img src="/templates/triko/img/sort_arrow_up.png" alt="По возрастанию" class="arrow" />');
var descImg = $('<img src="/templates/triko/img/sort_arrow_down.png" alt="По убыванию" class="arrow" />');
var material = 0, size = 0;
var brands = ($.cookie('brands')) ? $.cookie('brands') : '';
var check = ($.cookie('check')) ? $.cookie('check') : 4;
var timer;

function activeFilter() {
console.log(check);
	if(check == 1) {
		$("#mashuk_brend").attr("checked", "checked");
		$('#brendBossa').hide();
		$('#brendRoly').hide();
	} else if(check == 2) {
		$("#bossa_nova_brend").attr("checked", "checked");
		$('#brendMashuk').hide();
		$('#brendRoly').hide();		
	} else if(check == 3) {
		$("#bossa_nova_brend").attr("checked", "checked"); 
		$("#mashuk_brend").attr("checked", "checked");
		$('#brendRoly').hide();		
	} else if(check == 4) {
		$("#bossa_nova_brend").attr("checked", "checked"); 
		$("#mashuk_brend").attr("checked", "checked");
		$('#roly_poly_brend').attr("checked", "checked");		
	} else if(check == 5) {
		$("#brendBossa").hide(); 
		$("#brendMashuk").hide();
		$('#roly_poly_brend').attr("checked", "checked");		
	} else if(check == 6) {
		$("#brendBossa").hide(); 
		$("#mashuk_brend").attr("checked", "checked");
		$('#roly_poly_brend').attr("checked", "checked");		
	} else if(check == 7) {
		$("#bossa_nova_brend").attr("checked", "checked"); 
		$("#brendMashuk").hide();
		$('#roly_poly_brend').attr("checked", "checked");		
	}
	hideBrend();
};

function hideBrend() {
console.log($.cookie('check'));
	if($.cookie('check') == 1) {
		$('#filterBrend').hover(
			  function(){
				$('#brendMashuk, #brendBossa, #brendRoly').show();
			  },
			  function(){
				$('#brendBossa').hide();
				$('#brendMashuk').show();
				$('#brendRoly').hide();
		});
	} else if($.cookie('check') == 2) {
		$('#filterBrend').hover(
			  function(){
				$('#brendMashuk, #brendBossa, #brendRoly').show();
			  },
			  function(){
				$('#brendMashuk').hide();
				$('#brendBossa').show();
				$('#brendRoly').hide();
		});
	} else if($.cookie('check') == 3) {
		$('#filterBrend').hover(
			  function(){
				$('#brendMashuk, #brendBossa, #brendRoly').show();
			  },
			  function(){
				$('#brendBossa').show();
				$('#brendMashuk').show();
				$('#brendRoly').hide();
				});
	} else if($.cookie('check') == 4) {
		$('#filterBrend').hover(
			  function(){
				$('#brendMashuk, #brendBossa, #brendRoly').show();
			  },
			  function(){
				$('#brendBossa').show();
				$('#brendMashuk').show();
				$('#brendRoly').show();
				});
	} else if($.cookie('check') == 5) {
		$('#filterBrend').hover(
			  function(){
				$('#brendMashuk, #brendBossa, #brendRoly').show();
			  },
			  function(){
				$('#brendBossa').hide();
				$('#brendMashuk').hide();
				$('#brendRoly').show();
				});
	} else if($.cookie('check') == 6) {
		$('#filterBrend').hover(
			  function(){
				$('#brendMashuk, #brendBossa, #brendRoly').show();
			  },
			  function(){
				$('#brendBossa').hide();
				$('#brendMashuk').show();
				$('#brendRoly').show();
				});
	} else if($.cookie('check') == 7) {
		$('#filterBrend').hover(
			  function(){
				$('#brendMashuk, #brendBossa, #brendRoly').show();
			  },
			  function(){
				$('#brendBossa').show();
				$('#brendMashuk').hide();
				$('#brendRoly').show();
				});
	}
};

$(function()
{
	
	//  custom categoriesSizes
	$('#sizes div.sizeGroup:first').show();
	$('#categoriesSizes').change(function(){
		var activeCategories = $(this).val();
		$('#categoriesSizes option').removeAttr('selected');
		$('option[value ='+activeCategories+']').attr('selected', 'selected');
		$('.sizeGroup').hide();
		$(activeCategories).show();

	});
	
	//   end custom categoriesSizes
	//preloadFromCss();
	
	make_scroll_carousel();
		
	$('input[placeholder]').placeholder();
	
	
	$('#sizes select').change(function()
	{

		var container = $('#sizes > div').has(this);
		
		$('select', container).attr('readonly', 'readonly');
		$('.sizeGroup select').not(this).find('option', container).removeAttr('selected');
		
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
				var opCon = option.val();
				
				option.parents('label').find('span.selectBox-label').text(opCon);
			});
			
			$('select', container).removeAttr('readonly');
		}, 'html');
	}); 
	
	$('#sizes select').selectBox({menuTransition: 'fade', loopOptions: true, menuSpeed: 'fast'});
	
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
	
	//$('#sizes').tabs();
	
	//alert("makeCarousel: init page");
	makeCarousel(-1);
	
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


	//      filterbrends

	var filterOpen = ($.cookie('filterOpen') != null) ? $.cookie('filterOpen') : 'close';

	if (filterOpen == 'open') {
		$('.wrapFilter').show();
		$('#showBrend').addClass('active');
	}
	activeFilter();
	
	
	$('#showBrend').click(function(){
		if(filterOpen == 'close') {
			$('.wrapFilter').show();
			filterOpen = 'open';
			$.cookie('filterOpen', 'open', { path: '/'});
			$('#showBrend').addClass('active');
		} else {
			$('.wrapFilter').hide();
			filterOpen = 'close';
			$.cookie('filterOpen', 'close', { path: '/'});
			$('#showBrend').removeClass('active');
		}
	});
	
	
	
	
	$('#brendMashuk').click(function(event){
    event.preventDefault();
    console.log('brendMashuk');
		if($('#mashuk_brend').prop("checked")) {
      $('#mashuk_brend').removeAttr("checked");
      console.log('brendMashuk unchecked');
	
		} else {
      $('#mashuk_brend').attr("checked", 'checked');
      console.log('brendMashuk checked');
			
		}
	});
  /*$('#brendBossa').click(function(){
    console.log('brendBossa');
		if($('#brendBossa input').attr("checked") != 'checked') {
      $('#brendBossa input').attr("checked", 'checked');			
		} else {
			$('#brendBossa input').removeAttr("checked");
		}
	});
  $('#brendRoly').click(function(){
    console.log('brendRoly');
		if($('#brendRoly input').attr("checked") != 'checked') {
      $('#brendRoly input').attrattr("checked", 'checked');			
		} else {
			$('#brendRoly input').removeAttr("checked");
		}
	});*/
	
	//     coockie selected
	
	

	//     end  filterbrends
	
	
	
});

	

function makeCarousel(defIndex)
{	
	var defIndex = ($.cookie('activeIndex')) ? $.cookie('activeIndex') : 0;

	// строим меню заголовков каруселей. если карусель пустая, то без ссылки.
	makeCarouselMenu();

	// читаем куки ставим активный пункт карусели 

	$('#carouselMenu li').eq(defIndex).addClass('active');
	$('#carousel ul').eq(defIndex).show();
	
 //   alert(defIndex);	
	
	$('#carouselMenu li a').unbind('click').click(function(event)
	{
		activeIndex = $(this).parents('li').index();
		console.log('activeIndex', activeIndex);
		$.cookie('activeIndex', activeIndex, { path: '/'});
		event.preventDefault();
		
		//alert('one');
		if(defIndex == -1)
		 var listItem = $(this).parents('li');
		else
		{
		 var listItem = $('#carouselMenu li').eq(defIndex);
		 defIndex = -1;
		}

	//	var listItem = $(this).parents('li');
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
		
		//alert('clicked index1:' + index);
		
		return true;
	});
		
	// автоактивация рекомендованных
	/*if ($('#carouselMenu li').eq(2).has('a').length > 0)
	{
		console.log($('#carouselMenu li').eq(2).find('a').length);
		$('#carouselMenu li').eq(2).find('a').click();
	}*/
	
	// dvm
	if(defIndex != -1)
	{
		//alert('two');
		var listItem = $('#carouselMenu li').eq(defIndex);
		defIndex = -1;
		
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
	}	
}

// непосредственная активация заголовка карусели и самой карусели.
function show_carousel(listItem, index)
{	
    // если переданная карусель пустая - активируем первую карусель
	/*if ($('#carousel_' + index + ' li').length == 0)
	{
		index = 0;
		listItem = $('#carouselMenu li').eq(0);
	}
	*/

	
	// активируем заголовок
	$('#carouselMenu li.active').removeClass('active');
	listItem.addClass('active');
	
	// активируем карусель
	$('#carousel_' + index).fadeIn('fast' ,function()
	{
		make_scroll_carousel();
	});
}

function makeCarouselMenu()
{
	$('#carouselMenu li').each(function()
	{
		//if ($('li', '#carousel_' + $('#carouselMenu li').index(this)).length == 0)
		//{
		//	$('a', this).replaceWith('<div>'+$('a', this).html()+'</div>');
		//}
		//else
		//{
			$('div div', this).replaceWith('<a href="#">'+$('div div', this).html()+'</a>');
		//}
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
		slideshow: false
		//overlay_gallery: false
	});

	var indexPhoto = 0;  // индекс фотографии
	
	$('#numImage li').eq(0).addClass('active');
	$('#goodSmallImages a').eq(0).children('img').addClass('active');
	$('#goodSmallImages a, #numImage li').bind('click', function(){
		indexPhoto = $(this).index();

		$('#goodBigImage a.big').hide();
		$('#goodBigImage a.big').eq(indexPhoto).show();
		$('#numImage li, #goodSmallImages a img').removeClass('active');
		$('#numImage li').eq(indexPhoto).addClass('active');
		$('#goodSmallImages a').eq(indexPhoto).children('img').addClass('active');
		return false;
	});
	$('#goodBigImage').hover(function(){
		$('#goodSmallImages').show(200);
		clearInterval(timer);
	}, function(){
		$('#goodSmallImages').hide(200);
		timer = setInterval(slidePhoto, 3000);
	});
	
	//photoSlide();
	var totalPhoto = $('#goodBigImage a.big').length -1;
	timer = setInterval(slidePhoto, 3000);
	function slidePhoto() {
		if(totalPhoto >=1) {
			if(indexPhoto < totalPhoto) {

				indexPhoto++;
				$('#goodBigImage a.big').animate(
				  {
					opacity: "hide",
				  },
				300);
				$('#goodBigImage a.big').eq(indexPhoto).animate(
				  {
					opacity: "show",
				  },
				300);
				$('#numImage li, #goodSmallImages a img').removeClass('active');
				$('#numImage li').eq(indexPhoto).addClass('active');
				$('#goodSmallImages a').eq(indexPhoto).children('img').addClass('active');
			} else {
				indexPhoto = 0;
				$('#goodBigImage a.big').animate(
				  {
					opacity: "hide",
				  },
				300);
				$('#goodBigImage a.big').eq(indexPhoto).animate(
				  {
					opacity: "show",
				  },
				300);
				$('#numImage li, #goodSmallImages a img').removeClass('active');
				$('#numImage li').eq(indexPhoto).addClass('active');
				$('#goodSmallImages a').eq(indexPhoto).children('img').addClass('active');
			}
			//indexPhoto++;
		} else {
			clearInterval(timer);
		}
	}
	//  good tabs
	$('#goodTab a').click(function(){
		var activeTab = $(this).attr('href');
		$('#goodTab a').removeClass('active');
		$(this).addClass('active');
		$('#goodTab1, #goodTab2').hide();
		$(activeTab).show();
		return false;
	});
}



	
function loginImg(elem, isOver)
{
 var src = "";
 if(isOver)
  src = "/templates/triko/img/arrow_login_act.png";
 else
  src = "/templates/triko/img/arrow_login.png";
  
  elem.setAttribute("src", src);
}