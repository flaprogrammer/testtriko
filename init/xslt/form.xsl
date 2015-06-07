<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl">
	
<!--Страница с формой-->

	<xsl:template match="result[@module = 'webforms'][@method = 'page']">
		<xsl:call-template name="newsColumn" />
		<div id="formBlock">
			<div class="form">
				<xsl:apply-templates select="document('udata://system/listErrorMessages')/udata/items" mode="error" />
				
				<h2><xsl:value-of select="//property[@name = 'form_header']/value" /></h2>
				<xsl:apply-templates select="document(concat('udata://webforms/add/', //property[@name = 'form_id']/value))/udata" />
			</div>
			<div class="text">
				<h1><xsl:value-of select="//property[@name = 'h1']/value" /></h1>
			
				<xsl:value-of select="//property[@name = 'content']/value" disable-output-escaping="yes" />
			</div>
		</div>
	</xsl:template>
	
<!--Форма-->
	
	<xsl:template match="udata[@module = 'webforms'][@method = 'add']">
		<form method="post" class="restorable" id="form{@form_id}" action="/webforms/send/">
			<div>
				<input type="hidden" name="system_form_id" value="{@form_id}" />
				<input type="hidden" name="ref_onsuccess" value="/success/" />
				<input type="hidden" name="system_email_to" value="{.//item[@selected='selected']/@id}" />
			</div>
			
			<table>
				<xsl:apply-templates select="//field" />
				<tr>
					<td></td>
					<td class="submit">
						<input type="submit" value="Отправить" />
					</td>
				</tr>
			</table>
		</form>
	</xsl:template>
	
<!--Поля-->
	

	<xsl:template match="field[@type = 'string' or @type = 'int']">
		<tr>
			<td><xsl:value-of select="@title" />:<xsl:apply-templates select="@required" /> </td><td><input type="text" name="{@input_name}" value="{.}" /></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="field[@type = 'text']">
		<tr>
			<td><xsl:value-of select="@title" />:<xsl:apply-templates select="@required" /> </td><td><textarea name="{@input_name}"><xsl:value-of select="." /></textarea></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="field[@name = 'e-mail']" priority="2">
		<tr>
			<td><xsl:value-of select="@title" />:<xsl:apply-templates select="@required" /> </td><td><input type="text" name="email" value="{.}" /></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="udata[@method='captcha']" />
	
	<xsl:template match="udata[@method='captcha'][url]">
		<tr>
			<td></td>
			<td><img src="{url}{@random_string}" /></td>
		</tr>
		<tr>
			<td>Защитный код:<span>*</span> </td><td><input type="text" name="captcha" /></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="items" mode="error" />
	
	<xsl:template match="items[item]" mode="error">
		<div class="error">
			<xsl:apply-templates select="item" mode="error" />
		</div>
	</xsl:template>
	
	<xsl:template match="item" mode="error">
		<xsl:value-of select="." /><br />
	</xsl:template>
	
	<xsl:template match="@required">
		<span>*</span>
	</xsl:template>
	
	
	
</xsl:stylesheet>