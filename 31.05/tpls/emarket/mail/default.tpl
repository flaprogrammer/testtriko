<?php
	$FORMS = Array();

	$FORMS['status_notification'] = <<<END
	<p>Здравствуйте!<br/><br/>
		Благодарим вас за оформление заказа на <a href="http://triko.ru">нашем сайте </a>!<br/>	<br/>
		<b>Ваш заказ #%order_number% %status%</b>
		<br/><br/>
		Информация о товаре в заказе:<br/>

		%emarket order(%order_id%, %emarket orderinfo(%order_id%,'template')%, 'true')%


		Общая стоимость:
		%emarket orderinfo(%order_id%,'total_price')%  руб.
		<br/>
		Способ оплаты: %payment_type% <br />
	</p>
		<br/>

		Ваши данные:<br/>
        %emarket orderinfo(%order_id%,'customer_id')%<br/>



END;

	$FORMS['status_notification_receipt'] = <<<END
	<br/>
	Здравствуйте, Ваш заказ готов.


END;

	$FORMS['neworder_notification'] = <<<END
		Поступил новый заказ #%order_name% (<a href="http://%domain%/admin/emarket/order_edit/%order_id%/">Просмотр</a>)
		<br/><br/>

		Данные о покупателе:<br/>
        %emarket orderinfo(%order_id%,'customer_id')%<br/>



		Информация о товаре в заказе:<br/>

		%emarket order(%order_id%, %emarket orderinfo(%order_id%,'template')%, 'true')%


		Общая стоимость:
		%custom orderinfo(%order_id%,'total_price')% руб.<br/>
                Способ оплаты: %payment_type% <br />    <br/>

END;

        $FORMS['utp_notification'] = <<<END
		Здравствуйте!<br />
                Благодарим вас за оформление заказа на <a href="http://triko.ru">нашем сайте </a>!<br/>	<br/>
                Ваш %order_name% в обработке
		<br/><br/>
                Информация о товарах в Вашем заказе:<br/>

		%emarket orderNotifUtp(%order_id%, %customer_id%)%
                <br />
                Общая сумма: %totalPrice% руб.

END;
        $FORMS['utp_notification_basket'] = <<<END
		Здравствуйте!<br />
                В Вашу <a href="%domain%/cart">корзину сайта triko.ru</a> были внесены изменения!<br/>	<br/>

		<br/><br/>
                Информация о товарах в Вашем заказе:<br/>

		%emarket orderNotifUtp(%order_id%, %customer_id%)%
                <br />
                Общая сумма: %totalPrice% руб.

END;
?>