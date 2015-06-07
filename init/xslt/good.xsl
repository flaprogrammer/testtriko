<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common">

    <xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="UTF-8" indent="no" />

    <xsl:include href="carousel.xsl" />

    <xsl:variable name="tpl" select="string('/templates/triko')" />
    <xsl:variable name="users" select="//user" />
    <xsl:template match="/">

        <udata>
            <xsl:apply-templates select="udata/page" />
        </udata>
    </xsl:template>

    <xsl:template match="page">

        <xsl:variable name="collectionLink" select="document(concat('usel://in_collections/', @id))//page/@link" />
        <div id="goodInfo" goodId="{@id}">
            <div id="goodLabels">
                <xsl:if test="document(concat('udata://emarket/price/', @id))/udata/price/original > 0">
                    <img src="{$tpl}/img/label_sale.png" alt="Распродажа" />
                </xsl:if>

                <xsl:if test="//property[@name = 'new']/value = 1">
                    <a href="/categories/new_items/">
                        <img src="{$tpl}/img/label_new.png" alt="Новинка" />
                    </a>
                </xsl:if>

                <xsl:if test="document(concat('usel://in_collections/', @id))//page">

                    <a href="{$collectionLink}">
                        <img src="{$tpl}/img/label_ppl.png" alt="В коллекции" />
                    </a>
                </xsl:if>

                <xsl:if test="//property[@name = 'hit']/value = 1">
                    <a href="/categories/hits/">
                        <img src="{$tpl}/img/label_hit.png" alt="Хит" />
                    </a>
                </xsl:if>
            </div>
            <xsl:choose>
                <xsl:when test="//property[@name = 'sale_size_rows']/value">
                    <div id="goodImages">
                        <div id="goodBigImage" class="colors-size">
                            <xsl:call-template name="bigImageGroup" />
                            <div id="goodSmallImages">
                                <xsl:apply-templates select="document(concat('udata://emarket/getImageWithColorFromItem/', @id))/udata/image_color" mode="smallImageGroup" />
                            </div>

                        </div>
                        <ul class="color-ul" id="numImage">
                            <xsl:apply-templates select="document(concat('udata://emarket/getImageWithColorFromItem/', @id, '/', 'true'))/udata/image_color" mode="numImageGroup" />

                        </ul>
                    </div>

                    <div id="goodCaption">
                        <div class="prev">
                            <a href="#prev"><!--<img src="{$tpl}/img/arrow_prev.png" alt="prev" />--></a>
                        </div>
                        <div class="next">
                            <a href="#next"><!--<img src="{$tpl}/img/arrow_next.png" alt="next" />--></a>
                        </div>
                        <div class="info">
                            <a  class="toFavorites">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="@link" />
                                </xsl:attribute>
                                <div class="article">
                                    <xsl:value-of select="//property[@name = 'code']/value" />
                                </div>
                                <div class="label">
                                    <xsl:value-of select="name" />
                                </div>
                                <!--<a  class="toFavorites"> -->
                            </a>
                        </div>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <div id="goodImages">
                        <div id="goodBigImage">
                            <xsl:call-template name="bigImage" />
                            <div id="goodSmallImages">
                                <xsl:apply-templates select="//property[starts-with(@name, 'image_')]/value" mode="smallImage" />
                            </div>
                        </div>
                        <ul class="numImage" id="numImage">
                            <xsl:apply-templates select="//property[starts-with(@name, 'image_')]/value" mode="numImage" />
                        </ul>
                    </div>

                    <div id="goodCaption">
                        <div class="prev">
                            <a href="#prev"><!--<img src="{$tpl}/img/arrow_prev.png" alt="prev" />--></a>
                        </div>
                        <div class="next">
                            <a href="#next"><!--<img src="{$tpl}/img/arrow_next.png" alt="next" />--></a>
                        </div>
                        <div class="info">
                            <a  class="toFavorites">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="@link" />
                                </xsl:attribute>
                                <div class="article">
                                    <xsl:value-of select="//property[@name = 'code']/value" />
                                </div>
                                <div class="label">
                                    <xsl:value-of select="//property[@name = 'h1']/value" />
                                </div>
                                <!--<a  class="toFavorites"> -->

                            </a>
                        </div>
                    </div>
                </xsl:otherwise>
            </xsl:choose>

            <div class="priceWrap">
                <div class="goodTab" id="goodTab">
                    <a href="#goodTab1" class="active">Заказ<span></span></a>
                    <a href="#goodTab2">Описание<span></span></a>
                </div>
                <div id="goodPrice">
                    <a href="#favorites" class="toFavorites">
                        <xsl:choose>
                            <xsl:when test="document(concat('udata://custom/isFavorite/', @id))//result = 1">
                                <xsl:attribute name="fav">
                                    <xsl:text>true</xsl:text>
                                </xsl:attribute>
                                В избранном
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="fav">
                                    <xsl:text>false</xsl:text>
                                </xsl:attribute>
                                В избранное
                            </xsl:otherwise>
                        </xsl:choose>

                    </a>
                    Цена: <span class="price">
                        <xsl:apply-templates select="document(concat('udata://emarket/price/', @id))/udata" mode="good" />
                    </span>
                </div>
            </div>
            <div id="goodTab1">
                <xsl:choose>
                    <xsl:when test="//property[@name = 'sale_size_rows']/value">

                        <table id="goodSizes">
                            <tr>
                                <th>Цвета</th>
                                <xsl:choose>
                                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                        <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                        <xsl:choose>
                                            <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value and document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                                                <th class="amount">Упак.</th>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <th class="amount">Упак.</th>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <th class="pieces">Штуки</th>
                                <th class="order">Шт. в заказе</th>
                            </tr>

                            <tbody>
                                <xsl:choose>
                                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                        <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                        <xsl:variable name="delete_type" select="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value" />

                                        <xsl:choose>
                                            <xsl:when test="$delete_type and document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">

                                                <xsl:apply-templates select="document(concat('udata://emarket/getSizeColorsItem/', @id))/udata" mode="size-colors">
                                                    <xsl:with-param name="parentId" select="@id" />
                                                </xsl:apply-templates>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <tr>
                                                    <td class="utp" colspan="3" >
                                                        <div class="styled-select green rounded">
                                                            <select name="typecolor" >
                                                                <xsl:apply-templates select="document(concat('udata://emarket/getSizeColorsItem/', @id))/udata" mode="utp-option-size-colors">
                                                                    <xsl:with-param name="parentId" select="@id" />
                                                                </xsl:apply-templates>
                                                            </select>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <xsl:apply-templates select="document(concat('udata://emarket/getSizeColorsItem/', @id))/udata" mode="utp-size-colors">
                                                    <xsl:with-param name="parentId" select="@id" />
                                                </xsl:apply-templates>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>

                                        <xsl:apply-templates select="document(concat('udata://emarket/getSizeColorsItem/', @id))/udata" mode="size-colors">
                                            <xsl:with-param name="parentId" select="@id" />
                                        </xsl:apply-templates>
                                    </xsl:otherwise>
                                </xsl:choose>

                            </tbody>
                        </table>

                    </xsl:when>
                    <xsl:otherwise>

                        <table id="goodSizes">
                            <tr>
                                <th>Размеры</th>

                                <xsl:choose>
                                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                        <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />

                                        <xsl:choose>
                                            <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value and document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                                                <th class="amount">Упак.</th>
                                            </xsl:when>
                                        </xsl:choose>

                                    </xsl:when>
                                    <xsl:otherwise>
                                        <th class="amount">Упак.</th>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <th class="pieces">Штуки</th>
                                <th class="order">Шт. в заказе</th>
                            </tr>
                            <tbody>
                                <xsl:choose>
                                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                                        <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                                        <xsl:choose>
                                            <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                                                <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', @id, '/1/'))//item" mode="sizes">
                                                    <xsl:sort select="." order="ascending" />
                                                </xsl:apply-templates>
                                            </xsl:when>
                                            <xsl:otherwise>

                                                <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', @id, '/1/'))//item" mode="utpSizes">
                                                    <xsl:sort select="." order="ascending" />
                                                </xsl:apply-templates>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                                        <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', @id, '/1/'))//item" mode="orgSizes">
                                            <xsl:sort select="." order="ascending" />
                                        </xsl:apply-templates>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates select="document(concat('udata://content/menu/0/1/', @id, '/1/'))//item" mode="sizes">
                                            <xsl:sort select="." order="ascending" />
                                        </xsl:apply-templates>
                                    </xsl:otherwise>
                                </xsl:choose>

                            </tbody>
                        </table>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp' or document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'org'">
                        <xsl:variable name="userOrgId" select="document('udata://users/getIdOptUser/')/udata" />
                        <input type="hidden" name="emailOrg" class="emailOrg" >
                            <xsl:attribute name="value">
                                <xsl:value-of select="document(concat('uobject://', $userOrgId))//property[@name = 'e-mail']/value" />
                            </xsl:attribute>
                        </input>

                        <input type="hidden" name="phoneOrg" class="phoneOrg" >
                            <xsl:attribute name="value">
                                <xsl:value-of select="document(concat('uobject://', $userOrgId))//property[@name = 'phone']/value" />
                            </xsl:attribute>
                        </input>
                    </xsl:when>
                </xsl:choose>
            </div>
            <div id="goodTab2">
                <dl id="goodDetails">
                    <dt>Полотно:</dt>
                    <dd>
                        <xsl:value-of select="//property[@name = 'material']/value/item/@name" />
                    </dd>

                    <dt>Описание:</dt>
                    <dd>
                        <xsl:value-of select="//property[@name = 'descr']/value" disable-output-escaping="yes" />
                    </dd>

                    <xsl:apply-templates select="document(concat('usel://in_collections/', @id))/udata" mode="inCollections">
                        <xsl:with-param name="id" select="@id" />
                    </xsl:apply-templates>
                </dl>
            </div>
            <div class="myOrder" id="myOrder">
                Мой заказ
                <span>
                    <xsl:choose>
                        <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata = 'utp'">
                            <xsl:variable name="userid_for_price" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                            <xsl:choose>
                                <xsl:when test="document(concat('uobject://', $userid_for_price))//property[@name = 'delete_from_buys']/value">
                                    <xsl:choose>
                                        <xsl:when test="document('udata://emarket/cart/')/udata/summary/price/actual">
                                            <xsl:value-of select="document('udata://emarket/cart/')/udata/summary/price/actual" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            0
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>

                                    <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />
                                    <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />
                                    <xsl:variable name="priceCart" select="document(concat('udata://emarket/getTotalPriceUtp/', $orderId))/udata" />

                                    <span>
                                        <xsl:choose>
                                            <xsl:when test="$priceCart">
                                                <xsl:value-of select="$priceCart" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                0
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </span>

                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="document('udata://emarket/cart/')/udata/summary/price/actual">
                                    <xsl:value-of select="document('udata://emarket/cart/')/udata/summary/price/actual" />
                                </xsl:when>
                                <xsl:otherwise>
                                    0
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </span> руб.
            </div>
        </div>
        <ul id="carousel_2">
            <xsl:apply-templates select="//property[@name = 'recommend']//page" mode="carousel">
                <xsl:with-param name="limiter" select="'recommend'" />
                <xsl:with-param name="recommendId" select="@id" />
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <xsl:template match="udata" mode="size-colors">
        <xsl:apply-templates select="colors" mode="colors-item" />
    </xsl:template>

    <xsl:template match="udata" mode="utp-size-colors">
        <xsl:apply-templates select="colors" mode="utp-colors-item" />
    </xsl:template>

    <xsl:template match="udata" mode="utp-option-size-colors">
        <xsl:apply-templates select="colors" mode="utp-option-colors-item" />
    </xsl:template>

    <xsl:template match="colors" mode="colors-item">

        <xsl:variable name="pack" select="@count" />
        <xsl:variable name="takeout" select="document(concat('upage://', color/@id, '.takeout'))//value" />
        <xsl:variable name="id" select="color/@id" />
        <xsl:variable name="color_name" select="color/../@name" />
        <!-- <xsl:variable name="addCart" select="document('udata://emarket/cart')//item" /> -->
        <xsl:variable name="orderId" select="document('udata://emarket/cart')/udata/@id" />

            <xsl:choose>
                <xsl:when test="color">
                    <xsl:choose>
                        <xsl:when test="$takeout = '0'">
                            <tr id="size_{color/@id}" class="good_size">

                                <td class="cursorImage">
                                    <span class="arrow-blue">
                                        <xsl:if test="position() = 1">
                                            <xsl:attribute name="style" >
                                                <xsl:text>display:block;</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>
                                    </span>
                                    <span class="get-image" id="color_{color}">
                                        <xsl:if test="position() = 1">
                                            <xsl:attribute name="class" >
                                                <xsl:text>get-image active-color</xsl:text>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="@name" />
                                    </span>
                                </td>
                                <!--
                                <xsl:choose>
                                    <xsl:when test="document(concat('udata://users/getIdOptUser/', 'true'))/udata != 'utp'"> -->
                                        <td class="amount-color">
                                            <input type="text" name="amount" value="1" />
                                        </td>
                                        <td class="pack">
                                            <span class="in_pack" defvalue="{$pack}">
                                                <xsl:value-of select="$pack" />
                                            </span>
                                        </td>
                                <!--    </xsl:when>
                                    <xsl:otherwise>
                                        <td class="pack">
                                            <input type="pack" class="in_pack" value="1" />
                                        </td>
                                        <input type="hidden" name="amount" value="1" />
                                    </xsl:otherwise>
                                </xsl:choose> -->



                                <xsl:for-each select="color">
                                    <input type="hidden" name="id_element" class="elements" >
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="@id" />
                                        </xsl:attribute>
                                    </input>
                                </xsl:for-each>
                                <input type="hidden" name="colors-item" class="color_id">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="color" />
                                    </xsl:attribute>
                                </input>

                                <td class="button">

                                    <xsl:variable name="check" select="document('udata://emarket/getCurrentUser')/udata" />

                                    <a href="#order" >
                                        <xsl:choose>
                                            <xsl:when test="$check = 'good'">
                                                <xsl:attribute name="class">
                                                    <xsl:text>good sizeColors</xsl:text>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="class">
                                                    <xsl:text>not_auth </xsl:text>
                                                </xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>

                                        <!--    <xsl:value-of select="$addCart/item[contains(@itemsId, $id)][contains(@colorName, $colorName)]" /> -->
                                        <xsl:if test="$orderId != 'dummy'">
                                            <xsl:choose>
                                                <xsl:when test="document(concat('udata://emarket/getOrderItemsGroup/', $orderId))/udata/items/item[contains(@itemsId, $id)][contains(@colorName, $color_name)]">
                                                    В заказе
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    В заказ
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                        <xsl:if test="$orderId = 'dummy'">
                                            В заказ
                                        </xsl:if>

                                    </a>
                                    <xsl:if test="$orderId != 'dummy'">
                                        <xsl:choose>
                                            <xsl:when test="document(concat('udata://emarket/getOrderItemsGroup/', $orderId))/udata/items/item[contains(@itemsId, $id)][contains(@colorName, $color_name)]">
                                                <span class="totalPack">
                                                    <xsl:value-of select="document(concat('udata://emarket/getOrderItemsGroup/', $orderId))/udata/items/item[contains(@itemsId, $id)][contains(@colorName, $color_name)]/../item/@count" />
                                                </span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <span class="totalPack">
                                                    <span>0</span>
                                                </span>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                    <xsl:if test="$orderId = 'dummy'">
                                        <span class="totalPack">
                                            <span>0</span>
                                        </span>
                                    </xsl:if>
                                </td>
                            </tr>
                        </xsl:when>
                        <xsl:otherwise>
                            <tr id="size_{@id}" class="good_size">
                                <td>
                                    <xsl:value-of select="@name" />
                                </td>
                                <td colspan="5">Товара нет на складе</td>
                            </tr>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>


    </xsl:template>

    <xsl:template match="colors" mode="utp-colors-item">
        <xsl:variable name="type_user" select="document(concat('udata://users/getIdOptUser/', 'true'))/udata" />
        <xsl:choose>
            <xsl:when test="$type_user = 'utp'">
                <xsl:apply-templates select="color" mode="utp-color-select" />
            </xsl:when>
            <xsl:otherwise >
               <xsl:apply-templates select="color" mode="org-color-select" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="color" mode="org-color-select">

        <xsl:variable name="pack" select="1" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="@id" />

        <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />

        <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />

        <xsl:variable name="user_now_id" select="document('udata://users/getIdOptUser/true/true')/udata" />

      <!--  <xsl:variable name="id_in_basket" select="$addCart/item[contains(@name, $fullname)]/@id" /> -->

        <xsl:variable name="id_in_basket" select="document(concat('udata://emarket/getItemUserOrgFromBasketByName/', $main_user, '/', $id, '/', .))/udata" />
        <xsl:choose>
            <xsl:when test="$takeout = '0'">
                <tr id="size_{.}" class="good_size">
                    <xsl:attribute name="style">
                        <xsl:text>display:none</xsl:text>
                    </xsl:attribute>

                    <td >
                        <span >
                            <xsl:value-of select="document(concat('upage://', @id))/udata/page/name" />
                        </span>
                    </td>

                    <td class="pack">
                        <input name="amount"  value="1" />
                    </td>

                    <input type="hidden" name="pack" class="in_pack" value="1" />
                    <input type="hidden" name="userid"  >
                        <xsl:attribute name="value">
                            <xsl:value-of select="$user_now_id" />
                        </xsl:attribute>
                    </input>
                    <!--
                    <input type="hidden" name="mainid" >
                        <xsl:attribute name="value">
                            <xsl:value-of select="$main_user" />
                        </xsl:attribute>
                    </input> -->
                    <input type="hidden" name="id_element" class="elements" >
                        <xsl:attribute name="value">
                            <xsl:value-of select="@id" />
                        </xsl:attribute>
                    </input>
                    <input type="hidden" name="orgtype" >
                        <xsl:attribute name="value">
                            <xsl:value-of select="1" />
                        </xsl:attribute>
                    </input>

                    <input type="hidden" name="colors-item" class="color_id">
                        <xsl:attribute name="value">
                            <xsl:value-of select="." />
                        </xsl:attribute>
                    </input>

                    <!--<xsl:variable name="check" select="document(concat('udata://emarket/getBasketOrderByUserOpt/'))/udata" /> -->
                    <td class="button">

                        <xsl:variable name="check" select="document('udata://emarket/getCurrentUser')/udata" />
                        <a href="#order" id="{$orderId}">
                            <xsl:choose>
                                <xsl:when test="$check = 'good'">
                                    <xsl:attribute name="class">
                                        <xsl:text>good sizeColors</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="class">
                                        <xsl:text>not_auth </xsl:text>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="document(concat('uobject://', $orderId))//property[@name = 'stop_buys']/value">
                                <xsl:attribute name="class">
                                    <xsl:text>stoped_buys</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:choose>
                                <xsl:when test="$id_in_basket != ''">
                                    В заказе
                                </xsl:when>
                                <xsl:otherwise>
                                    В заказ
                                </xsl:otherwise>
                            </xsl:choose>

                        </a>

                        <xsl:choose>
                            <xsl:when test="$id_in_basket != ''">
                                <span class="totalPack">
                                    <xsl:value-of select="document(concat('uobject://', $id_in_basket))//property[@name = 'item_amount']/value" />
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="totalPack">
                                    <span>0</span>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>

                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr id="size_{.}" class="good_size">
                    <xsl:attribute name="style">
                        <xsl:text>display:none</xsl:text>
                    </xsl:attribute>
                    <td>
                        <xsl:value-of select="@name" />
                    </td>
                    <td colspan="5">Товара нет на складе</td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="color" mode="utp-color-select">

        <xsl:variable name="pack" select="1" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="@id" />

        <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />

        <xsl:variable name="type_user" select="document(concat('udata://users/getIdOptUser/', 'true'))/udata" />
        <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />

        <xsl:variable name="user_now_id" select="document('udata://users/getIdOptUser/true/true')/udata" />

      <!--  <xsl:variable name="id_in_basket" select="$addCart/item[contains(@name, $fullname)]/@id" /> -->

        <xsl:variable name="id_in_basket" select="document(concat('udata://emarket/getItemUserFromBasketByName/', $main_user, '/', $id, '/', $user_now_id, '/', .))/udata" />

        <xsl:choose>
            <xsl:when test="$takeout = '0'">
                <tr id="size_{.}" class="good_size">
                    <xsl:attribute name="style">
                        <xsl:text>display:none</xsl:text>
                    </xsl:attribute>

                    <td >
                        <span >
                            <xsl:value-of select="document(concat('upage://', @id))/udata/page/name" />
                        </span>
                    </td>

                    <td class="pack">
                        <input name="amount"  value="1" />
                    </td>

                    <input type="hidden" name="pack" class="in_pack" value="1" />
                    <input type="hidden" name="userid"  >
                        <xsl:attribute name="value">
                            <xsl:value-of select="$user_now_id" />
                        </xsl:attribute>
                    </input>

                    <input type="hidden" name="mainid" >
                        <xsl:attribute name="value">
                            <xsl:value-of select="$main_user" />
                        </xsl:attribute>
                    </input>
                    <input type="hidden" name="id_element" class="elements" >
                        <xsl:attribute name="value">
                            <xsl:value-of select="@id" />
                        </xsl:attribute>
                    </input>


                    <input type="hidden" name="colors-item" class="color_id">
                        <xsl:attribute name="value">
                            <xsl:value-of select="." />
                        </xsl:attribute>
                    </input>

                    <!--<xsl:variable name="check" select="document(concat('udata://emarket/getBasketOrderByUserOpt/'))/udata" /> -->
                    <td class="button">

                        <xsl:variable name="check" select="document('udata://emarket/getCurrentUser')/udata" />
                        <a href="#order" id="{$orderId}">
                            <xsl:choose>
                                <xsl:when test="$check = 'good'">
                                    <xsl:attribute name="class">
                                        <xsl:text>good sizeColors</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="class">
                                        <xsl:text>not_auth </xsl:text>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="document(concat('uobject://', $user_now_id))//property[@name = 'delete_from_buys']/value and $type_user = 'utp'">
                                    <xsl:attribute name="class">
                                        <xsl:text>not_utp</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:if test="document(concat('uobject://', $orderId))//property[@name = 'stop_buys']/value">
                                <xsl:attribute name="class">
                                    <xsl:text>stoped_buys</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:choose>
                                <xsl:when test="$id_in_basket != ''">
                                    В заказе
                                </xsl:when>
                                <xsl:otherwise>
                                    В заказ
                                </xsl:otherwise>
                            </xsl:choose>

                        </a>

                        <xsl:choose>
                            <xsl:when test="$id_in_basket != ''">
                                <span class="totalPack">
                                    <xsl:value-of select="document(concat('uobject://', $id_in_basket))//property[@name = 'item_amount']/value" />
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="totalPack">
                                    <span>0</span>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr id="size_{.}" class="good_size">
                    <xsl:attribute name="style">
                        <xsl:text>display:none</xsl:text>
                    </xsl:attribute>
                    <td>
                        <xsl:value-of select="@name" />
                    </td>
                    <td colspan="5">Товара нет на складе</td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="colors" mode="utp-option-colors-item">
        <option value="{@id_color}">
            <xsl:if test="position() = 1">
                <xsl:attribute name="selected" >
                    <xsl:text>selected</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="@name" />
        </option>
    </xsl:template>

    <xsl:template match="udata" mode="inCollections">
    </xsl:template>

    <xsl:template match="udata[page]" mode="inCollections">
        <xsl:param name="id" />

        <dt>Коллекции:</dt>
        <dd>
            <ul>
                <xsl:apply-templates select="page" mode="inCollections">
                    <xsl:with-param name="id" select="$id" />
                </xsl:apply-templates>
            </ul>
        </dd>
    </xsl:template>

    <xsl:template match="page" mode="inCollections">
        <xsl:param name="id" />

        <li>
            <a href="{@link}?startGood={$id}" class="goodColl">
                <xsl:value-of select="name" />
            </a>
        </li>
    </xsl:template>

    <xsl:template name="bigImage">
        <xsl:choose>
            <xsl:when test="//property[@name = 'image_1']/value">
                <!--<a href="{//property[@name = 'image_1']/value}" rel="lightbox[]"><img src="{document(concat('udata://system/makeThumbnailFull/(.', //property[@name = 'image_1']/value, ')/283/283/'))//src}" alt="{//property[@name = 'h1']/value}" /></a>-->
                <xsl:apply-templates select="//group[@name = 'images']/property[@type = 'img_file']" mode="imageCustom" />

            </xsl:when>
            <xsl:otherwise>
                <!--<div class="noImage">нет изображения</div>-->
                <img src="{$tpl}/img/not_image.jpeg" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="bigImageGroup">
        <xsl:choose>
            <xsl:when test="//property[@name = 'image_1']/value">

                <!--<a href="{//property[@name = 'image_1']/value}" rel="lightbox[]"><img src="{document(concat('udata://system/makeThumbnailFull/(.', //property[@name = 'image_1']/value, ')/283/283/'))//src}" alt="{//property[@name = 'h1']/value}" /></a>-->
                <xsl:apply-templates select="document(concat('udata://emarket/getImageWithColorFromItem/', @id))/udata/image_color" mode="imageCustomGroup" />
            </xsl:when>
            <xsl:otherwise>
                <!--<div class="noImage">нет изображения</div>-->
                <img src="{$tpl}/img/not_image.jpeg" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="image_color[1]" mode="imageCustomGroup">
        <xsl:variable name="patchImg"  select="info/@imageLink" />

        <a href="{info/@imageLink}" rel="lightbox[]" class="first big">
            <xsl:attribute name="id">
                <xsl:text>color_</xsl:text>
                <xsl:value-of select="info/@colorId" />
            </xsl:attribute>
            <img src="{document(concat('udata://system/makeThumbnailFull/(.',$patchImg,')/400/400/'))//src}"  width="283" />
        </a>  <!--  <img src="{$patchImg}" alt="{//property[@name = 'h1']/value}" width="283" /> -->
    </xsl:template>

    <xsl:template match="image_color" mode="imageCustomGroup">
        <xsl:variable name="patchImg"  select="info/@imageLink" />
        <a href="{info/@imageLink}" rel="lightbox[]" class="big">
            <xsl:attribute name="id">
                <xsl:text>color_</xsl:text>
                <xsl:value-of select="info/@colorId" />
            </xsl:attribute>
            <img src="{document(concat('udata://system/makeThumbnailFull/(.',$patchImg,')/400/400/'))//src}"  width="283" />
        </a>
    </xsl:template>

    <xsl:template match="property[1]" mode="imageCustom">
        <xsl:variable select="value" name="patchImg" />
        <a href="{value}" rel="lightbox[]" class="first big">
            <img src="{document(concat('udata://system/makeThumbnailFull/(.',$patchImg,')/400/400/'))//src}" alt="{//property[@name = 'h1']/value}" width="283" />
        </a>
    </xsl:template>

    <xsl:template match="property" mode="imageCustom">
        <xsl:variable select="value" name="patchImg" />
        <a href="{value}" rel="lightbox[]"  class="big">
            <img src="{document(concat('udata://system/makeThumbnailFull/(.',$patchImg,')/400/400/'))//src}" alt="{//property[@name = 'h1']/value}" width="283" />
        </a>
    </xsl:template>

    <xsl:template match="image_color" mode="smallImageGroup">
        <a href="#" >
            <xsl:attribute name="id">
                <xsl:text>color_</xsl:text>
                <xsl:value-of select="info/@colorId" />
            </xsl:attribute>
            <img src="{document(concat('udata://system/makeThumbnailFull/(.', info/@imageLink, ')/91/91/0/1'))//src}"  />
        </a>
    </xsl:template>

    <xsl:template match="value" mode="smallImage">
        <a href="#" >
            <img src="{document(concat('udata://system/makeThumbnailFull/(.', ., ')/91/91/0/1'))//src}" alt="{//property[@name = 'h1']/value}" />
        </a>
    </xsl:template>

    <xsl:template match="image_color" mode="numImageGroup">
        <li class="circle-color">
            <xsl:choose>
                <xsl:when test="info/@rgb">
                    <xsl:attribute name="style">
                        <xsl:text>background:rgb(</xsl:text>
                        <xsl:value-of select="info/@rgb" />
                        <xsl:text>);</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="style">
                        <xsl:text>display:none;</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>

    <xsl:template match="value" mode="numImage">
        <li>

        </li>
    </xsl:template>

    <xsl:template match="item" mode="sizes">
        <xsl:variable name="pack" select="document(concat('upage://', @id, '.pack'))//value" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="@id" />
        <xsl:variable name="addCart" select="document('udata://emarket/cart')//item" />



        <xsl:choose>
            <xsl:when test="$takeout=0">
                <tr id="size_{@id}" class="good_size">
                    <td>
                        <xsl:value-of select="." />
                    </td>

                            <td>
                                <input type="text" name="amount" value="1" />
                            </td>
                            <td class="pack">
                                <span class="in_pack" defvalue="{$pack}">
                                    <xsl:value-of select="$pack" />
                                </span>
                            </td>

                    <td class="button">

                        <xsl:variable name="check" select="document(concat('udata://emarket/getCurrentUser', '/',@id))//udata" />
                        <xsl:variable name="orgId" select="document(concat('udata://users/getIdOptUser/', 'true', '/', 'true'))/udata" />
                        <xsl:choose>
                            <xsl:when test="document(concat('uobject://', $orgId))//property[@name = 'org_type']/value">
                                <input type="hidden" class="orgtype" name="orgtype" value="1" />
                            </xsl:when>
                            <xsl:otherwise>
                            </xsl:otherwise>
                        </xsl:choose>
                        <a href="#order">
                            <xsl:choose>
                                <xsl:when test="$check = 'good'">
                                    <xsl:attribute name="class">
                                        <xsl:text>good</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="class">
                                        <xsl:text>not_auth</xsl:text>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="$addCart/page[@id = $id]">
                                    В заказе
                                </xsl:when>
                                <xsl:otherwise>
                                    В заказ
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                        <xsl:choose>
                            <xsl:when test="$addCart/page[@id = $id]">
                                <span class="totalPack">
                                    <xsl:value-of select="$addCart/page[@id = $id]/../amount * $pack" />
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="totalPack">
                                    <span>0</span>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr id="size_{@id}" class="good_size">
                    <td>
                        <xsl:value-of select="." />
                    </td>
                    <td colspan="3">Товара нет на складе</td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="item" mode="utpSizes">
        <xsl:variable name="pack" select="document(concat('upage://', @id, '.pack'))//value" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="@id" />
        <xsl:variable name="addCart" select="document('udata://emarket/cart')//item" />

        <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />
        <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />

        <xsl:variable name="user_now_id" select="document('udata://users/getIdOptUser/true/true')/udata" />
        <xsl:variable name="id_in_basket" select="document(concat('udata://emarket/getItemUserFromBasketByName/', $main_user, '/', $id, '/', $user_now_id))/udata" />

        <xsl:choose>
            <xsl:when test="$takeout=0">
                <tr id="size_{@id}" class="good_size">
                    <td>
                        <xsl:value-of select="." />
                    </td>

                    <td class="pack">
                        <input name="amount"  value="1" />
                    </td>
               <!--     <input type="hidden" name="pack" class="in_pack" value="1" /> -->
                    <input type="hidden" name="userid"  >
                        <xsl:attribute name="value">
                           <xsl:value-of select="$user_now_id" />
                        </xsl:attribute>
                    </input>

                    <input type="hidden" name="mainid" >
                        <xsl:attribute name="value">
                           <xsl:value-of select="$main_user" />
                        </xsl:attribute>
                    </input>
                    <input type="hidden" name="id_element" class="elements" >
                        <xsl:attribute name="value">
                           <xsl:value-of select="@id" />
                        </xsl:attribute>
                    </input>
                    <td class="button">

                        <xsl:variable name="check" select="document(concat('udata://emarket/getCurrentUser', '/',@id))//udata" />

                        <a href="#order" id="{$orderId}">
                            <xsl:choose>
                                <xsl:when test="$check = 'good'">
                                    <xsl:attribute name="class">
                                        <xsl:text>good sizeColors</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="class">
                                        <xsl:text>not_auth</xsl:text>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="document(concat('uobject://', $orderId))//property[@name = 'stop_buys']/value">
                                <xsl:attribute name="class">
                                    <xsl:text>stoped_buys</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:choose>
                                <xsl:when test="$id_in_basket">
                                    В заказе
                                </xsl:when>
                                <xsl:otherwise>
                                    В заказ
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                        <xsl:choose>

                            <xsl:when test="$id_in_basket != ''">
                                <!-- <xsl:value-of select="$id_in_basket" /> -->
                                <span class="totalPack">
                                    <xsl:value-of select="document(concat('uobject://', $id_in_basket))//property[@name = 'item_amount']/value" />
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="totalPack">
                                    <span>0</span>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr id="size_{@id}" class="good_size">
                    <td>
                        <xsl:value-of select="." />
                    </td>
                    <td colspan="3">Товара нет на складе</td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="item" mode="orgSizes">
        <xsl:variable name="pack" select="document(concat('upage://', @id, '.pack'))//value" />
        <xsl:variable name="takeout" select="document(concat('upage://', @id, '.takeout'))//value" />
        <xsl:variable name="id" select="@id" />
        <xsl:variable name="addCart" select="document('udata://emarket/cart')//item" />

        <xsl:variable name="main_user" select="document('udata://users/getIdOptUser/')/udata" />
        <xsl:variable name="orderId" select="document(concat('udata://emarket/getOrderNow/', $main_user))/udata" />

        <xsl:variable name="user_now_id" select="document('udata://users/getIdOptUser/true/true')/udata" />
        <xsl:variable name="id_in_basket" select="document(concat('udata://emarket/getItemUserOrgFromBasketByName/', $main_user, '/', $id))/udata" />

        <xsl:choose>
            <xsl:when test="$takeout=0">
                <tr id="size_{@id}" class="good_size">
                    <td>
                        <xsl:value-of select="." />
                    </td>

                    <td class="pack">
                        <input name="amount"  value="1" />
                    </td>
                    <input type="hidden" name="orgtype" >
                        <xsl:attribute name="value">
                            <xsl:value-of select="1" />
                        </xsl:attribute>
                    </input>
               <!--     <input type="hidden" name="pack" class="in_pack" value="1" /> -->
                    <input type="hidden" name="userid"  >
                        <xsl:attribute name="value">
                           <xsl:value-of select="$user_now_id" />
                        </xsl:attribute>
                    </input>
                    <input type="hidden" name="mainid" class="mainid" >
                        <xsl:attribute name="value">
                           <xsl:value-of select="$main_user" />
                        </xsl:attribute>
                    </input>
                    <input type="hidden" name="id_element" class="elements" >
                        <xsl:attribute name="value">
                           <xsl:value-of select="@id" />
                        </xsl:attribute>
                    </input>
                    <td class="button">

                        <xsl:variable name="check" select="document(concat('udata://emarket/getCurrentUser', '/',@id))//udata" />

                        <a href="#order" id="{$orderId}">
                            <xsl:choose>
                                <xsl:when test="$check = 'good'">
                                    <xsl:attribute name="class">
                                        <xsl:text>good </xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="class">
                                        <xsl:text>not_auth</xsl:text>
                                    </xsl:attribute>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="document(concat('uobject://', $orderId))//property[@name = 'stop_buys']/value">
                                <xsl:attribute name="class">
                                    <xsl:text>stoped_buys</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:choose>
                                <xsl:when test="$id_in_basket">
                                    В заказе
                                </xsl:when>
                                <xsl:otherwise>
                                    В заказ
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                        <xsl:choose>

                            <xsl:when test="$id_in_basket != ''">
                                <!-- <xsl:value-of select="$id_in_basket" /> -->
                                <span class="totalPack">
                                    <xsl:value-of select="document(concat('uobject://', $id_in_basket))//property[@name = 'item_amount']/value" />
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="totalPack">
                                    <span>0</span>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr id="size_{@id}" class="good_size">
                    <td>
                        <xsl:value-of select="." />
                    </td>
                    <td colspan="3">Товара нет на складе</td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="udata[@module = 'emarket'][@method = 'price']" mode="good">
        <xsl:if test="price/original > 0">
            <span style="text-decoration: line-through;color:red">&#0160;
                <xsl:value-of select="format-number(price/original,'#.0')" />&#0160;
            </span>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:variable name="price_new" select="price/original - price/actual" />

        <xsl:variable name="price_sec" select="$price_new div price/original"/>
        <xsl:variable name="price_thic" select="$price_sec * 100" />
        <span class="orig_price">
            <xsl:value-of select="format-number(price/actual,'#.0')" />
        </span>
        <xsl:if test="price/original > 0">
            <span class="procent_price" style="color: #ff8000; position:relative; "> -<xsl:value-of select="format-number($price_thic,'#')" />% </span>
        </xsl:if>
    </xsl:template>


</xsl:stylesheet>