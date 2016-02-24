<?php
/*
	* Modification module générateur de déclinaison
*/
class Product extends ProductCore {


	public function __construct($id_product = null, $full = false, $id_lang = null, $id_shop = null, Context $context = null)
	{
		parent::__construct($id_product, $id_lang, $id_shop);
		$this->quantity = $this->getWsStockAvailables();
	}

	public function generateMultipleCombinations($combinations, $attributes)
	{
		$attributes_list = array();
		$res = true;	
		$default_on = 1;

		foreach ($combinations as $key => $combination)
		{
			$id_combination = (int)$this->productAttributeExists($attributes[$key], false, null, true, true);
			$obj = new Combination($id_combination);

			if ($id_combination)
			{
				$obj->minimal_quantity = 1;
				$obj->available_date = '0000-00-00';
			}

			foreach ($combination as $field => $value)
			{
				//Si la déclinaison existe déjà, on sauvegarde le stock actuel
				if($id_combination != 0 && ($field == 'quantity' || $field == 'reference'))
					continue;
				else
					$obj->$field = $value;
			}

			$obj->default_on = $default_on;
			$default_on = 0;

			$obj->save();
		
			if (!$id_combination)
			{
				$attribute_list = array();
				foreach ($attributes[$key] as $id_attribute)
					$attribute_list[] = array(
						'id_product_attribute' => (int)$obj->id,
						'id_attribute' => (int)$id_attribute
					);
				$res &= Db::getInstance()->insert('product_attribute_combination', $attribute_list);
			}

			//Insertion des quantités par défaut pour les nouvelles déclinaisons
			if($this->depends_on_stock == 0)
			{
				foreach ($attribute_list as $attribute)
					StockAvailable::setQuantity($this->id, $attribute['id_product_attribute'], $combination['quantity']);
			}
		}

		return $res;
	}

	public function getCombinationImagesAndAttributes($id_lang)
	{
		if (!Combination::isFeatureActive())
			return false;

		$product_attributes = Db::getInstance()->executeS(
			'SELECT `id_product_attribute`
			FROM `'._DB_PREFIX_.'product_attribute`
			WHERE `id_product` = '.(int)$this->id
		);

		if (!$product_attributes)
			return false;

		$ids = array();

		foreach ($product_attributes as $product_attribute)
			$ids[] = (int)$product_attribute['id_product_attribute'];

		$result = Db::getInstance()->executeS('
			SELECT pai.`id_image`, pai.`id_product_attribute`, il.`legend`, GROUP_CONCAT(DISTINCT pac.id_attribute) AS id_attributes
			FROM `'._DB_PREFIX_.'product_attribute_image` pai
			LEFT JOIN `'._DB_PREFIX_.'product_attribute_combination` pac ON (pai.`id_product_attribute` = pac.`id_product_attribute`)
			LEFT JOIN `'._DB_PREFIX_.'image_lang` il ON (il.`id_image` = pai.`id_image`)
			LEFT JOIN `'._DB_PREFIX_.'image` i ON (i.`id_image` = pai.`id_image`)
			WHERE pai.`id_product_attribute` IN ('.implode(', ', $ids).') AND il.`id_lang` = '.(int)$id_lang.' GROUP BY pac.id_product_attribute ORDER by i.`position`'
		);

		if (!$result)
			return false;

		$images = array();

		foreach ($result as $row)
			$images[$row['id_product_attribute']][] = $row;

		return $images;
	}

	/**
	 * Get the combination url anchor of the product
	 *
	 * @param integer $id_product_attribute
	 * @return string
	 */
	public function getAnchor($id_product_attribute)
	{
		$attributes = Product::getAttributesParams($this->id, $id_product_attribute);
		$anchor = '#';
		foreach ($attributes as &$a)
		{
			if($a['group'] == 'Pointure')
				$a['name'] = str_replace(".", "-", $a['name']);

			foreach ($a as &$b)
			{
				$b = str_replace(Configuration::get('PS_ATTRIBUTE_ANCHOR_SEPARATOR'), '_', Tools::link_rewrite($b));
			}
			$anchor .= '/'.$a['group'].Configuration::get('PS_ATTRIBUTE_ANCHOR_SEPARATOR').$a['name'];
		}
		return $anchor;
	}
	
	
	public static function getProductsByRef($id_lang, $ref)
	{
		if (!$context)
			$context = Context::getContext();
		
		$sql = 'SELECT p.*, product_shop.*, pl.* , m.`name` AS manufacturer_name, s.`name` AS supplier_name,IFNULL(stock.quantity, 0) as quantity
				FROM `'._DB_PREFIX_.'product` p
				'.Shop::addSqlAssociation('product', 'p').'
				LEFT JOIN `'._DB_PREFIX_.'product_lang` pl ON (p.`id_product` = pl.`id_product` '.Shop::addSqlRestrictionOnLang('pl').')
				LEFT JOIN `'._DB_PREFIX_.'manufacturer` m ON (m.`id_manufacturer` = p.`id_manufacturer`)
				LEFT JOIN `'._DB_PREFIX_.'supplier` s ON (s.`id_supplier` = p.`id_supplier`)'.
				($id_category ? 'LEFT JOIN `'._DB_PREFIX_.'category_product` c ON (c.`id_product` = p.`id_product`)' : '').
				"  ".Product::sqlStock('p', 0, false, $context->shop).'
				WHERE pl.`id_lang` = '.(int)$id_lang." and p.reference like '".$ref."-%'".
					($id_category ? ' AND c.`id_category` = '.(int)$id_category : '').
					' AND product_shop.`visibility` IN ("both", "catalog") 
					AND product_shop.`active` = 1';
		
		$rq = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
		if ($order_by == 'price')
			Tools::orderbyPrice($rq, $order_way);
		
		foreach ($rq as &$row)
		{
			$row = Product::getTaxesInformations($row);
			$cover = Product::getCover($row['id_product']);
			$row["id_image"] = (Configuration::get('PS_LEGACY_IMAGES') ? ($row['id_product']."-".$cover["id_image"]):$cover["id_image"]);
		}
		//return Product::getProductsProperties((int)$id_lang, $rq);
		return ($rq);
	}
	
	public static function getNameById($id_product, $id_lang ,$id_shop)
	{
		$sql = 'SELECT name from `'._DB_PREFIX_.'product_lang`  where `id_product` = '.$id_product.' and `id_lang`='.$id_lang.' and `id_shop`='.$id_shop;

		$result = Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($sql);

		return $result;
	}

}
