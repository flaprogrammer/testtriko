<?xml version="1.0" encoding="UTF-8"?>
 
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common">

	<xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="UTF-8" indent="no" />
	
	<xsl:param name="start" select="'0'" />
	<xsl:param name="header" />
	<xsl:param name="limit" select="'50'" />
	<xsl:param name="preview" select="'1'" />
	<xsl:template match="/">
		
		<xsl:variable name="pre_pages">
			<xsl:apply-templates select="udata/page" mode="pre">
				<xsl:sort select="@parentId" order="ascending" />
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:variable name="pages" select="exsl:node-set($pre_pages)/*" />
		
		<udata>
			<count><xsl:value-of select="count($pages)" /></count>
			<table>
				<xsl:apply-templates select="$pages[position() &gt; $start and position() &lt;= ($start + $limit)]" />
			</table>
		</udata>
	</xsl:template>
	
	<xsl:template match="page" mode="pre">
		
		<xsl:copy-of select="." />
	</xsl:template>
	

	<xsl:template match="page">
		
		<xsl:variable name="parentId" select="@parentId" />
		<xsl:variable name="categoryId" select="document(concat('udata://custom/getParent/', @parentId))/udata" />
		<xsl:variable name="position" select="position() + $start" />
		
		<xsl:if test="@parentId != $header and (position() = 1 or ../*[position() = $position - 1]/@parentId != $parentId)">
			<tr class="header" id="header_{@parentId}" parent="{$categoryId}" parentH1="{document(concat('upage://', $categoryId, '.h1'))//value}">
				<td colspan="4"><xsl:value-of select="document(concat('upage://', @parentId, '.h1'))//value" /></td>
			</tr>
		</xsl:if>
		
		<tr id="tr{@id}" class="good" >
                        
			<td class="code"><a href="#{@id}" pageId="{@id}" class="@link"><xsl:value-of select="document(concat('upage://', @id, '.code'))//value" /></a></td>
			<td><a href="#{@id}" pageId="{@id}"><xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" /></a></td>
			<td class="prices"><a href="#{@id}" pageId="{@id}"><xsl:value-of select="document(concat('upage://', @id, '.sizes'))//value" /></a></td>
			<td class="price"><a href="#{@id}" pageId="{@id}"><xsl:apply-templates select="document(concat('udata://emarket/price/', @id))/udata" mode="catalog" /></a></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="page[@type-id = '118']">
            <script type="text/javascript">
                    $(document).ready(function() {
                setTimeout(function() {
                        $('#info #content #goods #table tr.for_image_active td.this_product a').mouseover(function(){
                           // alert('sd');
                            var new_titel = $(this).parents('tr.for_image_active').attr('id');
                            var id_new = new_titel.replace(/tr/g, '');
                            var src = $(this).parents('tr.for_image_active').find('.img_ready p').text();
                           
                            $('div.image_good img.take_src').attr('src', src);
                            $('div.preview_image').css('display', 'block');
                          
                        }).mousemove(function(kmouse){
                           
                            $('div.image_good').css('left', kmouse.pageX+15);
                            $('div.image_good').css('top', kmouse.pageY+15);
                            // alert(id_new);
                        }).mouseout(function(){
                               
                           //   alert(id_new);
                            //   $('div.preview_image').fadeOut(400);
                                $('div.preview_image').css('display', 'none');
                        });
                   
                }, 2000);   
                 }); 
		</script>
		<xsl:variable name="parentId" select="@parentId" />
		<xsl:variable name="categoryId" select="document(concat('udata://custom/getParent/', @parentId))/udata" />
		<xsl:variable name="position" select="position() + $start" />
		
		<xsl:if test="@parentId != $header and (position() = 1 or ../*[position() = $position - 1]/@parentId != $parentId)">
			<tr class="header" id="header_{@parentId}" parent="{$categoryId}" parentH1="{document(concat('upage://', $categoryId, '.h1'))//value}">
				<td colspan="4"><xsl:value-of select="document(concat('upage://', @parentId, '.h1'))//value" /></td>
			</tr>
		</xsl:if>
                <xsl:choose>
                    <xsl:when test="$preview = 1">
		
                        <tr id="tr{@id}" class="good ">

                                <td class="code"><a href="#{@id}" pageId="{@id}" class="{@link}">
                                    <xsl:value-of select="document(concat('upage://', @id, '.code'))//value" />
                                </a>
                                </td>
                                <xsl:choose>
                                    <xsl:when test="document(concat('upage://', @id))//property[@name = 'sale_size_rows']/value" >
                                        <td class="poom"><a href="#{@id}" pageId="{@id}"><xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" /></a><span class="size-group">PP</span></td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td class="poom"><a href="#{@id}" pageId="{@id}"><xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" /></a></td>
                                    </xsl:otherwise>
                                </xsl:choose>       
                                
                                <td class="prices"><a href="#{@id}" pageId="{@id}"><xsl:value-of select="document(concat('upage://', @id, '.sizes'))//value" /></a></td>
                                <td class="price"><a href="#{@id}" pageId="{@id}"><xsl:apply-templates select="document(concat('udata://emarket/price/', @id))/udata" mode="catalog" /></a></td>
                        </tr>
                    </xsl:when>	
                    <xsl:otherwise>
                             
                        <xsl:variable name="srces" select="document(concat('upage://', @id))//property[@name = 'image_1']/value" />
                        <xsl:variable name="ready_image" select="document(concat('udata://system/makeThumbnailFull/(.', $srces, ')/120/120/1/1/1/1'))//src" /> 
                        <tr id="tr{@id}" class="good for_image_active"  >
                                <td class="code"><a href="#{@id}" pageId="{@id}" class="{@link}">
                                   <div class="img_ready" style="display:none;"><p><xsl:value-of select="$ready_image" /></p></div>
                                    <xsl:value-of select="document(concat('upage://', @id, '.code'))//value" />
                                </a>
                                </td>


                                <td class="this_product"><a href="#{@id}" pageId="{@id}"><xsl:value-of select="document(concat('upage://', @id, '.h1'))//value" /></a></td>
                                <td class="prices"><a href="#{@id}" pageId="{@id}"><xsl:value-of select="document(concat('upage://', @id, '.sizes'))//value" /></a></td>
                                <td class="price"><a href="#{@id}" pageId="{@id}"><xsl:apply-templates select="document(concat('udata://emarket/price/', @id))/udata" mode="catalog" /></a></td>
                        </tr>
                    </xsl:otherwise>
                </xsl:choose>
	</xsl:template>
	

	
	<xsl:template match="udata[@module = 'emarket'][@method = 'price']" mode="catalog">
		<xsl:choose>
			<xsl:when test="price/original">
				<xsl:variable name="price_new" select="price/original - price/actual" />
				
				<xsl:variable name="price_sec" select="$price_new div price/original"/>
				<xsl:variable name="price_thic" select="$price_sec * 100" />
				<div class="sale">-<xsl:value-of select="format-number($price_thic,'#')" />% </div>
				<xsl:value-of select="format-number(price/actual,'#.0')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number(price/actual,'#.0')" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		
</xsl:stylesheet>