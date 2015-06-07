<?php
	$FORMS = Array();

	$FORMS['status_notification'] = <<<END
		Ваш заказ #%order_number% %status%
		<br/><br/>
		Посмотреть историю заказов вы можете в своем <a href="http://%domain%/emarket/personal/">личном кабинете</a>.
END;

	$FORMS['status_notification_receipt'] = <<<END
		Ваш заказ123 #%order_number% %status%
		<br/><br/>
		Посмотреть историю заказов вы можете в своем <a href="http://%domain%/emarket/personal/">личном кабинете</a>.
		<br/><br/>
		Квитанцию на оплату вы можете получить, перейдя по <a href="http://%domain%/emarket/receipt/%order_id%/%receipt_signature%/">этой ссылке</a>.
END;

	$FORMS['neworder_notification'] = <<<END
		Поступил новый заказ #%order_number% (<a href="http://%domain%/admin/emarket/order_edit/%order_id%/">Просмотр</a>)
		<br/><br/>

		Способ оплаты: %payment_type%<br/>
		Статус оплаты: %payment_status%<br/>
		Сумма оплаты:  %price%<br/>


END;
        $FORMS['invitation'] = <<<END
                Пользователь %user_name% приглашает Вас присоединится к покупкам на сайте triko.ru.<br />
                Для того, что бы приступить к покупкам, Вам необходимо зарегистироваться по ссылке
                http://%domain%/users/registrate/%key%



END;
?>