<?php
$FORMS = array();

$FORMS['price_block'] = '%price-actual%';

$FORMS['price_original'] = <<<END
	<strike>%original%</strike>
END;

$FORMS['price_actual'] = <<<END
%actual%
END;


$FORMS['order_block'] = <<<END
<table width="500px" border="1">
	<thead>
		<tr>
			<th>Наименование</th>
			<th>Артикул</th>
			<th>Упаковок</th>
			<th>Стоимость</th>
		</tr>
	</thead>
	<tbody>
		%items%
	</tbody>
</table>

END;

$FORMS['order_block_utp'] = <<<END
<table width="500px" border="1">
	<thead>
		<tr>
			<th>Наименование</th>
			<th>Артикул</th>
			<th>Штук</th>
			<th>Стоимость</th>
		</tr>
	</thead>
	<tbody>
		%items%
	</tbody>
</table>

END;

$FORMS['order_item'] = <<<END
<tr>

	<td>
		%custom getParentPoljot(%element_id%)%
	</td>
	<td>
		%custom getArtikulForMail(%element_id%)%
	</td>
	<td>
		%amount%
	</td>
	<td>
		%custom getOrderItemPrice(%id%)% руб.
	</td>
</tr>
END;

$FORMS['order_item_utp'] = <<<END
<tr>

	<td>
		%elementName% %elementSize% %colorName%
	</td>
	<td>
		%articul%
	</td>
	<td>
		%itemCount%
	</td>
	<td>
		%itemTotalPrice% руб.
	</td>
</tr>
END;

$FORMS['order_item_group'] = <<<END
<tr>

	<td>
		%name%
	</td>
	<td>
		%article%
	</td>
	<td>
		%amount%
	</td>
	<td>
		%price% руб.
	</td>
</tr>
END;

$FORMS['options_block'] = <<<END
	%items%
END;

$FORMS['options_block_empty'] = "(нет)";

$FORMS['options_item'] = <<<END
%custom showOptions(%field-name%, %name%, '%price%')%
END;

$FORMS['order_block_empty'] = <<<END
<p>Корзина пуста</p>
END;


$FORMS['purchase'] = <<<END
%purchasing%

%emarket ordersList()%
END;


$FORMS['orders_block'] = <<<END
<p>Список ваших заказов:</p>
<ul>
	%items%
</ul>
END;

$FORMS['orders_block_empty'] = <<<END
<p>Заказов нет</p>
END;

$FORMS['orders_item'] = <<<END
	<li>%name% (%id%)</li>
END;

$FORMS['purchase_successful'] = <<<END
<p>Заказ успешно добавлен</p>
END;

$FORMS['purchase_failed'] = <<<END
<p>Не удалось добавить заказ</p>
END;


$FORMS['personal'] = <<<END
	%emarket ordersList()%
END;

?>