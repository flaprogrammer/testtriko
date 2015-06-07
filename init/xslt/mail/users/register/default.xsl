<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="yes" />

	<xsl:variable name="result" select="/result" />
	<xsl:variable name="page" select="/result/page" />

	<xsl:template match="/">
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="result/mail_registrated" />
		<xsl:apply-templates select="result/mail_registrated_subject" />
		<xsl:apply-templates select="result/mail_admin_registrated_subject" />
		<xsl:apply-templates select="result/mail_admin_registrated" />
                <xsl:apply-templates select="result/invitation" />
                <xsl:apply-templates select="result/invitation_again" />
                <xsl:apply-templates select="result/mail_registrated_usp" />

	</xsl:template>

	<xsl:template match="mail_registrated_subject">
		Регистрация на сайте <xsl:value-of select="domain" />
	</xsl:template>

	<xsl:template match="mail_admin_registrated_subject">
		Регистрация на сайте <xsl:value-of select="domain" />
	</xsl:template>

	<xsl:template match="mail_registrated">
		<p><b>Здравствуйте!</b></p>
		<p>Вы зарегистрировались на сайте <a href="http://{domain}"><xsl:value-of select="domain" /></a>.</p>
		<p>
			<b>Логин:</b><xsl:text> </xsl:text><xsl:value-of select="login" /><br />
			<b>Пароль:</b><xsl:text> </xsl:text><xsl:value-of select="password" /><br />
		</p>
		<p>Для завершения регистрации пройдите по следующей ссылке: <a href="{activate_link}"><xsl:value-of select="activate_link" /></a>.</p>
	</xsl:template>

        <xsl:template match="mail_registrated_usp">
		<p><b>Здравствуйте!</b></p>
		<p>Вы зарегистрировались на сайте <a href="http://{domain}"><xsl:value-of select="domain" /></a>, как "Участник совместной покупки"</p>
		<p>
			<b>Логин:</b><xsl:text> </xsl:text><xsl:value-of select="login" /><br />
			<b>Пароль:</b><xsl:text> </xsl:text><xsl:value-of select="password" /><br />
		</p>
		<!--<p>Для завершения регистрации пройдите по следующей ссылке: <a href="{activate_link}"><xsl:value-of select="activate_link" /></a>.</p> -->
	</xsl:template>

	<xsl:template match="mail_admin_registrated">
            <xsl:variable name="userObj" select="document(concat('uobject://', user_id))/udata" />
		<p><b>Здравствуйте!</b></p>
		<p>На сайте зарегистрировался пользователь <b><xsl:value-of select="login" /></b>.</p>
                <div style="background:#FFF7EC;padding:40px;">

                    <xsl:if test="$userObj//property[@name = 'name']/value">
                        ФИО: <xsl:value-of select="$userObj//property[@name = 'name']/value" /><br />
                    </xsl:if>
                    <xsl:if test="$userObj//property[@name = 'phone']/value">
                        Телефон: <xsl:value-of select="$userObj//property[@name = 'phone']/value" /><br />
                    </xsl:if>
                    <xsl:if test="$userObj//property[@name = 'e-mail']/value">
                        Email: <xsl:value-of select="$userObj//property[@name = 'e-mail']/value" /><br />
                    </xsl:if>
                    <xsl:if test="$userObj//property[@name = 'city']/value">
                        Город: <xsl:value-of select="$userObj//property[@name = 'city']/value" /><br />
                    </xsl:if>

		</div>
	</xsl:template>

        <xsl:template match="invitation">

            Пользователь <xsl:value-of select="user_name" /> приглашает Вас присоединиться к совместным покупкам на сайте triko.ru.<br />
            Для того, что бы приступить к покупкам, Вам необходимо зарегистироваться, пройдя по ссылке

            <a href="http://triko.ru/users/register_usp?keyuser={key}&amp;org={org_id}&amp;must={must_email}&amp;usp={user_id}">

                Регистрация
            </a>


	</xsl:template>

        <xsl:template match="invitation_again">

            Пользователь <xsl:value-of select="user_name" /> приглашает Вас присоединиться к совместным покупкам на сайте triko.ru.<br />
            Для того, что бы приступить к покупкам, Вам необходимо пройти по ссылке

            <a href="http://triko.ru/users/connectedUtpToBuys/{user_id}">
                Присоединиться к покупкам!
            </a>

            <br />
            <br />
            Внимание! В случае принятия приглашения Ваша корзина будет очищена! <br />
            Для подключения к участникам совместной покупки, необходимо быть авторизованным на сайте.

	</xsl:template>
</xsl:stylesheet>