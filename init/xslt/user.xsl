<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl">

    <!--Авторизация-->
    <xsl:param name="keyuser" select="0" />
    <xsl:param name="must" select="0" />
    <xsl:param name="org" select="0" />
    <xsl:param name="usp" select="0" />


    <xsl:template match="result[@module = 'users'][@method = 'login'][user/@type='guest']">
        <xsl:call-template name="newsColumn" />
        <div id="textBlock">
            <h1>
                <xsl:value-of select="@header" />
            </h1>

            <p>Для продолжения работы необходимо войти в систему, используя свои логин и пароль.</p>
            <p>Если вы еще не зарегистрированы, то пройдите процедуру <a href="/users/registrate/">регистрации</a>.</p>
        </div>
    </xsl:template>

    <xsl:template match="result[@module = 'users'][@method = 'login_do']">
        <div id="textBlock">
            <h1>
                <xsl:value-of select="@header" />
            </h1>

            <p>Вы успешно вошли в систему.</p>
        </div>
    </xsl:template>

    <xsl:template match="result[@module = 'users'][@method = 'login_do'][user/@type='guest']">
        <xsl:call-template name="newsColumn" />
        <div id="textBlock">
            <h1>
                <xsl:value-of select="@header" />
            </h1>

            <p>Введена неверная комбинация логина и пароля.</p>
        </div>
    </xsl:template>


    <!--Восстановление пароля-->

    <xsl:template match="result[@module = 'users'][@method = 'forget']">
        <xsl:call-template name="newsColumn" />
        <div id="textBlock">
            <h1>Восстановление пароля</h1>
            <p>
                <b>Забыли пароль? Мы поможем вам!</b>
            </p>
            <p>Укажите электронную почту, которую вы ввели при регистрации, и мы вышлем на нее новый пароль.</p>
            <xsl:apply-templates select="document('udata://system/listErrorMessages')/udata/items" mode="error" />

            <form method="post" id="forget" action="/users/forget_do/">
                <div>
                    <input type="text" name="forget_email" placeholder="E-mail" />
                    <div class="submit">
                        <input type="image" src="{$tpl}/img/arrow_login.png" />
                    </div>
                </div>
            </form>
        </div>
    </xsl:template>

    <xsl:template match="result[@module = 'users'][@method = 'forget_do'][udata/@status = 'success']">
        <div id="textBlock">
            <h1>Восстановление пароля</h1>
            <p>Сообщение с информацией о восстановлении отправлено на вашу почту.</p>
        </div>
    </xsl:template>

    <xsl:template match="result[@module = 'users'][@method = 'restore']">
        <xsl:value-of select="document('udata://content/redirect/(/)')" />
    </xsl:template>


    <xsl:template match="result[@module = 'users'][@method = 'restore'][user/@type = 'guest']">
        <div id="textBlock">
            <h1>Восстановление пароля</h1>
            <p>
                Данный код подтверждения неверен или уже был использован.
            </p>
        </div>
    </xsl:template>

    <xsl:template match="result[@module = 'users'][@method = 'restore'][udata/@status = 'success']">
        <div id="textBlock">
            <h1>Восстановление пароля</h1>
            <p>Ваши новые данные:</p>
            <p>
                <b>Логин:</b>
                <xsl:text> </xsl:text>
                <xsl:value-of select="udata/login" />
                <br />
                <b>Пароль:</b>
                <xsl:text> </xsl:text>
                <xsl:value-of select="udata/password" />
                <br />
            </p>
        </div>
    </xsl:template>


    <!--Регистрация-->

    <xsl:template match="result[@module = 'users'][@method = 'registrate']">

        <xsl:call-template name="newsColumn" />

        <div id="textBlock">
            <h1 style="text-align:center;">Регистрация</h1>
            <!--	<p><b>Чтобы получить доступ в личный кабинет, вам необходимо заполнить небольшую форму.</b></p>
                    <p>После заполнения вам на почту будет выслан логин и пароль.</p>
            -->
            <xsl:apply-templates select="document('udata://system/listErrorMessages')/udata/items" mode="error" />

            <form method="post" class="restorable" id="registerForm" action="/users/registrate_do/">
                <table>

                    <xsl:choose>
                        <xsl:when test="$keyuser = '0'">
                            <xsl:apply-templates select="document(concat('udata://data/getCreateForm/', document('udata://users/registrate')//type_id, '/', 'default', '/', 'short_info', '%20', 'short_info_second'))//field"  />
                        </xsl:when>
                        <xsl:when test="$keyuser != '0' and $must = '0'">
                            <xsl:text>Вы прошли по неправильной ссылке!</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="document(concat('udata://data/getCreateForm/', document('udata://users/registrate')//type_id, '/', 'default', '/', 'short_info', '%20'))//field" mode="new_structure_fields" />
                        </xsl:otherwise>
                    </xsl:choose>
                    <!--	<xsl:apply-templates select="document('udata://system/captcha')/udata[url]" /> -->
                    <xsl:choose>
                    <xsl:when test="$keyuser != '0' and $must = '0'">

                    </xsl:when>
                    <xsl:otherwise>
                        <tr>
                            <td>
                                <strong>Пароль:</strong>
                                <span>*</span>
                            </td>
                            <td class="pass">
                                <input type="password" name="password" value='' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Повторите пароль:</strong>
                                <span>*</span>
                            </td>
                            <td class="repeat_pass">
                                <input type="password" name="password_confirm" value='' />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" width="150px">
                                <p>
                                    <span class="trek" style="color: red; font-size:9pt;">* - поля обязательные для заполнения.</span>
                                </p>
                            </td>

                        </tr>

                        <tr>
                            <xsl:choose>
                                <xsl:when test="$keyuser != '0'">
                                    <input type="hidden" name="keyuser" value="{$keyuser}" />
                                </xsl:when>
                            </xsl:choose>
                            <td colspan="2" align="center" class="submit">
                                <div style="display:inline-block;">
                                    <button style="cursor: pointer;" class="button_voice box_inline_w form-submit " name="op" id="edit-vote" type="submit">
                                        <div class="wrapper_button">
                                            <a href="#" class="button_reg voice inline relative box_shadow">
                                                <span class="value inline">ЗАРЕГИСТРИРОВАТЬСЯ</span>
                                            </a>
                                        </div>
                                    </button>
                                    <!--<input type="submit" value="Зарегистрироваться" />-->
                                    <img class="img_arrrow" src="/templates/triko/img/arrow.png" />
                                </div>
                            </td>

                        </tr>
                        <tr>
                            <td style="height:10px;"></td>
                        </tr>
                        <tr>

                            <td colspan="2" style="text-align:center;">
                                <span class="text_send">Вам на почту будет выслан логин и пароль</span>
                            </td>
                        </tr>
                    </xsl:otherwise>
                    </xsl:choose>

                </table>
            </form>

        </div>
    </xsl:template>

    <xsl:template match="field" mode="new_structure_fields">
        <xsl:choose>
            <xsl:when test="@name = 'e-mail'">
                <xsl:variable name="emailutp" select="document(concat('udata://users/getEmailInvitedUsers/', $org, '/', $must))/udata" />
                <tr>
                    <td>
                        <xsl:value-of select="@title" />:
                        <span>*</span>
                    </td>
                    <td >
                        <input type="text" name="email" value="{$emailutp}" disabled="disabled"/>
                        <input type="hidden" name="email" value="{$emailutp}" />
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr>
                    <td>
                        <strong><xsl:value-of select="@title" />:</strong>
                        <span>*</span>
                    </td>
                    <td >
                        <input type="text" name="{@input_name}" value='' />
                    </td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    <xsl:template match="result[@module = 'users'][@method = 'registrate_do' or @method = 'registrate_done']">
        <div id="textBlock">
            <h1>Регистрация</h1>
            <p>На вашу почту отправлено письмо с дальнейшими инструкциями.</p>
            <p class="alert">
                <strong>Предупреждение!</strong> Письмо-уведомление может попасть в спам.</p>
        </div>
    </xsl:template>

    <xsl:template match="result[@module = 'users'][@method = 'activate']">
        <div id="textBlock">
            <h1>Регистрация</h1>
            <xsl:apply-templates select="document(concat('udata://users/activate/', $param0))/udata" />
        </div>
    </xsl:template>

    <xsl:template match="udata[@module = 'users'][@method = 'activate']" />

    <xsl:template match="udata[@module = 'users'][@method = 'activate'][error]">
        <xsl:value-of select="error" />
    </xsl:template>

    <xsl:template match="udata[@module = 'users'][@method = 'activate'][activated = '1']">
        Вы подтвердили свою регистрацию и успешно вошли в систему!
    </xsl:template>

    <!--Личные данные-->
    <xsl:template match="result[@module = 'users'][@method = 'settings']">
        <xsl:variable name="userObj" select="document(concat('uobject://', user/@id))/udata" />
        <script type="text/javascript" src="/templates/triko/js/custom.js"></script>
	<xsl:choose>
            <xsl:when test="$userObj//property[@name = 'org_type']/value">
                <div class="buys-block">
                    <ul class="buys-list">
                        <li class="active-tab-buys padd-block-li" style="padding:4px; text-align:center;">
                            <a href="#tab1" class="">Личные данные</a>
                        </li>
                        <li class="padd-block-li">
                            <a href="#tab2">Адресная книга</a>
                        </li>
                    </ul>
                    <div id="tab1" class="step active-tab-buys">
                        <div id="textBlock">
                            <h1>
                                <xsl:value-of select="@header" />
                            </h1>

                            <p>Статус: Организатор совместных покупок</p>
                            <xsl:apply-templates select="document('udata://system/listErrorMessages')/udata/items" mode="error" />

                            <form method="post" class="restorable" id="settingsForm" action="/users/settings_do/">
                                <table>
                                    <tr>
                                        <td>Пароль: </td>
                                        <td>
                                            <input type="password" name="password" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Повторите пароль: </td>
                                        <td>
                                            <input type="password" name="password_confirm" />
                                        </td>
                                    </tr>
                                    <xsl:apply-templates select="document(concat('udata://data/getEditForm/', user/@id))//field" />
                                    <tr>
                                        <td></td>
                                        <td class="submit">
                                            <input type="submit" value="Сохранить" />
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                    <div id="tab2" class="step">
                        <xsl:apply-templates select="document(concat('uobject://', user/@id))/udata" mode="addressBook" />
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="textBlock">
                    <h1>
                        <xsl:value-of select="@header" />
                    </h1>
                    <xsl:choose>
                        <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                            <xsl:choose>
                                <xsl:when test="$userObj//property[@name = 'delete_from_buys']/value">
                                </xsl:when>
                                <xsl:otherwise>
                                    <p>Статус: Участник совместных покупок</p>
                                    <xsl:variable name="orgId" select="document('udata://users/getIdOptUser')/udata" />
                                    <p>Ваш организатор: <xsl:value-of select="document(concat('uobject://', $orgId))//property[@name = 'e-mail']/value" />
                                        <br />
                                        <xsl:choose>
                                            <xsl:when test="document(concat('uobject://', $orgId))//property[@name = 'phone']/value">
                                                Тел. <xsl:value-of select="document(concat('uobject://', $orgId))//property[@name = 'phone']/value" />
                                            </xsl:when>
                                        </xsl:choose>
                                    </p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:apply-templates select="document('udata://system/listErrorMessages')/udata/items" mode="error" />

                    <form method="post" class="restorable" id="settingsForm" action="/users/settings_do/">
                        <table>
                            <tr>
                                <td>Пароль: </td>
                                <td>
                                    <input type="password" name="password" />
                                </td>
                            </tr>
                            <tr>
                                <td>Повторите пароль: </td>
                                <td>
                                    <input type="password" name="password_confirm" />
                                </td>
                            </tr>
                            <xsl:apply-templates select="document(concat('udata://data/getEditForm/', user/@id))//field" />
                            <tr>
                                <td></td>
                                <td class="submit">
                                    <input type="submit" value="Сохранить" />
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


   <!-- Регистрация(типа) для УСП -->
   <xsl:template match="result[@module = 'users'][@method = 'register_usp']">
        <xsl:variable name="userObj" select="document(concat('uobject://', user/@id))/udata" />
        <script type="text/javascript" src="/templates/triko/js/custom.js"></script>
        <xsl:choose>
            <xsl:when test="$keyuser != '0' and $must != '0'">
                <div class="uspRegister" id="textBlock">
                    <h1>
                        Регистрация участника совместных покупок!
                    </h1>
                    <!--
                    <xsl:variable name="orgId" select="document('udata://users/getIdOptUser')/udata" />
                    <p>Ваш организатор: <xsl:value-of select="document(concat('uobject://', $orgId))//property[@name = 'e-mail']/value" />
                        <br />
                        <xsl:choose>
                            <xsl:when test="document(concat('uobject://', $orgId))//property[@name = 'phone']/value">
                                Тел. <xsl:value-of select="document(concat('uobject://', $orgId))//property[@name = 'phone']/value" />
                            </xsl:when>
                        </xsl:choose>
                    </p> -->

                    <xsl:apply-templates select="document('udata://system/listErrorMessages')/udata/items" mode="error" />

                    <form method="post" class="restorable" id="settingsForm" action="/users/saveUsp_do/">
                        <input type="hidden" name="user" value="{$usp}" />
                        <input type="hidden" name="user_org" value="{$org}" />
                        <input type="hidden" name="keyuser" value="{$keyuser}" />
                        <table>
                            <tr>
                                <td>Пароль: </td>
                                <td>
                                    <input type="password" name="password" />
                                </td>
                            </tr>
                            <tr>
                                <td>Повторите пароль: </td>
                                <td>
                                    <input type="password" name="password_confirm" />
                                </td>
                            </tr>
                            <tr>
                                <td>Email: </td>
                                <td>
                                    <input type="text" name="email" disabled="disabled" style="color:grey;">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="document(concat('uobject://', $usp))/udata//property[@name = 'e-mail']/value" />
                                        </xsl:attribute>
                                    </input>
                                </td>
                            </tr>
                            <tr>
                                <td>Имя: </td>
                                <td>
                                    <input type="text" name="name" />
                                </td>
                            </tr>
                            <tr>
                                <td>Телефон: </td>
                                <td>
                                    <input type="text" name="phone" />
                                </td>
                            </tr>
                            <tr>
                                <td>Город: </td>
                                <td>
                                    <input type="text" name="city" />
                                </td>
                            </tr>

                            <tr>
                                <td></td>
                                <td class="submit" >
                                    <input type="submit" style="cursor:pointer;" value="Сохранить" />
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </xsl:when>
            <xsl:when test="$keyuser != '0' and $must = '0'">
                <xsl:text>Вы прошли по неправильной ссылке!</xsl:text>
            </xsl:when>

        </xsl:choose>

    </xsl:template>


    <xsl:template match="udata" mode="addressBook">
        <div class="main-buys">
            <span class="invited-text">Приглашение отправлено!</span>
            <form action="/users/sendInviteToUser/" method="post" class="form-invite" >
                <input type="hidden" class="org_id" name="org_id" value="{object/@id}" />
                <input type="text" name="email" class="invite-email" placeholder="Новый участник" />
                <button type="submit" class="invite-submit" >Пригласить</button>
            </form>

        </div>

        <div class="invite-list-users">
            <xsl:choose>
                <xsl:when test="document(concat('uobject://', object/@id))//property[@name = 'key_org']/value">

                    <table class="users-table" cellspasing="2" cellpadding="4">
                        <th>№</th>
                        <th>Mail</th>
                        <th>ФИО</th>
                        <th>Город</th>
                        <th>Телефон</th>

                        <xsl:apply-templates select="document(concat('udata://users/getUtpUsersAddressBook/', object/@id))/udata/user" mode="users_table_book" />
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <span>У вас еще нет ниодного участника</span>
                </xsl:otherwise>
            </xsl:choose>

        </div>
    </xsl:template>

    <xsl:template match="result[@module = 'users'][@method = 'connectedUtpToBuys']">
        <div id="textBlock">
            <xsl:text>Вы были подключены к "Участникам Совместных Покупок"</xsl:text>
        </div>
    </xsl:template>
<!--
    <xsl:template match="udata" mode="BuysCart">
        <div class="main-buys">
            <span class="invited-text">Приглашение отправлен vbcvbcbcvbо!</span>
            <form action="/users/sendInviteToUser/" method="post" class="form-invite" >
                <input type="hidden" class="org_id" name="org_id" value="{object/@id}" />
                <input type="text" name="email" class="invite-email" placeholder="Новый участник" />
                <button type="submit" class="invite-submit" >Пригласить</button>
            </form>
            <button type="submit" class="invite-submit" >Пригласить</button>
            <input type="submit" class="invite-submit" value="Пригласить" />
            <span class="invited-text">Приглашение отправлено!</span>
        </div>
        <div class="invite-list-users">
            <xsl:choose>
                <xsl:when test="document(concat('uobject://', object/@id))//property[@name = 'key_org']/value">
                    <table class="users-table" cellspasing="2" cellpadding="4">
                        <th>№</th>
                        <th>Mail</th>
                        <th>ФИО</th>
                        <th>Город</th>
                        <th>Телефон</th>
                        <th>Уведомлять по email</th>
                        <xsl:apply-templates select="document(concat('udata://users/getUtpUsersByIdOpt/', object/@id))/udata/user" mode="users_table" />
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <span>У вас еще нет ниодного участника</span>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
-->
</xsl:stylesheet>