$( document ).ready(function() {

    $("div#headerColumn3 div#auth div.links a:contains('Регистрация')").click(function(e){
        e.preventDefault();
	$('div.box_fade').css('display', 'block');
        var url_form = $(this).attr('href');
        $.ajax({
            url: url_form,
            dataType:"html",
            context:  $("div.vote_img #thief"),
            success:function(b) {
		b = $(b).find('div#textBlock');
		this.html(b).fadeIn('fast');
                $('div.reg_form').css('display', 'block');
                setTimeout(function() {
                    $("div#thief tr:contains('Телефон') input").mask("(999) 999-9999");
                    $("div#thief tr:contains('Город') input").kladr({
			type: $.kladr.type.city
                    });

                }, 2000);
            }

	});
    });

    $('div.for_auth div.new_block button.button_voice').live('click', function(e){
        e.preventDefault();

    //    $("div#auth div.links a:contains('Регистрация')").attr('id', 'register_block');

        $('div.vote_img').css('display', 'none');
        for_reg();
     //   var evObj = document.createEvent('Events');
	//evObj.initEvent('click', true, false);
	//document.getElementById('register_block').dispatchEvent(evObj);

    });

    $('div.reg_form div.close').click(function(e){
        e.preventDefault();
        $('div.reg_form').css('display', 'none');
        $('div#thief').empty();
		$('div.box_fade').css('display', 'none');

    });


    $("div#goodSizes a.not_auth").click(function(event){
        event.preventDefault();
	$('div.box_fade').css('display', 'block');
        $('div.for_auth').css('display', 'block');
    });

    $("div#goodSizes a.not_utp").click(function(event){
        event.preventDefault();
	$('div.box_fade').css('display', 'block');
        $('div.dont_utp').css('display', 'block');
    });

    $('div.for_auth div.close, div.dont_utp div.close, div.stoped-buys div.close').click(function(e){
        e.preventDefault();
        $('div.for_auth').css('display', 'none');
        $('div.dont_utp').css('display', 'none');
        $('div.stoped-buys').css('display', 'none');
        $('div#thief').empty();
	$('div.box_fade').css('display', 'none');

    });




    $('div.for_auth a.auth_user').live('click', function(event){
        event.preventDefault();
        var form_url = $(this).parents('form').attr('action');
        var login = $(this).parents('form').find('.login_field input').val();
        var pass = $(this).parents('form').find('.pass_class input').val();
        var check = 'good';

        var options = {
            target: ".testresulted",
            url: '/users/login_do/',
            success: function(b) {
                if(check == 'good'){
                    location.reload();
                }
            }
        };

        $.ajax({
            url: '/users/checkLogin/'+login+'/'+pass,
            dataType:"html",
            context:  $(".testresult"),
            type: 'get',
            success:function(b) {

		if(b == 'bad'){
                    check = 'bad';
                    $(".testresult").html('Неверный логин или пароль');
                    return '';
                }
                if(b == 'good'){
                    $("form#auth_login").ajaxSubmit(options);
                    setTimeout(function() {
                        location.reload();
                    }, 2000)

                }

            }
	});








    });

///////////*******************////////////////

    $("div#thief tr:contains('ИНН') input").live('change', function(){
        $(this).css({'border' : '1px solid #569b44'});
        $(this).removeClass('box_error')
        $('.info_phone').html('');

    });


$('div#thief td.pass input').live('change', function(){

        $(this).parent('td.pass').append('<div class="info_pasfi"></div>');
	$('div.info_pasfi').html('Идет проверка...');

	var str_count = $(this).val().length;



		if(str_count < 6){

			$(".info_pasfi").fadeTo(200,0.6,function() {
                            $(this).html('Пароль должен состоять минимум из 6 символов');
			});
			$(this).addClass('box_error').fadeTo(900,1);
                        $(this).css({'border' : '1px solid #ff0000'});

		}if(str_count >= 6){

			$(".info_pasfi").fadeTo(200,0.6,function() {
                            $(this).html('');
			});
			$(this).removeClass('box_error');
                        $(this).css({'border' : '1px solid #569b44'});
			$(this).parent('td.pass').children('div.info_pasfi').remove();

		}

//	 $(this).parent('td.pass').children('div.info_pasfi').remove();

});




$('div#thief td.repeat_pass input').live('change', function(){
        $(this).parent('td.repeat_pass').append('<div class="info_passec"></div>');
	$('div.info_passec').html('Идет проверка...');
	var first_pas = $('div#thief div# td.pass input').val();
        var second_pas = $(this).val();
	var str_count = $(this).val().length;
		if(str_count < 6){

			if(second_pas != first_pas){
				$(".info_passec").fadeTo(200,0.6,function() {
                                    $(this).html('Пароли не совпадают!');
				});
				$(this).addClass('box_error').fadeTo(900,1);
                                $(this).css({'border' : '1px solid #ff0000'});

			}else{

                                $(".info_passec").fadeTo(200,0.6,function() {
                                    $(this).html('Пароль должен состоять минимум из 6 символов');
				});
				$(this).addClass('box_error').fadeTo(900,1);
                                $(this).css({'border' : '1px solid #ff0000'});
			}

		}if(str_count >= 6){

			if(second_pas == first_pas){

                            $(".info_passec").fadeTo(200,0.6,function() {
                                $(this).html('');
                            });
                            $(this).removeClass('box_error');
                            $(this).css({'border' : '1px solid #569b44'});
							$(this).parent('td.repeat_pass').children('div.info_passec').remove();
			}
                        if(second_pas != first_pas){
                            $(".info_passec").fadeTo(200,0.6,function() {
                                $(this).html('Пароли не совпадают!');
                            });
                            $(this).css({'border' : '1px solid #ff0000'});
                            $(this).addClass('box_error').fadeTo(900,1);
                        }
		}

	//c	 $(this).parent('td.repeat_pass').children('div.info_passec').remove();
    });



    $("div#thief td input[name = 'email']").live('change', function(){
        $(this).parent('td').append('<div class="info_email"></div>');
	$('div.info_email').html('Идет проверка...');
        if($(this).val() != '') {
            var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;
            if(pattern.test($(this).val())){
                $(this).css({'border' : '1px solid #569b44'});
                $(this).removeClass('box_error');
                $('.info_email').html('');
                var mail = $(this).val();
                $.get('/udata/catalog/checkMailUser/'+mail, function(data) {
                 //   alert(data);
                  //  var tek = $('udata').text();

                    xmlDoc = $.parseXML( data ),
                    $xml = $( xmlDoc ),
                    $title = $xml.find("udata");
                    var tek = $.trim($title.text());
                    if(tek == 'good'){
                        $('.info_email').html('');
                        $("div#thief td input[name = 'email']").css({'border' : '1px solid #569b44'});
                        $("div#thief td input[name = 'email']").removeClass('box_error');
                    }
                    if(tek == 'bad'){
                        $('.info_email').html('<strong style="color:red;">E-mail занят!</strong>');
                        $("div#thief td input[name = 'email']").css({'border' : '1px solid #ff0000'});
                        $("div#thief td input[name = 'email']").addClass('box_error');
                    }
                    if(tek != 'good' && tek != 'bad'){
                        $('.info_email').html('Возникла проблема!');
                        $("div#thief td input[name = 'email']").css({'border' : '1px solid #ff0000'});
                        $("div#thief td input[name = 'email']").addClass('box_error');
                    }
		}, 'html');
            } else {
                $(this).css({'border' : '1px solid #ff0000'});
                $(this).addClass('box_error');
                $('.info_email').html('Введите корректный email');
            }
        } else {
            $(this).css({'border' : '1px solid #ff0000'});
            $(this).addClass('box_error');
            $('.info_email').html('Поле email не должно быть пустым');
        }

    });


    $("div#thief tr:contains('Фамилия') input").live('change', function(){
        $(this).parent('td').append('<div class="info_fio"></div>');
	$('div.info_fio').html('Идет проверка...');
        if($(this).val() != '') {


                $(this).css({'border' : '1px solid #569b44'});
                $(this).removeClass('box_error')
                $('.info_fio').html('');

        } else {
                $(this).css({'border' : '1px solid #ff0000'});
                $(this).addClass('box_error')
                $('.info_fio').html('Поле обязательно к заполнению');
        }

    });
    $("div#thief tr:contains('Город') input").live('change', function(){
        $(this).parent('td').append('<div class="info_town"></div>');
	$('div.info_town').html('Идет проверка...');
        if($(this).val() != '') {


                $(this).css({'border' : '1px solid #569b44'});
                $(this).removeClass('box_error')
                $('.info_town').html('');

        } else {
                $(this).css({'border' : '1px solid #ff0000'});
                $(this).addClass('box_error')
                $('.info_town').html('Поле обязательно к заполнению');
        }

    });

    $("div#thief tr:contains('Телефон') input").mask("(999) 999-9999");
    $("div#thief tr:contains('Телефон') input").live('change', function(){
        $(this).parent('td').append('<div class="info_phone"></div>');
	$('div.info_phone').html('Идет проверка...');

        if($(this).val() != '') {


                $(this).css({'border' : '1px solid #569b44'});
                $(this).removeClass('box_error')
                $('.info_phone').html('');

        } else {
                $(this).css({'border' : '1px solid #ff0000'});
                $(this).addClass('box_error')
                $('.info_phone').html('Поле обязательно к заполнению');
        }

    });



    $('div#thief form#registerForm td.submit button').live('click', function(e){
        e.preventDefault();
        var check = 0;
        $('div#thief form#registerForm input.box_error').each(function(){
            $(this).parent('td:first').focus();
            $(this).css({'border' : '1px solid #ff0000'});
            check++;
        });

       var town = $('div#thief form#registerForm tr:contains("Город") input').val();
            if(town == ''){
                $(town).focus();
                $(town).css({'border' : '1px solid #ff0000'});
                check++;

            }

        var fio = $('div#thief form#registerForm tr:contains("Фамилия") input').val();
            if(fio == ''){
                $(fio).focus();
                $(fio).css({'border' : '1px solid #ff0000'});
                check++;

            }
        var phone = $('div#thief form#registerForm tr:contains("Телефон") input').val();
            if(phone == ''){
                $(phone).focus();
                $(phone).css({'border' : '1px solid #ff0000'});
                check++;

            }
        var email = $('div#thief form#registerForm tr:contains("E-mail") input').val();
            if(email == ''){
                $(email).focus();
                $(email).css({'border' : '1px solid #ff0000'});
                check++;

            }
        var pass = $('div#thief form#registerForm td.pass input').val();
            if(pass == ''){
                $(pass).focus();
                $(pass).css({'border' : '1px solid #ff0000'});
                check++;

            }
        var pass_repeat = $('div#thief form#registerForm td.repeat_pass input').val();
            if(pass_repeat == ''){
                $(pass_repeat).focus();
                $(pass_repeat).css({'border' : '1px solid #ff0000'});
                check++;

            }

        if(check == 0){
               $('td.submit').append('<div class="targer"></div>');
            var options = {
                target: ".targer",
                context:  $(".targer"),
                url: "/users/registrate_do/",
                success: function(b) {
                 //   var obj = data.find('#textBlock p:first'));
                    b = $(b).find("div#textBlock:contains('отправлено письмо')");
                //    this.append(b).fadeIn('fast');
                    if(b){
                        $('div#thief').empty();
                        $('div#thief').append('<div class="ready_to_reg"></div>');
                        $('div.ready_to_reg').append('На вашу почту отправлено письмо с дальнейшими инструкциями.');
                    }
                }
            };
            $("form#registerForm").ajaxSubmit(options);
            $('div#thief').empty();
            $('div#thief').append('<div class="ready_to_reg"></div>');
            $('div.ready_to_reg').append('На вашу почту отправлено письмо с дальнейшими инструкциями.');
            return false;
        }
    });

    var url = window.location.pathname;
    if(url == '/'){
        var height = $('#slider').height();
        var new_height = $('.textContent').height();
        var newSumm = height + new_height;
        $('div#content ul#newsColumn').css('height', newSumm);
        var count_news = $('div#content ul#newsColumn').length;
        if(count_news > 0){
            $('div.textContent').css('display', 'block');
        }
    }

    $('div.cartButton a.order').click(function(event){
        event.preventDefault();
        $('div.payment-order').css('display', 'block');
        $('div.box_fade').css('display', 'block');
    });
    $('span.back-to-buy').live('click', function(event){
        event.preventDefault();
        $(this).parents('div.payment-order').css('display', 'none');
        $('div.box_fade').css('display', 'none');
    });
    $('form.form-select-payment label.button-payment').live('click', function(event){
        $(this).parents('div.payment-block').find('input.input-payment').prop('checked', true);
        $(this).parents('form.form-select-payment').submit();
    });

    $('td.look-new a.choose-payment').click(function(event){
        event.preventDefault();
        $(this).parents('td.look-new').find('div.payment-order').css('display', 'block');
        $('div.box_fade').css('display', 'block');
    });
    setTimeout(function() {
        var utpCount = $( "td.utp select option" ).length;
        if(utpCount > 0) {

            var id = $( "td.utp select option:selected" ).attr('value');

            $('table#goodSizes').find('tr#size_'+id).css('display', '');
        }
    }, 3000);
    setTimeout(function() {
        var utpCount = $( "td.utp select option" ).length;
        if(utpCount > 0) {

            var id = $( "td.utp select option:selected" ).attr('value');

            $('table#goodSizes').find('tr#size_'+id).css('display', '');
        }
    }, 4000);
    setTimeout(function() {
        var utpCount = $( "td.utp select option" ).length;
        if(utpCount > 0) {

            var id = $( "td.utp select option:selected" ).attr('value');

            $('table#goodSizes').find('tr#size_'+id).css('display', '');
        }
    }, 5000);
    setTimeout(function() {
        var utpCount = $( "td.utp select option" ).length;
        if(utpCount > 0) {

            var id = $( "td.utp select option:selected" ).attr('value');

            $('table#goodSizes').find('tr#size_'+id).css('display', '');
        }
    }, 6000);
    setTimeout(function() {
        var utpCount = $( "td.utp select option" ).length;
        if(utpCount > 0) {

            var id = $( "td.utp select option:selected" ).attr('value');

            $('table#goodSizes').find('tr#size_'+id).css('display', '');
        }
    }, 7000);
    setTimeout(function() {
        var utpCount = $( "td.utp select option" ).length;
        if(utpCount > 0) {

            var id = $( "td.utp select option:selected" ).attr('value');

            $('table#goodSizes').find('tr#size_'+id).css('display', '');
        }
    }, 10000);
    $( "td.utp select" ).live('change', function(){
        var id = $(this).attr('value');
        $(this).parents('table#goodSizes').find('tr.good_size').css('display', 'none');
        $(this).parents('table#goodSizes').find('tr#size_'+id).css('display', '');
    });
});

function for_reg() {
    $('div.box_fade').css('display', 'block');
    var url_form = $("div#headerColumn3 div#auth div.links a:contains('Регистрация')").attr('href');
    $.ajax({
        url: url_form,
        dataType:"html",
        context:  $("div.vote_img #thief"),
        success:function(b) {
            b = $(b).find('div#textBlock');
            this.html(b).fadeIn('fast');
            $('div.reg_form').css('display', 'block');
            setTimeout(function() {
                $("div#thief tr:contains('Телефон') input").mask("(999) 999-9999");
            }, 2000);
        }
    });
}

