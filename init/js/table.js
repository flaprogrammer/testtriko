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
var main_url = window.location.pathname;
var hash_url_cat = window.location.hash;

// возвращает cookie с именем name, если есть, если нет, то undefined
function getCookie(name) {
    var matches = document.cookie.match(new RegExp(
            "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
            ));
    return matches ? decodeURIComponent(matches[1]) : false;
}

$(function ()
{
    var check_mashuk_brend = $('input#mashuk_brend:checked').val();
    var check_roly_poly_brend = $('input#roly_poly_brend:checked').val();
    var check_bossa_nova_brend = $('input#bossa_nova_brend:checked').val();

    if (!!!check_mashuk_brend || !!!check_roly_poly_brend || !!!check_bossa_nova_brend) {
        var hash_tags = window.location.hash;
        if (!!check_mashuk_brend) {
            var new_url = '#mashuk_brend';
        }
        if (!!!check_mashuk_brend) {
            var new_url = '';
        }
        if (!!check_roly_poly_brend) {
            var new_url_two = '#roly_poly_brend';
        }
        if (!!!check_roly_poly_brend) {
            var new_url_two = '';
        }
        if (!!check_bossa_nova_brend) {
            var new_url_three = '#bossa_nova_brend';
        }
        if (!!!check_bossa_nova_brend) {
            var new_url_three = '';
        }
        if (!!check_mashuk_brend && !!check_roly_poly_brend && !!check_bossa_nova_brend) {
            new_url = '#';
            new_url_two = '';
            new_url_three = '';
            history.pushState({}, '', new_url + new_url_two + new_url_three);
        }
        history.pushState({}, '', new_url + new_url_two + new_url_three);
        //	return false;
    }
    if (!!check_mashuk_brend && !!check_roly_poly_brend && !!check_bossa_nova_brend) {

        new_url = '#';
        new_url_two = '';
        new_url_three = '';
        history.pushState({}, '', new_url + new_url_two + new_url_three);
        //	return false;
    }

    if ($('#table').length == 0)
    {
        return null;
    }

    $('#table').height(function () {
        return $('#goodInfo').outerHeight() - $('#filter').outerHeight() - parseInt($(this).css('marginTop'))
    });

    var check_cookie = $.cookie('table_foto');
    if (check_cookie) {
        $('#selectPreview').attr("checked", 'checked');
        updateTableForImage(1);

    } else {
        $('#selectPreview').removeAttr("checked");
        updateTable(1);
    }
    //	alert(check_cookie);
    setTimeout(function () {
        newUpdateTable(1);
    }, 4000);

    $('#filter select').selectBox({menuTransition: 'fade', loopOptions: true, menuSpeed: 'fast'});

    $('#materialSelect').change(function ()
    {
        $('#table tr.good').show();

        material = $(this).val();

        $(function () {
            var hash_tags = window.location.hash;
            var size_url = $_GETS('size');
            if (size_url != false && size_url != '') {
                history.pushState({}, '', '?material=' + material + '&?size=' + size_url + hash_tags);
            }
            else {
                history.pushState({}, '', '?material=' + material + hash_tags);
            }

            return false;
        });

        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        }
        if (check_cookie == false) {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }


    });

    $('#sizeSelect').change(function ()
    {
        $('#table tr.good').show();

        size = $(this).val();

        $(function () {
            var hash_tags = window.location.hash;
            var mat_url = $_GETS('material');
            if (mat_url != false && mar_url != '') {
                history.pushState({}, '', '?size=' + size + '&?material=' + mat_url + hash_tags);
            }
            else {
                history.pushState({}, '', '?size=' + size + hash_tags);
            }
            return false;
        });


        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        }
        if (check_cookie == false) {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }
    });
    /* Custom by Gluchnoglaz */
    function $_GETS(key) {
        var s = window.location.search;
        s = s.match(new RegExp(key + '=([^&=]+)'));
        return s ? s[1] : false;
    }
    var geturl = $_GETS('size');
    if (geturl != false && geturl != '') {
        $("#sizeSelect option[value=" + geturl + "]").prop("selected", true);
        var new_text = $("#sizeSelect option[value=" + geturl + "]").text();
        $('div#filter label:first a.selectBox span.selectBox-label').text(new_text);
        //	alert(geturl);
        $('#table tr.good').show();

        size = $("#sizeSelect option[value=" + geturl + "]").val();

        //var check_cookie = getCookie('table_foto');
        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        }
        if (check_cookie == false) {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }
    }

    var getmaterial = $_GETS('material');
    if (getmaterial != false && geturl != '') {
        $("#materialSelect option[value=" + getmaterial + "]").prop("selected", true);
        var new_text = $("#materialSelect option[value=" + getmaterial + "]").text();
        $('div#filter label:eq(1) a.selectBox span.selectBox-label').text(new_text);

        $('#table tr.good').show();

        material = $("#materialSelect option[value=" + getmaterial + "]").val();


        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        } else {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }
    }

    var new_hash = window.location.hash;
    if (!!new_hash) {

        var mashuk_brand = new_hash.indexOf('mashuk_brend');
        var bossa_nova_brand = new_hash.indexOf('bossa_nova_brend');
        var roly_poly_brand = new_hash.indexOf('roly_poly_brend');
        if (mashuk_brand != -1 && bossa_nova_brand == -1 && roly_poly_brand == -1) {
            brands = '1782514/';
            $.cookie('brands', '1782514/', {path: '/'});
            $.cookie('check', '1', {path: '/'});
            $('#mashuk_brend').attr("checked", 'checked');

            $('#bossa_nova_brend').removeAttr("checked");
            $('#roly_poly_brend').removeAttr("checked");
            $(document).ready(function () {
                $('span.for_filter').html('Машук');
                $('li.last').removeClass('last');
                $('li.arrow_bread').addClass('last');
            });
        } else
        if (mashuk_brand == -1 && bossa_nova_brand != -1 && roly_poly_brand == -1) {
            brands = '1782513/';
            $.cookie('brands', '1782513/', {path: '/'});
            $.cookie('check', '2', {path: '/'});

            $('#mashuk_brend').removeAttr("checked");
            $('#bossa_nova_brend').attr("checked", 'checked');
            $('#roly_poly_brend').removeAttr("checked");
            $(document).ready(function () {
                $('span.for_filter').html('Bossa Nova');
                $('li.last').removeClass('last');
                $('li.arrow_bread').addClass('last');
            });
        } else
        if (mashuk_brand != -1 && bossa_nova_brand != -1 && roly_poly_brand == -1) {
            brands = '1782513/1782514/';
            $.cookie('brands', '1782513/1782514/', {path: '/'});
            $.cookie('check', '3', {path: '/'});

            $('#mashuk_brend').attr("checked", 'checked');
            $('#bossa_nova_brend').attr("checked", 'checked');
            $('#roly_poly_brend').removeAttr("checked");
            $(document).ready(function () {
                $('span.for_filter').html('Машук, Bossa Nova');
                $('li.last').removeClass('last');
                $('li.arrow_bread').addClass('last');
            });
        }

        else
        if (mashuk_brand !== -1 && bossa_nova_brand == -1 && roly_poly_brand == -1) {
            brands = '1782600/1782514/1782513/';
            $.cookie('brands', '1782600/1782514/1782513/', {path: '/'});
            $.cookie('check', '4', {path: '/'});

            $('#mashuk_brend').attr("checked", 'checked');
            $('#bossa_nova_brend').attr("checked", 'checked');
            $('#roly_poly_brend').attr("checked", 'checked');

            $(document).ready(function () {
                $('span.for_filter').html('');
                $('li.take_it').addClass('last');
                $('li.arrow_bread').removelass('last');
            });
        } else
        if (mashuk_brand == -1 && bossa_nova_brand == -1 && roly_poly_brand != -1) {
            brands = '1782600/';
            $.cookie('brands', '1782600/', {path: '/'});
            $.cookie('check', '5', {path: '/'});

            $('#mashuk_brend').removeAttr("checked");
            $('#bossa_nova_brend').removeAttr("checked");
            $('#roly_poly_brend').attr("checked", 'checked');

            $(document).ready(function () {
                $('span.for_filter').html('Roly Poly');
                $('li.last').removeClass('last');
                $('li.arrow_bread').addClass('last');
            });
        } else
        if (mashuk_brand != -1 && bossa_nova_brand == -1 && roly_poly_brand != -1) {
            brands = '1782600/1782514/';
            $.cookie('brands', '1782600/1782514/', {path: '/'});
            $.cookie('check', '6', {path: '/'});

            $('#mashuk_brend').attr("checked", 'checked');
            $('#bossa_nova_brend').removeAttr("checked");
            $('#roly_poly_brend').attr("checked", 'checked');
            $(document).ready(function () {
                $('span.for_filter').html('Машук, Roly Poly');
                $('li.last').removeClass('last');
                $('li.arrow_bread').addClass('last');
            });
        } else
        if (mashuk_brand == -1 && bossa_nova_brand != -1 && roly_poly_brand != -1) {
            brands = '1782600/1782513/';
            $.cookie('brands', '1782600/1782513/', {path: '/'});
            $.cookie('check', '7', {path: '/'});

            $('#mashuk_brend').removeAttr("checked");
            $('#bossa_nova_brend').attr("checked", 'checked');
            $('#roly_poly_brend').attr("checked", 'checked');
            $(document).ready(function () {
                $('span.for_filter').html('Bossa Nova, Roly Poly');
                $('li.last').removeClass('last');
                $('li.arrow_bread').addClass('last');
            });
        }
        if (bossa_nova_brand == -1 && roly_poly_brand == -1 && mashuk_brand == -1) {
            brands = '1782600/1782514/1782513/';
            $.cookie('brands', '1782600/1782514/1782513/', {path: '/'});
            $.cookie('check', '4', {path: '/'});

            $('#mashuk_brend').attr("checked");
            $('#bossa_nova_brend').attr("checked", 'checked');
            $('#roly_poly_brend').attr("checked", 'checked');
            $(document).ready(function () {
                $('span.for_filter').html('');
                $('li.take_it').addClass('last');
                $('li.arrow_bread').removeClass('last');
            });
        }
        if (bossa_nova_brand != -1 || roly_poly_brand != -1 || mashuk_brand != -1) {


            var check_cookie = $.cookie('table_foto');
            if (check_cookie) {
                $('#selectPreview').attr("checked");
                updateTableForImage(1);

            } else {
                $('#selectPreview').removeAttr("checked");
                updateTable(1);
            }
            setTimeout(function () {
                newUpdateTable(1);
            }, 2000);
            hideBrend();
        }
    }

    /* END Custom by Gluchnoglaz */

    /*        my custom
     _____________________________________*/

    function setCookie(name, value, exp_y, exp_m, exp_d, path, domain, secure)
    {
        var cookie_string = name + "=" + escape(value);

        if (exp_y)
        {
            var expires = new Date(exp_y, exp_m, exp_d);
            cookie_string += "; expires=" + expires.toGMTString();
        }

        if (path)
            cookie_string += "; path=" + escape(path);

        if (domain)
            cookie_string += "; domain=" + escape(domain);

        if (secure)
            cookie_string += "; secure";

        document.cookie = cookie_string;
    }

    function deleteCookie(cookie_name)
    {
        var cookie_date = new Date( );  // Текущая дата и время
        cookie_date.setTime(cookie_date.getTime() - 1);
        document.cookie = cookie_name += "=; expires=" + cookie_date.toGMTString();
    }
    $('input#selectPreview').change(function () {
        if ($(this).prop("checked") == true) {
            $.cookie('table_foto', 'good', {expires: 1, path: '/'});
            updateTableForImage(1);
        }
        if ($(this).prop("checked") == false) {
            $.removeCookie('table_foto');
            $.cookie('table_foto', '', {expires: 1, path: '/'});
            updateTable(1);

        }
    });



    $('#mashuk_brend').change(function ()
    {
        $('#table tr.good').show();
        if ($('#mashuk_brend').attr("checked") == 'checked'
                && $('#bossa_nova_brend').attr("checked") != 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked') {
            brands = '1782514/';
            $.cookie('brands', '1782514/', {path: '/'});
            $.cookie('check', '1', {path: '/'});

            $(function () {
                history.pushState({}, '', '#mashuk_brend');
                return false;
            });
            $('span.for_filter').html('Машук');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');

        } else if ($('#bossa_nova_brend').attr("checked") == 'checked'
                && $('#mashuk_brend').attr("checked") != 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked'
                ) {
            brands = '1782513/';
            $.cookie('brands', '1782513/', {path: '/'});
            $.cookie('check', '2', {path: '/'});

            $(function () {
                history.pushState({}, '', '#bossa_nova_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#bossa_nova_brend').attr("checked") == 'checked'
                && $('#mashuk_brend').attr("checked") == 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked'
                ) {
            brands = '1782513/1782514/';
            $.cookie('brands', '1782513/1782514/', {path: '/'});
            $.cookie('check', '3', {path: '/'});

            $(function () {
                history.pushState({}, '', '#bossa_nova_brend&#mashuk_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova, Машук');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") == 'checked' &&
                $('#bossa_nova_brend').attr("checked") == 'checked'
                ) {
            brands = '1782600/1782514/1782513/';
            $.cookie('brands', '1782600/1782514/1782513/', {path: '/'});
            $.cookie('check', '4', {path: '/'});
            $(function () {
                history.pushState({}, '', '#');
                return false;
            });
            $('span.for_filter').html('');
            $('li.take_it').addClass('last');
            $('li.arrow_bread').removeClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") != 'checked' &&
                $('#bossa_nova_brend').attr("checked") != 'checked'
                ) {
            brands = '1782600/';
            $.cookie('brands', '1782600/', {path: '/'});
            $.cookie('check', '5', {path: '/'});
            $(function () {
                history.pushState({}, '', '#roly_poly_brend');
                return false;
            });
            $('span.for_filter').html('Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") == 'checked' &&
                $('#bossa_nova_brend').attr("checked") != 'checked'
                ) {
            brands = '1782600/1782514/';
            $.cookie('brands', '1782600/1782514/', {path: '/'});
            $.cookie('check', '6', {path: '/'});

            $(function () {
                history.pushState({}, '', '#roly_poly_brend&#mashuk_brend');
                return false;
            });
            $('span.for_filter').html('Машук, Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") != 'checked' &&
                $('#bossa_nova_brend').attr("checked") == 'checked'
                ) {
            brands = '1782600/1782513/';
            $.cookie('brands', '1782600/1782513/', {path: '/'});
            $.cookie('check', '7', {path: '/'});
            $(function () {
                history.pushState({}, '', '#roly_poly_brend&#bossa_nova_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova, Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else {
            $(this).attr('checked', 'checked');

        }

        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        } else {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }
        setTimeout(function () {
            newUpdateTable(1);
        }, 2000);

        hideBrend();
    });

    $('#bossa_nova_brend').change(function ()
    {

        $('#table tr.good').show();
        if ($('#mashuk_brend').attr("checked") == 'checked'
                && $('#bossa_nova_brend').attr("checked") != 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked') {
            brands = '1782514/';
            $.cookie('brands', '1782514/', {path: '/'});
            $.cookie('check', '1', {path: '/'});

            $(function () {
                history.pushState({}, '', '#mashuk_brend');
                return false;
            });
            $('span.for_filter').html('Машук');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        } else if ($('#bossa_nova_brend').attr("checked") == 'checked'
                && $('#mashuk_brend').attr("checked") != 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked'
                ) {
            brands = '1782513/';
            $.cookie('brands', '1782513/', {path: '/'});
            $.cookie('check', '2', {path: '/'});

            $(function () {
                history.pushState({}, '', '#bossa_nova_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#bossa_nova_brend').attr("checked") == 'checked'
                && $('#mashuk_brend').attr("checked") == 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked'
                ) {
            brands = '1782513/1782514/';
            $.cookie('brands', '1782513/1782514/', {path: '/'});
            $.cookie('check', '3', {path: '/'});

            $(function () {
                history.pushState({}, '', '#mashuk_brend&#bossa_nova_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova, Машук');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") == 'checked' &&
                $('#bossa_nova_brend').attr("checked") == 'checked'
                ) {
            brands = '1782600/1782514/1782513/';
            $.cookie('brands', '1782600/1782514/1782513/', {path: '/'});
            $.cookie('check', '4', {path: '/'});

            $(function () {
                history.pushState({}, '', '#');
                return false;
            });
            $('span.for_filter').html('');
            $('li.take_it').addClass('last');
            $('li.arrow_bread').removeClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") != 'checked' &&
                $('#bossa_nova_brend').attr("checked") != 'checked'
                ) {
            brands = '1782600/';
            $.cookie('brands', '1782600/', {path: '/'});
            $.cookie('check', '5', {path: '/'});
            $(function () {
                history.pushState({}, '', '#roly_poly_brend');
                return false;
            });
            $('span.for_filter').html('Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") == 'checked' &&
                $('#bossa_nova_brend').attr("checked") != 'checked'
                ) {
            brands = '1782600/1782514/';
            $.cookie('brands', '1782600/1782514/', {path: '/'});
            $.cookie('check', '6', {path: '/'});

            $(function () {
                history.pushState({}, '', '#roly_poly_brend&#mashuk_brend');
                return false;
            });
            $('span.for_filter').html('Машук, Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") != 'checked' &&
                $('#bossa_nova_brend').attr("checked") == 'checked'
                ) {
            brands = '1782600/1782513/';
            $.cookie('brands', '1782600/1782513/', {path: '/'});
            $.cookie('check', '7', {path: '/'});
            $(function () {
                history.pushState({}, '', '#roly_poly_brend&#bossa_nova_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova, Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else {
            $(this).attr('checked', 'checked');

        }


        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        } else {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }

        setTimeout(function () {
            newUpdateTable(1);
        }, 2000);
        hideBrend();

    });

    $('#roly_poly_brend').change(function ()
    {

        $('#table tr.good').show();
        if ($('#mashuk_brend').attr("checked") == 'checked'
                && $('#bossa_nova_brend').attr("checked") != 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked') {
            brands = '1782514/';
            $.cookie('brands', '1782514/', {path: '/'});
            $.cookie('check', '1', {path: '/'});


            $(function () {
                history.pushState({}, '', '#mashuk_brend');
                return false;
            });
            $('span.for_filter').html('Машук');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        } else if ($('#bossa_nova_brend').attr("checked") == 'checked'
                && $('#mashuk_brend').attr("checked") != 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked'
                ) {
            brands = '1782513/';
            $.cookie('brands', '1782513/', {path: '/'});
            $.cookie('check', '2', {path: '/'});


            $(function () {
                history.pushState({}, '', '#bossa_nova_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#bossa_nova_brend').attr("checked") == 'checked'
                && $('#mashuk_brend').attr("checked") == 'checked'
                && $('#roly_poly_brend').attr("checked") != 'checked'
                ) {
            brands = '1782513/1782514/';
            $.cookie('brands', '1782513/1782514/', {path: '/'});
            $.cookie('check', '3', {path: '/'});

            $(function () {
                history.pushState({}, '', '#bossa_nova_brend&#mashuk_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova, Машук');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") == 'checked' &&
                $('#bossa_nova_brend').attr("checked") == 'checked'
                ) {
            brands = '1782600/1782514/1782513/';
            $.cookie('brands', '1782600/1782514/1782513/', {path: '/'});
            $.cookie('check', '4', {path: '/'});

            $(function () {
                history.pushState({}, '', '#');
                return false;
            });
            $('span.for_filter').html('');
            $('li.take_it').addClass('last');
            $('li.arrow_bread').removeClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") != 'checked' &&
                $('#bossa_nova_brend').attr("checked") != 'checked'
                ) {
            brands = '1782600/';
            $.cookie('brands', '1782600/', {path: '/'});
            $.cookie('check', '5', {path: '/'});

            $(function () {
                history.pushState({}, '', '#roly_poly_brend');
                return false;
            });
            $('span.for_filter').html('Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") == 'checked' &&
                $('#bossa_nova_brend').attr("checked") != 'checked'
                ) {
            brands = '1782600/1782514/';
            $.cookie('brands', '1782600/1782514/', {path: '/'});
            $.cookie('check', '6', {path: '/'});


            $(function () {
                history.pushState({}, '', '#roly_poly_brend&#mashuk_brend');
                return false;
            });
            $('span.for_filter').html('Машук, Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else if ($('#roly_poly_brend').attr("checked") == 'checked' &&
                $('#mashuk_brend').attr("checked") != 'checked' &&
                $('#bossa_nova_brend').attr("checked") == 'checked'
                ) {
            brands = '1782600/1782513/';
            $.cookie('brands', '1782600/1782513/', {path: '/'});
            $.cookie('check', '7', {path: '/'});
            $(function () {
                history.pushState({}, '', '#roly_poly_brend&#bossa_nova_brend');
                return false;
            });
            $('span.for_filter').html('Bossa Nova, Roly Poly');
            $('li.take_it').removeClass('last');
            $('li.arrow_bread').addClass('last');
        }
        else {
            $(this).attr('checked', 'checked');

        }

        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        } else {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }
        setTimeout(function () {
            newUpdateTable(1);
        }, 2000);
        hideBrend();

    });
    /*        end my custom
     _____________________________________*/

    $('#filter .sort').click(function (event)
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
        setTimeout(function () {
            newUpdateTable(1);
        }, 2000);
        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        } else {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }

        makeSorting();
    });

    $('#tableHeader th').click(function (event)
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
        setTimeout(function () {
            newUpdateTable(1);
        }, 2000);

        var check_cookie = $.cookie('table_foto');
        if (check_cookie) {
            $('#selectPreview').attr("checked", 'checked');
            updateTableForImage(1);

        } else {
            $('#selectPreview').removeAttr("checked");
            updateTable(1);
        }

        makeSorting2();
    });

    makeSorting();
    makeSorting2();
    return null;
});

$.fn.zebrafy = function ()
{
    $(this).removeClass('odd').removeClass('even').filter(":odd").addClass('odd').end().filter(":even").addClass('even');
}

function makeSorting()
{
    $('#filter .sort img.arrow').remove();

    if (sort != '')
    {
        sortImg = order == 'ascending' ? ascImg : descImg;
        $('#filter .sort[field="' + sort + '"] a').append(sortImg.clone());
    }
}

function makeSorting2()
{
    $('#tableHeader th img.arrow').remove();

    if (sort2 != '')
    {
        sortImg2 = order2 == 'ascending' ? ascImg : descImg;
        $('#tableHeader th[field="' + sort2 + '"] a').append(sortImg2.clone());
    }
}

function makeQuery(add)
{
    if (main_url)
        var new_test = main_url.search('/promo/');
    var coll_test = main_url.search('collections');
    if (new_test >= 0 || coll_test >= 0) {

        var base_w_brands = base.replace("/?", "/" + brands + "?");

    } else {
        var re = /(.+)all_goods\/(.*)/;
        var base_w_brands = base.replace(re, "$1all_goods/" + brands + "$2");

    }
    add = add || '';
    cats = '/categories/';
    var crat = base_w_brands + '&cat=' + cat + '&material=' + material + '&limit=30&&size=' + size + '&preview=1&sort=' + sort + '&order=' + order + '&sort2=' + sort2 + '&order2=' + order2 + '&start=' + rows + add;
    $('div.loading_info').append(crat);
    return crat;
}

function makeQueryForImage(add)
{
    var re = /(.+)all_goods\/(.*)/;
    var base_w_brands = base.replace(re, "$1all_goods/" + brands + "$2");
    add = add || '';
    cats = '/categories/';
    return base_w_brands + '&cat=' + cat + '&material=' + material + '&limit=30&&size=' + size + '&preview=2&sort=' + sort + '&order=' + order + '&sort2=' + sort2 + '&order2=' + order2 + '&start=' + rows + add;

}

function makeQueryNew(add)
{
    var re = /(.+)all_goods_new\/(.*)/;
    var new_base = '/usel/all_goods_new//?transform=goods.xsl';
    var base_w_brandse = new_base.replace(re, "$1all_goods_new/" + brands + "$2");
    add = add || '';
    var cats = '/categories/';
    return base_w_brandse + '&cat=' + cats + '&material=' + material + '&limit=554&&order=' + order;

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
        $('#tr' + startGood).addClass("act");

        doRowClick(startGood);

        startGood = 0;
    }
}

function updateTable(clear, add)
{
    $('#tableEmpty').css('display', 'none');
    clear = clear || 0;
    add = add || '';

    if (clear == 1)
    {
        $('#table table').css('visibility', 'hidden');
        if ($('div#table').hasClass('new_view_table')) {
            $('#table table').css('visibility', 'visible');
            newrowClick();
        }
        if (($('div#table').hasClass('new_view_table')) == false) {
            $('#table table tr:gt(0)').remove();
        }
        rows = 0;
    }
    else
    {
        $('#tableLoader').addClass('bottom');
    }
    makeCarousel(-1);

    if ('readyState' in updater && updater.readyState != 4)
    {
        updater.abort();
    }

    updater = $.get(makeQuery(add), function (data)
    {
        if (clear == 1)
        {

        }
        var responce = $('<div></div>').append(data);

        if ($('tr', responce).length > 0 || ($('tr', responce).length == 0 && clear != 1))
        {
            $('tr', responce).appendTo('#table table');

            rowClick()

            if (clear == 1)
            {
                selectGood();
            }

            makeCatalog();

            $('#table table').css('visibility', 'visible');
        }
        else
        {
            $('#tableEmpty').css('display', 'block');
            $('#tableEmpty').addClass('empty_table');
            $('#tableLoader').hide();
            var check_id = $('div#tableEmpty').attr('id');
            if (!!check_id) {
                document.location.href = '/categories/';
            }
            if (!!!check_id) {
                $('#tableLoader').hide();
            }
        }

        $('#tableLoader').removeClass('bottom').hide();
        $('#table .header.category').hide();
        $('#table tr[parent] td').each(function () {
            var ptitle = $('#table').find('#header_' + $(this).parent().attr('parent')).children().html();
            var t = $(this).html().split('&gt;')[1];
            if (!!!t) {
                t = $(this).html().split('&gt;');
            }
            $(this).html(ptitle + ' > ' + ((typeof (t) != 'undefined') ? t : $(this).html()));
        });
    }, 'html');
}
function updateTableForImage(clear, add)
{
    $('#tableEmpty').css('display', 'none');
    clear = clear || 0;
    add = add || '';

    if (clear == 1)
    {
        $('#table table').css('visibility', 'hidden');
        if ($('div#table').hasClass('new_view_table')) {
            $('#table table').css('visibility', 'visible');
            newrowClick();
        }
        if (($('div#table').hasClass('new_view_table')) == false) {
            $('#table table tr:gt(0)').remove();
        }
        rows = 0;
    }
    else
    {
        $('#tableLoader').addClass('bottom');
    }
    makeCarousel(-1);

    if ('readyState' in updater && updater.readyState != 4)
    {
        updater.abort();
    }

    updater = $.get(makeQueryForImage(add), function (data)
    {
        if (clear == 1)
        {

        }
        var responce = $('<div></div>').append(data);

        if ($('tr', responce).length > 0 || ($('tr', responce).length == 0 && clear != 1))
        {

            $('tr', responce).appendTo('#table table');

            rowClick()

            if (clear == 1)
            {
                selectGood();
            }
            makeCatalogNew();
            $('#table table').css('visibility', 'visible');
        }
        else
        {

            $('#tableEmpty').css('display', 'block');
            $('#tableLoader').hide();
            $('#tableEmpty').addClass('empty_table');
            var check_id = $('div#tableEmpty').attr('id');
            if (!!check_id) {
                document.location.href = '/categories/';

            }
            if (!!!check_id) {
                $('#tableLoader').hide();
            }
        }
        $('#tableLoader').removeClass('bottom').hide();
        $('#table .header.category').hide();

        $('#table tr[parent] td').each(function () {
            var ptitle = $('#table').find('#header_' + $(this).parent().attr('parent')).children().html();

            var t = $(this).html().split('&gt;')[1];
            if (!!!t) {
                t = $(this).html().split('&gt;');
            }
            $(this).html(ptitle + ' > ' + ((typeof (t) != 'undefined') ? t : $(this).html()));
        });
    }, 'html');
}

function newUpdateTable(clear, add)
{

    $.get(makeQueryNew(add), function (data)
    {
        $('div.loading_info').html(data);

        $('ul.leftSubmenu li').each(function (i) {
            $(this).hide();
        });
        $('ul#leftCatalog li.one_step').each(function (i) {

            $(this).hide();

        });

        $('div#info udata:last table tbody tr.header').each(function () {

            var title = $(this).attr('parent');

            var new_titel = $(this).attr('id');
            var id_new = new_titel.replace(/header_/g, '');
            $("ul#leftCatalog li[catId=" + title + "]").show();
            $("ul.leftSubmenu li[id=" + id_new + "]").show();

        });

        $('div.loading_info').empty();

    }, 'html');



}
var count_click = 0;
function rowClick()
{
    var count = 0;

    $('#table tr.good').unbind('click').click(function (event)
    {
        event.preventDefault();
        if (count == 0) {
            if ($_GETS('good_url') != '' && $_GETS('good_url') != 'undefined') {
                id = $_GETS('good_url');

                //dvm
                $('#table tr.good').removeClass("act");
                $('#table tr#tr' + id).addClass("act");
            }
            if ($_GETS('good_url') == '' || $_GETS('good_url') == false) {
                count = 1;
            }
        }
        count++;
        if (count > 1) {
            var id = $('a', this).attr('pageId');
            $('#table tr.good').removeClass("act");
            $(this).addClass("act");
        }
        $(function () {
            var hash_tags = window.location.hash;
            $("#table tr.good").click(function () {
                var new_url = '?good_url=' + $('a', this).attr("pageid");
                history.pushState({}, '', new_url + hash_tags);
                return false;
                /*history.pushState({}, '', $('a', this).attr("class")+hash_tags);
                 return false; */
            });
        });
        doRowClick(id);


    });
}
function newrowClick()
{
    setTimeout(function () {


        var id = $('#table tr.good a').attr('pageId');
        //dvm
        $('#table tr.good').removeClass("act");
        $('#table tr.good').addClass("act");
        var test = 1;
        newRowClick(id, test);

    }, 500);
}

function doRowClick(id, test)
{
    $('#goodInfo').html('<div id="goodInfoLoader"><img src="/images/loader.gif" alt="Загрузка" /></div>');

    if ('readyState' in pageLoader && pageLoader.readyState != 4)
    {
        pageLoader.abort();
    }

    $.get('/udata/custom/setVisited/' + id);



    pageLoader = $.get('/upage/' + id + '?transform=good.xsl', function (data)
    {
        clearInterval(timer);
        var responce = $('<div></div>').append(data);

        var info = $('#goodInfo', responce);
        var carousel = $('#carousel_2', responce);
        var visIndex = $('#carousel ul').index($('#carousel ul:visible'));
        $('#goodInfo').replaceWith(info);
        $('#carousel_2').replaceWith(carousel);

        $.get('/udata/custom/getVisited/?transform=visited.xsl', function (data)
        {
            $('#carousel_3').replaceWith(data);
            var listItem = $('#carouselMenu li').eq(visIndex);
            show_carousel(listItem, visIndex);
            makeCarousel(carouselAct);
        }, 'html');

        var current = $('#table table tr').has('a[href = "#' + id + '"]');
        var prev = current.prevAll('.good').first();
        var next = current.nextAll('.good').first();

        if (prev.length > 0)
        {
            $('#goodCaption a[href = "#prev"]').show().unbind('click').click(function (event)
            {
                event.preventDefault();
                $('#table table tr').has('a[href = "#' + id + '"]').prevAll('.good').first().click();
            });
        }
        else
        {
            $('#goodCaption a[href = "#prev"]').hide();
        }

        if (next.length > 0)
        {
            $('#goodCaption a[href = "#next"]').unbind('click').click(function (event)
            {
                event.preventDefault();
                $('#table table tr').has('a[href = "#' + id + '"]').nextAll('.good').first().click();
            });
        }
        else
        {
            $('#goodCaption a[href = "#next"]').hide();
        }

        $('#goodSizes input[name ^= "amount"]').bind('change keyup', function ()
        {
            var val = parseInt($(this).val());
            if (isNaN(val))
                val = 1;
            var amount = $('span.in_pack', this.parentNode.parentNode);
            amount.html(amount.attr('defvalue'));
        });

        $('#goodSizes a').click(function (event) {
            event.preventDefault();
            var thisClick = $(this);
            if ($(this).hasClass('not_auth')) {
                $('div.box_fade').css('display', 'block');
                $('div.for_auth').css('display', 'block');
                return '';
            }
            if ($(this).hasClass('not_utp')) {
                $('div.box_fade').css('display', 'block');
                $('div.dont_utp').css('display', 'block');
                return '';
            }
            thisClick.hide();
            orderLoader.appendTo(thisClick.parent());
            /*
            if ($(this).hasClass('stoped_buys')) {
                var emailOrg = $(this).parents('div#goodTab1').find('input.emailOrg').val();
                var phoneOrg = $(this).parents('div#goodTab1').find('input.phoneOrg').val();
                $('div.box_fade').css('display', 'block');
                $('div.stoped-buys').css('display', 'block');

                var text = 'Организатор совместных покупок '+emailOrg+' остановил закупку товаров<br />\n\
                            Вы можете связаться с организатором по телефону '+phoneOrg;

                        $('div.stoped-buys').find('div.padding_auth span').html(text);

                return '';
            } */
            $.ajax({
                type: "GET",
                url: '/emarket/checkStopedBuys',
                success: function (result) {
                    console.log(result);
                    if(result == 'stoped') {
                        var emailOrg = $(thisClick).parents('div#goodTab1').find('input.emailOrg').val();
                        var phoneOrg = $(thisClick).parents('div#goodTab1').find('input.phoneOrg').val();
                        $('div.box_fade').css('display', 'block');
                        $('div.stoped-buys').css('display', 'block');

                        var text = 'Организатор совместных покупок '+emailOrg+' остановил закупку товаров<br />\n\
                                    Вы можете связаться с организатором по телефону '+phoneOrg;

                                $('div.stoped-buys').find('div.padding_auth span').html(text);

                        return false;
                    }else {
                        if ($(thisClick).hasClass('sizeColors')) {
                            var row = $(thisClick).parents('tr.good_size');
                            var button = $(thisClick);
                            var checks = new Array();
                            var utpCheck = false;
                            $(thisClick).parents('tr.good_size').find('input').each(function () {
                                checks.push($(this).attr('name') + ' : ' + $(this).val());
                                if ($(this).attr('name') == 'mainid') {
                                    utpCheck = $(this).val();
                                }
                            });
                            //   checks.push('pack : ' + row.find('input.in_pack').val());
                            var data = checks;
                            //   button.hide();
                            //  orderLoader.appendTo(button.parent());
                            var amount = $('input[name="amount"]', row).val();
                            //    var pack = row.find('span.in_pack').text();
                            button.hide();
                            orderLoader.appendTo(button.parent());
                            $.get('/udata/emarket/purchaseAllGoods/' + data + '/', function () {
                                orderLoader.remove();
                                console.log('123');
                                if (utpCheck) {
                                    refreshSummaryUtp(utpCheck);
                                } else {
                                    refreshSummary(function () {
                                        $('#goodSizes a:hidden').fadeIn(1);
                                    });
                                }
                                refreshSummary(function () {
                                    $('#goodSizes a:hidden').fadeIn(1);
                                });
                                button.html('В заказе');

                                $.ajax({
                                    type: "GET",
                                    url: '/emarket/cart.xml',
                                    dataType: "xml",
                                    success: function (xml) {
                                        jQuery(row).find('span.totalPack').html(amount);
                                    }
                                });
                            });

                        } else {

                            var button = $(thisClick);
                            var row = button.parents('tr');
                            var id = row.attr('id').substring(5);
                            var amount = $('input[name="amount"]', row).val();
                            var pack = $('span.in_pack', row).text() * 1;
                            if(!!!pack) {
                                pack = 1;
                            }
                            button.hide();
                            orderLoader.appendTo(button.parent());

                            var orgType = $('input[name="orgtype"]', row).val();
                            if (!!orgType) {
                                var counts = pack * amount;
                                $.get('/udata/emarket/purchaseGoodOrg/' + id + '/' + counts + '/', function () {
                                    orderLoader.remove();
                                    refreshSummary(function () {
                                        $('#goodSizes a:hidden').fadeIn(1)
                                    });
                                    button.html('В заказе');

                                    $.ajax({
                                        type: "GET",
                                        url: '/emarket/cart.xml',
                                        dataType: "xml",
                                        success: function (xml) {

                                            jQuery(row).find('span.totalPack').html(pack * amount);
                                        }
                                    });
                                });
                            } else {
                                $.get('/udata/emarket/purchaseGood/' + id + '/' + amount + '/', function () {
                                    orderLoader.remove();
                                    refreshSummary(function () {
                                        $('#goodSizes a:hidden').fadeIn(1)
                                    });
                                    button.html('В заказе');

                                    $.ajax({
                                        type: "GET",
                                        url: '/emarket/cart.xml',
                                        dataType: "xml",
                                        success: function (xml) {

                                            jQuery(row).find('span.totalPack').html(pack * amount);
                                        }
                                    });
                                });
                            }
                        }


                    }
                }
            });





        });

        $('#goodPrice .toFavorites').click(function (event)
        {
            event.preventDefault();
            //	alert

            var button = $(this);

            button.hide();
            orderLoader2.appendTo(button.parent());

            var method = $(this).attr('fav') == 'true' ? 'delFavorite' : 'addFavorite';

            $.get('/udata/custom/' + method + '/' + $('#goodInfo').attr('goodId'), function ()
            {
                orderLoader2.remove();
                if (method == 'delFavorite')
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
            });
        });

        makeLightbox();


        //   custom

        if ($('#carousel_2 li').length == 0)
        {
            if (main_url == '/categories/') {
                $('#carousel_2').html('<div class="recError">Рекомендованные не назначены.</div>');
            } else {
                $('#carousel_2').html('<div class="recError">Чтобы увидеть Рекомендованные – перейдите в <a href="/categories/">Каталог</a> </div>');

            }
        }

        //   custom
    }, 'html')
}

function refreshSummary(callback)
{
    $.get('/udata/emarket/getSummary/', function (data)
    {
        var summary = parseInt($('price', data).text());
        summary = isNaN(summary) ? 0 : summary;

        $('#cart .summary span').text(summary);
        $('#myOrder span').text(summary);
        callback();
    }, 'xml');

}
function refreshSummaryUtp(mainid) {
    console.log(mainid);
    $.get('/emarket/getTotalPriceUtpAjax/' + mainid, function (data)
    {
        console.log(data);
        var summary = parseInt(data);
        summary = isNaN(summary) ? 0 : summary;

        $('#cart .summary span').text(summary);
        $('#myOrder span').text(summary);

    });

}
function makeCatalog()
{
    if (jQuery.browser.mobile == true)
    {
        $('#table').bind('scroll', function (event)
        {
            if ($(this).scrollTop() >= $(this).get(0).scrollHeight - $(this).height())
            {
                rows = $('#table tr.good').length;

                var lastHeader = $('#table tr.header:last').attr('id').substring(7);

                updateTable(0, '&header=' + lastHeader);
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
            scroll_cat = $('#table').jScrollPane({showArrows: true, verticalDragMinWidth: 50});


            setInterval(function () {
                if (rows != $('#table tr.good').length)
                {
                    rows = $('#table tr.good').length;

                    var lastHeader = $('#table tr.header:last').attr('id').substring(7);

                    updateTable(0, '&header=' + lastHeader);
                }
            }, 2000)
            scroll_api_cat = scroll_cat.data('jsp');
        }
    }


    $('#table tr.header').not('.category').each(function ()
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

    $('#table tr.odd + tr.header, #tableHeader + tr.header, tr.header + tr.header').each(function ()
    {
        spacer.clone().insertBefore(this);
    });

    return true;
}


function makeCatalogNew() {
    if (jQuery.browser.mobile == true) {
        $('#table').bind('scroll', function (event) {
            if ($(this).scrollTop() >= $(this).get(0).scrollHeight - $(this).height()) {
                rows = $('#table tr.good').length;

                var lastHeader = $('#table tr.header:last').attr('id').substring(7);

                updateTable(0, '&header=' + lastHeader);
            }
        })
    } else {
        if ('destroy' in scroll_api_cat) {
            scroll_api_cat.destroy();
        }

        if ('reinitialise' in scroll_cat) {
            scroll_cat.reinitialise();
        } else {
            scroll_cat = $('#table')
                    .unbind('jsp-arrow-change')
                    .bind('jsp-arrow-change', function (event, isAtTop, isAtBottom, isAtLeft, isAtRight)
                    {
                        if (isAtBottom == true && rows != $('#table tr.good').length)
                        {
                            rows = $('#table tr.good').length;

                            var lastHeader = $('#table tr.header:last').attr('id').substring(7);

                            updateTableForImage(0, '&header=' + lastHeader);
                        }
                    })
                    .jScrollPane({showArrows: true, verticalDragMinWidth: 50});
            scroll_api_cat = scroll_cat.data('jsp');
        }
    }


    $('#table tr.header').not('.category').each(function ()
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

    $('#table tr.odd + tr.header, #tableHeader + tr.header, tr.header + tr.header').each(function ()
    {
        spacer.clone().insertBefore(this);
    });

    return true;
}


function newRowClick(id, test)
{

    $.get('/udata/custom/setVisited/' + id);
    var current = $('#table table tr').has('a[href = "#' + id + '"]');
    var prev = current.prevAll('.good').first();
    var next = current.nextAll('.good').first();

    if (prev.length > 0)
    {
        $('#goodCaption a[href = "#prev"]').show().unbind('click').click(function (event)
        {
            event.preventDefault();
            $('#table table tr').has('a[href = "#' + id + '"]').prevAll('.good').first().click();
        });
    }
    else
    {
        $('#goodCaption a[href = "#prev"]').hide();
    }

    if (next.length > 0)
    {
        $('#goodCaption a[href = "#next"]').unbind('click').click(function (event)
        {
            event.preventDefault();
            $('#table table tr').has('a[href = "#' + id + '"]').nextAll('.good').first().click();
        });
    }
    else
    {
        $('#goodCaption a[href = "#next"]').hide();
    }

    $('#goodSizes input[name ^= "amount"]').bind('change keyup', function ()
    {
        var val = parseInt($(this).val());
        if (isNaN(val))
            val = 1;
        var amount = $('span.in_pack', this.parentNode.parentNode);
        amount.html(amount.attr('defvalue'));
    });

    $('#goodSizes a').click(function (event) {
        event.preventDefault();

        var button = $(this);
        var row = button.parents('tr');
        var id = row.attr('id').substring(5);
        var amount = $('input[name="amount"]', row).val();
        var pack = row.find('span.in_pack').text();

        button.hide();
        orderLoader.appendTo(button.parent());

        $.get('/udata/emarket/purchaseGood/' + id + '/' + amount + '/', function () {
            orderLoader.remove();
            refreshSummary(function () {
                $('#goodSizes a:hidden').fadeIn(1)
            });
            button.html('В заказе');
            $.ajax({
                type: "GET",
                url: '/emarket/cart.xml',
                dataType: "xml",
                success: function (xml) {
                    var amount = jQuery(xml).find('page[id =' + id + ']').parent('item').children('amount').text();
                    jQuery(row).find('span.totalPack').html(pack * amount);
                }
            });
        });

    });

    $('#goodPrice .toFavorites').click(function (event) {
        event.preventDefault();


        var button = $(this);

        button.hide();
        orderLoader2.appendTo(button.parent());

        var method = $(this).attr('fav') == 'true' ? 'delFavorite' : 'addFavorite';

        $.get('/udata/custom/' + method + '/' + $('#goodInfo').attr('goodId'), function ()
        {
            orderLoader2.remove();

            if (method == 'delFavorite')
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
        });
    });

    if ($('#carousel_2 li').length == 0) {
        if (main_url == '/categories/') {
            $('#carousel_2').html('<div class="recError">Рекомендованные не назначены.</div>');
        } else {
            $('#carousel_2').html('<div class="recError">Чтобы увидеть Рекомендованные – перейдите в <a href="/categories/">Каталог</a> </div>');

        }
    }
}
function $_GETS(key) {
    var s = window.location.search;
    s = s.match(new RegExp(key + '=([^&=]+)'));
    return s ? s[1] : false;
}
if ($_GETS('good_url') != '' && $_GETS('good_url') != 'undefined') {

    var id = $_GETS('good_url');

    //dvm
    $('#table tr.good').removeClass("act");
    $(this).addClass("act");

    doRowClick(id);


    $(function () {
        var hash_tags = window.location.hash;
        $("#table tr.good").click(function () {
            var new_url = '?good_url=' + $('a', this).attr("pageid");
            history.pushState({}, '', new_url + hash_tags);
            return false;

        });
    });

}

