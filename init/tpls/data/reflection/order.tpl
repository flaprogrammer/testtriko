<?php

$FORMS = Array();

$FORMS['reflection_block'] = <<<END
%groups%
END;

$FORMS['reflection_group'] = <<<END

<table border="1" cellspacing="1" style="width: 500px;">
	%fields%
</table>

END;


$FORMS['reflection_field_string']
    = $FORMS['reflection_field_text']
    = $FORMS['reflection_field_wysiwyg']
    = $FORMS['reflection_field_int']
    = $FORMS['reflection_field_float']
    
    = <<<END
<tr>
	<td style="width:200px; vertical-align:top;">
		%title%:
	</td>

	<td style="vertical-align:top;" >
		%value%
	</td>
</tr>
END;


$FORMS['reflection_field_boolean'] = <<<END
<tr>
	<td>
		%title%:
	</td>

	<td>
		%custom getYesNo(%value%)%
	</td>
</tr>
END;


$FORMS['reflection_field_password'] = <<<END
<tr>
	<td>
		%title%:
	</td>

	<td>
		%value%
	</td>
</tr>
<tr>
	<td>
		Подтверждение:
	</td>

	<td>
		%value%
	</td>
</tr>

END;


$FORMS['reflection_field_relation'] = <<<END
<tr>
	<td>
		%title%:
	</td>

	<td>
		%options%
	</td>
</tr>
END;

$FORMS['reflection_field_relation_option'] = '';

$FORMS['reflection_field_relation_option_a'] = '%name%';

?>