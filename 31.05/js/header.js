$(function() {

	var
		isScrolled,disableHover= false;

	if($(window).scrollTop()>110){
		$('#headerWrap').css('top', '-110px');
		$("#wrapper").css("margin-top", "-100px");
		$('#headerWrap .pointer').removeClass('open');
	}

	$('#headerPointer .pointer').click(function(){

		isScrolled= true;
		
		if($(this).hasClass('open')){

			disableHover= false;

			$("#headerWrap").animate({
			  "top": "-110px"
			}, 500);

			$("#headerPointer").animate({
			  "top": "-12px"
			}, 500);

			$("#wrapper").animate({
			  "margin-top": "-100px"
			}, 500);

		}else{
			disableHover= true;

			$("#headerWrap").stop(true, true).animate({
				  "top": "0"
				}, 500);

			$("#headerPointer").stop(true, true).animate({
				  "top": "98px"
				}, 500);

			$("#wrapper").animate({
			  "margin-top": "0"
			}, 500);
		}

		$(this).toggleClass('open');
	});

	$(window).scroll(function() {

		var scroll_top = $(window).scrollTop();
		var positionTop = '-' + scroll_top;
		
		if (scroll_top < 110) {
		//	$('#headerWrap').css('top', positionTop + 'px');
			$('#headerPointer')/*.css('top', '-12px')*/.find('.pointer').show();
			if(parseInt($("#wrapper").css("margin-top"))<0){
				$('#headerPointer').css('top', '-12px');
			}
		} else  {
			$('#headerPointer .pointer').hide();
			$('#headerPointer .pointer').removeClass('open');
			$('#headerWrap').css('top', '-110px');
			$("#wrapper").css("margin-top", "-100px");
			isScrolled= true;
			disableHover= false;
		}
	});
	
	$('#headerWrap').hover(function(e){

		if(disableHover){
			return;
		}

		//if ($(window).scrollTop() > 110) {
			$("#headerWrap").stop(true, true).animate({
			  "top": "0"
			}, 500);
		//}

		if ($(window).scrollTop() < 110) {

			$("#headerPointer").stop(true, true).animate({
			  "top": "98px"
			}, 500);
			
			$("#wrapper").stop(true, true).animate({
			  "margin-top": "0"
			}, 500,function(){$('#headerPointer .pointer').addClass('open');});
		}
	}, function(){

		if(disableHover){
			return;
		}

		if(!isScrolled){
			return false;
		}
		var scroll_top = $(window).scrollTop();
		//if (scroll_top > 110) {
			$("#headerWrap").delay(500).animate({
			  "top": "-110px"
			}, 500);

			$("#headerPointer").delay(500).animate({
			  "top": "-12px"
			}, 500);

			$("#wrapper").delay(500).animate({
			  "margin-top": "-100px"
			}, 500, function(){$('#headerPointer .pointer').removeClass('open');});
		//}
	});
});