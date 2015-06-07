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
	
	<xsl:variable name="result" select="/result" />
	<xsl:variable name="page" select="/result/page" />
	<xsl:variable name="prelang" select="/result/@pre-lang" />
	<xsl:variable name="lang" select="/result/@lang" />
	<xsl:variable name="cart" select="document('udata://emarket/cart/')/udata" />
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
				
				<title><xsl:value-of select="result/@title" /></title>
				
				<link rel="icon" type="image/png" href="/favicon.png" />
				<link rel="shortcut icon" type="image/png" href="/favicon.png" />
				<link type="text/css" href="{$tpl}/css/jquery.jscrollpane.css" rel="stylesheet" />
				<link type="text/css" href="{$tpl}/css/jquery.selectBox.css" rel="stylesheet" />
				<link type="text/css" href="{$tpl}/css/jquery-ui-1.8.21.custom.css" rel="stylesheet" />
				<link type="text/css" href="{$tpl}/css/prettyPhoto.css" rel="stylesheet" />
				<link type="text/css" href="{$tpl}/css/main.css" rel="stylesheet" />
				<link type="text/css" href="{$tpl}/css/header.css" rel="stylesheet" />
				<link type="text/css" href="{$tpl}/css/content.css" rel="stylesheet" />
				
				<script type="text/javascript" src="/js/jquery/jquery.js"></script>
				<script type="text/javascript" src="{$tpl}/js/jquery.mousewheel.js"></script>
				<script type="text/javascript" src="{$tpl}/js/jquery.jscrollpane.js"></script>
				<script type="text/javascript" src="{$tpl}/js/jquery.selectBox.min.js"></script>
				<script type="text/javascript" src="{$tpl}/js/jquery.placeholder.min.js"></script>
				<script type="text/javascript" src="{$tpl}/js/jquery.prettyPhoto.js"></script>
				<script type="text/javascript" src="{$tpl}/js/jquery-ui-1.8.21.custom.min.js"></script>
				<script type="text/javascript" src="{$tpl}/js/detectmobilebrowser.js"></script>
				<script type="text/javascript" src="{$tpl}/js/touch.js"></script>
				
				<script src="{$tpl}/js/jquery.cookie.js"></script>
				<script type="text/javascript" src="{$tpl}/js/main.js"></script>
				<script type="text/javascript" src="{$tpl}/js/table.js"></script>
				<script type="text/javascript" src="{$tpl}/js/cart.js"></script>
				<script type="text/javascript" src="{$tpl}/js/header.js"></script> 
				<script src="{$tpl}/js/jquery.cookie.js"></script>
				
				<script type="text/javascript" src="/js/guest.js"></script>
				
				<script type="text/javascript" src="http://userapi.com/js/api/openapi.js?49"></script>
				
				<script type="text/javascript">
					VK.init({apiId: 2998473, onlyWidgets: true});
				</script>
			</head>
			<body>
				<div id="wrapper">
				<div class="headerWrap" id="headerWrap">
					<div id="header">
						<div id="logo"><a href="/"><img src="{$tpl}/img/logo.png" alt="Машук"/></a></div>
						<div id="headerInfoWrapper">
							<div id="headerInfo">
								<div class="column" id="headerColumn1">
									<div id="slogan">
										Производство и дистрибуция одежды для детей<br />
										<b>Мы сделали качество доступным</b>
									</div>
									<div id="phoneWrapper">
										<div id="phone">
											<div class="number"><xsl:value-of select="document('upage:///.phone')//value" /></div>
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
												<div class="summary"><span><xsl:value-of select="$summary" /></span> руб.</div>
											</div>									  
										  </xsl:when>
										  <xsl:otherwise>
											<div class="info">
												<a href="/cart/" class="wide"></a>
												<div id="cartImg"></div>
													Мой заказ
												<div class="summary"><span><xsl:value-of select="$summary" /></span> руб.</div>
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
					<div id="breadcrumbs">
						<ul>
							<xsl:if test="not(/result/page/@is-default = 1)">
								<li>									
									<a href="/">Главная</a>
								</li>
							</xsl:if>
							<xsl:apply-templates select="/result/parents/page" mode="breadcrumb" />
							<li class="last"><xsl:value-of select="/result/@header" /></li>
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
							or (count(parents/page) = 1 and
								(starts-with(page/@link, '/collections/')
								or starts-with(page/@link, '/promo/')))
							]">
								<div class="filterBrend" id="filterBrend">
									<span id="showBrend">ФИЛЬТР ПО БРЕНДАМ</span>
									<div class="wrapFilter">
										<label id="brendMashuk">
											<input type="checkbox" id="mashuk_brend"  value="1" name="mashuk" /> Машук
										</label>
										<label id="brendBossa">
											<input type="checkbox" id="bossa_nova_brend" value="1" name="bossa_nova" /> Bossa nova
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
										<xsl:with-param name="text" select="'партнерам'" />
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
									<xsl:apply-templates select="." mode="news" />
									<xsl:apply-templates select="." mode="subMenu" />
									<xsl:apply-templates select="result" />
								</div>
								
								<ul id="carouselMenu">
									<li class="first"><div><a href="#">Новинки</a></div></li>
									<li><div><a href="#">Лидеры продаж</a></div></li>
									<li><div><a href="#">Рекомендованные</a></div></li>
									<li class="last"><div><a href="#">Посещенные</a></div></li>
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
										<div class="recError">Рекомендованные не назначены.</div>
									</ul>
									
									<ul id="carousel_3">
										<xsl:apply-templates select="document('udata://custom/getVisited/')/udata/page" mode="carousel">
											<xsl:with-param name="limiter" select="'visited'" />
										</xsl:apply-templates>										
									</ul>
								</div>
							</div>
						</div>
					</div>
					
					<div id="footer">
						<div id="fishart">Создание сайта <a href="http://fish-art.ru"><img src="{$tpl}/img/fishart.png" alt="Интернет-агентство FishArt" /></a></div>
						<div id="copyright">
							© 2011-2012 Швейная фабрика "Машук"<br />
							<a href="/sitemap/"><img src="{$tpl}/img/sitemap.png" alt="Карта сайта" />Карта сайта</a>
						</div>
						<div id="share">
							<div id="vk_like"></div>
							<script type="text/javascript">
								VK.Widgets.Like("vk_like", {type: "button"});
							</script>
							<iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2F{result/@domain}{result/@request-uri}&amp;send=false&amp;layout=button_count&amp;width=450&amp;show_faces=true&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:180px; height:21px;" allowTransparency="true"></iframe>
							<a href="https://twitter.com/share" class="twitter-share-button" data-lang="ru">Твитнуть</a>
							<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
						</div>
					</div>
				</div>
				<div id="temp"></div>
<!-- Yandex.Metrika counter --><script type="text/javascript">(function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter20045548 = new Ya.Metrika({id:20045548, webvisor:true, clickmap:true, trackLinks:true, accurateTrackBounce:true}); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks");</script><noscript><div><img src="//mc.yandex.ru/watch/20045548" style="position:absolute; left:-9999px;" alt="" /></div></noscript><!-- /Yandex.Metrika counter -->		

<!-- BEGIN JIVOSITE CODE {literal} -->
<script type='text/javascript'>
(function(){ var widget_id = '72541';
var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//code.jivosite.com/script/widget/'+widget_id; var ss = document.getElementsByTagName('script')[0]; ss.parentNode.insertBefore(s, ss);})();</script>
<!-- {/literal} END JIVOSITE CODE -->		
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="leftLink">
		<xsl:param name="link" />
		<xsl:param name="text" />
		
		<li>
			<xsl:if test="(starts-with($page/@link, $link) and not(starts-with($page/@link, '/categories/')))
							or $page/@link = $link">
				<xsl:attribute name="class">
					<xsl:text>active</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<div><div class="noArrow"><a href="{$link}"><xsl:value-of select="$text" /></a></div></div>
		</li>
	</xsl:template>

	<xsl:template match="item" mode="leftMenu">
		<xsl:choose>
			<xsl:when test="starts-with($result/page/@link, @link)">
				<li class="active" catId="{@id}">
					<div><div><a href="{@link}"><xsl:value-of select="@name" /></a></div></div>
					<ul class="leftSubmenu">
						<xsl:apply-templates select="document(concat('udata://content/menu/0/1/(', @link,')/'))//item" mode="leftSubMenu" />
					</ul>
				</li>
			</xsl:when>
			<xsl:otherwise>
				<li><div><div><a href="{@link}"><xsl:value-of select="@name" /></a></div></div></li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="item" mode="leftSubMenu">
		<li><a href="#cat{@id}"><xsl:value-of select="@name" /></a></li>
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
						<xsl:text>active </xsl:text><xsl:value-of select="$mode" />
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
			<a href="{@link}"><xsl:value-of select="name" /></a>
		</li>
	</xsl:template>
	
	<xsl:template match="user">
		<div id="auth">
			<xsl:apply-templates select="/result/user" mode="auth" />
			<form name="login" method="post" action="/users/login_do/">
				<div class="line">
					<input type="text" name="login" placeholder="Логин" />
				</div>
				<div class="lineWrapper">
					<div class="line button">
						<input type="password" name="password" placeholder="Пароль" />
					</div>
					<div class="submit">
						<div><a href="javascript:document.login.submit();">Войти</a></div>
						<!--<input type="image" src="{$tpl}/img/arrow_login.png" onmouseover="loginImg(this, true);" onmouseout="loginImg(this, false);" />-->
					</div>
				</div>
			</form>
			<div class="links">
				<a href="/users/forget/">Забыли пароль?</a><span>|</span><a href="/users/registrate/">Регистрация</a>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="user[@status = 'auth']">
		<xsl:param name="module" />
		<xsl:param name="method" />
		<xsl:param name="pageId" />
		
		<div id="user">
			 <xsl:choose>
			  <xsl:when test="$module='users' and $method='settings'">
				<a href="/users/settings/" class="act">Личные данные</a>
			  </xsl:when>
			  <xsl:otherwise>
				<a href="/users/settings/">Личные данные</a>			  
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
				<a href="{@link}"><xsl:value-of select="." /></a>
			</div>
		</td>
	</xsl:template>
		
	<xsl:template match="udata[@module = 'emarket'][@method = 'price']">
		<xsl:value-of select="format-number(price/actual,'#.0')" /> руб.
		
		
	</xsl:template>
	

<!--Главная-->

	<xsl:template match="result[page/@is-default = '1']">
		<xsl:call-template name="newsColumn" />

		<div>
			<a href="{//property[@name = 'link']/value}"><img src="{document(concat('udata://system/makeThumbnail/(.', //property[@name = 'image']/value, ')/580/'))//src}" alt="{//property[@name = 'alt']/value}" id="mainBanner" /></a>
		</div>
	</xsl:template>
	
	<xsl:template match="item" mode="lastNews">
		<li>
			<div class="date"><xsl:value-of select="php:function('date', 'd.m.Y', string(@publish_time))" /></div>
			<div class="text"><a href="{@link}"><xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" disable-output-escaping="yes" /></a></div>
		</li>
	</xsl:template>
	

<!--Акции-->

	<xsl:template match="result[page/@link = '/promo/' or page/@link = '/collections/']">
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
			<a href="{@link}" class="coll_act"><xsl:value-of select="name" /></a>
			<div><xsl:value-of select="document(concat('upage://', @id, '.content'))//value" disable-output-escaping="yes" /></div>
		</div>
	</xsl:template>
	
	<xsl:template name="promolectionImg">
		<xsl:param name="img" />
		<xsl:param name="header" />
		
		<xsl:variable name="thumb" select="document(concat('udata://system/makeThumbnailFull/(.', $img, ')/243/auto/'))//src" />
		<xsl:variable name="exactImg">
			<xsl:choose>
				<xsl:when test="$thumb">
					<xsl:value-of select="$thumb" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$tpl" /><xsl:text>/img/no_img_wide.png</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<img src="{$exactImg}" alt="{$header}" />
	</xsl:template>
	
	<xsl:template match="result[page/@link = '/order/']">
		<xsl:choose>
			<xsl:when test="not(document(concat('uobject://', $order_id, '.customer_id'))//value/item/@id = user/@id)">
				<div id="textBlock">
					<h1><xsl:value-of select="//property[@name = 'h1']/value" /></h1>
					
					<p>Этот заказ был оформлен не вами, либо вы не вошли в систему.</p>
				</div>				
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="totalPrice" select="document(concat('uobject://', $order_id, '.total_price'))//value" />
		
				<table id="cartInfo">
					<tr>
						<th>Дата</th>
						<th>Сумма, рублей</th>
					</tr>
					<tr>
						<td><xsl:value-of select="php:function('date', 'd-m-Y', number(document(concat('uobject://', $order_id, '.order_date'))//value/@unix-timestamp))" /></td>
						<td><xsl:value-of select="format-number($totalPrice, '### ### ### ### ###, 00', 'price')" /> руб., в т. ч. НДС 
						
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
						<!--<xsl:value-of select="php:function('ceil', string($totalPrice * 0.18 div 1.18 * 100)) div 100" />-->
					</tr>
				</table>
				<div id="cartFilter">
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
							<th class="thumb"><div><img src="{$tpl}/img/image_icon.gif" alt="Изображение" class="icon" /></div></th>
							<th class="code" field="code"><div><a href="#">Артикул</a></div></th>
							<th field="name"><div><a href="#">Наименование</a></div></th>
							<th class="packs" field="packs"><div><a href="#">Упаковок</a></div></th>
							<th class="items" field="items"><div><a href="#">Штук</a></div></th>
							<th class="price" field="price"><div><a href="#">Цена</a></div></th>
							<th class="totalPrice" field="totalPrice"><div><a href="#">Стоимость</a></div></th>
						</tr>
						<xsl:apply-templates select="document(concat('udata://emarket/getOrder/', $order_id, '/?transform=cart.xsl&amp;noremove=1'))/udata/table/tr" mode="cartItem" />
					</table>
				</div>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	

<!--Корзина-->

	<xsl:template match="result[page/@link = '/cart/']">
		<xsl:choose>
			<xsl:when test="$cart//summary/amount = 0">
				<xsl:apply-templates select="." mode="emptyCart" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="fullCart" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="result" mode="emptyCart">
		<div id="textBlock">
			В вашем заказе еще нет товаров.
		</div>
	</xsl:template>
	
	<xsl:decimal-format decimal-separator=',' grouping-separator=' ' name="price" />
	
	<xsl:template match="result" mode="fullCart">
		<table id="cartInfo">
			<tr>
				<th>Дата</th>
				<th>Сумма, рублей</th>
			</tr>
			<tr>
				<td><xsl:value-of select="php:function('date', 'd-m-Y')" /></td>
				<td><xsl:value-of select="format-number($summary, '### ### ### ### ###, 00', 'price')" /> руб., в т. ч. НДС <xsl:value-of select="format-number(document('udata://emarket/summNDS/')/udata, '### ### ### ### ###, 00', 'price')" /> руб.</td>
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
			
			<form method="post" action="/udata/emarket/recalcCart/" id="cartForm">
				<table id="cartTable">
					<tr id="cartHeader">
						<th class="thumb"><div><img src="{$tpl}/img/image_icon.gif" alt="Изображение" class="icon" /></div></th>
						<th class="code" field="code"><div><a href="#">Артикул</a></div></th>
						<th field="name"><div><a href="#">Наименование</a></div></th>
						<th class="packs" field="packs"><div><a href="#">Упаковок</a></div></th>
						<th class="items" field="items"><div><a href="#">Штук</a></div></th>
						<th class="price" field="price"><div><a href="#">Цена</a></div></th>
						<th class="totalPrice" field="totalPrice"><div><a href="#">Стоимость</a></div></th>
						<th class="remove"><div>Удаление</div></th>
					</tr>
					<xsl:apply-templates select="document('udata://emarket/getCart/?transform=cart.xsl')/udata/table/tr" mode="cartItem" />
				</table>
			</form>
		</div>
		
		<div id="cartBottom">
			<xsl:call-template name="cartButtons" />
		</div>
	</xsl:template>
	
	<xsl:template name="cartButtons">
		<div class="cartButton">
			<a href="/cart/print/" target="_blank" class="print">Распечатать</a>
			<a href="#recalc" class="recalc">Пересчитать/Удалить</a>
			<a href="/emarket/purchase/" class="order">Заказать</a>
		</div>
	</xsl:template>
	
	<xsl:template match="tr" mode="cartItem">
		<xsl:copy-of select="." />
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
			<td><xsl:value-of select="document(concat('upage://', $sizeGroupId, '.code'))//value" /></td>
			<td><xsl:value-of select="document(concat('upage://', $sizeGroupId, '.h1'))//value" /> р. <xsl:value-of select=".//page/name" /></td>
			<td class="packs"><input type="text" name="amount_{@id}" value="{amount}" /></td>
			<td class="items"><xsl:value-of select="amount * document(concat('upage://', $sizeId, '.pack'))//value" /></td>
			<td class="price">123<xsl:value-of select="format-number(price/actual,'#.#')" /></td>
			<td class="totalPrice"><xsl:value-of select="$totalPrice" /></td>
			<td class="remove">
				<input type="hidden" id="remove_{@id}" value="0" />
				<input type="checkbox" id="remove_{@id}" value="1" checked="" />
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
		
		<div id="goodInfo"></div>
		
		<div id="goods">
			<div id="filter">
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
				<div class="sort" field="create_date"><a href="#">Новизна</a></div>
				<div class="sort" field="popularity"><a href="#">Популярность</a></div>
				<div style="clear: both"></div>
			</div>
			
			<div id="table" style="height:1000px;">
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
						</xsl:when>						<xsl:otherwise>
							cat = '<xsl:value-of select="page/@link" />';
						</xsl:otherwise>
					</xsl:choose>
					
					<xsl:if test="$start_good > 0">
						startGood = <xsl:value-of select="$start_good" />;
					</xsl:if>
					
				</script>
				<div style="position: relative; min-height: 200px;">
					<div id="tableLoader">
						<img src="/images/loader-horizontal.gif" alt="Загрузка" />
					</div>
					<div id="tableEmpty">
						нет подходящих товаров
					</div>
					
					<table>
						<tr id="tableHeader">
							<th class="code" field="code"><div><a href="#">Артикул</a></div></th>
							<th class="name" field="name"><div><a href="#">Наименование</a></div></th>
							<th class="size" field="sizes"><div><a href="#">Раз.гр.</a></div></th>
							<th class="price" field="price"><div><a href="#">Цены</a></div></th>
						</tr>	
					</table>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="item" mode="select">
		<option value="{@id}"><xsl:value-of select="@name" /></option>
	</xsl:template>
	



<!--Новости-->

	<xsl:template name="newsColumn">
		<div id="newsColumnBack"></div>
		<ul id="newsColumn">
			<xsl:apply-templates select="document('udata://news/lastlist/(news)/0/3/1/?expire=3600')//item" mode="lastNews" />
		</ul>
	</xsl:template>


	<xsl:template match="result[@module = 'news'][@method = 'rubric']">
		<div class="rss"><a href="/data/rss/{page/@id}/"><img src="{$tpl}/img/rss.png" /></a> <a href="/data/rss/{page/@id}/" class="link">RSS-подписка</a></div>
		
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
					<div class="date"><xsl:value-of select="php:function('date', 'd.m.Y', string(@publish_time))" /></div>
				</xsl:when>
				<xsl:otherwise>
					<h2><a href="{@link}"><xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" /></a></h2>
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
		<div class="rss" style="padding-bottom:9px;"><a href="/data/rss/{page/@parentId}/"><img src="{$tpl}/img/rss.png" /></a> <a href="/data/rss/{page/@parentId}/" class="link">RSS-подписка</a></div>	
		<xsl:if test="not(//page[@alt-name = 'news'])">
			<xsl:call-template name="newsColumn" />
		</xsl:if>
		
		<div id="newsBlock">
			<h1><xsl:value-of select="//property[@name = 'h1']/value" /></h1>
			<div id="newsImages">
				<xsl:apply-templates select="//property[starts-with(@name, 'image_')]" mode="newsImage" />
			</div>
			
			<xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />
			<a href="/useful/articles/">Вернуться к списку статей</a>
		</div>
	</xsl:template>
	
	<xsl:template match="property" mode="newsImage">
		<a href="{document(concat('udata://system/makeThumbnail/(.', value, ')/800/(auto)/'))//src}" rel="lightbox[{page/@alt-name}]"><img src="{document(concat('udata://system/makeThumbnail/(.', value, ')/157/(auto)/'))//src}" alt="{$page//property[@name = 'h1']/value}" /></a>
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
			<div class="header"><span><xsl:value-of select="." /></span></div>
			<div class="text"><xsl:value-of select="document(concat('upage://', @id, '.content'))//value" disable-output-escaping="yes" /></div>
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
							<label><select id="categoriesSizes">
								
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
		<li><a href="#{@alt-name}"><xsl:value-of select="name" /></a></li>
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
		<option><xsl:value-of select="." /></option>
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
			<h1><xsl:value-of select="//property[@name = 'h1']/value" /></h1>
			
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
						<td><input type="text" name="nick" /></td>
					</tr>
					<tr>
						<td>Электронная почта:</td>
						<td><input type="text" name="email" /></td>
					</tr>
					<tr>
						<td>Тема:</td>
						<td><input type="text" name="title" /></td>
					</tr>
					<tr>
						<td>Вопрос:</td>
						<td><textarea name="question"></textarea></td>
					</tr>
					<xsl:apply-templates select="document('udata://system/captcha/')/udata" />
					<tr>
						<td colspan="2" class="submit"><input type="submit" class="button" value="Задать вопрос" /></td>
					</tr>
				</table>
			</form>
		</div>
	</xsl:template>
	
	<xsl:template match="item" mode="faqCategory">
		<xsl:variable name="questions" select="document(concat('udata://faq/category/notemplate/', @id, '/10000/'))/udata" />
		
		<xsl:if test="$questions/total > 0">
			<div class="category">
				<h2><xsl:value-of select="@name" /> (<xsl:value-of select="$questions/total" /> вопрос<xsl:apply-templates select="$questions/total" mode="morpho_male" />)</h2>
				<xsl:apply-templates select="$questions//item" mode="faqQuestion" />
			</div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="item" mode="faqCategoryList">
		<option value="{@id}"><xsl:value-of select="@name" /></option>
	</xsl:template>
	
	<xsl:template match="item" mode="faqQuestion">
		<div class="question">
			<h3><xsl:value-of select="question" /></h3>
			<div class="answer"><xsl:value-of select="answer" disable-output-escaping="yes"/></div>
		</div>
	</xsl:template>
	
	<xsl:template match="result[@module = 'faq'][@method = 'post_question']">
		<xsl:call-template name="newsColumn" />
		
		<div id="textBlock">
			<h1><xsl:value-of select="@header" /></h1>
			
			<p>Ваш вопрос успешно отправлен! Мы обязательно вам ответим!</p>
		</div>
	</xsl:template>


<!--Карта сайта-->

	<xsl:template match="result[count(parents/page) = 0][page/@alt-name = 'sitemap']">
		<xsl:call-template name="newsColumn" />
		
		<div id="textBlock">
			<h1><xsl:value-of select="//property[@name = 'h1']/value" /></h1>
			
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
			<a href="{@link}"><xsl:value-of select="@name" /></a>
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
			<h1><xsl:value-of select="$notfoundHeader" /></h1>
			
			<xsl:value-of select="$notfoundText" disable-output-escaping="yes" />
		</div>
	</xsl:template>

	
<!--Поиск-->

	<xsl:template match="result[@module = 'search'][@method = 'search_do']">
		<xsl:variable name="search-results" select="document('udata://search/search_do/')/udata" />
		
		<xsl:call-template name="newsColumn" />
		
		<div id="textBlock">
			<h1><xsl:value-of select="@header" /></h1>
				
			<xsl:apply-templates select="$search-results"/>
			<xsl:apply-templates select="document(concat('udata://system/numpages/', $search-results/total, '/', $search-results/per_page, '/notemplate/p/3'))/udata" />
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'search'][@method = 'search_do'][not(items/item)]">
		<div class="search_message">
			<xsl:text>По запросу </xsl:text>
			<span>&#171;<xsl:value-of select="$search_string" />&#187;</span>
			<xsl:text> ничего не найдено.</xsl:text>
		</div>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'search'][@method = 'search_do'][items/item]">
		<div class="search_message">
			<xsl:text>По запросу </xsl:text>
			<span>&#171;<xsl:value-of select="$search_string" />&#187;</span>
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
			<h1><xsl:value-of select="@header" /></h1>
			
			<xsl:apply-templates select="document('udata://emarket/purchase')//purchasing" />
		</div>
	</xsl:template>
	
	<xsl:template match="purchasing[@stage = 'result' and @step = 'successful']">
		<p>Ваш заказ успешно оформлен. Наш менеджер свяжется с вами в течение 3х часов.</p>
		<p class="alert"><strong>Предупреждение!</strong> Письмо-уведомление может попасть в спам.</p>
	</xsl:template>
	
	
<!--Заказы пользователя-->
	<xsl:template match="result[page/@link = '/orders/']">
		<div style="padding: 20px 0;">
			<h1><xsl:value-of select="//property[@name = 'h1']/value" /></h1>
			
			<xsl:apply-templates select="document('udata://emarket/ordersList/')/udata" mode="ordersList" />
		</div>
	</xsl:template>
	
	<xsl:template match="udata" mode="ordersList">
		<p>Вы еще не сделали ни одного заказа.</p>
	</xsl:template>
	
	<xsl:template match="udata[items/item]" mode="ordersList">
		<div id="ordersList">
			<table>
				<tr>
					<th>Заказ №</th>
					<th>Сумма, рублей</th>
					<th>Дата</th>
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
			<td><xsl:value-of select="substring-after(@name, 'Заказ ')" /></td>
			<td><xsl:value-of select="document(concat('uobject://', @id, '.total_price'))//value" /></td>
			<td><xsl:value-of select="php:function('date', 'd-m-Y', number(document(concat('uobject://', @id, '.order_date'))//value/@unix-timestamp))" /></td>
			<td><xsl:value-of select="document(concat('uobject://', @id, '.status_id'))//value/item/@name" /></td>
			<td class="look"><a href="/order/?order_id={@id}">Посмотреть заказ</a></td>
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
			<h1><xsl:value-of select="$header" /></h1>
			
			<xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	
</xsl:stylesheet>