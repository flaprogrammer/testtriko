$(document).ready(function() {
	var TableTumbler = (function() {
		$('.table_tumbler__grid_but').click(function() {
			$(this).addClass('table_tumbler__but--active');
			$('.table_tumbler__table_but').removeClass('table_tumbler__but--active');
		});
		$('.table_tumbler__table_but').click(function() {
			$(this).addClass('table_tumbler__but--active');
			$('.table_tumbler__grid_but').removeClass('table_tumbler__but--active');
		});
	}());
});