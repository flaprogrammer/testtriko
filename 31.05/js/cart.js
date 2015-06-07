var cartOrder = 'ascending';
var cartSort = 'code';
var order_id = '';
var tableLoader = $('<tr><td colspan="8" style="text-align: center"><img src="/images/loader-horizontal.gif" alt="Загрузка" /><td></tr>');

$(function()
{


        if ($('table#cartTable tr.in_tmp').length > 0) {
            $('table#cartTable tr#tr-utp input.count-usp').keypress(function(e) {
                var inputNum = String.fromCharCode(e.which);
                var maxNum = $(this).parents('tr#tr-utp').find('td.packs input').val();

                inputNum = parseInt(inputNum, 10);
                maxNum = parseInt(maxNum, 10);

                if (inputNum > maxNum) {
                    $(this).val(maxNum);
                    return false;
                }

            });
        }
	if ($('#cartTable').length == 0)
	{
		return null;
	}

	$('#cartFilter select').selectBox({menuTransition: 'fade', loopOptions: true, menuSpeed: 'fast'});

	$('#cartHeader th').not('.remove, .thumb').click(function(event)
	{
		event.preventDefault();

		if ($(this).hasClass('remove')) return null;
		if ($(this).attr('field') == cartSort)
		{
			cartOrder = (cartOrder == 'ascending') ? 'descending' : 'ascending';
		}
		else
		{
			cartOrder = 'ascending';
			cartSort = $(this).attr('field');
		}

		updateCart();

		makeCartSorting();
		return true;
	});

	$('#materialSelect').change(function()
	{
		$('#cartTable tr.good').show();

		material = $(this).val();

		updateCart();
	});

	$('#sizeSelect').change(function()
	{
		$('#cartTable tr.good').show();

		size = $(this).val();

		updateCart();
	});

	$('.cartButton .recalc').click(function(event)
	{
		event.preventDefault();

		$('#cartForm').submit();
	});

	makeCartSorting();

	makeCart();

	return true;
});

function makeCartSorting()
{
	$('#cartHeader th img.arrow').remove();

	if (cartSort != '')
	{
		var sortImg = (cartOrder == 'ascending') ? ascImg : descImg;
		$('#cartHeader th[field="'+cartSort+'"] a').append(sortImg.clone());
	}
}

function updateCart()
{
	$('#tableEmpty').hide();
	$('tr:gt(1)', '#cartTable').remove();
	$('#cartTable').hide();
	$('#tableLoader').show();

	$.get(makeCartQuery(), function(data)
	{
		if ($('tr', data).length > 0)
		{
			$('tr', data).appendTo('#cartTable');
			$('#tableLoader').hide();
			$('#cartTable').show();

			makeCart();
		}
		else
		{
			$('#tableEmpty').show();
		}

		makeLightbox();
	}, 'html');
}

function makeCartQuery()
{
	if (order_id == '')
	{
		var base = '/udata/emarket/getCart/?transform=cart.xsl';
	}
	else
	{
		var base = '/udata/emarket/getOrder/' + order_id + '/?transform=cart.xsl&noremove=1';
	}

	return base+'&material='+material+'&size='+size+'&sort='+cartSort+'&order='+cartOrder;
}

function makeCart()
{
	$('#cartTable tr.header').not('.category').each(function()
	{
		var row = $(this);

		if ($('#header_' + row.attr('parent')).length == 0)
		{
			$('<tr class="header category" id="header_' + row.attr('parent') + '">\
				<td colspan="' + $('td', row).attr('colspan') + '">' + row.attr('parentH1') + '</td>\
			 </tr>').insertBefore(row);
		}

		$(this).nextUntil('tr.header').zebrafy();
	});

	spacer = $('<tr class="spacer"><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');

	$('#cartTable tr.odd + tr.header, #cartHeader + tr.header, tr.header + tr.header').each(function()
	{
		spacer.clone().insertBefore(this);
	});
}