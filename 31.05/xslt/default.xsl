<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:include href="user.xsl" />
    <xsl:include href="form.xsl" />
    <xsl:include href="morpho.xsl" />
    <xsl:include href="carousel.xsl" />

    <xsl:param name="sort_org" />
    <xsl:variable name="result" select="/result" />
    <xsl:variable name="page" select="/result/page" />
    <xsl:variable name="prelang" select="/result/@pre-lang" />
    <xsl:variable name="lang" select="/result/@lang" />
    <xsl:variable name="cart" select="document('udata://emarket/cart/')/udata" />
    <xsl:variable name="cart_id" select="document('udata://emarket/cart/')/udata/@id" />
    <xsl:variable name="summary">
        <xsl:choose>
            <xsl:when test="$cart//summary/price/actual">
                <xsl:value-of select="format-number($cart//summary/price/actual,'#.0')" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>0</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:param name="param0" />
    <xsl:param name="start_good" />
    <xsl:param name="recommend_to" />
    <xsl:param name="order_id" />
    <xsl:param name="search_string" />
    <xsl:variable name="tpl" select="string('/templates/triko')" />

    <xsl:template match="/">
        <html>
            <head>
                <meta name="format-detection" content="telephone=no" />

                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <meta name="description" >
                    <xsl:attribute name="content">
                        <xsl:value-of select="//meta/description" />
                    </xsl:attribute>
                </meta>
                <meta name="keywords" >
                    <xsl:attribute name="content">
                        <xsl:value-of select="//meta/keywords" />
                    </xsl:attribute>
                </meta>
                <xsl:choose>
                    <xsl:when test="result//page[@type-id = '118']">
                        <xsl:variable name="parentId" select="result/page/@parentId" />
                        <xsl:variable name="categid" select="document(concat('upage://', $parentId))/udata/page/@parentId" />
                        <title>
                            <xsl:value-of select="//property[@name = 'h1']/value" />, арт. <xsl:value-of select="result//property[@name = 'code']/value" />, р. <xsl:value-of select="result//property[@name = 'sizes']/value" />-<xsl:value-of select="document(concat('upage://', $parentId))//property[@name = 'h1']/value" />. Купить оптом от производителя. Bossa Nova Group
                        </title>

                    </xsl:when>
                    <xsl:otherwise>
                        <title>
                            <xsl:value-of select="result/@title" />
                        </title>

                    </xsl:otherwise>
                </xsl:choose>

                <!--	<link rel="icon" type="image/png" href="/favicon.png" /> -->
                <!--	<link rel="shortcut icon" type="image/png" href="/favicon.png" /> -->
                <link type="text/css" href="{$tpl}/css/jquery.jscrollpane.css" rel="stylesheet" />
                <link type="text/css" href="{$tpl}/css/jquery.selectBox.css" rel="stylesheet" />
                <link type="text/css" href="{$tpl}/css/jquery-ui-1.8.21.custom.css" rel="stylesheet" />
                <link type="text/css" href="{$tpl}/css/prettyPhoto.css" rel="stylesheet" />
                <link type="text/css" href="{$tpl}/css/main.css" rel="stylesheet" />
                <link type="text/css" href="{$tpl}/css/header.css" rel="stylesheet" />
                <link type="text/css" href="{$tpl}/css/content.css" rel="stylesheet" />
                <link type="text/css" href="{$tpl}/css/jquery.kladr.min.css" rel="stylesheet" />
                <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
                <script src="{$tpl}/js/jquery.kladr.min.js"></script>
                <!--<script type="text/javascript" src="/js/jquery/jquery.js"></script> -->



                <!--	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script> -->
                <script type="text/javascript" src="{$tpl}/js/jquery.mousewheel.js"></script>
                <script type="text/javascript" src="{$tpl}/js/jquery.jscrollpane.js"></script>
                <script type="text/javascript" src="{$tpl}/js/jquery.selectBox.min.js"></script>
                <script type="text/javascript" src="{$tpl}/js/jquery.placeholder.min.js"></script>
                <script type="text/javascript" src="{$tpl}/js/jquery.prettyPhoto.js"></script>
                <!--<script type="text/javascript" src="{$tpl}/js/jquery-ui-1.8.21.custom.min.js"></script> -->
                <!--	<script type="text/javascript" src="{$tpl}/js/detectmobilebrowser.js"></script> -->
                <script type="text/javascript" src="{$tpl}/js/touch.js"></script>
                <script type="text/javascript" src="{$tpl}/js/jquery.form.js"></script>
                <script src="{$tpl}/js/jquery.cookie.js"></script>
                <script type="text/javascript" src="{$tpl}/js/main.js"></script>
                <script type="text/javascript" src="{$tpl}/js/new_form_submit.js"></script>
                <script type="text/javascript" src="{$tpl}/js/table.js"></script>
                <script type="text/javascript" src="{$tpl}/js/cart.js"></script>
                <script type="text/javascript" src="{$tpl}/js/header.js"></script>
                <script src="{$tpl}/js/jquery.cookie.js"></script>

                <script type="text/javascript" src="{$tpl}/js/jquery.cycle.all.min.js" />
                <script type="text/javascript" src="{$tpl}/js/jquery.maskedinput.min.js" />


                <script type="text/javascript" src="/js/guest.js"></script>

                <script type="text/javascript" src="http://userapi.com/js/api/openapi.js?49"></script>
                <!--
                <script type="text/javascript">
                        VK.init({apiId: 2998473, onlyWidgets: true});
                </script>
                -->
                <script type="text/javascript">
                    $(document).ready(function() {
                    $('#slider').cycle({
                    fx:      'fade',
                    speed:    1000,
                    timeout:  5000,
                    pager: '#nav_slider'
                    });
                    $('tr.sum_discount div.for_count').each(function(){
                    var summer = parseInt($(this).text(), 10);
                    var summ = summ + summer;
                    $('div.ready_discount').text();
                    $('div.ready_discount').text(summ+'.руб');
                    });
                    });
                </script>
                <style type="text/css">
                    #nav_slider a{
                    height: 6px;
                    width: 6px;
                    font-size:1px;
                    text-decoration: none;
                    display: inline-block;
                    vertical-align: middle;
                    background: #025687;
                    color: #025687;
                    margin: 10px;
                    border-radius:50%;
                    border: none;

                    }
                    #nav_slider a.activeSlide{
                    height: 8px;
                    width: 8px;
                    border-radius:50%;
                    border:1px solid #025687;
                    vertical-align: middle;

                    background: none;
                    color: #025687;
                    }
                </style>
            </head>
            <body>
                

                <div id="wrapper">
                    <div class="headerWrap" id="headerWrap">
                        <div id="header">
                            <div id="logo">
                                <a href="/">
                                    <img src="{$tpl}/img/9_bng.png" alt="Машук"/>
                                </a>
                            </div>
                            <div id="headerInfoWrapper">
                                <div id="headerInfo">
                                    <div class="column" id="headerColumn1">
                                        <div id="slogan">
                                            Производство и дистрибуция одежды для детей<br />
                                            <b>Мы сделали качество доступным</b>
                                        </div>
                                        <div id="phoneWrapper">
                                            <div id="phone">
                                                <div class="number">
                                                    <xsl:value-of select="document('upage:///.phone')//value" />
                                                </div>
                                                <a href="/about/contacts/">Связаться с нами</a>
                                            </div>
                                        </div>
                                        <div style="clear: both"></div>
                                        <div id="search">
                                            <form method="get" action="/search/search_do/">
                                                <div>
                                                    <div id="query">
                                                        <input type="text" name="search_string" placeholder="Поиск" />
                                                    </div>
                                                    <div class="submit">
                                                        <input type="submit" value="" />
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <div class="column" id="headerColumn2">
                                        <div id="cart">
                                            <xsl:choose>
                                                <xsl:when test="result/@pageId=457">
                                                    <div class="info_act">
                                                        <a href="/cart/" class="wide"></a>
                                                        <div id="cartImg"></div>
                                                        Мой заказ
                                                        <div class="summary">
                                                            <xsl:choose>
                                                                <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata != 'utp'">
                                                                    <span>
                                                                        <xsl:value-of select="$summary" />
                                                                    </span>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:variable name="tmp_user" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                                                    <xsl:choose>

                                                                        <xsl:when test="document(concat('uobject://', $tmp_user))//property[@name = 'delete_from_buys']/value">
                                                                            <span>
                                                                                <xsl:value-of select="$summary" />
                                                                            </span>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />
                                                                            <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />
                                                                            <xsl:variable name="priceCart" select="document(concat('udata://emarket/getTotalPriceUtp/', $orderId))/udata" />

                                                                            <span>
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$priceCart">
                                                                                        <xsl:value-of select="$priceCart" />
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        0
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </span>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>

                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                            руб.</div>
                                                    </div>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <div class="info">
                                                        <a href="/cart/" class="wide"></a>
                                                        <div id="cartImg"></div>
                                                        Мой заказ
                                                        <div class="summary">
                                                            <xsl:choose>
                                                                <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata != 'utp'">
                                                                        <span>
                                                                            <xsl:value-of select="$summary" />
                                                                        </span>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                                                    <xsl:choose>
                                                                        <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                                                                            <span>
                                                                                <xsl:value-of select="$summary" />
                                                                            </span>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                        <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />
                                                                        <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />
                                                                        <xsl:variable name="priceCart" select="document(concat('udata://emarket/getTotalPriceUtp/', $orderId))/udata" />

                                                                        <span>
                                                                            <xsl:choose>
                                                                                <xsl:when test="$priceCart">
                                                                                    <xsl:value-of select="$priceCart" />
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    0
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </span>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                            руб.</div>
                                                    </div>
                                                </xsl:otherwise>
                                            </xsl:choose>

                                            <xsl:choose>
                                                <xsl:when test="result/@pageId=441">
                                                    <div class="favorites_act">
                                                        <a href="/favorites/" class="wide"></a>
                                                        Избранное
                                                    </div>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <div class="favorites">
                                                        <a href="/favorites/" class="wide"></a>
                                                        Избранное
                                                    </div>
                                                </xsl:otherwise>
                                            </xsl:choose>

                                        </div>
                                    </div>

                                    <div class="column" id="headerColumn3">
                                        <xsl:apply-templates select="/result/user">
                                            <xsl:with-param name="module" select="result/@module" />
                                            <xsl:with-param name="method" select="result/@method" />
                                            <xsl:with-param name="pageId" select="result/@pageId" />
                                        </xsl:apply-templates>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div><!--    end header wrap   -->
                    <div id="headerPointer">
                        <div id="wrap">
                            <div class="pointer open"></div>
                        </div>
                    </div>
                    <div id="breadcrumbs">
                        <ul>
                            <xsl:if test="not(/result/page/@is-default = 1)">
                                <li>
                                    <a href="/">Главная</a>
                                </li>
                            </xsl:if>
                            <xsl:apply-templates select="/result/parents/page" mode="breadcrumb" />
                            <li class="last take_it">
                                <xsl:choose>
                                    <xsl:when test="result//page[@type-id = '118']">
                                        <h1 >
                                            <xsl:value-of select="result/@header" /> арт. <xsl:value-of select="result//property[@name = 'code']/value" />
                                        </h1>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <h1 >
                                            <xsl:value-of select="/result/@header" />
                                        </h1>

                                    </xsl:otherwise>
                                </xsl:choose>
                            </li>
                            <li class="arrow_bread">
                                <span style="color:orange; font-style: oblique;">
                                    <strong>Бренды: </strong>
                                </span>
                                <span class="for_filter"></span>
                            </li>
                        </ul>
                    </div>

                    <div id="main">
                        <div id="left">
                            <div id="leftTopWrapper">
                                <div id="leftTop"></div>
                            </div>
                            <ul id="leftMenu">
                                <xsl:call-template name="leftLink">
                                    <xsl:with-param name="link" select="'/promo/'" />
                                    <xsl:with-param name="text" select="'Акции'" />
                                </xsl:call-template>
                                <xsl:call-template name="leftLink">
                                    <xsl:with-param name="link" select="'/collections/'" />
                                    <xsl:with-param name="text" select="'Коллекции'" />
                                </xsl:call-template>
                            </ul>

                            <!--      filter to brend   -->
                            <xsl:if test="result[(@module = 'catalog' and @method = 'category')
							or page/@link = '/categories/new_items/'
							or page/@link = '/categories/hits/'
							or page/@link = '/categories/visited/'
							or page/@link = '/categories/recommend/'
							or page/@link = '/favorites/'
							or page/@link = '/'
                                                        or page/@link = '/promo/'
                                                        or page/@link = '/collections/'
														or page/@link = '/categories/'
							or (count(parents/page) = 1 and
								(starts-with(page/@link, '/collections/')
								or starts-with(page/@link, '/promo/')))
							]">
                                <div class="filterBrend" id="filterBrend">
                                    <span id="showBrend">ФИЛЬТР ПО БРЕНДАМ</span>
                                    <div class="wrapFilter">
                                        <label id="brendBossa">
                                            <input type="checkbox" id="bossa_nova_brend" value="1" name="bossa_nova" /> Bossa Nova
                                        </label>
                                        <label id="brendMashuk">
                                            <input type="checkbox" id="mashuk_brend"  value="1" name="mashuk" /> Машук
                                        </label>

                                        <label id="brendRoly">
                                            <input type="checkbox" id="roly_poly_brend" value="1" name="roly_poly" /> Roly Poly
                                        </label>
                                    </div>

                                </div>
                            </xsl:if>
                            <!--   end filter to brend   -->


                            <ul id="leftCatalog">
                                <xsl:call-template name="leftLink">
                                    <xsl:with-param name="link" select="'/categories/'" />
                                    <xsl:with-param name="text" select="'Все категории'" />
                                </xsl:call-template>

                                <xsl:apply-templates select="document('udata://content/menu/0/1/(/categories/)/')//item" mode="leftMenu" />
                            </ul>
                            <div class="textContentUl">
                                <xsl:value-of select="//property[@name = 'descr']/value" disable-output-escaping="yes" />
                            </div>
                        </div>

                        <div id="infoWrapper">
                            <div id="info">
                                <ul id="mainMenu">
                                    <xsl:call-template name="mainMenuItem">
                                        <xsl:with-param name="text" select="'клиентам'" />
                                        <xsl:with-param name="link" select="'/clients/'" />
                                        <xsl:with-param name="mode" select="'first'" />
                                    </xsl:call-template>
                                    <xsl:call-template name="mainMenuItem">
                                        <xsl:with-param name="text" select="'информация'" />
                                        <xsl:with-param name="link" select="'/partners/'" />
                                    </xsl:call-template>
                                    <xsl:call-template name="mainMenuItem">
                                        <xsl:with-param name="text" select="'полезное'" />
                                        <xsl:with-param name="link" select="'/useful/'" />
                                    </xsl:call-template>
                                    <xsl:call-template name="mainMenuItem">
                                        <xsl:with-param name="text" select="'о компании'" />
                                        <xsl:with-param name="link" select="'/about/'" />
                                    </xsl:call-template>
                                    <xsl:call-template name="mainMenuItem">
                                        <xsl:with-param name="text" select="'новости'" />
                                        <xsl:with-param name="link" select="'/news/'" />
                                        <xsl:with-param name="mode" select="'last'" />
                                    </xsl:call-template>
                                </ul>

                                <div id="content">
                                    <noscript>
                                        <span style="color:red;">
                                            <strong>Включите, пожалуйста, Javascript, или используйте другой браузер</strong>
                                        </span>
                                    </noscript>
                                    <script type='text/javascript'>
                                        $(document).ready(function(){
                                        (function(){ var widget_id = 'tHR8ygAXPx';
                                        var s = document.createElement('script');
                                        s.type = 'text/javascript';
                                        s.async = false;
                                        s.src = '//code.jivosite.com/script/widget/'+widget_id;
                                        var ss = document.getElementsByTagName('script')[0];
                                        ss.parentNode.insertBefore(s, ss);})();
                                        });

                                    </script>
                                    <div id="nav_slider" style="position:absolute; top: 370px;width:579px; text-align:center; z-index:7;overflow:hidden;"></div>
                                    <xsl:apply-templates select="." mode="news" />

                                    <xsl:apply-templates select="." mode="subMenu" />

                                    <xsl:apply-templates select="result" />
                                    <div class="textContent">
                                        <xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />
                                    </div>
                                </div>

                                <ul id="carouselMenu">
                                    <li class="first">
                                        <div>
                                            <a href="#">Новинки</a>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <a href="#">Лидеры продаж</a>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <a href="#">Рекомендованные</a>
                                        </div>
                                    </li>
                                    <li class="last">
                                        <div>
                                            <a href="#">Посещенные</a>
                                        </div>
                                    </li>
                                </ul>

                                <div id="carousel">
                                    <ul id="carousel_0">
                                        <xsl:apply-templates select="document('usel://filter/new/')/udata/page" mode="carousel">
                                            <xsl:with-param name="limiter" select="'new_items'" />
                                        </xsl:apply-templates>
                                    </ul>

                                    <ul id="carousel_1">

                                        <xsl:apply-templates select="document('usel://filter/hit/')/udata/page" mode="carousel">
                                            <xsl:with-param name="limiter" select="'hits'" />
                                        </xsl:apply-templates>
                                    </ul>

                                    <ul id="carousel_2">
                                        <div class="recError">Чтобы увидеть Рекомендованные – перейдите в <a href="/categories/">Каталог</a> </div>
                                    </ul>

                                    <ul id="carousel_3">
                                        <xsl:apply-templates select="document('udata://custom/getVisited/')/udata/page" mode="carousel">
                                            <xsl:with-param name="limiter" select="'visited'" />
                                        </xsl:apply-templates>
                                    </ul>
                                </div>
                                <div class="loading_info" style="display:none;"></div>
                            </div>
                        </div>
                    </div>

                    <div id="footer">
                        <!--<div id="fishart">Создание сайта <a href="http://fish-art.ru"><img src="{$tpl}/img/fishart.png" alt="Интернет-агентство FishArt" /></a></div> -->
                        <div id="copyright">
                                © 2011-2015 Швейная фабрика "Машук"<br />
                                <a href="/sitemap/"><img src="{$tpl}/img/sitemap.png" alt="Карта сайта" />Карта сайта</a>
                        </div>
                        <div id="share">
                                <div class="follow_us">Следуйте за нами</div>
                                <div class="socs">
                                        <div class="soc">
                                                <div class="sicon vk"></div>
                                                <a target="_blank" href="https://vk.com/bossanovagroup">Вконтакте</a>
                                        </div>
                                        <div class="soc">
                                                <div class="sicon fb"></div>
                                                <a target="_blank" href="https://www.facebook.com/bossanovakids?ref=profile">Facebook</a>
                                        </div>
                                        <div class="soc">
                                                <div class="sicon ok"></div>
                                                <a target="_blank" href="http://ok.ru/group/54566353240074">Одноклассники</a>
                                        </div>
                                        <div class="soc">
                                                <div class="sicon in"></div>
                                                <a target="_blank" href="http://instagram.com/bossanovagroup">Instagram</a>
                                        </div>
                                        <div class="soc">
                                                <div class="sicon mm"></div>
                                                <a target="_blank" href="http://my.mail.ru/mail/bossanovagroup/">Мой Мир</a>
                                        </div>
                                </div>

                            <!--
                                <div id="vk_like"></div>
                                <script type="text/javascript">
                                        VK.Widgets.Like("vk_like", {type: "button"});
                                </script>
                                -->
                                <!--<iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2F{result/@domain}{result/@request-uri}&amp;send=false&amp;layout=button_count&amp;width=450&amp;show_faces=true&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:180px; height:21px;" allowTransparency="true"></iframe>
                                <a href="https://twitter.com/share" class="twitter-share-button" data-lang="ru">Твитнуть</a>
                                <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
                                -->
                        </div>
                    </div>
                </div>
                <div id="temp"></div>
                <!-- Yandex.Metrika counter -->
                <script type="text/javascript">(function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter20045548 = new Ya.Metrika({id:20045548, webvisor:true, clickmap:true, trackLinks:true, accurateTrackBounce:true}); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks");</script>
                <noscript>
                    <div>
                        <img src="//mc.yandex.ru/watch/20045548" style="position:absolute; left:-9999px;" alt="" />
                    </div>
                </noscript><!-- /Yandex.Metrika counter -->


                <script type="text/javascript">
                    $('body').on('click', 'a[href="#order"]', function(){
                    console.log('vzakaz');
                    yaCounter20045548.reachGoal('vzakaz');
                    });

                    function jivo_onOpen(){

                    console.log('jivosite');
                    yaCounter20045548.reachGoal('jivosite');
                    }

                </script>
                <div class="reg_form vote_img popup common_popup box_shadow select_for_clicked_image" >
                    <div class="close absolute" title="Закрыть"></div>
                    <div class="box">
                        <div id="thief"></div>
                    </div>
                </div>
                <div class="for_auth vote_img popup common_popup box_shadow" >
                    <div class="close absolute" title="Закрыть"></div>
                    <div class="padding_auth">
                        <div class="header_auth">Для добавление товара в корзину <br /> необходимо авторизоваться</div>
                        <form name="login" method="post" action="/users/login_do/" id="auth_login">
                            <div class="block_auth">

                                <div class="line input_field login_field">
                                    <span class="spanText"> Логин </span>
                                    <input type="text" name="login"  />
                                </div>
                                <div class="both"></div>
                                <div class="lineWrapper">
                                    <div class="line button pass_class input_field">
                                        <span class="spanText"> Пароль </span>
                                        <input type="password" name="password"  />
                                        <a class="auth_user" href="">Войти</a>
                                    </div>
                                    <input type="hidden" name="ajfrom" value="1"  />
                                </div>
                                <div class="testresult"></div>
                            </div>
                        </form>
                        <div class="otherSteps">
                            <span class="stepsOr">Или</span>
                            <div class="new_block">
                                <div style="display:inline-block;">
                                    <button style="cursor: pointer;" class="button_voice box_inline_w form-submit " name="op" id="edit-vote" type="submit">
                                        <div class="wrapper_button">
                                            <a href="#" class="button_reg voice inline relative box_shadow">
                                                <span class="value inline">ЗАРЕГИСТРИРОВАТЬСЯ</span>
                                            </a>
                                        </div>
                                    </button>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="dont_utp vote_img popup common_popup box_shadow" >
                    <div class="close absolute" title="Закрыть"></div>
                    <div class="padding_auth">
                        <div class="header_auth">Вы не являетесь участником совместных покупок</div>
                    </div>
                </div>
                <div class="stoped-buys vote_img popup common_popup box_shadow" >
                    <div class="close absolute" title="Закрыть"></div>
                    <div class="padding_auth">
                        <div class="header_auth">Закупка товаров приостановлена!</div>
                        <span></span>
                    </div>
                </div>
                <div class="box_fade" style="display: none;"></div>
                <div class="preview_image image_good tooltip">
                    <div width="94" >
                        <img style="float:right;" class="img_production take_src" height="91" src="">
                        </img>
                        <img class="arrow_image" src="/templates/triko/img/new_arrow_green.png" width="11" height="16" />
                    </div>
                </div>


            </body>
        </html>
    </xsl:template>

    <!-- Слайдер -->
    <xsl:template match="property[@name = 'kartinki']/value">

        <div id="slider" style="height:397px; width:579px; float:left;">
            <xsl:apply-templates select="item" mode="slide_object" />
        </div>


    </xsl:template>

    <xsl:template match="item" mode="slide_object">
        <xsl:apply-templates
            select="document(concat('uobject://', @id))/udata"
            mode="slide_object" />
    </xsl:template>

    <xsl:template match="udata" mode="slide_object">
        <a href="{.//property[@name = 'link']/value/page/@link}">
            <img src="{.//property[@name = 'kartinka']/value}" />
        </a>
    </xsl:template>
    <!--Слайдер end-->

    <xsl:template name="leftLink">
        <xsl:param name="link" />
        <xsl:param name="text" />

        <li >
            <xsl:if test="(starts-with($page/@link, $link) and not(starts-with($page/@link, '/categories/')))
							or $page/@link = $link">
                <xsl:attribute name="class">
                    <xsl:text>active</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <div>
                <div class="noArrow">
                    <a href="{$link}">
                        <xsl:value-of select="$text" />
                    </a>
                </div>
            </div>
        </li>
    </xsl:template>

    <xsl:template match="item" mode="leftMenu">
        <xsl:choose>
            <xsl:when test="starts-with($result/page/@link, @link)">
                <li class="active one_step" catId="{@id}" id="{@id}">
                    <div>
                        <div>
                            <a href="{@link}">
                                <xsl:value-of select="@name" />
                            </a>
                        </div>
                    </div>
                    <ul class="leftSubmenu">
                        <xsl:apply-templates select="document(concat('udata://content/menu/0/1/(', @link,')/'))//item" mode="leftSubMenu" />
                    </ul>
                </li>
            </xsl:when>
            <xsl:otherwise>
                <li class="one_step" catId="{@id}" id="{@id}">
                    <div>
                        <div>
                            <a href="{@link}">
                                <xsl:value-of select="@name" />
                            </a>
                        </div>
                    </div>
                    <ul class="leftSubmenu" style="display:none;">
                        <xsl:apply-templates select="document(concat('udata://content/menu/0/1/(', @link,')/'))//item" mode="leftSubMenu" />
                    </ul>
                </li>



            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="item" mode="leftSubMenu">
        <!--	<li><a href="#cat{@id}"><xsl:value-of select="@name" /></a></li> -->
        <xsl:choose>
            <xsl:when test="starts-with($result/page/@link, @link)">
                <li class="active" id="{@id}">
                    <a href="{@link}">
                        <xsl:value-of select="@name" />
                    </a>
                </li>
            </xsl:when>
            <xsl:otherwise>
                <li  id="{@id}">
                    <a href="{@link}" >
                        <xsl:value-of select="@name" />
                    </a>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="mainMenuItem">
        <xsl:param name="text" />
        <xsl:param name="link" />
        <xsl:param name="mode" />
        <xsl:variable name="active" select="starts-with(/result/@request-uri, $link)" />

        <li>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="$active">
                        <xsl:text>active </xsl:text>
                        <xsl:value-of select="$mode" />
                    </xsl:when>
                    <xsl:when test="$mode != ''">
                        <xsl:value-of select="$mode" />
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <div>
                <a href="{$link}">
                    <xsl:if test="$link != '/news/'">
                        <xsl:choose>
                            <xsl:when test="$active">
                                <img src="{$tpl}/img/arrow_menu_active.png" alt="Arrow active" />
                            </xsl:when>
                            <xsl:otherwise>
                                <img src="{$tpl}/img/arrow_menu.png" alt="Arrow" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                    <span>
                        <xsl:value-of select="$text" />
                    </span>
                </a>
            </div>
        </li>
    </xsl:template>

    <xsl:template match="page" mode="breadcrumb">
        <li>
            <a href="{@link}">
                <xsl:value-of select="name" />
            </a>
        </li>
    </xsl:template>

    <xsl:template match="user">
        <div id="auth">
            <xsl:apply-templates select="/result/user" mode="auth" />
            <form name="login" id="clickLoginForm" method="post" action="/users/login_do/">
                <div class="line">
                    <input type="text" name="login" placeholder="Логин" />
                </div>
                <div class="lineWrapper">
                    <div class="line button">
                        <input type="password" name="password" placeholder="Пароль" />
                    </div>
                    <div class="submit">
                        <div>
                            <a href="javascript:document.getElementById('clickLoginForm').submit();;">Войти</a>
                        </div>
                        <!--<input type="image" src="{$tpl}/img/arrow_login.png" onmouseover="loginImg(this, true);" onmouseout="loginImg(this, false);" />-->
                    </div>
                </div>
            </form>
            <div class="links">
                <a href="/users/forget/">Забыли пароль?</a>
                <span>|</span>
                <a href="/users/registrate/">Регистрация</a>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="user[@status = 'auth']">
        <xsl:param name="module" />
        <xsl:param name="method" />
        <xsl:param name="pageId" />
        <xsl:variable name="userObj" select="document(concat('uobject://', @id))/udata" />

        <xsl:variable name="nameButton" >
            <xsl:choose>
                <xsl:when test="$userObj//property[@name = 'org_type']/value">
                    <xsl:text>Личный кабинет</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Личные данные</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <div id="user">
            <xsl:choose>
                <xsl:when test="$module='users' and $method='settings'">

                    <a href="/users/settings/" class="act"><xsl:value-of select="$nameButton" /></a>
                </xsl:when>
                <xsl:otherwise>
                    <a href="/users/settings/"><xsl:value-of select="$nameButton" /></a>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:choose>
                <xsl:when test="$pageId=460 or $pageId=461">
                    <a href="/orders/" class="act">Журнал заказов</a>
                </xsl:when>
                <xsl:otherwise>
                    <a href="/orders/">Журнал заказов</a>
                </xsl:otherwise>
            </xsl:choose>

            <a href="/users/logout/">Выход</a>
        </div>
    </xsl:template>

    <xsl:template match="result" mode="news" />

    <xsl:template match="result" mode="subMenu"/>

    <xsl:template match="result[starts-with(page/@link, '/about/') or starts-with(page/@link, '/clients/') or starts-with(page/@link, '/useful/') or starts-with(page/@link, '/partners/')]" mode="subMenu">
        <table id="subMenu">
            <tr>
                <xsl:apply-templates select="document(concat('udata://content/menu/0/1/(', (parents/page[1]|page)/@link, ')'))//item" mode="subMenu" />
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="item" mode="subMenu">
        <xsl:variable name="active">
            <xsl:if test="starts-with($result/@request-uri, @link)">
                <xsl:text>active</xsl:text>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="mode">
            <xsl:choose>
                <xsl:when test="position() = 1">
                    <xsl:text>first</xsl:text>
                </xsl:when>
                <xsl:when test="position() = last()">
                    <xsl:text>last</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>

        <td>
            <div>
                <xsl:attribute name="class">
                    <xsl:value-of select="concat($mode, ' ', $active)" />
                </xsl:attribute>
                <a href="{@link}">
                    <xsl:value-of select="." />
                </a>
            </div>
        </td>
    </xsl:template>

    <xsl:template match="udata[@module = 'emarket'][@method = 'price']">
        <xsl:value-of select="format-number(price/actual,'#.0')" /> руб.


    </xsl:template>




    <!--Главная-->

    <xsl:template match="result[page/@is-default = '1']">


        <!--<div>
                <a href="{//property[@name = 'link']/value}"><img src="{document(concat('udata://system/makeThumbnail/(.', //property[@name = 'image']/value, ')/580/'))//src}" alt="{//property[@name = 'alt']/value}" id="mainBanner" /></a>
        </div>-->
        <xsl:apply-templates select="document('upage://1')/udata/page//property[@name = 'kartinki']/value" />
        <xsl:call-template name="newsColumn" />
    </xsl:template>

    <xsl:template match="item" mode="lastNews">
        <li>
            <div class="date">
                <xsl:value-of select="php:function('date', 'd.m.Y', string(@publish_time))" />
            </div>
            <xsl:choose>
                <xsl:when test="document(concat('upage://', @id))//property[@name = 'banner']/value">
                    <div class="news_banner">
                        <img  >
                            <xsl:attribute name="src">
                                <xsl:value-of select="document(concat('upage://', @id))//property[@name = 'banner']/value" />
                            </xsl:attribute>
                        </img>
                    </div>
                </xsl:when>
            </xsl:choose>
            <div class="text">
                <a href="{@link}">
                    <xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" disable-output-escaping="yes" />
                </a>
            </div>
        </li>
    </xsl:template>


    <!--Акции-->

    <xsl:template match="result[page/@link = '/promo/' or page/@link = '/collections/']">
        <script type="text/javascript" src="{$tpl}/js/action_filter.js"></script>


        <xsl:variable name="stream">
            <xsl:choose>
                <xsl:when test="page/@link = '/promo/'">
                    <xsl:text>udata://custom/getPromos/</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>usel://subpages</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <div id="promolections">
            <xsl:apply-templates select="document(concat($stream,'/', page/@id))//page" mode="promolection" />
        </div>

    </xsl:template>

    <xsl:template match="page" mode="promolection">
        <div class="promolection">
            <div>
                <a href="{@link}">
                    <xsl:call-template name="promolectionImg">
                        <xsl:with-param name="img" select="document(concat('upage://', @id, '.picture'))//value" />
                        <xsl:with-param name="header" select="name" />
                    </xsl:call-template>
                </a>
            </div>
            <a href="{@link}" class="coll_act">
                <xsl:value-of select="name" />
            </a>
            <div>
                <xsl:value-of select="document(concat('upage://', @id, '.content'))//value" disable-output-escaping="yes" />
            </div>
        </div>



    </xsl:template>

    <xsl:template name="promolectionImg">
        <xsl:param name="img" />
        <xsl:param name="header" />

        <!--	<xsl:variable name="thumb" select="document(concat('udata://system/makeThumbnailFull/(.', $img, ')/(auto)/(auto)'))//src" /> -->
        <xsl:variable name="exactImg">
            <xsl:choose>
                <xsl:when test="$img">
                    <xsl:value-of select="$img" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$tpl" />
                    <xsl:text>/img/no_img_wide.png</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <img src="{$exactImg}" width="242"  alt="{$header}" />



    </xsl:template>

    <xsl:template match="result[page/@link = '/order/']">
        <xsl:choose>
            <xsl:when test="not(document(concat('uobject://', $order_id, '.customer_id'))//value/item/@id = user/@id)">
                <div id="textBlock">
                    <h1>
                        <xsl:value-of select="//property[@name = 'h1']/value" />
                    </h1>

                    <p>Этот заказ был оформлен не вами, либо вы не вошли в систему.</p>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="totalPrice" select="document(concat('uobject://', $order_id, '.total_price'))//value" />

                <table id="cartInfo">
                    <tr>
                        <th>Дата</th>
                        <th>Сумма, рублей</th>
                        <th> </th>
                        <th>Сумма скидки</th>
                        <th>Способ оплаты</th>
                    </tr>
                    <tr>
                        <td>
                            <xsl:value-of select="php:function('date', 'd-m-Y', number(document(concat('uobject://', $order_id, '.order_date'))//value/@unix-timestamp))" />
                        </td>
                        <td>
                            <xsl:value-of select="format-number($totalPrice, '### ### ### ### ###, 00', 'price')" /> руб., в т. ч. НДС

                            <xsl:choose>
                                <xsl:when test="document(concat('uobject://', $order_id, '.is_not_nds'))//value">
                                    0,00 руб.
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="format-number(document(concat('udata://emarket/summNDS/', $order_id))/udata, '### ### ### ### ###, 00', 'price')" /> руб.
                                    <!--<xsl:value-of select="document(concat('udata://emarket/summNDS/', $order_id))/udata" />-->
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                        <td> </td>
                        <td> </td>
                        <td>

                            <xsl:variable name="idpayment" select="document(concat('uobject://', $order_id))//property[@name = 'payment_id']/value/item/@id" />
                            <xsl:choose>
                                <xsl:when test="document(concat('uobject://', $idpayment))//property[@name = 'manager_payment']/value = '1'">
                                    <xsl:attribute name="class">
                                        <xsl:text>look-new</xsl:text>
                                    </xsl:attribute>
                                    <a href="#" class="choose-payment">Выбрать</a>

                                    <div class="payment-order">
                                        <span class="green-head">
                                            Для завершения формирования заказа<br />
                                            выберите форму оплаты
                                        </span>
                                        <form action="/emarket/changeStatusPaymentOrder" method="post" class="form-select-payment journal">
                                            <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                                                <xsl:choose>
                                                    <xsl:when test="@manag = '0'">
                                                        <div class="payment-block">
                                                            <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                                            <label class="checkbox button-payment" for="payment{@id}">
                                                                <xsl:value-of select="." />
                                                            </label>
                                                            <div class="short_desc">
                                                                <xsl:value-of select="@short" />
                                                            </div>
                                                        </div>
                                                    </xsl:when>

                                                </xsl:choose>
                                            </xsl:for-each>
                                            <input type="hidden" name="order-id" value="{$order_id}" />

                                            <input type="submit" value="Заказать" style="display: none;" />
                                        </form>
                                        <span class="back-to-buy">Вернутся к формированию заказа</span>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="document(concat('uobject://', $order_id))//property[@name = 'payment_id']/value/item/@name" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                        <!--<xsl:value-of select="php:function('ceil', string($totalPrice * 0.18 div 1.18 * 100)) div 100" />-->
                    </tr>
                </table>
                <xsl:choose>
                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">

                        <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                        <xsl:choose>
                            <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">

                            </xsl:when>
                            <!--
                            <xsl:otherwise>
                                <label>
                                    Размер
                                    <select id="sizeSelect">
                                        <option value="0">Не важно</option>
                                        <xsl:apply-templates select="document('usel://select/119/')/udata/item" mode="select">
                                            <xsl:sort select="@name" order="ascending" />
                                        </xsl:apply-templates>
                                    </select>
                                </label>
                                <label>
                                    Полотно
                                    <select id="materialSelect">
                                        <option value="0">Не важно</option>
                                        <xsl:apply-templates select="document('usel://select/125/')/udata/item" mode="select">
                                            <xsl:sort select="@name" order="ascending" />
                                        </xsl:apply-templates>
                                    </select>
                                </label>
                            </xsl:otherwise> -->
                        </xsl:choose>
                        <div id="cartFilter">

                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <!--
                        <label>
                            Размер
                            <select id="sizeSelect">
                                <option value="0">Не важно</option>
                                <xsl:apply-templates select="document('usel://select/119/')/udata/item" mode="select">
                                    <xsl:sort select="@name" order="ascending" />
                                </xsl:apply-templates>
                            </select>
                        </label>
                        <label>
                            Полотно
                            <select id="materialSelect">
                                <option value="0">Не важно</option>
                                <xsl:apply-templates select="document('usel://select/125/')/udata/item" mode="select">
                                    <xsl:sort select="@name" order="ascending" />
                                </xsl:apply-templates>
                            </select>
                        </label> -->
                    </xsl:otherwise>
                </xsl:choose>
                <script type="text/javascript">
                    $(function()
                    {
                    order_id = <xsl:value-of select="$order_id" />;
                    });

                </script>

                <div style="position: relative; min-height: 200px;">

                    <div id="tableLoader" style="display: none;">
                        <img src="/images/loader-horizontal.gif" alt="Загрузка" />
                    </div>
                    <div id="tableEmpty">
                        нет подходящих товаров
                    </div>


                    <table id="cartTable">
                        <tr id="cartHeader">
                            <th class="thumb">
                                <div>
                                    <img src="{$tpl}/img/image_icon.gif" alt="Изображение" class="icon" />
                                </div>
                            </th>
                            <th class="code" field="code">
                                <div>
                                    <a href="#">Артикул</a>
                                </div>
                            </th>
                            <th field="name">
                                <div>
                                    <a href="#">Наименование</a>
                                </div>
                            </th>
                            <th class="packs" field="packs">
                                <div>
                                    <a href="#">Упаковок</a>
                                </div>
                            </th>
                            <th class="items" field="items">
                                <div>
                                    <a href="#">Штук</a>
                                </div>
                            </th>
                            <th class="price" field="price">
                                <div>
                                    <a href="#">Цена</a>
                                </div>
                            </th>
                            <th class="totalPrice" field="totalPrice">
                                <div>
                                    <a href="#">Стоимость</a>
                                </div>
                            </th>
                        </tr>
                        <!--	<xsl:apply-templates select="document(concat('udata://emarket/getOrder/', $order_id, '/?transform=cart.xsl&amp;noremove=1'))/udata/table/tr" mode="cartItem" /> -->
                        <xsl:apply-templates select="document(concat('udata://emarket/getOrderItemsGroup/', $order_id))/udata/items" mode="newCartItem" >
                            <xsl:with-param name="width_col" select="7" />
                        </xsl:apply-templates>
                    </table>
                </div>

                <div class="payment-order">
                    <span class="green-head">
                        Для завершения формирования заказа<br />
                        выберите форму оплаты
                    </span>
                    <form action="/emarket/purchase/payment/choose/do/" method="post" class="form-select-payment">
                        <xsl:choose>
                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                <xsl:attribute name="action">
                                    <xsl:text>/emarket/prePaymentChoose</xsl:text>
                                </xsl:attribute>

                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="action">
                                    <xsl:text>/emarket/purchase/payment/choose/do/</xsl:text>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                            <xsl:choose>
                                <xsl:when test="@manag = '0'">
                                    <div class="payment-block">
                                        <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                        <label class="checkbox button-payment" for="payment{@id}">
                                            <xsl:value-of select="." />
                                        </label>
                                        <div class="short_desc">
                                            <xsl:value-of select="@short" />
                                        </div>
                                    </div>
                                </xsl:when>

                            </xsl:choose>
                        </xsl:for-each>
                        <!--    <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                            <xsl:choose>
                                <xsl:when test="@manag = '1'">
                                    <div class="minHeight"></div>
                                    <span class="green-or">ИЛИ</span>
                                    <div class="minHeight"></div>
                                    <div class="payment-center-block">
                                        <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                        <label class="checkbox button-payment" for="payment{@id}"><xsl:value-of select="." /></label>
                                        <div class="short_desc"><xsl:value-of select="@short" /></div>
                                    </div>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each> -->

                        <input type="submit" value="Заказать" style="display: none;" />
                    </form>
                    <span class="back-to-buy">Вернутся к формированию заказа</span>
                </div>

            </xsl:otherwise>
        </xsl:choose>



    </xsl:template>



    <!--Корзина-->

    <xsl:template match="result[page/@link = '/cart/']">
        <script type="text/javascript" src="{$tpl}/js/custom.js"></script>
        <xsl:variable name="user_id" select="user/@id" />
        <xsl:choose>
            <xsl:when test="document(concat('uobject://', $user_id))//property[@name = 'org_type']/value">
                <div class="buys-block">

                    <ul class="buys-list">
                        <li class="active-tab-buys first-li-tab" >
                            <a style="font-size:14px;" href="#tab1">Корзина</a>

                            <div class="basket-buttons" style="margin-top:6px;">
                                    <a style="margin-left: -5px; width: 40%;" href="/cart">
                                        <xsl:choose>
                                            <xsl:when test="$sort_org = 1">

                                                <xsl:attribute name="class">not-active-subtab-buys</xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="class">active-subtab-buys</xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        по участникам
                                    </a>

                                    <a style="width: 39%; margin-right: -6px;" href="/cart/?sort_org=1">
                                        <xsl:choose>
                                            <xsl:when test="$sort_org = 1">
                                                <xsl:attribute name="class">active-subtab-buys</xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="class">not-active-subtab-buys</xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        с разбивкой
                                    </a>

                            </div>

                        </li>
                        <li style="vertical-align: top; padding:4px; text-align: center;" class="second-li-tab">
                            <a href="#tab2" style="font-size:14px;">Участники совместных покупок</a>
                        </li>
                    </ul>


                    <ul class="buys-list">
                        <!--
                        <li class="active-tab-buys">
                            <a href="#tab1" class="">Корзина</a>

                        </li>
                        -->

                    </ul>
                    <div id="tab1" class="step active-tab-buys">
                        <xsl:choose>
                            <xsl:when test="$cart//summary/amount = 0">
                                <xsl:apply-templates select="." mode="emptyCart" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="." mode="fullCartOrg" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                    <div id="tab2" class="step">
                        <xsl:apply-templates select="document(concat('uobject://', $user_id))/udata" mode="BuysCart" />
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="buys-block">
                    <xsl:choose>
                        <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                            <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />
                            <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />
                            <xsl:variable name="amountCart" select="document(concat('uobject://', $orderId))//property[@name = 'total_amount']/value" />

                            <xsl:choose>
                                <xsl:when test="document(concat('uobject://', $user_id))//property[@name = 'delete_from_buys']/value">

                                    <xsl:choose>
                                        <xsl:when test="document('udata://emarket/cart/')/udata/summary/amount &gt; 0">
                                            <xsl:apply-templates select="." mode="fullCart" />

                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:apply-templates select="." mode="emptyCart" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="$amountCart = 0">
                                            <xsl:apply-templates select="." mode="emptyCart" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:apply-templates select="document(concat('udata://emarket/order/', $orderId))/udata" mode="fullCartUtp" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>

                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="$cart//summary/amount = 0">
                                   <xsl:apply-templates select="." mode="emptyCart" />
                                </xsl:when>
                                <xsl:otherwise>
                                   <xsl:apply-templates select="." mode="fullCart" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!--
                    <xsl:choose>
                        <xsl:when test="document(concat('uobject://', document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))))//property[@name = 'delete_from_buys']/value">
                            <label>
                                Размер
                                <select id="sizeSelect">
                                    <option value="0">Не важно</option>
                                    <xsl:apply-templates select="document('usel://select/119/')/udata/item" mode="select">
                                        <xsl:sort select="@name" order="ascending" />
                                    </xsl:apply-templates>
                                </select>
                            </label>
                            <label>
                                Полотно
                                <select id="materialSelect">
                                    <option value="0">Не важно</option>
                                    <xsl:apply-templates select="document('usel://select/125/')/udata/item" mode="select">
                                        <xsl:sort select="@name" order="ascending" />
                                    </xsl:apply-templates>
                                </select>
                            </label>
                        </xsl:when>
                    </xsl:choose> -->
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="udata" mode="BuysCart">
        <div class="main-buys">

            <form action="/users/sendInviteToUser/" method="post" class="form-invite" >
                <input type="hidden" class="org_id" name="org_id" value="{object/@id}" />
                <input type="text" name="email" class="invite-email" placeholder="Новый участник" />
                <button type="submit" class="invite-submit" >Пригласить</button>
              <!--  <div class="invite-submit">Пригласить</div> -->
            </form>
            <span class="invited-text">Приглашение отправлено!</span>

            <xsl:choose>
                <xsl:when test="document(concat('udata://users/getUtpUsersAddressBook/', object/@id))/udata/user">
                    <input type="button" class="add-from-address" value='Подключить участника из "Адресной книги"' />
                </xsl:when>
            </xsl:choose>

        </div>
        <div class="invite-list-users">

            <xsl:choose>
                <xsl:when test="document(concat('uobject://', object/@id))//property[@name = 'key_org']/value">

                    <table class="users-table" cellspasing="2" cellpadding="4">
                        <th>№</th>
                        <th>Mail</th>
                        <th>ФИО</th>
                        <th>Город</th>
                        <th>Телефон</th>
                        <th>Уведомлять по email</th>
                        <xsl:apply-templates select="document(concat('udata://users/getUtpUsersByIdOpt/', object/@id))/udata/user" mode="users_table" />
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <span>У вас еще нет ниодного участника</span>
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <div class="invite-from-address">
            <table class="users-table" cellspasing="2" cellpadding="4">
                <th>№</th>
                <th>Mail</th>
                <th>ФИО</th>
                <th>Город</th>
                <th>Телефон</th>
                <th></th>
                <xsl:apply-templates select="document(concat('udata://users/getUtpUsersAddressBook/', object/@id))/udata/user" mode="users_table_book" />
            </table>
            <input type="button" class="ready-add-from-address" value='Готово!' /> <a href="/users/inviteAllUsers/{object/@id}" class="inviteAllUsers" >Пригласить всех пользователей!</a>
        </div>
    </xsl:template>

    <xsl:template match="user" mode="users_table">
        <tr>
            <td>
                <xsl:value-of select="@number" />
            </td>
            <td class="email-utp-org">
                <xsl:value-of select="@email" />
            </td>
            <td>
                <xsl:value-of select="@name" />
            </td>
            <td>
                <xsl:value-of select="@city" />
            </td>
            <td>
                <xsl:value-of select="@phone" />
            </td>
            <td class="notif">
                <xsl:if test="@name != ''" >
                    <xsl:choose>
                        <xsl:when test="document(concat('uobject://', @id))//property[@name = 'notif_email']/value = '1'">
                            <input type="checkbox" value="{@id}" name="sendChangeToUser[]" checked="checked" class="send-notif" />
                        </xsl:when>
                        <xsl:otherwise>
                            <input type="checkbox" value="{@id}" name="sendChangeToUser[]" class="send-notif" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </td>
            <td><xsl:value-of select="@status" /></td>
            <td>
                <xsl:if test="@status != 'приглашен'">
                    <a class="changeUserStatus" href="/users/getOutUtpUserFromCart/{@id}" rel="{@id}">удалить</a>
                </xsl:if>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="user" mode="users_table_book">
        <tr>
            <td>
                <xsl:value-of select="@number" />
            </td>
            <td>
                <xsl:value-of select="@email" />
            </td>
            <td>
                <xsl:value-of select="@name" />
            </td>
            <td>
                <xsl:value-of select="@city" />
            </td>
            <td>
                <xsl:value-of select="@phone" />
            </td>
            <td class="messageTd">
                <a class="changeUserStatus" href="/users/addUserToUtpByAddressBook/{@org_id}/{@email}" >Пригласить пользователя к покупкам</a>
            </td>

        </tr>
    </xsl:template>

    <xsl:template match="result" mode="emptyCart">
        <div id="textBlock">
            В вашем заказе еще нет товаров.
        </div>
    </xsl:template>

    <xsl:decimal-format decimal-separator=',' grouping-separator=' ' name="price" />

    <xsl:template match="udata" mode="fullCartUtp">
        <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
        <xsl:variable name="cartId" select="document('udata://emarket/cart/')/udata/@id" />
        <script type="text/javascript">
            $(document).ready(function() {
            var summ = 0;
            $('td.sum_discount div.for_count').each(function(){
            var text = $(this).text();
            var cut_text = text.replace(/-/gi, '');
            if(!!cut_text) {

            summer = parseInt(cut_text, 10);


            summ += summer;
            $('div.ready_discount').text();
            $('div.ready_discount').text(summ+' .руб');
            }
            });
            });
        </script>

        <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />
        <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />
        <xsl:variable name="priceCart" select="document(concat('udata://emarket/getTotalPriceUtp/', $orderId))/udata" />
        <table id="cartInfo">
            <tr>
                <th>Дата</th>
                <th>Сумма, рублей</th>
                <th> </th>
                <th>Сумма cкидки</th>

            </tr>
            <tr>
                <td>
                    <xsl:value-of select="php:function('date', 'd-m-Y')" />
                </td>
                <td>
                    <xsl:value-of select="format-number($priceCart, '### ### ### ### ###, 00', 'price')" /> руб., в т. ч. НДС <xsl:value-of select="format-number(document('udata://emarket/summNDS/')/udata, '### ### ### ### ###, 00', 'price')" /> руб.</td>
                <td></td>
                <td class="sum_discount">
                <!--
                    <div style="display:none;">
                        <xsl:for-each select="//property[@name = 'order_items']/value/item" >
                            <div class="for_count">
                                <xsl:variable name="sizeId" select="page/@id" />
                                <xsl:variable name="count" select="amount * document(concat('upage://', $sizeId, '.pack'))//value" />
                                <xsl:choose>
                                    <xsl:when test="discount/amount">
                                        <xsl:value-of select="discount/amount" />

                                    </xsl:when>
                                </xsl:choose>
                            </div>
                        </xsl:for-each>
                    </div>
                    <div class="ready_discount"></div> -->
                </td>

            </tr>
        </table>

        <a href="/users/sendEmailNotification/{$userid_for_price}" class="notif-email">
            <xsl:choose>
                <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'notif_email']/value">
                    <input type="checkbox" class="send-notif" value="1" checked="checked" name="send-email">Уведомлять меня по email</input>
                </xsl:when>
                <xsl:otherwise>
                    <input type="checkbox" class="send-notif" value="2"  name="send-email">Уведомлять меня по email</input>
                </xsl:otherwise>
            </xsl:choose>

        </a>
        <div id="cartFilter">
            <xsl:call-template name="cartButtons" />
            <xsl:choose>
                <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">

                    <xsl:choose>
                        <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value and document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                            <label>
                                Размер
                                <select id="sizeSelect">
                                    <option value="0">Не важно</option>
                                    <xsl:apply-templates select="document('usel://select/119/')/udata/item" mode="select">
                                        <xsl:sort select="@name" order="ascending" />
                                    </xsl:apply-templates>
                                </select>
                            </label>
                            <label>
                                Полотно
                                <select id="materialSelect">
                                    <option value="0">Не важно</option>
                                    <xsl:apply-templates select="document('usel://select/125/')/udata/item" mode="select">
                                        <xsl:sort select="@name" order="ascending" />
                                    </xsl:apply-templates>
                                </select>
                            </label>
                        </xsl:when>

                    </xsl:choose>

                </xsl:when>
                <xsl:otherwise>
                        <label>
                            Размер
                            <select id="sizeSelect">
                                <option value="0">Не важно</option>
                                <xsl:apply-templates select="document('usel://select/119/')/udata/item" mode="select">
                                    <xsl:sort select="@name" order="ascending" />
                                </xsl:apply-templates>
                            </select>
                        </label>
                        <label>
                            Полотно
                            <select id="materialSelect">
                                <option value="0">Не важно</option>
                                <xsl:apply-templates select="document('usel://select/125/')/udata/item" mode="select">
                                    <xsl:sort select="@name" order="ascending" />
                                </xsl:apply-templates>
                            </select>
                        </label>

                </xsl:otherwise>
            </xsl:choose>
        </div>

        <div style="position: relative; min-height: 200px;">
            <div id="tableLoader" style="display: none;">
                <img src="/images/loader-horizontal.gif" alt="Загрузка" />
            </div>
            <div id="tableEmpty">
                нет подходящих товаров
            </div>

            <!--<xsl:variable name="orderId" select="@id" /> -->
            <form method="post" action="/udata/emarket/recalcCart/" id="cartForm" >
                <table id="cartTable">
                    <tr id="cartHeader">
                        <th class="thumb">
                            <div>
                                <img src="{$tpl}/img/image_icon.gif" alt="Изображение" class="icon" />
                            </div>
                        </th>
                        <th class="code" field="code">
                            <div>
                                <a href="#">Артикул</a>
                            </div>
                        </th>
                        <th field="name">
                            <div>
                                <a href="#">Наименование</a>
                            </div>
                        </th>
                        <xsl:choose>
                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                              <!--  <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" /> -->
                                <xsl:choose>
                                    <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                                        <th class="packs" field="packs">
                                            <div>
                                                <a href="#">Упаковок</a>
                                            </div>
                                        </th>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <th class="packs" field="packs">
                                    <div>
                                        <a href="#">Упаковок</a>
                                    </div>
                                </th>
                            </xsl:otherwise>
                        </xsl:choose>

                        <th class="items" field="items">
                            <div>
                                <a href="#">Штук</a>
                            </div>
                        </th>
                        <th class="price" field="price">
                            <div>
                                <a href="#">Цена</a>
                            </div>
                        </th>
                        <th class="totalPrice" field="totalPrice">
                            <div>
                                <a href="#">Стоимость</a>
                            </div>
                        </th>
                        <th class="remove">
                            <div>Удаление</div>
                        </th>
                    </tr>
                    <!--<xsl:apply-templates select="document('udata://emarket/getCart/?transform=cart.xsl')/udata/table/tr" mode="cartItem" /> -->
                    <xsl:apply-templates select="items/item" mode="preCartItemUtp" >
                        <xsl:with-param name="width_col" select="8" />
                    </xsl:apply-templates>

                    <!--    <xsl:param name="noremove" select="'0'" />
                    <xsl:variable name="colspan">
                            <xsl:choose>
                                    <xsl:when test="$noremove = 1">
                                            <xsl:value-of select="7" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                            <xsl:value-of select="8" />
                                    </xsl:otherwise>
                            </xsl:choose>
                    </xsl:variable> -->
                </table>
            </form>
        </div>
        <div class="payment-order">
            <span class="green-head">
                Для завершения формирования заказа<br />
                выберите форму оплаты
            </span>
            <form action="/emarket/purchase/payment/choose/do/" method="post" class="form-select-payment">
                <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                    <xsl:choose>
                        <xsl:when test="@manag = '0'">
                            <div class="payment-block">
                                <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                <label class="checkbox button-payment" for="payment{@id}">
                                    <xsl:value-of select="." />
                                </label>
                                <div class="short_desc">
                                    <xsl:value-of select="@short" />
                                </div>
                            </div>
                        </xsl:when>

                    </xsl:choose>
                </xsl:for-each>
                <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                    <xsl:choose>
                        <xsl:when test="@manag = '1'">
                            <div class="minHeight"></div>
                            <span class="green-or">ИЛИ</span>
                            <div class="minHeight"></div>
                            <div class="payment-center-block">
                                <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                <label class="checkbox button-payment" for="payment{@id}">
                                    <xsl:value-of select="." />
                                </label>
                                <div class="short_desc">
                                    <xsl:value-of select="@short" />
                                </div>
                            </div>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>

                <input type="submit" value="Заказать" style="display: none;" />
            </form>
            <span class="back-to-buy">Вернутся к формированию заказа</span>
        </div>
        <div id="cartBottom">
            <xsl:call-template name="cartButtons" />
        </div>
    </xsl:template>

    <xsl:template match="result" mode="fullCartOrg">
        <xsl:variable name="orderId" select="document('udata://emarket/cart')/udata/@id" />
        <script type="text/javascript">
            $(document).ready(function() {
                var summ = 0;
                $('td.sum_discount div.for_count').each(function(){
                    var text = $(this).text();
                    var cut_text = text.replace(/-/gi, '');
                    if(!!cut_text) {

                        summer = parseInt(cut_text, 10);


                        summ += summer;
                        $('div.ready_discount').text();
                        $('div.ready_discount').text(summ+' .руб');
                    }
                });
            });
        </script>
        <!--
        <xsl:choose>
           <xsl:when test="$sort_org = 1">
               <a href="/cart" class="button-sort">Корзина "по участникам"</a>
           </xsl:when>
           <xsl:otherwise>
               <a href="?sort_org=1" class="button-sort">Корзина с разбивкой</a>
           </xsl:otherwise>
        </xsl:choose> -->
        <table id="cartInfo">
            <tr>
                <th>Дата</th>
                <th>Сумма, рублей</th>
                <th> </th>
                <th>Сумма cкидки</th>
            </tr>
            <tr>
                <td>
                    <xsl:value-of select="php:function('date', 'd-m-Y')" />
                </td>
                <td>
                    <xsl:value-of select="format-number($summary, '### ### ### ### ###, 00', 'price')" /> руб., в т. ч. НДС <xsl:value-of select="format-number(document('udata://emarket/summNDS/')/udata, '### ### ### ### ###, 00', 'price')" /> руб.</td>
                <td></td>
                <td class="sum_discount">

                    <div style="display:none;">
                        <xsl:for-each select="document('udata://emarket/cart')/udata/items/item" >
                            <div class="for_count">
                                <xsl:variable name="sizeId" select="page/@id" />
                                <xsl:variable name="count" select="amount * document(concat('upage://', $sizeId, '.pack'))//value" />
                                <xsl:choose>
                                    <xsl:when test="discount/amount">
                                        <xsl:value-of select="discount/amount" />

                                    </xsl:when>
                                </xsl:choose>
                            </div>
                        </xsl:for-each>
                    </div>
                    <div class="ready_discount"></div>
                </td>
            </tr>
        </table>

        <div id="cartFilter">
           <!-- <xsl:call-template name="cartButtons" /> -->
            <div id="cartBottom">

                <div class="cartButton">
                    <xsl:choose>
                        <xsl:when test="document(concat('uobject://', $orderId))//property[@name = 'stop_buys']/value">
                            <a href="/emarket/stopBuys/{$orderId}" class="print">Возобновить закупку</a>
                        </xsl:when>
                        <xsl:otherwise>
                            <a href="/emarket/stopBuys/{$orderId}" class="print">Остановить закупку</a>
                        </xsl:otherwise>
                    </xsl:choose>

                    <a href="/cart/print/" target="_blank" class="print">Распечатать</a>
                    <a href="#recalc" class="recalc">Пересчитать/Удалить</a>

                    <!--
                    <xsl:choose>
                        <xsl:when test="document(concat('udata://emarket/getOrgOrder/', $orderId))/udata/user[@user_id = 'org']/item/@pageId" >

                        </xsl:when>
                        <xsl:otherwise> -->
                           <xsl:choose>
                                <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">

                                    <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                    <xsl:choose>
                                        <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                                            <a href="/emarket/purchase/" class="order">Заказать</a>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <a href="/emarket/purchase/" class="order">Заказать</a>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!--
                        </xsl:otherwise>
                    </xsl:choose> -->


                </div>
            </div>
            <!--
            <label>
                Размер
                <select id="sizeSelect">
                    <option value="0">Не важно</option>
                    <xsl:apply-templates select="document('usel://select/119/')/udata/item" mode="select">
                        <xsl:sort select="@name" order="ascending" />
                    </xsl:apply-templates>
                </select>
            </label>
            <label>
                Полотно
                <select id="materialSelect">
                    <option value="0">Не важно</option>
                    <xsl:apply-templates select="document('usel://select/125/')/udata/item" mode="select">
                        <xsl:sort select="@name" order="ascending" />
                    </xsl:apply-templates>
                </select>
            </label> -->
        </div>


        <div style="position: relative; min-height: 200px;">
            <div id="tableLoader" style="display: none;">
                <img src="/images/loader-horizontal.gif" alt="Загрузка" />
            </div>
            <div id="tableEmpty">
                нет подходящих товаров
            </div>



            <form method="post" action="/udata/emarket/recalcCartOrg/" id="cartForm">
                <table id="cartTable" class="resultSummTable">

                    <xsl:choose>
                        <xsl:when test="$sort_org = 1">
                            <tr class="grid-border">
                              <!--  <td></td> -->
                                <td></td>
                                <td></td>
                             <!--   <td></td> -->
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr id="cartHeader" class="padd-table" >
                              <!--  <th ></th> -->
                                <th ></th>
                                <th ></th>
                                <th colspan="3" >Всего в заказе</th>
                                <th colspan="2" >Заказано организатором и участниками</th>
                                <th colspan="2" >Не распределено между участниками</th>
                            </tr>

                            <tr id="cartHeaderNew">
                              <!--  <th>№</th> -->
                                <th>Артикул</th>
                                <th>Наименование</th>
                              <!--  <th>Упаковок</th> -->
                                <th>Штук</th>
                                <th>Цена</th>
                                <th>Стоимость</th>
                                <th>Штук</th>
                                <th>Стоимость</th>
                                <th>Штук</th>
                                <th>Стоимость</th>

                            </tr>

                            <xsl:apply-templates select="document(concat('udata://emarket/getOrgOrderSort/', $orderId))/udata/user/item" mode="orgItemCartSort" >
                                <xsl:with-param name="width_col" select="8" />
                                <xsl:with-param name="order_original_id" select="$orderId" />
                            </xsl:apply-templates>

                            <xsl:apply-templates select="document(concat('udata://emarket/getOrgOrderSort/', $orderId))/udata/user/item[contains(@dokup, 'yes')]" mode="orgItemCartSortDokup" >
                                <xsl:with-param name="width_col" select="8" />
                                <xsl:with-param name="order_original_id" select="$orderId" />
                            </xsl:apply-templates>
                            <tr class="resultTr" style="border-top: 2px solid #afafaf;">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="summ-first" style="font-weight:bold;"></td>
                                <td></td>
                                <td class="summ-second" style="font-weight:bold;"></td>
                                <td></td>
                                <td class="summ-third" style="font-weight:bold;"></td>
                            </tr>
                        </xsl:when>
                        <xsl:otherwise>
                            <tr id="cartHeader">
                                <th class="thumb">
                                    <div>
                                        <img src="{$tpl}/img/image_icon.gif" alt="Изображение" class="icon" />
                                    </div>
                                </th>
                                <th class="code" field="code">
                                    <div>
                                        <a href="#">Артикул</a>
                                    </div>
                                </th>
                                <th field="name">
                                    <div>
                                        <a href="#">Наименование</a>
                                    </div>
                                </th>

                                <th class="items" field="items">
                                    <div>
                                        <a href="#">Штук</a>
                                    </div>
                                </th>
                                <th class="price" field="price">
                                    <div>
                                        <a href="#">Цена</a>
                                    </div>
                                </th>
                                <th  class="totalPrice" field="totalPrice">
                                    <div>
                                        <a href="#">Стоимость</a>
                                    </div>
                                </th>
                                <th  class="remove">
                                    <div>Удаление</div>
                                </th>
                                <th  >
                                    <div></div>
                                </th>

                            </tr>
                            <xsl:apply-templates select="document(concat('udata://emarket/getOrgOrder/', $orderId))/udata/user" mode="orgItemCart" >
                                <xsl:with-param name="width_col" select="8" />
                                <xsl:with-param name="order_original_id" select="$orderId" />
                            </xsl:apply-templates>
                        </xsl:otherwise>
                    </xsl:choose>
                </table>
            </form>
        </div>
        <div class="payment-order">
            <span class="green-head">
                Для завершения формирования заказа<br />
                выберите форму оплаты
            </span>
            <form action="/emarket/purchase/payment/choose/do/" method="post" class="form-select-payment">
                <xsl:choose>
                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                        <xsl:attribute name="action">
                            <xsl:text>/emarket/prePaymentChoose</xsl:text>
                        </xsl:attribute>

                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="action">
                            <xsl:text>/emarket/purchase/payment/choose/do/</xsl:text>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                    <xsl:choose>
                        <xsl:when test="@manag = '0'">
                            <div class="payment-block">
                                <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                <label class="checkbox button-payment" for="payment{@id}">
                                    <xsl:value-of select="." />
                                </label>
                                <div class="short_desc">
                                    <xsl:value-of select="@short" />
                                </div>
                            </div>
                        </xsl:when>

                    </xsl:choose>
                </xsl:for-each>
                <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                    <xsl:choose>
                        <xsl:when test="@manag = '1'">
                            <div class="minHeight"></div>
                            <span class="green-or">ИЛИ</span>
                            <div class="minHeight"></div>
                            <div class="payment-center-block">
                                <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                <label class="checkbox button-payment" for="payment{@id}">
                                    <xsl:value-of select="." />
                                </label>
                                <div class="short_desc">
                                    <xsl:value-of select="@short" />
                                </div>
                            </div>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>

                <input type="submit" value="Заказать" style="display: none;" />
            </form>
            <span class="back-to-buy">Вернутся к формированию заказа</span>
        </div>

        <div id="cartBottom">

            <div class="cartButton">
                <xsl:choose>
                    <xsl:when test="document(concat('uobject://', $orderId))//property[@name = 'stop_buys']/value">
                        <a href="/emarket/stopBuys/{$orderId}" target="_blank" class="print">Возобновить закупку</a>
                    </xsl:when>
                    <xsl:otherwise>
                        <a href="/emarket/stopBuys/{$orderId}" target="_blank" class="print">Остановить закупку</a>
                    </xsl:otherwise>
                </xsl:choose>
                <a href="/cart/print/" target="_blank" class="print">Распечатать</a>
                <a href="#recalc" class="recalc">Пересчитать/Удалить</a>

                <!--
                <xsl:choose>
                    <xsl:when test="document(concat('udata://emarket/getOrgOrder/', $orderId))/udata/user[@user_id = 'org']/item/@pageId" >

                    </xsl:when>
                    <xsl:otherwise> -->
                       <xsl:choose>
                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">

                                <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                <xsl:choose>
                                    <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                                        <a href="/emarket/purchase/" class="order">Заказать</a>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <a href="/emarket/purchase/" class="order">Заказать</a>
                            </xsl:otherwise>
                        </xsl:choose>
                        <!--
                    </xsl:otherwise>
                </xsl:choose> -->


            </div>
        </div>
    </xsl:template>

    <xsl:template match="result" mode="fullCart">
        <script type="text/javascript">
            $(document).ready(function() {
                var summ = 0;
                $('td.sum_discount div.for_count').each(function(){
                    var text = $(this).text();
                    var cut_text = text.replace(/-/gi, '');
                    if(!!cut_text) {

                        summer = parseInt(cut_text, 10);


                        summ += summer;
                        $('div.ready_discount').text();
                        $('div.ready_discount').text(summ+' .руб');
                    }
                });
            });
        </script>
        <table id="cartInfo">
            <tr>
                <th>Дата</th>
                <th>Сумма, рублей</th>
                <th> </th>
                <th>Сумма cкидки</th>
            </tr>
            <tr>
                <td>
                    <xsl:value-of select="php:function('date', 'd-m-Y')" />
                </td>
                <td>
                    <xsl:value-of select="format-number($summary, '### ### ### ### ###, 00', 'price')" /> руб., в т. ч. НДС <xsl:value-of select="format-number(document('udata://emarket/summNDS/')/udata, '### ### ### ### ###, 00', 'price')" /> руб.</td>
                <td></td>
                <td class="sum_discount">

                    <div style="display:none;">
                        <xsl:for-each select="document('udata://emarket/cart')/udata/items/item" >
                            <div class="for_count">
                                <xsl:variable name="sizeId" select="page/@id" />
                                <xsl:variable name="count" select="amount * document(concat('upage://', $sizeId, '.pack'))//value" />
                                <xsl:choose>
                                    <xsl:when test="discount/amount">
                                        <xsl:value-of select="discount/amount" />

                                    </xsl:when>
                                </xsl:choose>
                            </div>
                        </xsl:for-each>
                    </div>
                    <div class="ready_discount"></div>
                </td>
            </tr>
        </table>
        <div id="cartFilter">
            <xsl:call-template name="cartButtons" />
            <label>
                Размер
                <select id="sizeSelect">
                    <option value="0">Не важно</option>
                    <xsl:apply-templates select="document('usel://select/119/')/udata/item" mode="select">
                        <xsl:sort select="@name" order="ascending" />
                    </xsl:apply-templates>
                </select>
            </label>
            <label>
                Полотно
                <select id="materialSelect">
                    <option value="0">Не важно</option>
                    <xsl:apply-templates select="document('usel://select/125/')/udata/item" mode="select">
                        <xsl:sort select="@name" order="ascending" />
                    </xsl:apply-templates>
                </select>
            </label>
        </div>

        <div style="position: relative; min-height: 200px;">
            <div id="tableLoader" style="display: none;">
                <img src="/images/loader-horizontal.gif" alt="Загрузка" />
            </div>
            <div id="tableEmpty">
                нет подходящих товаров
            </div>

            <xsl:variable name="orderId" select="document('udata://emarket/cart')/udata/@id" />
            <form method="post" action="/udata/emarket/recalcCart/" id="cartForm" class="bg">
                <table id="cartTable">
                    <tr id="cartHeader">
                        <th class="thumb">
                            <div>
                                <img src="{$tpl}/img/image_icon.gif" alt="Изображение" class="icon" />
                            </div>
                        </th>
                        <th class="code" field="code">
                            <div>
                                <a href="#">Артикул</a>
                            </div>
                        </th>
                        <th field="name">
                            <div>
                                <a href="#">Наименование</a>
                            </div>
                        </th>
                        <xsl:choose>
                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                                <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                <xsl:choose>
                                    <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                                        <th class="packs" field="packs">
                                            <div>
                                                <a href="#">Упаковок</a>
                                            </div>
                                        </th>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <th class="packs" field="packs">
                                    <div>
                                        <a href="#">Упаковок</a>
                                    </div>
                                </th>
                            </xsl:otherwise>
                        </xsl:choose>
                        <th class="items" field="items">
                            <div>
                                <a href="#">Штук</a>
                            </div>
                        </th>
                        <th class="price" field="price">
                            <div>
                                <a href="#">Цена</a>
                            </div>
                        </th>
                        <th class="totalPrice" field="totalPrice">
                            <div>
                                <a href="#">Стоимость</a>
                            </div>
                        </th>
                        <th class="remove">
                            <div>Удаление</div>
                        </th>
                    </tr>

                    <xsl:apply-templates select="document(concat('udata://emarket/getOrderItemsGroup/', $orderId))/udata/items" mode="newCartItem" >
                        <xsl:with-param name="width_col" select="8" />
                    </xsl:apply-templates>

                </table>
            </form>
        </div>
        <div class="payment-order">
            <span class="green-head">
                Для завершения формирования заказа<br />
                выберите форму оплаты
            </span>
            <form action="/emarket/purchase/payment/choose/do/" method="post" class="form-select-payment">
                <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                    <xsl:choose>
                        <xsl:when test="@manag = '0'">
                            <div class="payment-block">
                                <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                <label class="checkbox button-payment" for="payment{@id}">
                                    <xsl:value-of select="." />
                                </label>
                                <div class="short_desc">
                                    <xsl:value-of select="@short" />
                                </div>
                            </div>
                        </xsl:when>

                    </xsl:choose>
                </xsl:for-each>
                <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                    <xsl:choose>
                        <xsl:when test="@manag = '1'">
                            <div class="minHeight"></div>
                            <span class="green-or">ИЛИ</span>
                            <div class="minHeight"></div>
                            <div class="payment-center-block">
                                <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                <label class="checkbox button-payment" for="payment{@id}">
                                    <xsl:value-of select="." />
                                </label>
                                <div class="short_desc">
                                    <xsl:value-of select="@short" />
                                </div>
                            </div>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>

                <input type="submit" value="Заказать" style="display: none;" />
            </form>
            <span class="back-to-buy">Вернутся к формированию заказа</span>
        </div>
        <div id="cartBottom">
            <xsl:call-template name="cartButtons" />
        </div>
        <!--
        <div id="cartBottom">
            <xsl:call-template name="cartButtons" />
        </div> -->
    </xsl:template>

    <xsl:template name="cartButtons">
        <div class="cartButton">
            <a href="/cart/print/" target="_blank" class="print">Распечатать</a>
            <a href="#recalc" class="recalc">Пересчитать/Удалить</a>
            <xsl:choose>
                <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">

                    <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                    <xsl:choose>
                        <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                            <a href="/emarket/purchase/" class="order">Заказать</a>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <a href="/emarket/purchase/" class="order">Заказать</a>
                </xsl:otherwise>
            </xsl:choose>

        </div>
    </xsl:template>

    <xsl:template match="tr" mode="cartItem">
        <xsl:copy-of select="." />
    </xsl:template>

    <xsl:template match="item" mode="orgItemCartSortDokup" >
        <xsl:param name="order_original_id" />
        <xsl:variable name="pageId" select="@pageId" />
        <xsl:variable name="colorId" select="@colorItemId" />
        <tr>
           <!-- <td></td> -->
            <td><xsl:value-of select="@article" /></td>
            <td><xsl:value-of select="." /></td>

           <!-- <td></td> -->
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><xsl:value-of select="@count" /></td>
            <td class="totalprice-third"><xsl:value-of select="@totalPrice" /></td>

        </tr>
    </xsl:template>


    <xsl:template match="item" mode="orgItemCartSort" >
        <xsl:param name="order_original_id" />
        <xsl:variable name="pageId" select="@pageId" />
        <xsl:variable name="colorId" select="@colorItemId" />
        <xsl:choose>
            <xsl:when test="@dokup = 'yes'">
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@has = 'yes'">
                    </xsl:when>
                    <xsl:otherwise>
                        <tr>
                            <!--<td></td> -->
                            <td><xsl:value-of select="@article" /></td>
                            <td><xsl:value-of select="." /></td>


                            <!--<td></td>-->
                            <td><xsl:value-of select="@count" /></td>
                            <td><xsl:value-of select="@price" /></td>
                            <td class="totalprice-first"><xsl:value-of select="@totalPrice" /></td>
                            <td><xsl:value-of select="@count" /></td>
                            <td class="totalprice-second"><xsl:value-of select="@totalPrice" /></td>

                            <xsl:choose>
                                <xsl:when test="@colorItemId != ''">

                                    <td><xsl:value-of select="../item[contains(@colorItemId, $colorId)][contains(@pageId, $pageId)][contains(@has, 'yes')]/@count" /></td>
                                    <td class="totalprice-third"><xsl:value-of select="../item[contains(@colorItemId, $colorId)][contains(@pageId, $pageId)][contains(@has, 'yes')]/@totalPrice" /></td>

                                </xsl:when>
                                <xsl:otherwise>

                                    <td><xsl:value-of select="../item[contains(@pageId, $pageId)][contains(@has, 'yes')]/@count" /></td>
                                    <td class="totalprice-third"><xsl:value-of select="../item[contains(@pageId, $pageId)][contains(@has, 'yes')]/@totalPrice" /></td>
                                </xsl:otherwise>
                            </xsl:choose>

                        </tr>
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="user" mode="orgItemCart" >
        <xsl:param name="order_original_id" />
        <xsl:choose>
            <xsl:when test="@user_id = 'org_in_order'">
                <xsl:variable name="user_obj" select="document(concat('uobject://', @user_id))/udata" />
                <xsl:variable name="user_adm" select="document(concat('uobject://', $order_original_id))//property[@name = 'customer_id']/value/item/@id" />
                <tr class="header category in_tmp" >
                    <td colspan="5" style="text-transform: none;">Ваши товары</td>
                    <td style="text-align:right;"><xsl:value-of select="sum(item/@totalPrice)" /></td>
                    <td  style="text-align:center;"><input type="checkbox" name="users_item[{@user_id}]" value="{$user_adm}"  /></td>
                    <td></td>
                </tr>
                <xsl:apply-templates select="item" mode="cartItemOrgLocation" />
            </xsl:when>
            <xsl:when test="@user_id != 'org'">
                <xsl:variable name="user_obj" select="document(concat('uobject://', @user_id))/udata" />
                <xsl:variable name="user_adm" select="document(concat('uobject://', $order_original_id))//property[@name = 'customer_id']/value/item/@id" />
                <tr class="header category" id="info-utp" >
                    <td colspan="5" style="text-transform: none;"><xsl:value-of select="$user_obj//property[@name = 'name']/value" /> - <span class="email-utp"><xsl:value-of select="$user_obj//property[@name = 'e-mail']/value" /></span></td>
                    <td style="text-align:right;"><xsl:value-of select="sum(item/@totalPrice)" /></td>
                    <td  style="text-align:center;"><input type="checkbox" name="users_item[{@user_id}]" value="{$user_adm}"  /></td>
                    <td></td>
                </tr>
                <xsl:apply-templates select="item" mode="cartItemOrg" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="user_obj" select="document(concat('uobject://', @user_id))/udata" />
                <xsl:variable name="user_adm" select="document(concat('uobject://', $order_original_id))//property[@name = 'customer_id']/value/item/@id" />
                <tr class="header category in_tmp" >
                    <td colspan="5" style="text-transform: none;">Не распределено между участниками</td>
                    <td style="text-align:right;"><xsl:value-of select="sum(item/@totalPrice)" /></td>
                    <td >Количество</td>
                    <td >УСП</td>
                </tr>
                <xsl:apply-templates select="item" mode="cartItemOrgLocation" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="items" mode="newCartItem">
        <xsl:param name="width_col" />
        <xsl:variable name="categoryId" select="document(concat('udata://custom/getParent/', item/@parentId))/udata" />
        <xsl:variable name="position" select="position()" />
        <xsl:variable name="parentId" select="item/@parentId" />

        <xsl:if test="position() = 1 or ../*[position() = $position - 1]/item/@parentId != $parentId">
            <tr class="header" id="header_{item/@parentId}" parent="{$categoryId}" parentH1="{document(concat('upage://', $categoryId, '.h1'))//value}">
                <td colspan="{$width_col}">
                    <xsl:value-of select="document(concat('upage://', item/@parentId, '.h1'))//value" />
                </td>
            </tr>
        </xsl:if>
        <!--	<xsl:variable name="sizeId" select=".//page/@id" />
        <xsl:variable name="sizeGroupId" select="document(concat('udata://custom/getParent/', .//page/@id))/udata" />
        <xsl:variable name="totalPrice">
                <xsl:choose>
                        <xsl:when test="total-price/actual > 0">
                                <xsl:value-of select="total-price/actual" />
                        </xsl:when>
                        <xsl:otherwise>
                                0
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:variable>
        -->

        <tr>
            <td class="thumb">
                <xsl:if test="item/@imageLink">
                    <a href="{item/@imageLink}" rel="lightbox">
                        <img src="{document(concat('udata://system/makeThumbnailFull/(.', item/@imageLink, ')/30/30/'))//src}" alt="{item}" />
                    </a>
                </xsl:if>
            </td>
            <td>
                <xsl:value-of select="item/@article" />
            </td>
            <td>
                <xsl:value-of select="item" />
            </td>
            <xsl:choose>
                <xsl:when test="item/@RR = 'yes'">
                    <td class="packs">
                        <input type="text" name="amountGroup[{item/@removeId}]" value="{item/@count}" />
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td class="packs">
                        <input type="text" name="amount[{item/@id}]" value="{item/@count}" />
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <td class="items">
                <xsl:value-of select="item/@count * item/@pack" />
            </td>
            <td class="price">
                <xsl:value-of select="format-number(item/@price,'#.#')" />
            </td>
            <td class="totalPrice">
                <xsl:value-of select="format-number(item/@totalPrice,'#.#')" />
            </td>
            <xsl:choose>
                <xsl:when test="$width_col = '8'">
                    <xsl:choose>
                        <xsl:when test="item/@RR = 'yes'">
                            <td class="remove">
                                <input type="hidden" name="removeGroup[{item/@removeId}]" value="0" />
                                <input type="checkbox" name="removeGroup[{item/@removeId}]" value="1" />
                            </td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td class="remove">
                                <input type="hidden" name="remove[{item/@id}]" value="0" />
                                <input type="checkbox" name="remove[{item/@id}]" value="1" />
                            </td>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </tr>
    </xsl:template>

    <xsl:template match="item" mode="preCartItemUtp">
        <xsl:variable name="user_id" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
        <xsl:variable name="item_user_id" select="document(concat('uobject://', @id))//property[@name = 'options']/value/option[@varchar = 'own_user']/object/@id" />
        <xsl:choose>
            <xsl:when test="$user_id = $item_user_id">
                <xsl:apply-templates select="." mode="cartItemUtp" />
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="item" mode="cartItemUtp">
        <xsl:variable name="sizeId" select="page/@id" />
        <xsl:variable name="sizeGroupId" select="document(concat('udata://custom/getParent/', page/@id))/udata" />
        <xsl:variable name="colorIdItem" select="document(concat('uobject://', @id))//property[@name = 'options']/value/option[@varchar = 'colors-item']/object/@id" />
        <xsl:variable name="totalPrice">
            <xsl:choose>
                <xsl:when test="total-price/actual > 0">
                    <xsl:value-of select="total-price/actual" />
                </xsl:when>
                <xsl:otherwise>
                    0
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <tr>

            <td class="thumb">
                <xsl:if test="document(concat('udata://emarket/getImageColorByItemId/', page/@parentId, '/', $colorIdItem))/udata" >
                    <xsl:variable name="image" select="document(concat('udata://emarket/getImageColorByItemId/', page/@parentId, '/', $colorIdItem))/udata" />
                    <a href="{$image}" rel="lightbox">
                        <img src="{document(concat('udata://system/makeThumbnailFull/(.', $image, ')/30/30/'))//src}" />
                    </a>
                </xsl:if>
            </td>
            <td>
                <xsl:value-of select="document(concat('upage://', $sizeGroupId, '.code'))//value" />
            </td>
            <td>
                <xsl:value-of select="document(concat('upage://', $sizeGroupId, '.h1'))//value" /> р. <xsl:value-of select=".//page/name" />
            </td>
            <td class="packs">
                <input type="text" name="amount[{@id}]" value="{amount}" />
            </td>
            <td class="price">
                <xsl:value-of select="format-number(price/actual,'#.#')" />
            </td>
            <td class="totalPrice">
                <xsl:value-of select="$totalPrice" />
            </td>

            <td class="remove">
                <input type="hidden" name="remove[{@id}]" value="0" />
                <input type="checkbox" name="remove[{@id}]" value="1" />
            </td>

        </tr>
    </xsl:template>

    <xsl:template match="item" mode="cartItemOrgLocation">
        <xsl:variable name="sizeId" select="page/@id" />
        <xsl:variable name="sizeGroupId" select="@parentId" />
        <xsl:variable name="totalPrice">
            <xsl:choose>
                <xsl:when test="@totalPrice > 0">
                    <xsl:value-of select="@totalPrice" />
                </xsl:when>
                <xsl:otherwise>
                    0
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--<xsl:value-of select="@id" /> -->
        <tr id="tr-utp">

            <td class="thumb">
                <a href="{@imageLink}" rel="lightbox">
                    <img src="{document(concat('udata://system/makeThumbnailFull/(.', @imageLink, ')/30/30/'))//src}" />
                </a>
            </td>
            <td>
                <xsl:value-of select="@article" />
            </td>
            <xsl:choose>
                <xsl:when test="@colorType = 'yes'" >
                    <td>
                        <xsl:value-of select="." />
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td>
                      <!--  <xsl:value-of select="document(concat('upage://', $sizeGroupId, '.h1'))//value" /> р.  --> <xsl:value-of select="." />
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <td class="packs" style="text-align:center;">

             <!--   <input type="text" name="amount[{@id}]" value="{@count}" /> -->
                <xsl:choose>
                    <xsl:when test="@colorItemId != ''">

                        <input type="text" name="amount[{@pageId}][{@colorItemId}]" value="{@count}" disabled="disabled" />

                    </xsl:when>
                    <xsl:otherwise>

                        <input type="text" name="amount[{@pageId}]" value="{@count}" disabled="disabled" />

                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="price">
                <xsl:value-of select="format-number(@price,'#.#')" />
            </td>
            <td class="totalPrice">
                <xsl:value-of select="$totalPrice" />
            </td>

            <xsl:choose>
                <xsl:when test="@orgItem = 'yes'" >
                    <xsl:choose>
                        <xsl:when test="@colorItemId != ''">
                            <td class="inOrder" style="text-align:center;">
                                <input type="text" name="utp[count][{@pageId}][{@colorItemId}][ready]" class="count-usp" style="width:50px;" />
                            </td>
                            <td class="select-utp">
                                <select style="width:120px;" name="utp[select][{@pageId}][{@colorItemId}]">
                                    <xsl:value-of select="document('udata://users/getUspUsers')/udata" disable-output-escaping="yes" />
                                </select>
                            </td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td class="inOrder" style="text-align:center;">
                                <input type="text" name="utp[count][{@pageId}][ready]" class="count-usp" style="width:50px;" />
                            </td>
                            <td class="select-utp">
                                <select style="width:120px;" name="utp[select][{@pageId}]">
                                    <xsl:value-of select="document('udata://users/getUspUsers')/udata" disable-output-escaping="yes" />
                                </select>
                            </td>

                        </xsl:otherwise>
                    </xsl:choose>
                        <!--
                        <xsl:choose>
                            <xsl:when test="@colorItemId != ''">
                                <a href="/emarket/purchaseGoodOrg/{@pageId}/{@count}/{@colorItemId}" title="Данные товар будет привязан к Вам">Заказать!</a>

                            </xsl:when>
                            <xsl:otherwise>
                                <a href="/emarket/purchaseGoodOrg/{@pageId}/{@count}" title="Данные товар будет привязан к Вам">Заказать!</a>
                            </xsl:otherwise>
                        </xsl:choose>
                        -->
                </xsl:when>
                <xsl:when test="@itemOrderId != ''">
                    <input name="orgUserId" type="hidden">
                        <xsl:attribute name="value">
                            <xsl:value-of select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                        </xsl:attribute>
                    </input>
                    <xsl:choose>
                        <xsl:when test="@colorItemId != ''">
                            <td class="inOrder" style="text-align:center;">
                                <input type="text" name="org[count][{@itemOrderId}][{@colorItemId}][ready]" class="count-usp" style="width:50px;" />
                            </td>
                            <td class="select-utp">
                                <select style="width:120px;" name="org[select][{@itemOrderId}][{@colorItemId}]">
                                    <xsl:value-of select="document('udata://users/getUspUsers')/udata" disable-output-escaping="yes" />
                                </select>
                            </td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td class="inOrder" style="text-align:center;">
                                <input type="text" name="org[count][{@itemOrderId}][ready]" class="count-usp" style="width:50px;" />
                            </td>
                            <td class="select-utp">
                                <select style="width:120px;" name="org[select][{@itemOrderId}]">
                                    <xsl:value-of select="document('udata://users/getUspUsers')/udata" disable-output-escaping="yes" />
                                </select>
                            </td>

                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </tr>
    </xsl:template>

    <xsl:template match="item" mode="cartItemOrg">
        <xsl:variable name="sizeId" select="page/@id" />
        <xsl:variable name="sizeGroupId" select="@parentId" />
        <xsl:variable name="totalPrice">
            <xsl:choose>
                <xsl:when test="@totalPrice > 0">
                    <xsl:value-of select="@totalPrice" />
                </xsl:when>
                <xsl:otherwise>
                    0
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--<xsl:value-of select="@id" /> -->
        <tr>

            <td class="thumb">
                <a href="{@imageLink}" rel="lightbox">
                    <img src="{document(concat('udata://system/makeThumbnailFull/(.', @imageLink, ')/30/30/'))//src}" />
                </a>
            </td>
            <td>
                <xsl:value-of select="@article" />
            </td>
            <xsl:choose>
                <xsl:when test="@colorType = 'yes'" >
                    <td>
                        <xsl:value-of select="." />
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td>
                      <!--  <xsl:value-of select="document(concat('upage://', $sizeGroupId, '.h1'))//value" /> р.  --> <xsl:value-of select="." />
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <td class="packs" style="text-align:center;">

             <!--   <input type="text" name="amount[{@id}]" value="{@count}" /> -->
                <xsl:choose>
                    <xsl:when test="@itemOrderId != ''">

                        <input type="text" name="amount[{@itemOrderId}]" value="{@count}" />

                    </xsl:when>
                    <xsl:otherwise>

                        <input type="text" name="amount[{@id}]" value="{@count}" />

                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="price">
                <xsl:value-of select="format-number(@price,'#.#')" />
            </td>
            <td class="totalPrice">
                <xsl:value-of select="$totalPrice" />
            </td>


            <xsl:choose>
                <xsl:when test="@orgItem = 'yes'" >
                    <td class="inOrder" style="text-align:center;">
                        <xsl:choose>
                            <xsl:when test="@colorItemId != ''">
                                <a href="/emarket/purchaseGoodOrg/{@pageId}/{@count}/{@colorItemId}" title="Данные товар будет привязан к Вам">Заказать!</a>

                            </xsl:when>
                            <xsl:otherwise>
                                <a href="/emarket/purchaseGoodOrg/{@pageId}/{@count}" title="Данные товар будет привязан к Вам">Заказать!</a>
                            </xsl:otherwise>
                        </xsl:choose>

                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="@itemOrderId != ''">
                            <td class="remove">
                                <input type="hidden" name="remove[{@itemOrderId}]" value="0" />
                                <input type="checkbox" name="remove[{@itemOrderId}]" value="1" />
                            </td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td class="remove">
                                <input type="hidden" name="remove[{@id}]" value="0" />
                                <input type="checkbox" name="remove[{@id}]" value="1" />
                            </td>
                        </xsl:otherwise>

                    </xsl:choose>

                </xsl:otherwise>
            </xsl:choose>
            <td></td>

        </tr>
    </xsl:template>


    <xsl:template match="item" mode="cartItem">
        <xsl:variable name="sizeId" select=".//page/@id" />
        <xsl:variable name="sizeGroupId" select="document(concat('udata://custom/getParent/', .//page/@id))/udata" />
        <xsl:variable name="totalPrice">
            <xsl:choose>
                <xsl:when test="total-price/actual > 0">
                    <xsl:value-of select="total-price/actual" />
                </xsl:when>
                <xsl:otherwise>
                    0
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <tr>
            <td>
                <xsl:value-of select="document(concat('upage://', $sizeGroupId, '.code'))//value" />
            </td>
            <td>
                <xsl:value-of select="document(concat('upage://', $sizeGroupId, '.h1'))//value" /> р. <xsl:value-of select=".//page/name" />
            </td>
            <td class="packs">
                <input type="text" name="amount[{@id}]" value="{amount}" />
            </td>

            <td class="items">
                <xsl:value-of select="amount * document(concat('upage://', $sizeId, '.pack'))//value" />
            </td>
            <td class="price">
                <xsl:value-of select="format-number(price/actual,'#.#')" />
            </td>
            <td class="totalPrice">
                <xsl:value-of select="$totalPrice" />
            </td>
            <td class="remove">
                <input type="hidden" name="remove[{@id}]" value="0" />
                <input type="checkbox" name="remove[{@id}]" value="1" />
            </td>

        </tr>
    </xsl:template>


    <!--Каталог-->



    <xsl:template match="result[(@module = 'catalog' and @method = 'category')
							or page/@link = '/categories/new_items/'
							or page/@link = '/categories/hits/'
							or page/@link = '/categories/visited/'
							or page/@link = '/categories/recommend/'
							or page/@link = '/favorites/'
							or (count(parents/page) = 1 and
								(starts-with(page/@link, '/collections/')
								or starts-with(page/@link, '/promo/')))
							]">

        <xsl:choose>
            <xsl:when test="page[@type-id = '118']">
                <div id="goodInfo" goodId="{page/@id}">
                    <xsl:variable name="tpl" select="string('/templates/triko')" />
                    <xsl:variable name="collectionLink" select="document(concat('usel://in_collections/', page/@id))//page/@link" />
                    <div id="goodLabels">
                        <xsl:if test="document(concat('udata://emarket/price/', page/@id))/udata/price/original > 0">
                            <img src="{$tpl}/img/label_sale.png" alt="Распродажа" />
                        </xsl:if>

                        <xsl:if test="page//property[@name = 'new']/value = 1">
                            <a href="/categories/new_items/">
                                <img src="{$tpl}/img/label_new.png" alt="Новинка" />
                            </a>
                        </xsl:if>

                        <xsl:if test="document(concat('usel://in_collections/', page/@id))//page">

                            <a href="{$collectionLink}">
                                <img src="{$tpl}/img/label_ppl.png" alt="В коллекции" />
                            </a>
                        </xsl:if>

                        <xsl:if test="page//property[@name = 'hit']/value = 1">
                            <a href="/categories/hits/">
                                <img src="{$tpl}/img/label_hit.png" alt="Хит" />
                            </a>
                        </xsl:if>

                    </div>

                    <xsl:choose>
                        <xsl:when test="page//property[@name = 'sale_size_rows']/value">
                            <div id="goodImages">
                                <div id="goodBigImage" class="colors-size">
                                    <xsl:call-template name="bigImageGroup" />

                                    <div id="goodSmallImages">
                                        <xsl:apply-templates select="document(concat('udata://emarket/getImageWithColorFromItem/', page/@id))/udata/image_color" mode="smallImageGroup" />
                                    </div>

                                </div>

                                <ul class="color-ul" id="numImage">
                                    <xsl:apply-templates select="document(concat('udata://emarket/getImageWithColorFromItem/', page/@id, '/', 'true'))/udata/image_color" mode="numImageGroup" />

                                </ul>
                            </div>

                            <div id="goodCaption">
                                <div class="prev">
                                    <a href="#prev"><!--<img src="{$tpl}/img/arrow_prev.png" alt="prev" />--></a>
                                </div>
                                <div class="next">
                                    <a href="#next"><!--<img src="{$tpl}/img/arrow_next.png" alt="next" />--></a>
                                </div>
                                <div class="info">
                                    <a  class="toFavorites">
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="@link" />
                                        </xsl:attribute>
                                        <div class="article">
                                            <xsl:value-of select="page//property[@name = 'code']/value" />
                                        </div>
                                        <div class="label">
                                            <xsl:value-of select="name" />
                                        </div>
                                        <!--<a  class="toFavorites"> -->
                                    </a>
                                </div>
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <div id="goodImages">
                                <div id="goodBigImage">
                                    <xsl:call-template name="bigImage" />
                                    <div id="goodSmallImages">
                                        <xsl:apply-templates select="page//property[starts-with(page/@name, 'image_')]/value" mode="smallImage" />
                                    </div>
                                </div>
                                <ul class="numImage" id="numImage">
                                    <xsl:apply-templates select="page//property[starts-with(page/@name, 'image_')]/value" mode="numImage" />
                                </ul>
                            </div>

                            <div id="goodCaption">
                                <div class="prev">
                                    <a href="#prev"><!--<img src="{$tpl}/img/arrow_prev.png" alt="prev" />--></a>
                                </div>
                                <div class="next">
                                    <a href="#next"><!--<img src="{$tpl}/img/arrow_next.png" alt="next" />--></a>
                                </div>
                                <div class="info">
                                    <a  class="toFavorites">
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="@link" />
                                        </xsl:attribute>
                                        <div class="article">
                                            <xsl:value-of select="page//property[@name = 'code']/value" />
                                        </div>
                                        <div class="label">
                                            <xsl:value-of select="page//property[@name = 'h1']/value" />
                                        </div>
                                        <!--<a  class="toFavorites"> -->

                                    </a>
                                </div>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>



                    <div class="priceWrap">

                        <div class="goodTab" id="goodTab">
                            <a href="#goodTab1" class="active">Заказ<span></span></a>
                            <a href="#goodTab2">Описание<span></span></a>
                        </div>
                        <div id="goodPrice">
                            <a href="#favorites" class="toFavorites">
                                <xsl:choose>
                                    <xsl:when test="document(concat('udata://custom/isFavorite/', page/@id))//result = 1">
                                        <xsl:attribute name="fav">
                                            <xsl:text>true</xsl:text>
                                        </xsl:attribute>
                                        В избранном
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="fav">
                                            <xsl:text>false</xsl:text>
                                        </xsl:attribute>
                                        В избранное
                                    </xsl:otherwise>
                                </xsl:choose>

                            </a>
                            Цена: <span class="price">
                                <xsl:apply-templates select="document(concat('udata://emarket/price/', page/@id))/udata" mode="good" />
                            </span>
                        </div>
                    </div>
                    <div id="goodTab1">
                        <xsl:choose>
                            <xsl:when test="page//property[@name = 'sale_size_rows']/value">

                                <table id="goodSizes">
                                    <tr>
                                        <th>Цвета</th>
                                        <xsl:choose>
                                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                                <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                                <xsl:choose>
                                                    <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value and document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                                                        <th class="amount">Упак.</th>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <th class="amount">Упак.</th>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <th class="pieces">Штуки</th>
                                        <th class="order">Шт. в заказе</th>
                                    </tr>

                                    <tbody>
                                        <xsl:choose>
                                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                                <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                                <xsl:variable name="delete_type" select="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value" />

                                                <xsl:choose>
                                                    <xsl:when test="$delete_type and document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">

                                                        <xsl:apply-templates select="document(concat('udata://emarket/getSizeColorsItem/', page/@id))/udata" mode="size-colors">
                                                            <xsl:with-param name="parentId" select="page/@id" />
                                                        </xsl:apply-templates>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <tr>
                                                            <td class="utp" colspan="3" >
                                                                <div class="styled-select green rounded">
                                                                    <select name="typecolor" >
                                                                        <xsl:apply-templates select="document(concat('udata://emarket/getSizeColorsItem/', page/@id))/udata" mode="utp-option-size-colors">
                                                                            <xsl:with-param name="parentId" select="page/@id" />
                                                                        </xsl:apply-templates>
                                                                    </select>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <xsl:apply-templates select="document(concat('udata://emarket/getSizeColorsItem/', page/@id))/udata" mode="utp-size-colors">
                                                            <xsl:with-param name="parentId" select="page/@id" />
                                                        </xsl:apply-templates>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>

                                                <xsl:apply-templates select="document(concat('udata://emarket/getSizeColorsItem/', page/@id))/udata" mode="size-colors">
                                                    <xsl:with-param name="parentId" select="page/@id" />
                                                </xsl:apply-templates>
                                            </xsl:otherwise>
                                        </xsl:choose>

                                    </tbody>
                                </table>

                            </xsl:when>
                            <xsl:otherwise>

                                <table id="goodSizes">
                                    <tr>
                                        <th>Размеры</th>

                                        <xsl:choose>
                                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                                <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />

                                                <xsl:choose>
                                                    <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value and document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                                                        <th class="amount">Упак.</th>
                                                    </xsl:when>
                                                </xsl:choose>

                                            </xsl:when>
                                            <xsl:otherwise>
                                                <th class="amount">Упак.</th>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <th class="pieces">Штуки</th>
                                        <th class="order">Шт. в заказе</th>
                                    </tr>
                                    <tbody>
                                        <xsl:choose>
                                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                                                <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                                <xsl:choose>
                                                    <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                                                        <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', page/@id, '/1/'))//item" mode="sizes">
                                                            <xsl:sort select="." order="ascending" />
                                                        </xsl:apply-templates>
                                                    </xsl:when>
                                                    <xsl:otherwise>

                                                        <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', page/@id, '/1/'))//item" mode="utpSizes">
                                                            <xsl:sort select="." order="ascending" />
                                                        </xsl:apply-templates>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                                <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', page/@id, '/1/'))//item" mode="orgSizes">
                                                    <xsl:sort select="." order="ascending" />
                                                </xsl:apply-templates>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', page/@id, '/1/'))//item" mode="sizes">
                                                    <xsl:sort select="." order="ascending" />
                                                </xsl:apply-templates>
                                            </xsl:otherwise>
                                        </xsl:choose>

                                    </tbody>
                                </table>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                            <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                <xsl:variable name="userOrgId" select="document('udata://users/getIdOptUser/')/udata" />
                                <input type="hidden" name="emailOrg" class="emailOrg" >
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="document(concat('uobject://', $userOrgId))//property[@name = 'e-mail']/value" />
                                    </xsl:attribute>
                                </input>

                                <input type="hidden" name="phoneOrg" class="phoneOrg" >
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="document(concat('uobject://', $userOrgId))//property[@name = 'phone']/value" />
                                    </xsl:attribute>
                                </input>
                            </xsl:when>
                        </xsl:choose>
                    </div>
                    <div id="goodTab2">
                        <dl id="goodDetails">
                            <dt>Полотно:</dt>
                            <dd>
                                <xsl:value-of select="//property[@name = 'material']/value/item/@name" />
                            </dd>

                            <dt>Описание:</dt>
                            <dd>
                                <xsl:value-of select="//property[@name = 'descr']/value" disable-output-escaping="yes" />
                            </dd>

                            <xsl:apply-templates select="document(concat('usel://in_collections/', page/@id))/udata" mode="inCollections">
                                <xsl:with-param name="id" select="page/@id" />
                            </xsl:apply-templates>
                        </dl>
                    </div>
                    <div class="myOrder" id="myOrder">
                        Мой заказ
                        <span>
                            <xsl:choose>
                                <xsl:when test="document('udata://emarket/cart/')/udata/summary/price/actual">
                                    <xsl:value-of select="document('udata://emarket/cart/')/udata/summary/price/actual" />
                                </xsl:when>
                                <xsl:otherwise>
                                    0
                                </xsl:otherwise>
                            </xsl:choose>

                        </span> руб.
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="goodInfo"></div>
            </xsl:otherwise>
        </xsl:choose>


        <div id="goods">
            <div id="filter">
                <label style="margin-top:-2px;">
                    Размер
                    <select id="sizeSelect">
                        <option value="0">Не важно</option>
                        <xsl:apply-templates select="document('usel://select/119/')/udata/item" mode="select">
                            <xsl:sort select="@name" order="ascending" />
                        </xsl:apply-templates>
                    </select>
                </label>
                <label style="margin-left:4%; margin-top:-2px;" class="polotno_lab">
                    Полотно
                    <select id="materialSelect">
                        <option value="0">Не важно</option>
                        <xsl:apply-templates select="document('usel://select/125/')/udata/item" mode="select">
                            <xsl:sort select="@name" order="ascending" />
                        </xsl:apply-templates>
                    </select>
                </label>
                <!--<div class="sort" field="create_date"><a href="#">Новизна</a></div>
                <div class="sort" field="popularity"><a href="#">Популярность</a></div> -->
                <!--    <input type="checkbox" id="selectPreview" value="1" name="mashuk"  />
<label  class="preview_foto_lab" for="selectPreview" > <span class="text_table_foto">Таблица с фото</span>
                </label> -->
                <label style="margin-top:-2px; margin:left:-2px;">
                    <input type="checkbox" id="selectPreview" value="1" name="mashuk"  />
                    <span class="text_label">Таблица с фото</span>
                </label>

                <div style="clear: both"></div>
            </div>

            <div id="table" style="height:1000px;">
                <xsl:choose>
                    <xsl:when test="page[@type-id = '118']">
                        <xsl:attribute name="class">new_view_table</xsl:attribute>
                        <xsl:attribute name="style">visibility:visible</xsl:attribute>
                    </xsl:when>


                </xsl:choose>
                <script type="text/javascript">
                    var base = '/usel/all_goods/?transform=goods.xsl';
                    var carouselAct = '';

                    <xsl:choose>
                        <xsl:when test="page/@link = '/categories/new_items/'">
                            base += '<xsl:text disable-output-escaping="yes">&amp;</xsl:text>new=1';
                            carouselAct = '0';
                        </xsl:when>
                        <xsl:when test="page/@link = '/categories/hits/'">
                            base += '<xsl:text disable-output-escaping="yes">&amp;</xsl:text>hit=1';
                            carouselAct = '1';
                        </xsl:when>
                        <xsl:when test="page/@link = '/favorites/'">
                            base = '/udata/custom/getFavorites/?transform=goods.xsl';
                        </xsl:when>
                        <xsl:when test="page/@link = '/categories/visited/'">
                            base = '/udata/custom/getVisited/?transform=goods.xsl';
                            carouselAct = '3';
                        </xsl:when>
                        <xsl:when test="page/@link = '/categories/recommend/'">
                            //base = '/udata/custom/getVisited/?transform=goods.xsl';
                            base = '/udata/custom/getRecommend/<xsl:value-of select="$recommend_to" />/?transform=goods.xsl';
                            carouselAct = '2';
                        </xsl:when>
                        <xsl:when test="starts-with(page/@link, '/collections/')">
                            base = '/udata/custom/getCollections/<xsl:value-of select="page/@id" />/?transform=goods.xsl';
                            //base = '/usel/in_collections/<xsl:value-of select="page/@id" />/?transform=goods.xsl';
                        </xsl:when>
                        <xsl:when test="starts-with(page/@link, '/promo/')">
                            base = '/udata/custom/getPromo/<xsl:value-of select="page/@id" />/?transform=goods.xsl';
                        </xsl:when>
                        <xsl:otherwise>
                            cat = '<xsl:value-of select="page/@link" />';
                        </xsl:otherwise>
                        <xsl:when test="page[@type-id = '118']">
                            edfsdf
                            alert('key');
                            newcat = '<xsl:value-of select="page/@link" />';
                        </xsl:when>
                    </xsl:choose>

                    <xsl:if test="$start_good > 0">
                        startGood = <xsl:value-of select="$start_good" />;
                    </xsl:if>

                </script>

                <div style="position: relative; min-height: 210px;">
                    <div id="tableLoader">
                        <img src="/images/loader-horizontal.gif" alt="Загрузка" />
                    </div>
                    <xsl:choose>
                        <xsl:when test="page[@type-id != '118']">
                            <div id="tableEmpty">
                                нет подходящих товаров
                            </div>
                        </xsl:when>
                    </xsl:choose>
                    <table>
                        <xsl:choose>
                            <xsl:when test="page[@type-id = '118']">
                                <xsl:attribute name="class">visib_new</xsl:attribute>
                            </xsl:when>
                        </xsl:choose>
                        <tr id="tableHeader">
                            <th class="code" field="code">
                                <div>
                                    <a href="#">Артикул</a>
                                </div>
                            </th>
                            <th class="name" field="name">
                                <div>
                                    <a href="#">Наименование</a>
                                </div>
                            </th>
                            <th class="size" field="sizes">
                                <div>
                                    <a href="#">Раз.гр.</a>
                                </div>
                            </th>
                            <th class="price" field="price">
                                <div>
                                    <a href="#">Цена</a>
                                </div>
                            </th>
                        </tr>

                        <xsl:choose>
                            <xsl:when test="page[@type-id = '118']">
                                <tr class="spacer">
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <xsl:variable name="categoryId" select="document(concat('udata://custom/getParent/', page/@parentId))/udata" />

                                <tr class="header"  >
                                    <td colspan="4">
                                        <xsl:value-of select="document(concat('upage://', $categoryId, '.h1'))//value" /> > <xsl:value-of select="document(concat('upage://', page/@parentId, '.h1'))//value" />
                                    </td>
                                </tr>

                                <tr id="tr{page/@id}" class="good">
                                    <div class="preview_image">
                                        <img class="img_production">
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="//property[@name = 'image_1']/value" />
                                            </xsl:attribute>
                                        </img>

                                    </div>
                                    <td class="code">
                                        <a href="#{page/@id}" pageId="{page/@id}">
                                            <xsl:value-of select="document(concat('upage://', page/@id, '.code'))//value" />
                                        </a>
                                    </td>
                                    <td>
                                        <a href="#{page/@id}" pageId="{page/@id}">
                                            <xsl:value-of select="document(concat('upage://', page/@id, '.h1'))//value" />
                                        </a>
                                    </td>
                                    <td class="prices">
                                        <a href="#{page/@id}" pageId="{page/@id}">
                                            <xsl:value-of select="document(concat('upage://', page/@id, '.sizes'))//value" />
                                        </a>
                                    </td>
                                    <td class="price">
                                        <a href="#{page/@id}" pageId="{page/@id}">
                                            <xsl:apply-templates select="document(concat('udata://emarket/price/', page/@id))/udata" mode="catalog" />
                                        </a>
                                    </td>
                                </tr>
                            </xsl:when>

                        </xsl:choose>
                    </table>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="udata" mode="inCollections">
    </xsl:template>

    <xsl:template match="udata" mode="size-colors">
        <xsl:apply-templates select="colors" mode="colors-item" />
    </xsl:template>

    <xsl:template match="udata" mode="utp-size-colors">
        <xsl:apply-templates select="colors" mode="utp-colors-item" />
    </xsl:template>

    <xsl:template match="udata" mode="utp-option-size-colors">
        <xsl:apply-templates select="colors" mode="utp-option-colors-item" />
    </xsl:template>

    <xsl:template match="colors" mode="utp-option-colors-item">
        <option value="{@id_color}">
            <xsl:if test="position() = 1">
                <xsl:attribute name="selected" >
                    <xsl:text>selected</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="@name" />
        </option>
    </xsl:template>

    <xsl:template match="colors" mode="utp-colors-item">
        <xsl:variable name="type_user" select="document(concat('udata://users/getIdOptUser/', 'true'))/udata" />
        <xsl:choose>
            <xsl:when test="$type_user = 'utp'">
                <xsl:apply-templates select="color" mode="utp-color-select" />
            </xsl:when>
            <xsl:otherwise >
               <xsl:apply-templates select="color" mode="org-color-select" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="color" mode="org-color-select">

        <xsl:variable name="pack" select="1" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="@id" />

        <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />

        <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />

        <xsl:variable name="user_now_id" select="document('udata://users/getIdOptUser/true/true')/udata" />

      <!--  <xsl:variable name="id_in_basket" select="$addCart/item[contains(@name, $fullname)]/@id" /> -->

        <xsl:variable name="id_in_basket" select="document(concat('udata://emarket/getItemUserOrgFromBasketByName/', $main_user, '/', $id, '/', .))/udata" />

        <tr id="size_{.}" class="good_size">
            <xsl:attribute name="style">
                <xsl:text>display:none</xsl:text>
            </xsl:attribute>

            <td >
                <span >
                    <xsl:value-of select="document(concat('upage://', @id))/udata/page/name" />
                </span>
            </td>

            <td class="pack">
                <input name="amount"  value="1" />
            </td>

            <input type="hidden" name="pack" class="in_pack" value="1" />
            <input type="hidden" name="userid"  >
                <xsl:attribute name="value">
                    <xsl:value-of select="$user_now_id" />
                </xsl:attribute>
            </input>
            <!--
            <input type="hidden" name="mainid" >
                <xsl:attribute name="value">
                    <xsl:value-of select="$main_user" />
                </xsl:attribute>
            </input> -->
            <input type="hidden" name="id_element" class="elements" >
                <xsl:attribute name="value">
                    <xsl:value-of select="@id" />
                </xsl:attribute>
            </input>
            <input type="hidden" name="orgtype" >
                <xsl:attribute name="value">
                    <xsl:value-of select="1" />
                </xsl:attribute>
            </input>

            <input type="hidden" name="colors-item" class="color_id">
                <xsl:attribute name="value">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </input>

            <!--<xsl:variable name="check" select="document(concat('udata://emarket/getBasketOrderByUserOpt/'))/udata" /> -->
            <td class="button">

                <xsl:variable name="check" select="document('udata://emarket/getCurrentUser')/udata" />
                <a href="#order" id="{$orderId}">
                    <xsl:choose>
                        <xsl:when test="$check = 'good'">
                            <xsl:attribute name="class">
                                <xsl:text>good sizeColors</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="class">
                                <xsl:text>not_auth </xsl:text>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="document(concat('uobject://', $orderId))//property[@name = 'stop_buys']/value">
                        <xsl:attribute name="class">
                            <xsl:text>stoped_buys</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="$id_in_basket != ''">
                            В заказе
                        </xsl:when>
                        <xsl:otherwise>
                            В заказ
                        </xsl:otherwise>
                    </xsl:choose>

                </a>

                <xsl:choose>
                    <xsl:when test="$id_in_basket != ''">
                        <span class="totalPack">
                            <xsl:value-of select="document(concat('uobject://', $id_in_basket))//property[@name = 'item_amount']/value" />
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="totalPack">
                            <span>0</span>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>

            </td>
        </tr>
    </xsl:template>

    <xsl:template match="color" mode="utp-color-select">

        <xsl:variable name="pack" select="1" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="@id" />

        <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />

        <xsl:variable name="type_user" select="document(concat('udata://users/getIdOptUser/', 'true'))/udata" />
        <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />

        <xsl:variable name="user_now_id" select="document('udata://users/getIdOptUser/true/true')/udata" />

      <!--  <xsl:variable name="id_in_basket" select="$addCart/item[contains(@name, $fullname)]/@id" /> -->

        <xsl:variable name="id_in_basket" select="document(concat('udata://emarket/getItemUserFromBasketByName/', $main_user, '/', $id, '/', $user_now_id, '/', .))/udata" />


        <tr id="size_{.}" class="good_size">
            <xsl:attribute name="style">
                <xsl:text>display:none</xsl:text>
            </xsl:attribute>

            <td >
                <span >
                    <xsl:value-of select="document(concat('upage://', @id))/udata/page/name" />
                </span>
            </td>

            <td class="pack">
                <input name="amount"  value="1" />
            </td>

            <input type="hidden" name="pack" class="in_pack" value="1" />
            <input type="hidden" name="userid"  >
                <xsl:attribute name="value">
                    <xsl:value-of select="$user_now_id" />
                </xsl:attribute>
            </input>

            <input type="hidden" name="mainid" >
                <xsl:attribute name="value">
                    <xsl:value-of select="$main_user" />
                </xsl:attribute>
            </input>
            <input type="hidden" name="id_element" class="elements" >
                <xsl:attribute name="value">
                    <xsl:value-of select="@id" />
                </xsl:attribute>
            </input>


            <input type="hidden" name="colors-item" class="color_id">
                <xsl:attribute name="value">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </input>

            <!--<xsl:variable name="check" select="document(concat('udata://emarket/getBasketOrderByUserOpt/'))/udata" /> -->
            <td class="button">

                <xsl:variable name="check" select="document('udata://emarket/getCurrentUser')/udata" />
                <a href="#order" id="{$orderId}">
                    <xsl:choose>
                        <xsl:when test="$check = 'good'">
                            <xsl:attribute name="class">
                                <xsl:text>good sizeColors</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="class">
                                <xsl:text>not_auth </xsl:text>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="document(concat('uobject://', $user_now_id))//property[@name = 'delete_from_buys']/value and $type_user = 'utp'">
                            <xsl:attribute name="class">
                                <xsl:text>not_utp</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:if test="document(concat('uobject://', $orderId))//property[@name = 'stop_buys']/value">
                        <xsl:attribute name="class">
                            <xsl:text>stoped_buys</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="$id_in_basket != ''">
                            В заказе
                        </xsl:when>
                        <xsl:otherwise>
                            В заказ
                        </xsl:otherwise>
                    </xsl:choose>

                </a>

                <xsl:choose>
                    <xsl:when test="$id_in_basket != ''">
                        <span class="totalPack">
                            <xsl:value-of select="document(concat('uobject://', $id_in_basket))//property[@name = 'item_amount']/value" />
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="totalPack">
                            <span>0</span>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="colors" mode="colors-item">
        <xsl:variable name="pack" select="@count" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="color/@id" />
        <xsl:variable name="color_name" select="color/../@name" />
        <!-- <xsl:variable name="addCart" select="document('udata://emarket/cart')//item" /> -->
        <xsl:variable name="orderId" select="document('udata://emarket/cart')/udata/@id" />

        <xsl:choose>
            <xsl:when test="color">

                <tr id="size_{@id}" class="good_size">

                    <td class="cursorImage">
                        <span class="arrow-blue">
                            <xsl:if test="position() = 1">
                                <xsl:attribute name="style" >
                                    <xsl:text>display:block;</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                        </span>
                        <span class="get-image" id="color_{color}">
                            <xsl:if test="position() = 1">
                                <xsl:attribute name="class" >
                                    <xsl:text>get-image active-color</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:value-of select="@name" />
                        </span>
                    </td>
                    <!--
                    <xsl:choose>
                        <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata != 'utp'"> -->
                            <td class="amount-color">
                                <input type="text" name="amount" value="1" />
                            </td>
                            <td class="pack">
                                <span class="in_pack" defvalue="{$pack}">
                                    <xsl:value-of select="$pack" />
                                </span>
                            </td>
                    <!--    </xsl:when>
                        <xsl:otherwise>
                            <td class="pack">
                                <input type="pack" class="in_pack" value="1" />
                            </td>
                            <input type="hidden" name="amount" value="1" />
                        </xsl:otherwise>
                    </xsl:choose> -->



                    <xsl:for-each select="color">
                        <input type="hidden" name="id_element" class="elements" >
                            <xsl:attribute name="value">
                                <xsl:value-of select="@id" />
                            </xsl:attribute>
                        </input>
                    </xsl:for-each>
                    <input type="hidden" name="colors-item" class="color_id">
                        <xsl:attribute name="value">
                            <xsl:value-of select="color" />
                        </xsl:attribute>
                    </input>

                    <td class="button">

                        <xsl:variable name="check" select="document('udata://emarket/getCurrentUser')/udata" />

                        <a href="#order" >
                            <xsl:choose>
                                <xsl:when test="$check = 'good'">
                                    <xsl:attribute name="class">
                                        <xsl:text>good sizeColors</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="class">
                                        <xsl:text>not_auth </xsl:text>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>

                            <!--    <xsl:value-of select="$addCart/item[contains(@itemsId, $id)][contains(@colorName, $colorName)]" /> -->
                            <xsl:if test="$orderId != 'dummy'">
                                <xsl:choose>
                                    <xsl:when test="document(concat('udata://emarket/getOrderItemsGroup/', $orderId))/udata/items/item[contains(@itemsId, $id)][contains(@colorName, $color_name)]">
                                        В заказе
                                    </xsl:when>
                                    <xsl:otherwise>
                                        В заказ
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                            <xsl:if test="$orderId = 'dummy'">
                                В заказ
                            </xsl:if>

                        </a>
                        <xsl:if test="$orderId != 'dummy'">
                            <xsl:choose>
                                <xsl:when test="document(concat('udata://emarket/getOrderItemsGroup/', $orderId))/udata/items/item[contains(@itemsId, $id)][contains(@colorName, $color_name)]">
                                    <span class="totalPack">
                                        <xsl:value-of select="document(concat('udata://emarket/getOrderItemsGroup/', $orderId))/udata/items/item[contains(@itemsId, $id)][contains(@colorName, $color_name)]/../item/@count" />
                                    </span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="totalPack">
                                        <span>0</span>
                                    </span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <xsl:if test="$orderId = 'dummy'">
                            <span class="totalPack">
                                <span>0</span>
                            </span>
                        </xsl:if>
                    </td>
                </tr>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="bigImage">
        <xsl:choose>
            <xsl:when test="page//property[@name = 'image_1']/value">
                <!--<a href="{//property[@name = 'image_1']/value}" rel="lightbox[]"><img src="{document(concat('udata://system/makeThumbnailFull/(.', //property[@name = 'image_1']/value, ')/283/283/'))//src}" alt="{//property[@name = 'h1']/value}" /></a>-->
                <xsl:apply-templates select="//group[@name = 'images']/property[@type = 'img_file']" mode="imageCustom" />
            </xsl:when>
            <xsl:otherwise>
                <!--<div class="noImage">нет изображения</div>-->
                <img src="{$tpl}/img/not_image.jpeg" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="image_color" mode="smallImageGroup">
        <a href="#" >
            <xsl:choose>
                <xsl:when test="info/@colorId">
                    <xsl:attribute name="id">
                        <xsl:text>color_</xsl:text>
                        <xsl:value-of select="info/@colorId" />
                    </xsl:attribute>
                    <img src="{document(concat('udata://system/makeThumbnailFull/(.', info/@imageLink, ')/91/91/0/1'))//src}"  />
                </xsl:when>
            </xsl:choose>

        </a>
    </xsl:template>

    <xsl:template name="bigImageGroup">
        <xsl:choose>
            <xsl:when test="//property[@name = 'image_1']/value">

                <!--<a href="{//property[@name = 'image_1']/value}" rel="lightbox[]"><img src="{document(concat('udata://system/makeThumbnailFull/(.', //property[@name = 'image_1']/value, ')/283/283/'))//src}" alt="{//property[@name = 'h1']/value}" /></a>-->
                <xsl:apply-templates select="document(concat('udata://emarket/getImageWithColorFromItem/', page/@id))/udata/image_color" mode="imageCustomGroup" />
            </xsl:when>
            <xsl:otherwise>
                <!--<div class="noImage">нет изображения</div>-->
                <img src="{$tpl}/img/not_image.jpeg" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="image_color[1]" mode="imageCustomGroup">
        <xsl:choose>
            <xsl:when test="info/@colorId">
                <xsl:variable name="patchImg"  select="info/@imageLink" />
                <a href="{info/@imageLink}" rel="lightbox[]" class="first big">
                    <xsl:attribute name="id">
                        <xsl:text>color_</xsl:text>
                        <xsl:value-of select="info/@colorId" />
                    </xsl:attribute>
                    <img src="{document(concat('udata://system/makeThumbnailFull/(.',$patchImg,')/400/400/'))//src}"  width="283" />
                </a>  <!--  <img src="{$patchImg}" alt="{//property[@name = 'h1']/value}" width="283" /> -->
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="image_color" mode="imageCustomGroup">
        <xsl:choose>
            <xsl:when test="info/@colorId">
                <xsl:variable name="patchImg"  select="info/@imageLink" />
                <a href="{info/@imageLink}" rel="lightbox[]" class="big">
                    <xsl:attribute name="id">
                        <xsl:text>color_</xsl:text>
                        <xsl:value-of select="info/@colorId" />
                    </xsl:attribute>
                    <img src="{document(concat('udata://system/makeThumbnailFull/(.',$patchImg,')/400/400/'))//src}"  width="283" />
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="udata[@module = 'emarket'][@method = 'price']" mode="good">
        <xsl:if test="price/original > 0">
            <span style="text-decoration: line-through;color:red">&#0160;
                <xsl:value-of select="format-number(price/original,'#.0')" />&#0160;
            </span>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:variable name="price_new" select="price/original - price/actual" />

        <xsl:variable name="price_sec" select="$price_new div price/original"/>
        <xsl:variable name="price_thic" select="$price_sec * 100" />
        <span class="orig_price">
            <xsl:value-of select="format-number(price/actual,'#.0')" />
        </span>
        <xsl:if test="price/original > 0">
            <span class="procent_price" style="color: #ff8000; position:relative; "> -<xsl:value-of select="format-number($price_thic,'#')" />% </span>
        </xsl:if>
    </xsl:template>

    <xsl:template match="image_color" mode="numImageGroup">
        <li class="circle-color">
            <xsl:attribute name="style">
                <xsl:text>background:rgb(</xsl:text>
                <xsl:value-of select="info/@rgb" />
                <xsl:text>);</xsl:text>
            </xsl:attribute>
        </li>
    </xsl:template>

    <xsl:template match="property[1]" mode="imageCustom">
        <xsl:variable select="value" name="patchImg" />
        <a href="{value}" rel="lightbox[]" class="first big">
            <img src="{document(concat('udata://system/makeThumbnailFull/(.',$patchImg,')/283/283/'))//src}" alt="{//property[@name = 'h1']/value}" />
        </a>
    </xsl:template>

    <xsl:template match="property" mode="imageCustom">
        <xsl:variable select="value" name="patchImg" />
        <a href="{value}" rel="lightbox[]"  class="big">
            <img src="{document(concat('udata://system/makeThumbnailFull/(.',$patchImg,')/283/283/'))//src}" alt="{//property[@name = 'h1']/value}" />
        </a>
    </xsl:template>


    <xsl:template match="value" mode="smallImage">
        <a href="#">
            <img src="{document(concat('udata://system/makeThumbnailFull/(.', ., ')/91/91/'))//src}" alt="{//property[@name = 'h1']/value}" />
        </a>
    </xsl:template>

    <xsl:template match="value" mode="numImage">
        <li>

        </li>
    </xsl:template>

    <xsl:template match="udata[@module = 'emarket'][@method = 'price']" mode="catalog">
        <xsl:choose>
            <xsl:when test="price/original">
                <xsl:variable name="price_new" select="price/original - price/actual" />

                <xsl:variable name="price_sec" select="$price_new div price/original"/>
                <xsl:variable name="price_thic" select="$price_sec * 100" />
                <div class="sale">-<xsl:value-of select="format-number($price_thic,'#')" />% </div>
                <xsl:value-of select="format-number(price/actual,'#.0')" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="format-number(price/actual,'#.0')" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="item" mode="select">
        <option value="{@id}">
            <xsl:value-of select="@name" />
        </option>
    </xsl:template>




    <!--Новости-->

    <xsl:template name="newsColumn">
        <div id="newsColumnBack"></div>
        <ul id="newsColumn" style="overflow:hidden;">
            <xsl:apply-templates select="document('udata://news/lastlist/(news)/0/12/1/?expire=3600')//item" mode="lastNews" />
        </ul>
    </xsl:template>


    <xsl:template match="result[@module = 'news'][@method = 'rubric']">
        <div class="rss">
            <a href="/data/rss/{page/@id}/">
                <img src="{$tpl}/img/rss.png" />
            </a>
            <a href="/data/rss/{page/@id}/" class="link">RSS-подписка</a>
        </div>

        <xsl:variable name="news" select="document(concat('udata://news/lastlist/', page/@id, '/0/'))/udata" />

        <xsl:if test="page/@alt-name != 'news'">
            <xsl:call-template name="newsColumn" />
        </xsl:if>

        <div id="newsList">
            <ul>
                <xsl:apply-templates select="$news//item" mode="news" />
            </ul>

            <xsl:apply-templates select="document(concat('udata://system/numpages/', $news//total, '/', $news//per_page))/udata" />
        </div>
    </xsl:template>

    <xsl:template match="item" mode="news">
        <li>
            <div class="image">
                <xsl:if test="document(concat('upage://', @id, '.anons_pic'))//value">
                    <a href="{@link}">
                        <img src="{document(concat('udata://system/makeThumbnail/(.', document(concat('upage://', @id, '.anons_pic'))//value, ')/157/(auto)/'))//src}" alt="{.}" />
                    </a>
                </xsl:if>
            </div>
            <xsl:choose>
                <xsl:when test="$result/page/@alt-name = 'news'">
                    <div class="date">
                        <xsl:value-of select="php:function('date', 'd.m.Y', string(@publish_time))" />
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <h2>
                        <a href="{@link}">
                            <xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" />
                        </a>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>



            <xsl:if test="$result/page/@alt-name = 'news'">
                <div class="announce">
                    <xsl:value-of select="document(concat('upage://', @id, '.anons'))//value" disable-output-escaping="yes" />
                    <xsl:value-of select="document(concat('upage://', @id, '.content'))//value" disable-output-escaping="yes" />
                </div>
                <div class="more">
                    <a href="{@link}">подробнее...</a>
                </div>
            </xsl:if>




        </li>
    </xsl:template>

    <xsl:template match="result[@module = 'news'][@method = 'item']">
        <div class="rss" style="padding-bottom:9px;">
            <a href="/data/rss/{page/@parentId}/">
                <img src="{$tpl}/img/rss.png" />
            </a>
            <a href="/data/rss/{page/@parentId}/" class="link">RSS-подписка</a>
        </div>
        <xsl:if test="not(//page[@alt-name = 'news'])">
            <xsl:call-template name="newsColumn" />
        </xsl:if>

        <div id="newsBlock">
            <h1>
                <xsl:value-of select="//property[@name = 'h1']/value" />
            </h1>
            <div id="newsImages">
                <xsl:apply-templates select="//property[starts-with(@name, 'image_')]" mode="newsImage" />
            </div>

            <xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />
            <a href="/news/">Вернуться в ленту новостей</a>
        </div>
    </xsl:template>

    <xsl:template match="property" mode="newsImage">
        <a href="{document(concat('udata://system/makeThumbnail/(.', value, ')/800/(auto)/'))//src}" rel="lightbox[{page/@alt-name}]">
            <img src="{document(concat('udata://system/makeThumbnail/(.', value, ')/157/(auto)/'))//src}" alt="{$page//property[@name = 'h1']/value}" />
        </a>
    </xsl:template>

    <xsl:template match="result[page/@alt-name = 'clients' or page/@alt-name = 'partners' or page/@alt-name = 'useful' or page/@alt-name = 'about']">
        <xsl:value-of select="document(concat('udata://custom/redirectToFirst/', page/@id))" />
    </xsl:template>

    <xsl:template match="result[count(parents/page) = 1][parents/page/@alt-name = 'partners' or parents/page/@alt-name = 'about' or parents/page/@alt-name = 'useful'][@method = 'content']">
        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />
        </div>
    </xsl:template>


    <!--Клиентам-->

    <xsl:template match="result[count(parents/page) = 1][parents/page/@alt-name = 'clients' or parents/page/@alt-name = 'about' ]">
        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />
            <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', page/@id))//item" mode="clientsSubpage" />
        </div>
    </xsl:template>

    <xsl:template match="item" mode="clientsSubpage">
        <div class="subpage">
            <div class="header">
                <span>
                    <xsl:value-of select="." />
                </span>
            </div>
            <div class="text">
                <xsl:value-of select="document(concat('upage://', @id, '.content'))//value" disable-output-escaping="yes" />
            </div>
        </div>
    </xsl:template>


    <!--Размеры-->

    <xsl:template match="result[page/@link = '/useful/sizes/']">
        <xsl:call-template name="newsColumn" />

        <div id="sizes">
            <!--<ul>
                    <xsl:apply-templates select="document(concat('usel://subpages/', page/@id))//page" mode="sizesSubpage" />
            </ul>-->
            <div  class="categoriesS">
                <table>
                    <tbody>
                        <tr>
                            <td>КАТЕГОРИЯ</td>
                            <td>
                                <label>
                                    <select id="categoriesSizes">

                                        <option value="#kinder">новорожденные</option>
                                        <option value="#teen">дети и подростки</option>
                                        <option value="#female">мужчины</option>
                                        <option value="#male">женщины</option>
                                    </select>
                                </label>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <xsl:apply-templates select="document(concat('usel://subpages/', page/@id))//page" mode="sizesSubpageContent" />
        </div>
    </xsl:template>

    <xsl:template match="page" mode="sizesSubpage">
        <li>
            <a href="#{@alt-name}">
                <xsl:value-of select="name" />
            </a>
        </li>
    </xsl:template>

    <xsl:template match="page" mode="sizesSubpageContent">
        <div id="{@alt-name}" class="sizeGroup">
            <table>
                <xsl:apply-templates select="document(concat('udata://custom/showSizes/', @alt-name))//field" mode="sizeField" />
            </table>
        </div>
    </xsl:template>

    <xsl:template match="field" mode="sizeField">
        <tr>
            <td>
                <xsl:value-of select="@title" />
            </td>
            <td>
                <label>
                    <select name="{@name}">
                        <option value="0">-</option>
                        <xsl:apply-templates select="options/option" mode="sizeOption" />
                    </select>
                </label>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="option" mode="sizeOption">
        <option>
            <xsl:value-of select="." />
        </option>
    </xsl:template>


    <!--FAQ-->

    <xsl:template match="result[@module = 'faq'][@method = 'project']">
        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <div id="faq">
                <xsl:apply-templates select="document(concat('udata://faq/project/notemplate/', @id, '/10000/'))//item" mode="faqCategory" />
            </div>
            <a href="./ask/">Задать вопрос</a>
        </div>
    </xsl:template>

    <xsl:template match="result[page/@link = '/useful/faq/ask/']">
        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <h1>
                <xsl:value-of select="//property[@name = 'h1']/value" />
            </h1>

            <xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />

            <xsl:apply-templates select="document('udata://system/listErrorMessages')/udata/items" mode="error" />

            <form method="post" id="questionForm" action="/faq/post_question/" class="restorable">
                <table>
                    <tr>
                        <td>Категория вопроса:</td>
                        <td>
                            <select name="param0">
                                <xsl:apply-templates select="document('udata://faq/project/notemplate/(/useful/faq/)')//item" mode="faqCategoryList" />
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Имя:</td>
                        <td>
                            <input type="text" name="nick" />
                        </td>
                    </tr>
                    <tr>
                        <td>Электронная почта:</td>
                        <td>
                            <input type="text" name="email" />
                        </td>
                    </tr>
                    <tr>
                        <td>Тема:</td>
                        <td>
                            <input type="text" name="title" />
                        </td>
                    </tr>
                    <tr>
                        <td>Вопрос:</td>
                        <td>
                            <textarea name="question"></textarea>
                        </td>
                    </tr>
                    <xsl:apply-templates select="document('udata://system/captcha/')/udata" />
                    <tr>
                        <td colspan="2" class="submit">
                            <input type="submit" class="button" value="Задать вопрос" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </xsl:template>

    <xsl:template match="item" mode="faqCategory">
        <xsl:variable name="questions" select="document(concat('udata://faq/category/notemplate/', @id, '/10000/'))/udata" />

        <xsl:if test="$questions/total > 0">
            <div class="category">
                <h2>
                    <xsl:value-of select="@name" /> (<xsl:value-of select="$questions/total" /> вопрос<xsl:apply-templates select="$questions/total" mode="morpho_male" />)</h2>
                <xsl:apply-templates select="$questions//item" mode="faqQuestion" />
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="item" mode="faqCategoryList">
        <option value="{@id}">
            <xsl:value-of select="@name" />
        </option>
    </xsl:template>

    <xsl:template match="item" mode="faqQuestion">
        <div class="question">
            <h3>
                <xsl:value-of select="question" disable-output-escaping="yes"/>
            </h3>
            <div class="answer">
                <xsl:value-of select="answer" disable-output-escaping="yes"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="result[@module = 'faq'][@method = 'post_question']">
        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <h1>
                <xsl:value-of select="@header" />
            </h1>

            <p>Ваш вопрос успешно отправлен! Мы обязательно вам ответим!</p>
        </div>
    </xsl:template>


    <!--Карта сайта-->

    <xsl:template match="result[count(parents/page) = 0][page/@alt-name = 'sitemap']">
        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <h1>
                <xsl:value-of select="//property[@name = 'h1']/value" />
            </h1>

            <div id="sitemap">
                <xsl:apply-templates select="document('udata://content/sitemap/')/udata/items" mode="sitemap" />
            </div>
        </div>
    </xsl:template>

    <xsl:template match="items" mode="sitemap" />

    <xsl:template match="items[item]" mode="sitemap">
        <ul>
            <xsl:apply-templates select="item" mode="sitemap" />
        </ul>
    </xsl:template>

    <xsl:template match="item" mode="sitemap">
        <li>
            <a href="{@link}">
                <xsl:value-of select="@name" />
            </a>
            <xsl:apply-templates select="items" mode="sitemap" />
        </li>
    </xsl:template>


    <!--Пейджинг-->

    <xsl:template match="udata[@method = 'numpages'][count(items) = 0]" />

    <xsl:template match="udata[@method = 'numpages']">
        <div class="paging">
            <xsl:apply-templates select="toprev_link" />
            <xsl:apply-templates select="items/item" mode="numpages" />
            <xsl:apply-templates select="tonext_link" />
        </div>
    </xsl:template>

    <xsl:template match="item" mode="numpages">
        <a href="{@link}">
            <xsl:value-of select="." />
        </a>
    </xsl:template>

    <xsl:template match="item[@is-active = '1']" mode="numpages">
        <span>
            <xsl:value-of select="." />
        </span>
    </xsl:template>

    <xsl:template match="toprev_link">
        <a class="prev" href="{.}">
            <xsl:text>Предыдущая</xsl:text>
        </a>
    </xsl:template>

    <xsl:template match="tonext_link">
        <a class="next" href="{.}">
            <xsl:text>Следующая</xsl:text>
        </a>
    </xsl:template>


    <!--Страница не найдена-->

    <xsl:template match="result[@module = 'content'][@method = 'notfound']">
        <xsl:variable name="notfoundHeader" select="document('upage://notfound.h1')//value" />
        <xsl:variable name="notfoundText" select="document('upage://notfound.content')//value" />

        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <h1>
                <xsl:value-of select="$notfoundHeader" />
            </h1>

            <xsl:value-of select="$notfoundText" disable-output-escaping="yes" />
        </div>
    </xsl:template>


    <!--Поиск-->

    <xsl:template match="result[@module = 'search'][@method = 'search_do']">
        <xsl:variable name="search-results" select="document('udata://search/search_do/')/udata" />

        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <h1>
                <xsl:value-of select="@header" />
            </h1>

            <xsl:apply-templates select="$search-results"/>
            <xsl:apply-templates select="document(concat('udata://system/numpages/', $search-results/total, '/', $search-results/per_page, '/notemplate/p/3'))/udata" />
        </div>
    </xsl:template>

    <xsl:template match="udata[@module = 'search'][@method = 'search_do'][not(items/item)]">
        <div class="search_message">
            <xsl:text>По запросу </xsl:text>
            <span>&#171;
                <xsl:value-of select="$search_string" />&#187;
            </span>
            <xsl:text> ничего не найдено.</xsl:text>
        </div>
    </xsl:template>

    <xsl:template match="udata[@module = 'search'][@method = 'search_do'][items/item]">
        <div class="search_message">
            <xsl:text>По запросу </xsl:text>
            <span>&#171;
                <xsl:value-of select="$search_string" />&#187;
            </span>
            <xsl:text> найден</xsl:text>
            <xsl:apply-templates select="total" mode="morpho_fem_short_part" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="total" />
            <xsl:text> страниц</xsl:text>
            <xsl:apply-templates select="total" mode="morpho_fem" />
        </div>

        <ol class="search_results">
            <xsl:apply-templates select="items/item" mode="search.results"/>
        </ol>
    </xsl:template>

    <xsl:template match="item" mode="search.results" >

        <xsl:variable name="this" select="document(concat('upage://',@id))/udata" />

        <li>
            <xsl:choose>
                <xsl:when test="$this/page/@type-id=118">
                    <xsl:variable name="parentLink" select="document(concat('upage://',$this/page/@parentId))/udata/page/@link" />
                    <a href="{$parentLink}?start_good={@id}">
                        <xsl:value-of select="@name"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <a href="{@link}">
                        <xsl:value-of select="@name"/>
                    </a>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:value-of select="." disable-output-escaping="yes"/>
        </li>
    </xsl:template>


    <!--Оформление заказа-->

    <xsl:template match="result[@module = 'emarket'][@method = 'purchase']">
        <div id="textBlock">
            <h1>
                <xsl:value-of select="@header" />
            </h1>

            <xsl:apply-templates select="document('udata://emarket/purchase')//purchasing" />
        </div>
    </xsl:template>

    <xsl:template match="purchasing[@stage = 'result' and @step = 'successful']">
        <p>Ваш заказ успешно оформлен. Наш менеджер свяжется с вами в течение 3х часов.</p>
        <p class="alert">
            <strong>Предупреждение!</strong> Письмо-уведомление может попасть в спам.</p>
    </xsl:template>


    <!--Заказы пользователя-->
    <xsl:template match="result[page/@link = '/orders/']">
        <div style="padding: 20px 0;">
            <h1>
                <xsl:value-of select="//property[@name = 'h1']/value" />
            </h1>

            <xsl:apply-templates select="document('udata://emarket/ordersList/')/udata" mode="ordersList" />
        </div>
    </xsl:template>

    <xsl:template match="udata" mode="ordersList">
        <p>Вы еще не сделали ни одного заказа.</p>
    </xsl:template>

    <xsl:template match="udata[items/item]" mode="ordersList">

        <script type="text/javascript">
            $(document).ready(function() {
                var summ = 0;
                $('td.sum_discount div.for_count').each(function(){
                    var text = $(this).text();
                    var cut_text = text.replace(/-/gi, '');
                    if(!!cut_text) {
                        summer = parseInt(cut_text, 10);
                        summ += summer;
                        $(this).parents('tr').find('td.sum_discount div.ready_discount').text(summ+' .руб');
                        summ = 0;
                    }
                });
            });
        </script>
        <div id="ordersList">
            <table>
                <tr>
                    <th>Заказ №</th>
                    <th>Сумма, рублей</th>
                    <th>Сумма скидки</th>
                    <th>Дата</th>
                    <th>Способ оплаты</th>
                    <th>Статус</th>
                    <th class="look"></th>
                </tr>

                <xsl:apply-templates select="//item" mode="ordersList">
                    <!--<xsl:sort select="substring-after(@name, '#')" order="descending" />-->
                    <!--<xsl:sort select="@id" order="descending" />-->
                    <!--<xsl:sort select="@id" order="descending" />-->

                    <xsl:sort order="descending" select="number(@id)" data-type="number"/>
                </xsl:apply-templates>
            </table>

        </div>
    </xsl:template>

    <xsl:template match="item" mode="ordersList">
        <tr>
            <!--<td><xsl:value-of select="format-number(substring-after(@name, '#'), '00000')" /></td>-->
            <td>
                <xsl:value-of select="substring-after(@name, 'Заказ ')" />
            </td>
            <td>
                <xsl:value-of select="document(concat('uobject://', @id, '.total_price'))//value" />
            </td>
            <td class="sum_discount">

                <div style="display:none;">
                    <xsl:for-each select="document(concat('udata://emarket/order/', @id))//items/item" >
                        <div class="for_count">
                            <xsl:choose>
                                <xsl:when test="discount/amount">
                                  <!--  <xsl:variable name="item_discount" select="//property[@name = 'item_discount_id']/value/item/@id" />
                                    <xsl:variable name="modificator" select="document(concat('uobject://', $item_discount))//property[@name = 'discount_modificator_id']/value/item/@id" />
                                    <xsl:variable name="proc" select="document(concat('uobject://', $modificator))//property[@name = 'proc']/value" />
                                    <xsl:value-of select="//property[@name = 'item_total_price']/value * $proc div 100" /> -->
                                    <xsl:value-of select="discount/amount" />
                                </xsl:when>
                            </xsl:choose>
                            <!--
                            <xsl:choose>
                                <xsl:when test="price/original">
                                    <xsl:value-of select="((amount * 5) * price/original) - total-price/actual" />

                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="((amount * 5) * price/actual) - total-price/actual" />

                                </xsl:otherwise>
                            </xsl:choose> -->
                        </div>
                    </xsl:for-each>
                </div>
                <div class="ready_discount"></div>
            </td>
            <td>
                <xsl:value-of select="php:function('date', 'd-m-Y', number(document(concat('uobject://', @id, '.order_date'))//value/@unix-timestamp))" />
            </td>
            <td>
                <xsl:variable name="orderid" select="@id" />
                <xsl:variable name="idpayment" select="document(concat('uobject://', @id))//property[@name = 'payment_id']/value/item/@id" />
                <xsl:choose>
                    <xsl:when test="document(concat('uobject://', $idpayment))//property[@name = 'manager_payment']/value = '1'">
                        <xsl:attribute name="class">
                            <xsl:text>look-new</xsl:text>
                        </xsl:attribute>
                        <a href="#" class="choose-payment">Выбрать</a>

                        <div class="payment-order">
                            <span class="green-head">
                                Для завершения формирования заказа<br />
                                выберите форму оплаты
                            </span>
                            <form action="/emarket/changeStatusPaymentOrder" method="post" class="form-select-payment journal">
                                <xsl:for-each select="document('udata://emarket/getListPayments/')/udata/items/item">
                                    <xsl:choose>
                                        <xsl:when test="@manag = '0'">
                                            <div class="payment-block">
                                                <input type="radio" name="payment-id" class="input-payment" value="{@id}" id="payment{@id}" checked="" />
                                                <label class="checkbox button-payment" for="payment{@id}">
                                                    <xsl:value-of select="." />
                                                </label>
                                                <div class="short_desc">
                                                    <xsl:value-of select="@short" />
                                                </div>
                                            </div>
                                        </xsl:when>

                                    </xsl:choose>
                                </xsl:for-each>
                                <input type="hidden" name="order-id" value="{$orderid}" />

                                <input type="submit" value="Заказать" style="display: none;" />
                            </form>
                            <span class="back-to-buy">Вернутся к формированию заказа</span>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="document(concat('uobject://', @id))//property[@name = 'payment_id']/value/item/@name" />
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:value-of select="document(concat('uobject://', @id, '.status_id'))//value/item/@name" />
            </td>
            <td class="look">
                <a href="/order/?order_id={@id}">Посмотреть заказ</a>
            </td>
        </tr>
    </xsl:template>

    <!--Дефолтная страница-->



    <xsl:template match="result">
        <xsl:variable name="header">
            <xsl:choose>
                <xsl:when test="page">
                    <xsl:value-of select="//property[@name = 'h1']/value" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@header" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <h1>
                <xsl:value-of select="$header" />
            </h1>

            <xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />
        </div>
    </xsl:template>
    <xsl:template match="item" mode="sizes">
        <xsl:variable name="pack" select="document(concat('upage://', @id, '.pack'))//value" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="@id" />
        <xsl:variable name="addCart" select="document('udata://emarket/cart')//item" />

        <xsl:choose>
            <xsl:when test="$takeout=0">
                <tr id="size_{@id}" class="good_size">
                    <td>
                        <xsl:value-of select="." />
                    </td>
                    <td>
                        <input type="text" name="amount" value="1" />
                    </td>
                    <td class="pack">
                        <span class="in_pack" defvalue="{$pack}">
                            <xsl:value-of select="$pack" />
                        </span>
                    </td>
                    <td class="button">
                        <xsl:variable name="check" select="document(concat('udata://emarket/getCurrentUser', '/',@id))//udata" />

                        <xsl:choose>
                            <xsl:when test="$check = 'good'">
                                <xsl:attribute name="class">
                                    <xsl:text>button good</xsl:text>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="class">
                                    <xsl:text>button not_auth</xsl:text>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <a href="#order">
                            <xsl:choose>
                                <xsl:when test="$addCart/page[@id = $id]">
                                    В заказе
                                </xsl:when>
                                <xsl:otherwise>
                                    В заказ
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                        <xsl:choose>
                            <xsl:when test="$addCart/page[@id = $id]">
                                <span class="totalPack">
                                    <xsl:value-of select="$addCart/page[@id = $id]/../amount * $pack" />
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="totalPack">
                                    <span>0</span>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr id="size_{@id}" class="good_size">
                    <td>
                        <xsl:value-of select="." />
                    </td>
                    <td colspan="3">Товара нет на складе</td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
</xsl:stylesheet>