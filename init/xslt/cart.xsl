<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common">
	
	<xsl:param name="noremove" select="'0'" />
	<xsl:variable name="colspan">
		<xsl:choose>
			<xsl:when test="$noremove = 1">
				<xsl:value-of select="7" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="8" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="UTF-8" indent="no" />
	
	<xsl:template match="/">
		<xsl:variable name="pre_items">
			<xsl:apply-templates select="udata/item" mode="pre">
				<xsl:sort select="@catId" order="ascending" />
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:variable name="items" select="exsl:node-set($pre_items)/*" />
		
		<udata>
			<count><xsl:value-of select="count($items)" /></count>
			<table>
				<xsl:apply-templates select="$items" />
			</table>
		</udata>
	</xsl:template>
	
	<xsl:template match="item" mode="pre">
		<xsl:copy-of select="." />
	</xsl:template>
	
	<xsl:template match="item">
		<xsl:variable name="parentId" select="@catId" />
		<xsl:variable name="categoryId" select="document(concat('udata://custom/getParent/', @catId))/udata" />
		<xsl:variable name="position" select="position()" />
		
		<xsl:if test="position() = 1 or ../*[position() = $position - 1]/@catId != $parentId">
			<tr class="header" id="header_{@catId}" parent="{$categoryId}" parentH1="{document(concat('upage://', $categoryId, '.h1'))//value}">
				<td colspan="{$colspan}"><xsl:value-of select="document(concat('upage://', @catId, '.h1'))//value" /></td>
			</tr>
		</xsl:if>
		
		<tr class="item">
			<td class="thumb">
				<xsl:if test="@img">
					<a href="{@img}" rel="lightbox">
						<img src="{document(concat('udata://system/makeThumbnailFull/(.', @img, ')/30/30/'))//src}" alt="{@name}" />
					</a>
				</xsl:if>
			</td>
			<td><xsl:value-of select="@code" /></td>
			<td><xsl:value-of select="@name" /></td>
			<xsl:choose>
				<xsl:when test="$noremove = 0">
					<td class="packs"><input type="text" name="amount[{@id}]" value="{@packs}" /></td>
				</xsl:when>
				<xsl:otherwise>
					<td class="packs"><xsl:value-of select="@packs" /></td>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:variable name="parId" select="document(concat('uobject://', @id))//page/@parentId" />
			<!--<xsl:variable name="newprice" select="document(concat('upage://', $parId))/udata//property[@name = 'price']/value" />-->
			<xsl:variable name="newprice" select="document(concat('udata://emarket/price/', $parId))/udata/price/actual" />
	
			
			<td class="items"><xsl:value-of select="@items" /></td>
			<td class="price"><xsl:value-of select="format-number($newprice,'#.0')" /></td>
			<td class="totalPrice"><xsl:value-of select="format-number(@totalPrice,'#.0')" /></td>
			<xsl:if test="$noremove = 0">
				<td class="remove">
					<input type="hidden" name="remove[{@id}]" value="0" />
					<input type="checkbox" name="remove[{@id}]" value="1" />
				</td>
			</xsl:if>
		</tr>
	</xsl:template>
	
	<xsl:template match="udata[@module = 'emarket'][@method = 'price']" mode="catalog">
		<xsl:if test="price/original">
			<div class="sale">%</div>
		</xsl:if>
		
		<xsl:value-of select="format-number(price/actual,'#.0')" />
	</xsl:template>
		
</xsl:stylesheet>