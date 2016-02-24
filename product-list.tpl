{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
    *  @copyright  2007-2014 PrestaShop SA
    *  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
    *  International Registered Trademark & Property of PrestaShop SA
    *}
    {if isset($products) && $products}
    {*define numbers of product per line in other page for desktop*}
    {if $page_name !='index' && $page_name !='product'}
    {assign var='nbItemsPerLine' value=3}
    {assign var='nbItemsPerLineTablet' value=2}
    {assign var='nbItemsPerLineMobile' value=3}
    {else}
    {assign var='nbItemsPerLine' value=4}
    {assign var='nbItemsPerLineTablet' value=3}
    {assign var='nbItemsPerLineMobile' value=2}
    {/if}
    {*define numbers of product per line in other page for tablet*}
    {assign var='nbLi' value=$products|@count}
    {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
    {math equation="nbLi/nbItemsPerLineTablet" nbLi=$nbLi nbItemsPerLineTablet=$nbItemsPerLineTablet assign=nbLinesTablet}
    <style>
        .product-container {
            padding-top: 150px;
        }
        .left-block .content_price
        {
            display:none !important;
        }
        .right-block .content_price
        {
            display:inline-block !important;
        }
        .button-container
        {
            display:none !important;
        }
        .wishlist
        {
            display:none !important;
        }
        .functional-buttons
        {
            padding: 0px 0 0px !important;
        }


        .color-list-container img
        {
            width: 35px !important;
            height: 35px !important;
			
        }

        .taille-list-container
        {
            margin:0px;
            padding:11px;
            color: #fff;
            line-height: 2.0;
            text-align:center;
        }
        .product-image-container
        {
            padding:0px !important;
        }
        .product-container .taille-list-container
        {
            width: 263px;
            height: 250px;
            background-color: #000;
            position: absolute;
            opacity: 0.5;
            z-index:1;
        }
        .newbox
        {
            margin-right: 10px;
            font-weight: 600;
            font-family: "Open Sans", sans-serif;
            font-size: 18px;
            line-height: 20px;
            background: #f13340;
            border: 1px solid #d02a2c;
            z-index:1000;
            position:relative;
        }
        .new-box
        {
            width:101px !important;
            padding-top:20px;
            padding-left:20px;
        }

        @media screen and (max-width:1024px)
        {
            .img-responsive {
                max-width: 93%;
            }
            .taille-list-container
            {
                padding: 11px !important;
                line-height: 1.5 !important;
                margin:0px !important;
                color: #fff !important;
                text-align:center !important;
            }
            .product-image-container
            {
                padding:0px !important;
            }
            .product-container .taille-list-container {
                width: 213px !important;
                height: 213px !important;
                background-color: #000 !important;
                position: absolute !important;
                z-index:1 !important;

            }	
            ul.product_list.grid > li.hovered .product-container {
                -webkit-box-shadow: rgba(0, 0, 0, 0.17) 0 0 13px !important;
                -moz-box-shadow: rgba(0, 0, 0, 0.17) 0 0 13px !important;
                box-shadow: rgba(0, 0, 0, 0.17) 0 0 13px !important;
                position: relative !important;
                z-index: 10 !important; }
            ul.product_list.grid > li.hovered .product-container .content_price {
                display: none !important; }
            ul.product_list.grid > li.hovered .product-container .product-image-container .content_price {
                display: block !important; }
            ul.product_list.grid > li.hovered .product-container .product-image-container .quick-view {
                display: block !important; }
            ul.product_list.grid > li.hovered .product-container .taille-list-container {
                display: block !important; }
            ul.product_list.grid > li.hovered .product-container .mindeclinaison {
                display: block !important; }
            ul.product_list.grid > li.hovered .product-container .functional-buttons,
            ul.product_list.grid > li.hovered .product-container .button-container,
            ul.product_list.grid > li.hovered .product-container .comments_note {
                display: block !important; }
        }
        @media screen and (max-width:800px)
        {
            .product-container .taille-list-container h6
            {
                color: #585C62 !important;
            }
            .product-container
            {
                float:left;
            }
            .taille-list-container
            { 

                margin:0px;
                color: #585C62;
                line-height: 1;
                text-align:none;
            }
            .product-container .taille-list-container
            {
                left: 280px !important;
                top:110px;
                float:right;
                width: 100% !important;
                height: 200px;
                background-color: #fff !important;
                display:inline;
                position:absolute;
                opacity:1;
                padding-top:5px !important;
            }
            .right-block .content_price
            {
                left: 280px;
                top: 0px;
                float: right;
                position: absolute;
                background-color: #000;
                opacity: 0.6;
                width: 100%;
            }
            .right-block .product-name
            {
                left: 280px;
                top: 40px;
                float: right;
                position: absolute;
                text-align: center;
                width: 100% !important;
            }
            .right-block .product-desc
            {
                display:none !important;
            }
            ul.product_list.grid > li
            {
                width:150% !important;
            }
        }
        @media screen and (min-device-width: 479px) and (max-device-width: 600px)
        {
            ul.product_list.grid > li .product-container
            {
                left: 25px;
            }
        }
        @media screen and (min-width: 319px) and (max-width: 480px) 
        {
            .product-container
            {
                float:left;
            }
            .taille-list-container
            { 
                font-size:12px;
                margin:0px;
                color: #585C62;
                line-height: 1;
                text-align:none;
            }
            .product-container .taille-list-container
            {
                left:260px !important;
                top:104px;
                float:right;
                width: 90% !important;
                height: 85%;
                background-color: #fff;
                display:inline;
                opacity:1;
                padding-top:5px !important;	
            }
            .product-container .taille-list-container h6
            {
                margin-right:15px;
            }
            .right-block .content_price {
                left: 260px !important;
                width: 80% !important;
            }
            .right-block .product-name
            {
                left:260px;
                top:65px;
                float:right;
                display:inline;
                position:absolute;
                text-align:center;
                z-index:1;
                width:80% !important;
            }
            .right-block .product-desc
            {
                display:none !important;
            }
            ul.product_list.grid > li
            {
                width:59% !important;
                height:100%;
            }
            ul.product_list.grid > li .product-container .product-image-container .product_img_link img
            {
                background:none;
            }
            ul.product_list.grid > li .product-container {
                left: 0px !important;
            }
        }

		/**************************************/			
        /*             Max width 375         */
        /*************************************/	
		
		 @media screen and (max-width:475px) 
{

            .product-container .taille-list-container h6 {
                margin-right: 0px;
            }
            .columns-container .container {
                top: 60px !important;
            }
            .product-container
            {
                float:left !important;
            }
            .taille-list-container
            { 
                font-size:12px !important;
                margin:0px !important;
                color: #585C62 !important;
                line-height: 1 !important;
                text-align:none !important;
            }
            .product-container .taille-list-container
            {
                margin-left: -245px !important;
                top: 326px !important;
                float:right;
                width: 100%!important !important;
                background-color: #fff !important;
                display:inline !important;
                opacity:1 !important;
                padding-top:5px !important !important;
                font-size:14px !important;
            }
            .product-container .taille-list-container h6
            {
                text-align:center !important;
                font-size:13px !important;
            }
            .right-block .product-desc
            {
                display:none !important;
            }
            ul.product_list.grid > li
            {
                width:59% !important;
                height:100% !important;
            }
            ul.product_list.grid > li .product-container .product-image-container .product_img_link img
            {
                padding-top: 0px !important;
                background: none !important;
                margin-left: 3px !important;
            }
            .right-block .content_price
            {
                left: 0px !important;
                top: 260px !important;
                width: 100% !important;
            }
            .right-block .product-name
            {
                left: 0px !important;
                top: 300px !important;
                width: 100% !important;
            }
            .product_img_link .img-responsive
            {
                max-width: 155% !important;
            }
            .product-container
            {
                margin-bottom: 20px !important;
            }
            .bottom-pagination-content
            {
                border-top:none !important;
            }
            ul.product_list.grid > li .product-container .content_price
            {
                line-height: 10px !important;
            }
            .left-block {
                margin-bottom: 150px !important;
            }
            ul.product_list.grid > li .product-container {
                width: 155% !important;
                height: 540px !important;
            }
            ul.product_list.grid > li .product-container {
                left: 15px;
            }
		
		}
		
		
        /**************************************/			
        /*             Max width 320         */
        /*************************************/	

        @media screen and (max-width:320px)
        {
            .product-container .taille-list-container h6 {
                margin-right: 0px;
            }
            .columns-container .container {
                top: 60px !important;
            }
            .product-container
            {
                float:left !important;
            }
            .taille-list-container
            { 
                font-size:12px !important;
                margin:0px !important;
                color: #585C62 !important;
                line-height: 1 !important;
                text-align:none !important;
            }
            .product-container .taille-list-container
            {
                margin-left: -245px !important;
                top: 326px !important;
                float:right;
                width: 100%!important !important;
                background-color: #fff !important;
                display:inline !important;
                opacity:1 !important;
                padding-top:5px !important !important;
                font-size:14px !important;
            }
            .product-container .taille-list-container h6
            {
                text-align:center !important;
                font-size:13px !important;
            }
            .right-block .product-desc
            {
                display:none !important;
            }
            ul.product_list.grid > li
            {
                width:59% !important;
                height:100% !important;
            }
            ul.product_list.grid > li .product-container .product-image-container .product_img_link img
            {
                padding-top: 0px !important;
                background: none !important;
                margin-left: 3px !important;
            }
            .right-block .content_price
            {
                left: 0px !important;
                top: 260px !important;
                width: 100% !important;
            }
            .right-block .product-name
            {
                left: 0px !important;
                top: 300px !important;
                width: 100% !important;
            }
            .product_img_link .img-responsive
            {
                max-width: 155% !important;
            }
            .product-container
            {
                margin-bottom: 20px !important;
            }
            .bottom-pagination-content
            {
                border-top:none !important;
            }
            ul.product_list.grid > li .product-container .content_price
            {
                line-height: 10px !important;
            }
            .left-block {
                margin-bottom: 150px !important;
            }
            ul.product_list.grid > li .product-container {
                width: 155% !important;
                height: 540px !important;
            }
            ul.product_list.grid > li .product-container {
                left: 15px;
            }
        }


    </style>
    <!-- Products list -->
    <ul{if isset($id) && $id} id="{$id}"{/if} class="product_list grid row{if isset($class) && $class} {$class}{/if}">
        {foreach from=$products item=product name=products}
        {math equation="(total%perLine)" total=$smarty.foreach.products.total perLine=$nbItemsPerLine assign=totModulo}
        {math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
        {math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineMobile assign=totModuloMobile}
        {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
        {if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
        {if $totModuloMobile == 0}{assign var='totModuloMobile' value=$nbItemsPerLineMobile}{/if}

        <li class="ajax_block_product{if $page_name == 'index' || $page_name == 'product'} col-xs-12 col-sm-4 col-md-3{else} col-xs-12 col-sm-6 col-md-4{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLine == 1} first-in-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModulo)} last-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 0} last-item-of-tablet-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 1} first-item-of-tablet-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 0} last-item-of-mobile-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 1} first-item-of-mobile-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModuloMobile)} last-mobile-line{/if}">
            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                {assign var='nbimage' value=$product.images_combinations|@count}
                {if $nbimage > 1}
                {assign var="id_image" value="-"|explode:$product.id_image}
                <div class="mindeclinaison">
                    <a href="#" class="prevPage" id="{$product.id_product}"><img src="{$img_dir}icon/ascendant.png" /></a>
                    <div class="frame-mindeclinaison" id="{$product.id_product}">
                        <ul class="mindeclinaison-list-container" align="center">
                            {foreach $product.images_combinations as $id_image_product_attribute => $image_combination}
                            {if $id_image_product_attribute != $id_image[1]}
                            <li>
                                <a href="{$link->getProductLink($product.id_product, null, null, null, null, null, $image_combination)|escape:'html':'UTF-8'}">
                                    <img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $id_image_product_attribute, 'cart_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" itemprop="image" />
                                </a>
                            </li>
                            {/if}
                            {/foreach}
                        </ul>
                    </div>
                    <ul class="pages"></ul>
                    <a href="#" class="nextPage" id="{$product.id_product}"><img src="{$img_dir}icon/chevron.png" /></a>
                </div>
                {/if}

                <div class="left-block">
                    <div class="product-image-container">
                        <!------------------------------>

                        {if !empty($product.attributes)}
                        <div  class="taille-list-container">
                            <h6>{l s='NOS TAILLES DISPONIBLES'}</h6>
                            {foreach $product.attributes as $attribute_name => $attribute_stock }
                            {*foreach $product.attributes|@sortby:"name" as $attribute_name => $attribute_stock *}
							
							{*foreach from=$product.attributes  item=attribute_stock key=attribute_name *}  
                            {if !$attribute_stock@first}
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            {/if}
                            {if $attribute_stock == 0}
                            <s>{$attribute_name}</s>
                            {else}
                            <a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute)|escape:'html':'UTF-8'}">
                                {$attribute_name|escape:'html':'UTF-8'}
                            </a>
                            <!--a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" onclick="document.getElementById($attribute_name)|escape:'html':'UTF-8'" id="size_{$attribute_name|intval}" name="{$attribute_name|escape:'html':'UTF-8'}" class="size_pick{if ($product.default == $attribute_name)} selected{/if}" title="{$attribute_name|escape:'html':'UTF-8'}" style="  text-decoration : none !important ">
                            {$attribute_name|escape:'html':'UTF-8'}
                            </a-->
                            {/if}
                            {/foreach}
							<br>

                            <br>
							
							{assign var="idprod" value=$product.id_product}
                            <ul align="center" class="color-list-container" style="margin-bottom : 4px"> 
                                <h6 style="margin-bottom : 4px">{$allcolorsproducts.$idprod|count} {l s='COULEURS DISPONIBLES'} </h6>
									{if isset($allcolorsproducts)}
										
									
										{foreach from=$allcolorsproducts key=id_attribute item='colora'} 
												{if $product.id_product == $id_attribute}
													{*$id_attribute*}
													
												
													{foreach from=$allcolorsproducts.$id_attribute key=id_at item='col'} 
														   
															{foreach from=$col key=id_prod_col item='prod_col' } 
															
															
															{*$category->id*}
																{*if $product.id_product != $prod_col.id_product_attribute && $category->id == $prod_col.id_category_default *}
																{if  $category->id == $prod_col.id_category_default }
																
																	<li align="center" style="width : 20% !important ; float : left ; margin :1px   /*margin-left  : 10px !important ;*/"  >
																		<a href="{$link->getProductLink($prod_col.id_product_attribute)|escape:'html':'UTF-8'}" id="color_{$prod_col.id_product_attribute|intval}" name="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" class="color_pick{if ($group.default == $id_attribute)} selected{/if}"{if !$img_color_exists && isset($colors.$id_attribute.value) && $colors.$id_attribute.value} style="background:{$colors.$id_attribute.value|escape:'html':'UTF-8'};"{/if} title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}">
																			<img class="replace-2x img-responsive" src="{$link->getImageLink($prod_col.id_image , $prod_col.id_image , 'large_default' )|escape:'html':'UTF-8'}" alt="{$colors.$id_attribute.name|escape:'html':'UTF-8'}"  title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" itemprop="image" />
																		</a>
																	</li>	
																	
																{/if}
															{/foreach}	
													{/foreach}	
												{/if}
											<!--li style="margin-left  : 10px !important ;"  >
												<a href="{$link->getProductLink($id_attribute)|escape:'html':'UTF-8'}" id="color_{$id_attribute|intval}" name="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" class="color_pick{if ($group.default == $id_attribute)} selected{/if}"{if !$img_color_exists && isset($colors.$id_attribute.value) && $colors.$id_attribute.value} style="background:{$colors.$id_attribute.value|escape:'html':'UTF-8'};"{/if} title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}">
													<img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$colors.$id_attribute.name|escape:'html':'UTF-8'}"  title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" itemprop="image" />
												</a>
											</li-->		
										{/foreach}						
									{else}
											no colors list
									{/if}
                                {if isset($product.color)}
                                {*foreach from=$product.color key=id_attribute item='color'} 
									<li style="margin-left  : 10px !important ;  {if $product.color == $id_attribute} class="selected"{/if}>
									
										<a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" id="color_{$id_attribute|intval}" name="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" class="color_pick{if ($group.default == $id_attribute)} selected{/if}"{if !$img_color_exists && isset($colors.$id_attribute.value) && $colors.$id_attribute.value} style="background:{$colors.$id_attribute.value|escape:'html':'UTF-8'};"{/if} title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}">
											<img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$colors.$id_attribute.name|escape:'html':'UTF-8'}"  title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" itemprop="image" />
										</a>
									</li>
                                {/foreach*}	

                                {/if}
                            </ul>

                        </div>
                        {/if}

                        <!------------------------------>

                        <a class="product_img_link"	href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
                            <img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} itemprop="image" />
                        </a>

                        {if isset($quick_view) && $quick_view}
                        <div class="quick-view-wrapper-mobile">
                            <a class="quick-view-mobile" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
                                <i class="icon-eye-open"></i>
                            </a>
                        </div>
                        <a class="quick-view" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
                            <span>{l s='Quick view'}</span>
                        </a>
                        {/if}

                        {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                        <div class="content_price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                            {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
                            <span itemprop="price" class="price product-price">
                                {if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
                            </span>
                            <meta itemprop="priceCurrency" content="{$currency->iso_code}" />
                            {if isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
                            {hook h="displayProductPriceBlock" product=$product type="old_price"}
                            <span class="old-price product-price">
                                {displayWtPrice p=$product.price_without_reduction}
                            </span>
                            {if $product.specific_prices.reduction_type == 'percentage'}
                            <span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
                            {/if}
                            {/if}
                            {hook h="displayProductPriceBlock" product=$product type="price"}
                            {hook h="displayProductPriceBlock" product=$product type="unit_price"}
                            {/if}
                        </div>
                        {/if}

                        {if isset($product.new) && $product.new == 1}
                        <a class="new-box" href="{$product.link|escape:'html':'UTF-8'}">
                            <span class="newbox">
                                <span class="newlabel" style="text-align:center; color:#fff;">{l s='New'}</span>
                            </span></a>
                        {/if}


                        <!--{if isset($product.new) && $product.new == 1}
                                <a class="new-box" href="{$product.link|escape:'html':'UTF-8'}">
                                        <span class="new-label">{l s='New'}</span>
                                        
                                </a>
                        {/if}-->
                        {if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
                        <a class="new-box" href="{$product.link|escape:'html':'UTF-8'}">
                            <span class="newbox">
                                <span class="newlabel" style="text-align:center; color:#fff;">{l s='Sale!'}</span>
                            </span></a>
                        <!--<a class="sale-box" href="{$product.link|escape:'html':'UTF-8'}">
                                <span class="sale-label">{l s='Sale!'}</span>
                        </a>-->
                        {/if}
                    </div>
                    {hook h="displayProductDeliveryTime" product=$product}
                    {hook h="displayProductPriceBlock" product=$product type="weight"}
                </div>

                <div class="right-block">



                    <h5 itemprop="name">
                        {if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
                        <a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
                            {$product.name|truncate:45:'...'|escape:'html':'UTF-8'}
                        </a>
                    </h5>



                    {hook h='displayProductListReviews' product=$product}
                    <p class="product-desc" itemprop="description">
                        {$product.description_short|strip_tags:'UTF-8'|truncate:360:'...'}
                    </p>
                    {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                    <div itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="content_price">
                        {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
                        <span itemprop="price" class="price product-price">
                            {if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
                        </span>
                        <meta itemprop="priceCurrency" content="{$currency->iso_code}" />
                        {if isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
                        {hook h="displayProductPriceBlock" product=$product type="old_price"}
                        <span class="old-price product-price">
                            {displayWtPrice p=$product.price_without_reduction}
                        </span>
                        {hook h="displayProductPriceBlock" id_product=$product.id_product type="old_price"}
                        {if $product.specific_prices.reduction_type == 'percentage'}
                        <span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
                        {/if}
                        {/if}
                        {hook h="displayProductPriceBlock" product=$product type="price"}
                        {hook h="displayProductPriceBlock" product=$product type="unit_price"}
                        {/if}
                    </div>
                    {/if}
                    <div class="button-container">
                        {*
                        {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.minimal_quantity <= 1 && $product.customizable != 2 && !$PS_CATALOG_MODE}
                        {if (!isset($product.customization_required) || !$product.customization_required) && ($product.allow_oosp || $product.quantity > 0)}
                        {if isset($static_token)}
                        <a class="button ajax_add_to_cart_button btn btn-default" href="{$link->getPageLink('cart',false, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;token={$static_token}", false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product="{$product.id_product|intval}">
                           <span>{l s='Add to cart'}</span>
                        </a>
                        {else}
                        <a class="button ajax_add_to_cart_button btn btn-default" href="{$link->getPageLink('cart',false, NULL, 'add=1&amp;id_product={$product.id_product|intval}', false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product="{$product.id_product|intval}">
                            <span>{l s='Add to cart'}</span>
                        </a>
                        {/if}
                        {else}
                        <span class="button ajax_add_to_cart_button btn btn-default disabled">
                            <span>{l s='Add to cart'}</span>
                        </span>
                        {/if}
                        {/if}
                        *}
                        <a itemprop="url" class="button lnk_view btn btn-default" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View'}">
                            <span>{if (isset($product.customization_required) && $product.customization_required)}{l s='Customize'}{else}{l s='More'}{/if}</span>
                        </a>
                    </div>

                    {$group.group_type}
                    <div class="product-flags">
                        {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                        {if isset($product.online_only) && $product.online_only}
                        <span class="online_only">{l s='Online only'}</span>
                        {/if}
                        {/if}
                        {if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
                        {elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
                        <span class="discount">{l s='Reduced price!'}</span>
                        {/if}
                    </div>
                    {if (!$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                    {if isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
                    <span itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="availability">
                        {if ($product.allow_oosp || $product.quantity > 0)}
                        <span class="{if $product.quantity <= 0 && !$product.allow_oosp}out-of-stock{else}available-now{/if}">
                            <link itemprop="availability" href="http://schema.org/InStock" />{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
                        </span>
                        {elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
                        <span class="available-dif">
                            <link itemprop="availability" href="http://schema.org/LimitedAvailability" />{l s='Product available with different options'}
                        </span>
                        {else}
                        <span class="out-of-stock">
                            <link itemprop="availability" href="http://schema.org/OutOfStock" />{l s='Out of stock'}
                        </span>
                        {/if}
                    </span>
                    {/if}
                    {/if}
                </div>

                {if $page_name != 'index'}
                <div class="functional-buttons clearfix">
                    {hook h='displayProductListFunctionalButtons' product=$product}
                    {if isset($comparator_max_item) && $comparator_max_item}
                    <div class="compare">
                        <a class="add_to_compare" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product}">{l s='Add to Compare'}</a>
                    </div>
                    {/if}
                </div>
                {/if}
            </div><!-- .product-container> -->
        </li>
        {/foreach}
    </ul>
    {addJsDefL name=min_item}{l s='Please select at least one product' js=1}{/addJsDefL}
    {addJsDefL name=max_item}{l s='You cannot add more than %d product(s) to the product comparison' sprintf=$comparator_max_item js=1}{/addJsDefL}
    {addJsDef comparator_max_item=$comparator_max_item}
    {addJsDef comparedProductsIds=$compared_products}
    {/if}
