<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="yes" />
	
	<xsl:variable name="result" select="/result" />
	<xsl:variable name="page" select="/result/page" />

	<xsl:template match="/">
		<xsl:apply-templates select="result/mail_verification" />
		<xsl:apply-templates select="result/mail_verification_subject" />		
	</xsl:template>
	
	<xsl:template match="mail_verification_subject">
		Восстановление пароля на сайте <xsl:value-of select="domain" />
	</xsl:template>
	
	<xsl:template match="mail_verification">
		<p><b>Здравствуйте!</b></p>
		<p>Вы запросили восстановление пароля на сайте <a href="http://{domain}"><xsl:value-of select="domain" /></a> для пользователя <b><xsl:value-of select="login" /></b>.</p>
		<p>Для восстановления пароля пройдите по следующей ссылке: <a href="{restore_link}"><xsl:value-of select="restore_link" /></a>.</p>
	</xsl:template>
	
</xsl:stylesheet>