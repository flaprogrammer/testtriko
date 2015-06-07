<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl">
	
	
	<xsl:template match="page" mode="carousel">
		<xsl:param name="limiter" />
		
		<!--<xsl:variable name="parentId" select="document(concat('upage://',@id))/udata/page/@parentId" />	
		<xsl:variable name="parentLink" select="document(concat('upage://',$parentId))/udata/page/@link" />	-->
		
		
		<li>
			<div class="img">
				<a href="{$parentLink}?start_good={@id}">
					<xsl:call-template name="carouselImg">
						<xsl:with-param name="img" select="document(concat('upage://', @id, '.image_1'))//value" />
						<xsl:with-param name="header" select="document(concat('upage://', @id, '.h1'))//value" />
					</xsl:call-template>
				</a>
			</div>
			<div class="info">
				<a href="{$parentLink}?start_good={@id}">
					<xsl:value-of select="document(concat('upage://', @id, '.code'))//value" /><br />
					<xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" /><br/>
					Размер: <xsl:value-of select="document(concat('upage://', @id, '.sizes'))//value" />
				</a>
			</div>
			<div class="bottom">
				<div class="price"><xsl:apply-templates select="document(concat('udata://emarket/price/', @id))/udata" /></div>
				<div class="buy"><a href="{$parentLink}?start_good={@id}"></a></div>
				<div class="favorite loaded"><a href="#favorite" pageId="{@id}"></a></div>
			</div>
		</li>
	</xsl:template>
	
	<xsl:template name="carouselImg">
		<xsl:param name="img" />
		<xsl:param name="header" />
		
		<xsl:variable name="thumb" select="document(concat('udata://system/makeThumbnailFull/(.', $img, ')/140/140/'))//src" />
		<xsl:variable name="exactImg">
			<xsl:choose>
				<xsl:when test="$thumb">
					<xsl:value-of select="$thumb" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$tpl" /><xsl:text>/img/no_img.png</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<img src="{$exactImg}" alt="{$header}" />
	</xsl:template>
	
	<xsl:template match="udata[@module = 'emarket'][@method = 'price']">
		<xsl:value-of select="price/actual" /> руб.
	</xsl:template>
	
</xsl:stylesheet>