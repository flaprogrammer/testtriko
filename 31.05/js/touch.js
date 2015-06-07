/* Взято с chris-barr.com и доработано для скролов в 2 плоскостях*/

function isTouchDevice(){
	try{
		document.createEvent("TouchEvent");
		return true;
	}catch(e){
		return false;
	}
}

function touchScroll(id){
	if(isTouchDevice()){ //if touch events exist...
		var el=document.getElementById(id);
		var scrollStartPosX=0, scrollStartPosY=0;

		document.getElementById(id).addEventListener("touchstart", function(event) {
			scrollStartPosX=this.scrollLeft+event.touches[0].pageX;
			scrollStartPosY=this.scrollTop+event.touches[0].pageY;
			event.preventDefault();
		},false);

		document.getElementById(id).addEventListener("touchmove", function(event) {
			this.scrollLeft=scrollStartPosX-event.touches[0].pageX;
			this.scrollTop=scrollStartPosY-event.touches[0].pageY;
			event.preventDefault();
		},false);
	}
}