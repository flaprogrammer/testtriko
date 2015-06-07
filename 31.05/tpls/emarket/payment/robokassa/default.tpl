<?php
$FORMS = Array();

$FORMS['form_block'] = <<<END

<form action="%formAction%" method="post" accept-charset="windows-1251">
	
	<input type="hidden" name="LMI_PAYEE_PURSE" value="%LMI_PAYEE_PURSE%"/> 
	<input type = "hidden" name = "LMI_PAYMENT_AMOUNT" value = "%LMI_PAYMENT_AMOUNT%"/>
	<input type = "hidden" name = "LMI_PAYMENT_DESC" value = "%LMI_PAYMENT_DESC%"/>
	<input type = "hidden" name = "LMI_PAYMENT_NO" value = "%LMI_PAYMENT_NO%"/>  
	
	<input type = "hidden" name = "LMI_RESULT_URL" value = "http://www.erolaif.ru/emarket/resultWebmoney/"/>
    <input type = "hidden" name = "LMI_SUCCESS_URL" value = "http://www.erolaif.ru/order_success"/> 
	<input type = "hidden" name = "LMI_SUCCESS_METHOD" value="1"/> 
	<input type = "hidden" name = "LMI_FAIL_URL" value = "http://www.erolaif.ru/order_fail"/> 
	<input type = "hidden" name = "LMI_FAIL_METHOD" value="1"/>
	<p>
		Нажмите кнопку "Оплатить" для перехода на сайт платежной системы <strong>WebMoney</strong>.
	</p>        

	<p>
		<input type="submit" value="Оплатить" />
	</p>
</form>
END;
?>