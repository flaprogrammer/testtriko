<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl">

<!--Имитируем морфологический анализ на XSLT-->

<!--Стандартные слова-->
	<xsl:template match="*" mode="morpho_male">
		<xsl:apply-templates select="." mode="morpho">
			<xsl:with-param name="morpho_1" select="''" />
			<xsl:with-param name="morpho_2_4" select="'а'" />
			<xsl:with-param name="default" select="'ов'" />
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="*" mode="morpho_fem">
		<xsl:apply-templates select="." mode="morpho">
			<xsl:with-param name="morpho_1" select="'а'" />
			<xsl:with-param name="morpho_2_4" select="'ы'" />
			<xsl:with-param name="default" select="''" />
		</xsl:apply-templates>
	</xsl:template>

<!--Краткие причастия-->
	<xsl:template match="*" mode="morpho_male_short_part">
		<xsl:apply-templates select="." mode="morpho">
			<xsl:with-param name="morpho_1" select="''" />
			<xsl:with-param name="morpho_2_4" select="'ы'" />
			<xsl:with-param name="default" select="'ы'" />
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="*" mode="morpho_fem_short_part">
		<xsl:apply-templates select="." mode="morpho">
			<xsl:with-param name="morpho_1" select="'а'" />
			<xsl:with-param name="morpho_2_4" select="'ы'" />
			<xsl:with-param name="default" select="'о'" />
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="*" mode="morpho">
		<xsl:param name="morpho_1" />
		<xsl:param name="morpho_2_4" />
		<xsl:param name="default" />
		
		<xsl:variable name="value" select="." />
		<xsl:variable name="last" select="substring($value, string-length($value), string-length($value))" />
		<xsl:variable name="last_two" select="substring($value, string-length($value)-1, string-length($value))" />
		
		<xsl:choose>
			<xsl:when test="not($last_two &gt; 9 and $last_two &lt; 20)">
				<xsl:choose>
					<xsl:when test="$last = 1">
						<xsl:value-of select="$morpho_1" />
					</xsl:when>
					<xsl:when test="$last &gt; 1 and $last &lt; 5">
						<xsl:value-of select="$morpho_2_4" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$default" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default" />
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
</xsl:stylesheet>