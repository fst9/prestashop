<?php
/*
	* Modification pour pointure/déclinaison au survol produit
*/
class CategoryController extends CategoryControllerCore {

	public function initContent()
	{
		parent::initContent();
		
		$this->setTemplate(_PS_THEME_DIR_.'category.tpl');
		
		if (!$this->customer_access)
			return;

		if (isset($this->context->cookie->id_compare))
			$this->context->smarty->assign('compareProducts', CompareProduct::getCompareProducts((int)$this->context->cookie->id_compare));

		$this->productSort(); // Product sort must be called before assignProductList()
		
		$this->assignScenes();
		$this->assignSubcategories();
		//$this->assignProductList();
		$this->assignProductList();
		// var_dump($this->cat_products);
		##################################
		foreach ($this->cat_products as $key => $cat_product) 
		{           
		
	        $product = new Product($cat_product['id_product'], $this->context->language->id);
			
	        $attributes = $product->getAttributeCombinations($this->context->language->id);

	        $id_products_attribute = array();

	        //Récupération des ID produit attribut
	        foreach($attributes as $attribute)
	        {
				//var_dump($id_products_attribute);
				//var_dump($attribute['id_product_attribute']);
				//echo '<br> <br>';
	        	//if(!in_array($attribute['id_product_attribute'], $id_products_attribute) && $attribute['id_attribute'] == $cat_product['id_attribute_color'])
	        	if(!in_array($attribute['id_product_attribute'], $id_products_attribute) )
	        		$id_products_attribute[] = $attribute['id_product_attribute'];
				
			}
					//var_dump($id_products_attribute);
					// echo '<br> <br>';
	        //Récupération des attributs Pointure + stock pour la déclinaison par défaut
	        $combinations = array();
	        
	        foreach($id_products_attribute as $id_product_attribute)
	        {
	        	foreach($product->getAttributeCombinationsById($id_product_attribute, $this->context->language->id) as $attribute)
	        	{	
		        	if(($attribute['id_attribute_group'] == 1 || $attribute['id_attribute_group'] == 2 || $attribute['id_attribute_group'] == 7) && !array_key_exists($attribute['attribute_name'], $combinations))
		        	{
		        		$combinations[$attribute['attribute_name']] = StockAvailable::getQuantityAvailableByProduct($product->id, $attribute['id_product_attribute']);            
					}
	        	}
	        }
				//var_dump($combinations);
			    //echo '<br> <br> ';
			$images_combinations = $product->getCombinationImages($this->context->language->id);

			$image_combinations = array();

			if(!empty($images_combinations))
			{
				foreach($images_combinations as $id_product_attribute => $image_combination)
				{
		        	if(!array_key_exists($image_combination[0]['id_image'], $image_combinations))
		        		$image_combinations[$image_combination[0]['id_image']] = $id_product_attribute;
				}
			}

			$this->cat_products[$key]['attributes'] = $combinations;
			$this->cat_products[$key]['images_combinations'] = $image_combinations;
		}
		##################################

		$this->context->smarty->assign(array(
			'category' => $this->category,
			'description_short' => Tools::truncateString($this->category->description, 350),
			'products' => (isset($this->cat_products) && $this->cat_products) ? $this->cat_products : null,
			'id_category' => (int)$this->category->id,
			'id_category_parent' => (int)$this->category->id_parent,
			'return_category_name' => Tools::safeOutput($this->category->name),
			'path' => Tools::getPath($this->category->id),
			'add_prod_display' => Configuration::get('PS_ATTRIBUTE_CATEGORY_DISPLAY'),
			'categorySize' => Image::getSize(ImageType::getFormatedName('category')),
			'mediumSize' => Image::getSize(ImageType::getFormatedName('medium')),
			'thumbSceneSize' => Image::getSize(ImageType::getFormatedName('m_scene')),
			'homeSize' => Image::getSize(ImageType::getFormatedName('home')),
			'allow_oosp' => (int)Configuration::get('PS_ORDER_OUT_OF_STOCK'),
			'comparator_max_item' => (int)Configuration::get('PS_COMPARATOR_MAX_ITEM'),
			'suppliers' => Supplier::getSuppliers(),
			'body_classes' => array($this->php_self.'-'.$this->category->id, $this->php_self.'-'.$this->category->link_rewrite)
		));
	}

    /**
     * Assign list of products template vars
     */
    public function assignProductList()
    {
        if (Tools::getIsset('id_lang'))
            $id_lang = Tools::getValue('id_lang');
        else
            $id_lang = Configuration::get('PS_LANG_DEFAULT');

        $hookExecuted = false;
        Hook::exec('actionProductListOverride', array(
            'nbProducts' => &$this->nbProducts,
            'catProducts' => &$this->cat_products,
            'hookExecuted' => &$hookExecuted,
        ));

        // The hook was not executed, standard working
        if (!$hookExecuted)
        {
            $this->context->smarty->assign('categoryNameComplement', '');
            $this->nbProducts = $this->category->getProducts(null, null, null, $this->orderBy, $this->orderWay, true);
            $this->pagination((int)$this->nbProducts); // Pagination must be call after "getProducts"
            $this->cat_products = $this->category->getProducts($this->context->language->id, (int)$this->p, (int)$this->n, $this->orderBy, $this->orderWay);
        }
        // Hook executed, use the override
        else
            // Pagination must be call after "getProducts"
            $this->pagination($this->nbProducts);

        Hook::exec('actionProductListModifier', array(
            'nb_products' => &$this->nbProducts,
            'cat_products' => &$this->cat_products,
        ));

        $products = array();
       $array_colors = array();
        foreach ($this->cat_products as $product) {
            if ($product['id_product_attribute'] && isset($product['product_attribute_minimal_quantity']))
                $product['minimal_quantity'] = $product['product_attribute_minimal_quantity'];

            $id_product = $product['id_product'];

            $name = $product['name'];
            $colors = $this->_getAttributesColorList( array( $id_product ) , false);
			$array_colors [$id_product]= $colors ; 
			
			
 			if($colors)
 			{
	            foreach ($colors[$id_product] as $color) {
		
	            	$id_product_attribute = $this->_getDeclinaisonWithStock($id_product, $color['id_attribute_color']);
					
	            	if(!$id_product_attribute)
	            		$id_product_attribute = $color['id_product_attribute'];

					//var_dump($id_product_attribute);
					//echo '<br> <br> ';
					
	             //   $product['name'] = $name . ' - '. $color['color_name'];
				  //	var_dump($product['name']);
				  //echo '<br> <br> ';
				//   $product['link'] = Context::getContext()->link->getProductLink($id_product, null, null, null, null, null, $id_product_attribute);
				   $product['link'] = Context::getContext()->link->getProductLink($id_product_attribute, null, null, null, null, null, null);
	               // var_dump($product['link']);
					
					
					//$image = Image::getImages($id_lang, $id_product, $color['id_product_attribute']);
					$image = Image::getImages($id_lang, $color['id_product_attribute']);
	               $image = $image[0];
				  //  var_dump($image);
					//echo '<br> <br> ';
					//if (isset($image) && !empty($image) )
	                   // $product['id_image'] = $id_product.'-'.$image[0]['id_image'];
	               
				   $products[] = array_merge($product, $color);
	            }
	        }
	        // else
	        	// $products[] = $product;
        }
		$this->context->smarty->assign('allcolorsproducts', $array_colors);
		 // var_dump($array_colors);
		 // echo '<br> <br> ';
		//var_dump( $products);
		//die(' pr ');
		//echo '<br> <br>';
        $this->cat_products = $products;

        $this->nbProducts = count($this->cat_products);
		//var_dump( $this->nbProducts);
        
		
        $this->context->smarty->assign('nb_products', $this->nbProducts);
    }

    public static function _getAttributesColorList(Array $products, $have_stock = true)
    {
	//	echo '<br> <br> <br>';
	//var_dump($products);
		
		
        if (!count($products))
            return array();

        if (Tools::getIsset('id_lang'))
            $id_lang = Tools::getValue('id_lang');
        else
            $id_lang = Configuration::get('PS_LANG_DEFAULT');

        $check_stock = !Configuration::get('PS_DISP_UNAVAILABLE_ATTR');
        if (!$res = Db::getInstance()->executeS('
					SELECT pa.id_product, a.id_attribute, pal.name, a.color, pac.id_product_attribute, '.($check_stock ? 'SUM(IF(stock.quantity > 0, 1, 0))' : '0').' qty
					FROM '._DB_PREFIX_.'product_attribute pa
					'.Shop::addSqlAssociation('product_attribute', 'pa').
            ($check_stock ? Product::sqlStock('pa', 'pa') : '').'
					JOIN '._DB_PREFIX_.'product_attribute_combination pac ON (pac.id_product_attribute = product_attribute_shop.id_product_attribute)
					JOIN '._DB_PREFIX_.'attribute a ON (a.id_attribute = pac.id_attribute)
					JOIN '._DB_PREFIX_.'attribute_lang pal ON (a.id_attribute = pal.id_attribute)
					JOIN '._DB_PREFIX_.'attribute_group ag ON (a.id_attribute_group = ag.id_attribute_group)
					WHERE pa.id_product IN ('.implode(array_map('intval', $products), ',').') AND ag.is_color_group = 1 AND id_lang = '. $id_lang .'
					GROUP BY pa.id_product, a.id_attribute 

					'.($check_stock ? 'HAVING qty > 0' : '')
					
        )
        )
		return false;
		
		$nameproduct = Db::getInstance()->executeS('
						SELECT pl.name , p.id_product,  p.id_category_default, p.reference
						FROM '._DB_PREFIX_.'product p
						JOIN '._DB_PREFIX_.'product_lang pl ON (p.id_product = pl.id_product)
						WHERE p.id_product IN ('.implode(array_map('intval', $products), ',').') 
						');
		$rest = substr($nameproduct[0]['name'], 0,10);   
		//$rest = $nameproduct[0]['name'];   
		$category_default = $nameproduct[0]['id_category_default'];
		$id_product_current  = $nameproduct[0]['id_product'];
		$current_product_reference  = $nameproduct[0]['reference'];
		$ref = explode("-",$current_product_reference);
		$ref = $ref[0];
		$product = new Product($id_product_current,false,$lang_id);
		$imagesref = $product->getProductsByRef( $id_lang,$ref);
		
		
		$prods = array();
		foreach($imagesref as $prod)
			{
				$temp = array();
			//	echo $prod['id_product']."-".$prod["quantity"]."<br>";
				if($prod["quantity"])
				{
					$temp = $prod;
					$attributes = $product->getAttributesParams($prod["id_product"],$prod["cache_default_attribute"]);
					foreach($attributes as $att)
					{
						if($att["group"] ==   "Couleurs "  )
						$temp["name_attribute"] = $att["name"];
						
					}
					$prods[] = $temp;
				}
			}
		
		
		
		
		
		
		//   var_dump($prods);
		//  die('f');
		  
		  
		  
		//die(' catr ');p.id_product <> '.$id_product_current.' and
		//
		if ($rest && $rest !='' ) {
			
				$listenoms = Db::getInstance()->executeS('
						SELECT DISTINCT p.id_category_default , p.id_product , pl.name  , pi.id_image
						FROM '._DB_PREFIX_.'product p 
						JOIN  '._DB_PREFIX_.'product_attribute pa ON (pa.id_product = p.id_product)
						JOIN  '._DB_PREFIX_.'image pi ON (pi.id_product = p.id_product  )				
						JOIN '._DB_PREFIX_.'product_lang pl ON (p.id_product = pl.id_product)
					    JOIN '._DB_PREFIX_.'product_attribute_combination pac ON (pac.id_product_attribute = pa.id_product_attribute )
						JOIN '._DB_PREFIX_.'attribute a ON (a.id_attribute = pac.id_attribute)
					    JOIN '._DB_PREFIX_.'attribute_group ag ON (a.id_attribute_group = ag.id_attribute_group)

						WHERE p.reference LIKE "'.$ref.'%" and p.id_category_default = '.$category_default.'  AND ag.is_color_group = 1  AND p.quantity > 0  and pi.cover = 1 and p.active = 1 and p.available_for_order =1 
						GROUP BY p.id_product, a.id_attribute 
						');
			 
		}
 	//var_dump($listenoms);
 	//echo '<br> <br> <br>';
		/*
								WHERE p.reference LIKE "%'.$ref.'%" and p.id_category_default = '.$category_default.'  AND ag.is_color_group = 1  AND p.quantity > 0  and pi.cover = 1 and p.active = 1 and p.available_for_order =1 

								JOIN '._DB_PREFIX_.'product_attribute_combination pac ON (pac.id_product_attribute = product_attribute_shop.id_product_attribute)	
						JOIN '._DB_PREFIX_.'attribute a ON (a.id_attribute = pac.id_attribute)
						JOIN '._DB_PREFIX_.'attribute_lang pal ON (a.id_attribute = pal.id_attribute)
					    JOIN '._DB_PREFIX_.'attribute_group ag ON (a.id_attribute_group = ag.id_attribute_group)
					
		*/
		

		
        
		
		//$attributes_groups = $this->product->getAttributesGroups($this->context->language->id);
			
			//	var_dump($res);
			 //   echo '<br> <br> <br>';
		/*	 
        foreach ($res as $row)
        {
            $colors[(int)$row['id_product']][] = array('id_product_attribute' => (int)$row['id_product_attribute'], 'id_attribute_color' => $row['id_attribute'], 'color' => $row['color'], 'color_name' => $row['name']);
       
	   }
	  */
	   /* array(1) { 
	   [0]=> array(6) {
		   ["id_product"]=> string(4) "1726" 
		   ["id_attribute"]=> string(2) "95" 
		   ["name"]=> string(4) "Bleu" 
		   ["color"]=> string(7) "#2032ff"
		   ["id_product_attribute"]=> string(5) "20402" 
		   ["qty"]=> string(2) "11" } } 
*/

/*
array(15) {
  [0]=>
  array(3) {
    ["name"]=>
    string(12) "Nike Kobe IV"
    ["id_product"]=>
    string(3) "337"
    ["color"]=>
    string(7) "#F39C11"
  }
*/
 /*
        foreach ($listenoms as $row)
        {
            $colors[(int)$row['id_product']][] = array(
			'id_product' => (int) $id_product_current,
			'id_product_attribute' => (int) $row['id_product'],
			'id_attribute_color' => $row['id_product'],
			'id_category_default' => $row['id_category_default'],
			'color' => $row['color'], 
			'color_name' => $row['name'],
			'id_image' => $row['id_image']);
		}       

*/
		$colors = array();
		foreach ($prods as $row)
        {
            $colors[(int)$row['id_product']][] = array(
			'id_product' => (int) $id_product_current,
			'id_product_attribute' => (int) $row['id_product'],
			'id_attribute_color' => $row['id_product'],
			'id_category_default' => $row['id_category_default'],
			'color' => $row['color'], 
			'color_name' => $row['name'],
			'id_image' => $row['id_image']);
		}
		 
	 // $this->context->smarty->assign('listcolors', $listenoms);
		//var_dump($colors);
		// echo '<br> <br> <br> ' ;
		//die(' d');
		//$this->assignAttributesGroups();
        return $colors;
    }

    public static function _getDeclinaisonWithStock($id_product, $id_attribute)
    {
        if (Tools::getIsset('id_lang'))
            $id_lang = Tools::getValue('id_lang');
        else
            $id_lang = Configuration::get('PS_LANG_DEFAULT');

    	if(!$res = Db::getInstance()->executeS('
			SELECT pac.id_product_attribute
			FROM `ps_product_attribute` pa
			INNER JOIN ps_product_attribute_combination pac ON pa.id_product_attribute = pac.id_product_attribute
			INNER JOIN ps_attribute ON ps_attribute.id_attribute = pac.id_attribute
			INNER JOIN ps_attribute_lang pas ON pac.id_attribute = pas.id_attribute AND pas.id_lang = '.$id_lang.'
			INNER JOIN ps_attribute_group_lang pagl ON ps_attribute.id_attribute_group = pagl.id_attribute_group AND pagl.id_lang = '.$id_lang.'
            INNER JOIN ps_stock_available psa ON pa.id_product = psa.id_product AND pac.id_product_attribute = psa.id_product_attribute
			WHERE pa.id_product = '.$id_product.' AND ps_attribute.id_attribute = '.$id_attribute.' AND psa.quantity > 0 
			ORDER By pac.id_product_attribute ASC 
			LIMIT 1   	
    	'))
    		return false;
			
			//var_dump($res[0]['id_product_attribute']);
		 
    	else
    		return $res[0]['id_product_attribute'];
		 
    }

}
