<?php
$FORMS = Array();

$FORMS['form_block'] = <<<END

<form action="%formAction%" method="post">
	
	<input type="hidden" name="LMI_PAYEE_PURSE" value="%LMI_PAYEE_PURSE%"/> 
	<input type = "hidden" name = "LMI_PAYMENT_AMOUNT" value = "%LMI_PAYMENT_AMOUNT%"/>
	<input type = "hidden" name = "LMI_PAYMENT_DESC" value = "%LMI_PAYMENT_DESC%"/>
	<input type = "hidden" name = "LMI_PAYMENT_NO" value = "%LMI_PAYMENT_NO%"/>  
	
	<p>
		Нажмите кнопку "Оплатить" для перехода на сайт платежной системы <strong>WebMoney</strong>.
	</p>        

	<p>
		<input type="submit" value="Оплатить" />
	</p>
</form>
END;
?>