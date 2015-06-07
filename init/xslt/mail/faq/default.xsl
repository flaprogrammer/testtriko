<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
	
	<xsl:variable name="result" select="/result" />
	<xsl:variable name="page" select="/result/page" />

	<xsl:template match="/">
		<xsl:apply-templates select="result/confirm_mail_user" />
		<xsl:apply-templates select="result/confirm_mail_admin" />
	</xsl:template>
	
	<xsl:template match="confirm_mail_user">
		Ваш вопрос:
		<p><q><xsl:value-of select="question" /></q></p>
		успешно отправлен! Мы обязательно вам ответим!
	</xsl:template>
	
	<xsl:template match="confirm_mail_admin">
		С сайта <xsl:value-of select="domain" /> прислан следующий вопрос:
		<p><q><xsl:value-of select="question" /></q></p>
		<a href="{question_link}">Редактировать</a>
	</xsl:template>
	
</xsl:stylesheet>