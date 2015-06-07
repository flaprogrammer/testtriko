<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="UTF-8" indent="no" />
	
	<xsl:include href="carousel.xsl" />
	
	<xsl:variable name="tpl" select="string('/templates/triko')" />
	
	<xsl:template match="/">
		<ul id="carousel_3">
			<xsl:apply-templates select="udata/page" mode="carousel">
				<xsl:with-param name="limiter" select="'visited'" />
			</xsl:apply-templates>
		</ul>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'emarket'][@method = 'price']">
		<xsl:value-of select="format-number(price/actual,'#.0')" /> руб.
	</xsl:template>
	
</xsl:stylesheet>