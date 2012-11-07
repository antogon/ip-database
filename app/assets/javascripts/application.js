// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).ready(function(){
	$.pnotify.defaults.styling = 'bootstrap';
	$.pnotify.defaults.opacity = .8;
	$.pnotify.defaults.sticker_hover = true;
	$.pnotify.defaults.type = 'info';
	$.pnotify.defaults.title = false;
	$.pnotify.defaults.closer_hover = true;
	$.pnotify.defaults.icon = false;
	$.pnotify.defaults.history = true;
	$.pnotify({text:"",before_open:function(){return false;}});
	$('.navbar-inner').append($('.ui-pnotify-history-container'));
});
