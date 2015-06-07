<?php
	class custom {
		public function cms_callMethod($method_name, $args) {
			return call_user_func_array(Array($this, $method_name), $args);
		}
		
		public function __call($method, $args) {
			throw new publicException("Method " . get_class($this) . "::" . $method . " doesn't exists");
		}
		//TODO: Write your own macroses here

 public function delart($artikul) {
 $rest = substr($artikul, 0, 3);
 return $rest;
 }

		
		// Проверяем новый ли это объект
		public function newobject($time_add){
		if(!$time_add) return "";
		// Временной интервал в месяц
		$interval = 60*60*24*31;
		// Прошедшее время, с момента добавления товара
		$begin_time = time() - $time_add;
		if($begin_time < $interval) return "new";
		}
		
		
		public function orderinfo($order_id, $ide)
		{
			if(!$order_id)
			{
				return false;
			}
			
			$inst = umiObjectsCollection::getInstance();
			$object = $inst->getObject($order_id);
			if (!$object) return;
			$customer = $inst->getObject($object->customer_id);
			
			$isPartner = in_array('530', $customer->groups);
			
			$id_value = $object->getValue($ide);
			
			switch($ide)
			{
				case 'template':
					if ($isPartner == true)
					{
						return '\'default_partner\'';
					}
					else
					{
						return '\'default\'';
					}
					break;
				case 'delivery_id':
					if ($isPartner == true)
					{
						return;
					}
					else
					{
						if ($delivery = $inst->getObject($id_value))
						{
							return 'Способ доставки: '.$delivery->getName().'<br />';
						}
						return;
					}
					break;
				case 'delivery_price':
					return ($inst->getObject($id_value) != '') ? 'Стоимость доставки (включена в стоимость выше): '.$inst->getObject($id_value).' руб.<br />' : '';
					break;
				case 'total_price':
					return $id_value;
					break;
				case 'comment':
					if (trim($id_value) != '')
					{
						return $id_value;
					}
					else
					{
						return '(нет)';
					}
					
					break;
				case 'order_discount_id':
					$description_discount = $inst->getObject($id_value)->getValue('description');
					$value_disc = $object->total_price - $object->total_original_price;
					return "Скидка на заказ: {$name_disc} ({$value_disc} руб.)";
					break;
				case 'delivery_address':
					if (strpos(self::orderinfo($order_id, 'delivery_id'), 'Самовывоз') === false && $isPartner == false)
					{
						return "Адрес доставки:<br/>
						%data getEditForm({$id_value},'order')%";
					}
					else
					{
						return;
					}
					break;
				default:
					if ($isPartner == true)
					{
						$transport = $inst->getObject($customer->getValue('transport'));
						
						$retString = '<table border="1" cellspacing="1" style="width: 500px;">';
						
						$retString .= '<tr><td style="width: 200px;">Компания:</td><td>'.$customer->getValue('company').'</td></tr>';
						$retString .= '<tr><td>Фамилия:</td><td>'.$customer->getValue('lname').'</td></tr>';
						$retString .= '<tr><td>Имя:</td><td>'.$customer->getValue('fname').'</td></tr>';
						$retString .= '<tr><td>Отчество:</td><td>'.$customer->getValue('father_name').'</td></tr>';
						$retString .= '<tr><td>Адрес доставки:</td><td>'.$customer->getValue('address').'</td></tr>';
						
						if ($transport instanceof umiObject)
						{
							$retString .= '<tr><td>Транспортная компания:</td><td>'.$inst->getObject($customer->getValue('transport'))->getName().'</td></tr>';
						}
						
						$retString .= '<tr><td>Имя менеджера:</td><td>'.$customer->getValue('manager_name').'</td></tr>';
						$retString .= '<tr><td>Телефон менеджера:</td><td>'.$customer->getValue('manager_phone').'</td></tr>';
						
						$retString .= '</table>';
						
						return $retString;
					}
					else
					{
						return "%data getEditForm({$id_value},'order')%";
					}
			}   
		}
		
		public function urlreceipt()
		{
			if(array_key_exists('code', $_GET) && array_key_exists('id', $_GET))
			{
				$id = htmlspecialchars($_GET['id']);
				$code = htmlspecialchars($_GET['code']);
				$url = "/emarket/receipt/{$id}/{$code}/";
		 
				return "Квитанцию на оплату вы можете получить, перейдя по <a href=\"{$url}\" target=\"_blank\">этой ссылке</a>.";  
			}    
		}
		
		public function showOptions($field, $name, $price = false)
		{
			if ($field == 'engrave_text')
			{
				if ($price)
				{
					return $name.' +'.$price;
				}
				else
				{
					return $name;
				}
			}
			else
			{
				return '';
			}
		}
		
		public function getParentPoljot($id)
		{
			$hierarchy = umiHierarchy::getInstance();
			return $hierarchy->getElement($hierarchy->getParent($id))->name;
		}		
		
		public function getArtikulForMail($id)
		{
			$hierarchy = umiHierarchy::getInstance();
			return $hierarchy->getElement($hierarchy->getParent($id))->code;
		}		
		
		public function getYesNo($value)
		{
			if ($value == 1)
			{
				return 'Да';
			}
			else
			{
				return 'Нет';
			}
		}
		
		public function getHTMLCatalog()
		{			
			$categories = array();
			$items = array();
			
			$sel = new selector('pages');
			$sel->where('hierarchy')->page('316')->childs(1);
			
			foreach ($sel as $category)
			{				
				$categories[] = array('node:text' => $category->h1, 'attribute:id' => $category->id);
			}
			
			$sel = new selector('pages');
			$sel->where('hierarchy')->page('316')->childs(2);
			
			foreach ($sel as $object)
			{
				if ($object->getParentId() != '316')
				{
					$image = $object->image;
					$item['attribute:id'] = $object->id;
					$item['attribute:name'] = $object->getName();
					$item['attribute:image'] = ($image) ? $image->getFilePath() : '';
					$item['attribute:price'] = ($object->partnerprice != 0) ? $object->partnerprice : $object->price;
					$item['attribute:category'] = $object->getParentId();
					
					$items[] = $item;
				}
			}
			
			$catList = array();
			
			foreach ($items as $row)
			{
					$catList[]  = $row['attribute:category'];
					$nameList[]  = $row['attribute:name'];
			}
			
			array_multisort($catList, SORT_ASC, $nameList, SORT_ASC, $items);
			
			$param['subnodes:categories'] = $categories;
			$param['subnodes:items'] = $items;
			return def_module::parseTemplate(null, $param);
		}
		
		//макрос для блочного кеширования стыбрен с вики юмисофта
		public function xsltHtmlCache($expire = 3600, $stream, $module, $method = false){
			$xslFilePath = getRequest('xsl');
			  // $filePath - путь к xsl-шаблону трансформации.
			$filePath = CURRENT_WORKING_DIR . '/xsltTpls/' . $xslFilePath;
			if(!is_file($filePath)) return;
	   
			$args = func_get_args();
			$params = array_slice($args, 4);
			
			foreach ($params as $key => $param)
			{
				if (strpos($param, '/') !== false)
				{
					$params[$key] = '('.$param.')';
				}
			}
			
			$params_str = implode('/', $params);
			$url = $stream.'://' . $module . '/' . $method . '/' . $params_str;
	   
			$folder = CURRENT_WORKING_DIR . '/sys-temp/udatacache/';  
			$path = $folder . md5($url . $filePath) . '.xml';
			if(!is_dir($folder)) mkdir($folder, 0777, true);
			if(is_file($path)) $mtime = filemtime($path);
			 
			if(!is_file($path) || time() > ($mtime + $expire)) {    

				$xsltDom = new DomDocument;
				$xsltDom->resolveExternals = true;
				$xsltDom->substituteEntities = true;
		 
				$xsltDom->load($filePath, DOM_LOAD_OPTIONS);
		 
				$xslt = new xsltProcessor;
				$xslt->registerPHPFunctions();
				$xslt->importStyleSheet($xsltDom);
				$page_id = cmsController::getInstance()->getCurrentElementId();
				$parent_id = "";
				$active    = "";
		 
				if($page_id){
				   $page = umiHierarchy::getInstance()->getElement($page_id);
				   $parent_id = $page->getParentId();
				   $active    = (int) $page->getIsDefault();
				}
		 
				// Добавляем необходимые глобальные переменные, которые можно будет использовать в xsl-шаблоне 
				$xslt->setParameter("", 'parent-id', $parent_id);
				$xslt->setParameter("", 'document-page-id', $page_id);
				$xslt->setParameter("", 'active', $active);
				$xslt->setParameter("", 'stream', $stream);
				$xslt->setParameter("", 'module', $module);
				$xslt->setParameter("", 'method', $method);
		 
				$dom_new = new DOMDocument("1.0", "utf-8");
				// $xml - xml-данные для трансформации.
				$xml = file_get_contents($url);
				$dom_new->loadXML($xml);
		 
				//производим трансформацию
				$result = $xslt->transformToXML($dom_new);
				//html-данные необходимо включить в CDATA и в какой либо корневой узел.
				$result = '<udata mode="cache" url="'.$url.'" timestamp="'.$mtime.'" date="'.date('d.m.Y H:i:s', $mtime).'"><![CDATA[' . $result . ']]></udata>';
				
				$fp = fopen($path, 'w');
				fputs($fp, $result);
				fclose($fp);
				
				// данный принцип возвращения данных отключает xslt-трансформацию системой UMI.CMS
				return array('plain:result' => $result);
	   
			}else{
				$result = file_get_contents($path);
				return array('plain:result' => $result);
			}	
		}
		
		public function getOrderItemPrice($id = false)
		{
			if (!$id) return;
			
			$item = umiObjectsCollection::getInstance()->getObject($id);
			
			if (!$item) return;
			
			return $item->item_total_price;
		}
	};
?>