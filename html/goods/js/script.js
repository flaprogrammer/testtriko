function Good(id) {
	var self = this;
	self.images = [
		'i/skirt.jpg',
		'i/skirt2.jpg',
	];
	self.el = $('.good')[id];
	/*$(this.el).find('.good__photo').each(function (i, index) {
		console.log(i);
	});*/
	$(self.el).find('.good__photo_nav_el').click(function (e) {
		var id = $(this).attr('data-target');
		self.changePhoto(id);
	});

	$(self.el).find('.good__photo').click(function (e) {
		var id = $(this).closest('.good').attr('data-id');
		self.openModal(id);
	});
}

Good.prototype.changePhoto = function(id) {
	var self = this;

	$(self.el).find('.good__photo_nav_el').removeClass('good__photo_nav_el__active');
	$(self.el).find('.good__photo_nav_el[data-target="'+id+'"]').addClass('good__photo_nav_el__active');

	$(self.el).find('.good__photo').removeClass('good__photo__active');
	$(self.el).find('.good__photo[data-id="'+id+'"]').addClass('good__photo__active');
};

Good.prototype.openModal = function(id) {
	console.log(id);
}


$('.good').each(function(i, el) {
	var good = new Good(i);
})


function Modal() {
	var self = this;
	self.el = $('#goodsModal')[0];
	$(self.el).modal();

	$(self.el).find('.modal__plus_but').on('click', function() {
		var val = $(this).closest('.boxes').find('.modal__boxes_num').val();
		val ++;
		$(this).closest('.boxes').find('.modal__boxes_num').val(val);
	});

	$(self.el).find('.modal__minus_but').on('click', function() {
		var val = $(this).closest('.boxes').find('.modal__boxes_num').val();
		val = (val>0) ? val-1 : 0;
		$(this).closest('.boxes').find('.modal__boxes_num').val(val);
	});
}

var modal = new Modal();