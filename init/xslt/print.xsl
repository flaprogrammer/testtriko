<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

	
	<xsl:decimal-format decimal-separator=',' grouping-separator=' ' name="price" />	
	<xsl:variable name="cart" select="document('udata://emarket/cart/')/udata" />
	<xsl:variable name="summary">
		<xsl:choose>
			<xsl:when test="$cart//summary/price/actual">
				<xsl:value-of select="$cart//summary/price/actual" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>0</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="order_id" select="document('udata://emarket/cart/')/udata/@id" />
	
	
	
	
	
	<xsl:variable name="tpl" select="string('/templates/triko')" />
		
	<xsl:template match="/">
		<html>
			<head>
				<meta name="format-detection" content="telephone=no" />
				
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				
				<title><xsl:value-of select="result/@title" /></title>
				
				<link rel="icon" type="image/png" href="/favicon.png" />
				<link rel="shortcut icon" type="image/png" href="/favicon.png" />
				
				<style type="text/css">
					<xsl:text disable-output-escaping="yes">
						#header
						{
							overflow: hidden;
							margin-bottom: 30px;
						}
						
							#header > div
							{
								float: left;
								margin-right: 25px;
							}
						
						.numeric
						{
							text-align: right;
						}
						
						table
						{
							border-collapse: collapse;
							margin-bottom: 30px;
						}
						
							th,
							td
							{
								border: solid 1px black;
								padding: 2px 10px;
							}
							
							th
							{
								text-align: left;
								background: #eeeeee;
							}
					</xsl:text>
				</style>
			</head>
			<body onload="window.print();">
				<div id="header">
					<div id="logo"><img src="{$tpl}/img/logo.png" alt="Машук"/></div>
					<div id="slogan">
						Группа компаний Босса Нова<br />
						<b>Мы сделали качество доступным</b>
					</div>
					<div id="phone">
						<div class="number"><xsl:value-of select="document('upage:///.phone')//value" /></div>
					</div>
				</div>
					
				<div id="main">						
					<table id="cartInfo">
						<tr>
							<th>Дата</th>
							<th>Сумма, рублей</th>
						</tr>
						<tr>
							<td><xsl:value-of select="php:function('date', 'd-m-Y')" /></td>
							<td><xsl:value-of select="format-number($summary, '### ### ### ### ###, 00', 'price')" /> руб., в т. ч. НДС 
							

						  		<xsl:value-of select="format-number(document('udata://emarket/summNDS/')/udata, '### ### ### ### ###, 00', 'price')" /> руб.
									
							
							</td>
						</tr>
					</table>
					
					<table id="cartTable">
						<tr id="cartHeader">
							<th>Артикул</th>
							<th>Наименование</th>
							<th class="numeric">Упаковок</th>
							<th class="numeric">Штук</th>
							<th class="numeric">Цена</th>
							<th class="numeric">Стоимость</th>
						</tr>
						<xsl:apply-templates select="$cart//items/item" mode="cartItem" />
					</table>
				</div>
<!-- Yandex.Metrika counter --><script type="text/javascript">(function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter20045548 = new Ya.Metrika({id:20045548, webvisor:true, clickmap:true, trackLinks:true, accurateTrackBounce:true}); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks");</script><noscript><div><img src="//mc.yandex.ru/watch/20045548" style="position:absolute; left:-9999px;" alt="" /></div></noscript><!-- /Yandex.Metrika counter -->				
			</body>
		</html>
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
			<td class="numeric"><xsl:value-of select="amount" /></td>
			<td class="numeric"><xsl:value-of select="amount * document(concat('upage://', $sizeId, '.pack'))//value" /></td>
			<td class="numeric"><xsl:value-of select="price/actual" /></td>
			<td class="numeric"><xsl:value-of select="$totalPrice" /></td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>