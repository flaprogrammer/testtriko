$( document ).ready(function() {
    $('div.buys-block ul.buys-list li').click(function(event){
        event.preventDefault();
        $(this).parents('ul').find('li.active-tab-buys').removeClass('active-tab-buys');
        $(this).addClass('active-tab-buys');
        var id_tab = $(this).find('a').attr('href');
        $(this).parents('div.buys-block').find('div.step').removeClass('active-tab-buys');
        $(this).parents('div.buys-block').find('div#'+id_tab).addClass('active-tab-buys');

    });
    $('input.add-from-address').click(function(event){
        event.preventDefault();
        $('div.invite-from-address').css('display', 'inline-block');
        $('div.invite-list-users').css('display', 'none');
    });

    $('input.ready-add-from-address').click(function(event){
        event.preventDefault();
        $('div.invite-from-address').css('display', 'none');
        $('div.invite-list-users').css('display', 'inline-block');
    });
    $('div.invite-from-address a.changeUserStatus').on('click', function(event){
        event.preventDefault();
        var url = $(this).attr('href');
        var body = $(this);
        $.ajax({
            type: "GET",
            url: url,

            success: function (data) {
                $(body).parents('td.messageTd').html(data);
                return '';
            }
        });

    });

    $('button.invite-submit').click(function(event){
        event.preventDefault();
        var email = $(this).parents('form').find('input.invite-email').val();
        var org_id = $(this).parents('form').find('input.org_id').val();
        var url = $(this).parents('form').attr('action');
        var body = $(this);

        var countTr = $('div.invite-list-users table.users-table tbody tr').length * 1;
        var text = '<tr><td>'+countTr+'</td><td>'+email+'</td><td></td><td></td><td></td><td class="notif"></td><td>приглашен</td><td></td></tr>';
        var check = false;
        $('div.invite-list-users table.users-table tbody tr').each(function(){
            if($(this).find('td.email-utp-org').text() == email) {
                check = true;
            }
        });

        if(!!email && !!org_id) {
            $.ajax({
                type: "POST",
                url: url,
                data: "email="+email+"&org_id="+org_id,
                success: function (data) {
                    $(body).parents('div.main-buys').find('span.invited-text').css('display', 'block').text(data);
                    if(check == false) {
                        $('div.invite-list-users table.users-table tbody').append(text);
                    }
                    $('input.invite-email').val('');
                    
                }
            });
        }
    });
    $('td.messageTd a.changeUserStatus').click(function(event){
        event.preventDefault();
        var url = $(this).attr('href');
        var body = $(this);
        if(!!url) {
            $.ajax({
                type: "GET",
                url: url,

                success: function (data) {
                    $(body).parents('td.messageTd').html('<span>'+data+'</span>');
                }
            });
        }
    });

    $('div.buys-block a.notif-email').click(function(event){
        event.preventDefault();
        var url = $(this).attr('href');
        if($(this).find('input').prop("checked")) {
            $(this).find('input').prop("checked", false)
        }else {
            $(this).find('input').prop("checked", true)
        }
        var body = $(this);
        if(!!url) {
            $.ajax({
                type: "GET",
                url: url,
                success: function (data) {

                }
            });
        }
    });
    $('td.notif input.send-notif').live('click', function(){
     //   event.preventDefault();
        var url = '/users/sendEmailNotification/'+$(this).val();
        /* if($(this).prop("checked") == true) {
            $(this).prop("checked", false);
            this.checked = false;
            $(this).removeAttr("checked");
        }else {
            this.checked = true;
            $(this).prop("checked", true);
            $(this).attr('checked', 'checked');
        } */
        //console.log($(this).prop("checked"));
        var body = $(this);
        if(!!url) {
            $.ajax({
                type: "GET",
                url: url,
                success: function (data) {
                }
            });
        }
    });
    var first = parseInt(0, 10);
    var second = 0 * 1;
    var third = 0 * 1;

    var length = $('table.resultSummTable tr').length;
    $('table.resultSummTable tr').each(function(index, val) {
        if($(this).find('td.totalprice-first').text() != '') {
            var first_int = parseInt($(this).find('td.totalprice-first').text(), 10);
        }
        if($(this).find('td.totalprice-second').text() != '') {
            var second_int = parseInt($(this).find('td.totalprice-second').text(), 10);
        }
        if($(this).find('td.totalprice-third').text() != '') {
            var third_int = parseInt($(this).find('td.totalprice-third').text(), 10);
        }

        if(!!first_int) {
            first += first_int;
        }
        if(!!second_int) {
            second += second_int;
        }
        if(!!third_int) {
            third += third_int;
        }
      //  console.log(length, index);
        if(index == length-1) {
            $('table.resultSummTable td.summ-first').text(first);
            $('table.resultSummTable td.summ-second').text(second);
            $('table.resultSummTable td.summ-third').text(third);
        }
    });

    $('ul.buys-list li.second-li-tab').click(function(event) {
        $('ul.buys-list div.basket-buttons').css('display', 'none');
        $('ul.buys-list li.first-li-tab').css('padding', '4px');
    });
    $('ul.buys-list li.first-li-tab').click(function(event) {
        $('ul.buys-list div.basket-buttons').css('display', 'block');
        $(this).css('padding', '4px 4px 0 4px');

    });

    $('div.basket-buttons a').click(function(event){
        event.preventDefault();
        var url = $(this).attr('href');

        window.location.replace(url);
    });
    var utpOption = '';
  //  $('tr#info-utp').each(function(){
 //       var utpEmail = $(this).find('td span.email-utp').text();
//        console.log(utpEmail);
  //      utpOption += '<option value='+utpEmail+'>'+utpEmail+'</option>';
 //   });
    /*
    $('tr#tr-utp td.select-utp select').each(function(){
        $(this).append(utpOption);
    });
    */

    $('div.uspRegister form.restorable td.submit input').click(function(event){
        event.preventDefault();
        var countErrors = 0;
        var body = $(this).parents('form');
        $(body).find('input').each(function(){
            if($(this).parents('tr').hasClass('submit') == false) {
                if($(this).val() == '') {
                    $(this).css('border', '1px solid red');
                    countErrors++;
                }else {
                    $(this).css('border', '0px');
                }
                if ( $(this).attr('name') == 'password_confirm' ) {

                    var passwordConfirm = $(this).val();
                    console.log(passwordConfirm);
                    console.log($(body).find('input[name = "password"]').val());
                    if (  $(body).find('input[name = "password"]').val() != passwordConfirm ) {
                       $(body).find('input[name = "password"]').css('border', '1px solid red');
                       $(this).css('border', '1px solid red');
                        countErrors++;
                    } else {
                        $(body).find('input[name = "password"]').css('border', '0px ');

                    }
                }
            }
        });
        $(body).find('input').change(function(){
            if ( $(this).attr('name') == 'password_confirm' ) {

                var passwordConfirm = $(this).val();
                console.log(passwordConfirm);
                console.log($(body).find('input[name = "password"]').val());
                if (  $(body).find('input[name = "password"]').val() != passwordConfirm ) {
                   $(body).find('input[name = "password"]').css('border', '1px solid red');
                   $(this).css('border', '1px solid red');
                    countErrors++;
                } else {
                    $(body).find('input[name = "password"]').css('border', '0px ');

                }
            } else {
                if ( $(this).val() == '' ) {
                    $(this).css('border', '1px solid red');
                    countErrors++;
                }else {
                    $(this).css('border', '0px');
                }
            }

        });
        if(countErrors == 0) {
            $(this).parents('form').submit();
        }
    });


});


