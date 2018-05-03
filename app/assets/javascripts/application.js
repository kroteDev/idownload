// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
	$("form.simple_form .btn").hover( function(){
		if($("#url_instaurl").val() == ""){
			$("#url_instaurl").css("background-color", "rgba(254, 108, 108, 0.7)").focus();
			$(this).attr("disabled", "disabled");
		}else{
		 	$("#url_instaurl").css("background-color", "rgba(255, 255, 255, 0.3)");
		 	$(this).removeAttr("disabled");	
		}
	});
	$("#url_instaurl").on("keyup", function(){
		$(this).css("background-color", "rgba(255, 255, 255, 0.3)");
		$("form.simple_form .btn").removeAttr("disabled");
	});
	$("form.simple_form .btn").on("click", function(){				
		if($('.info-wrapper').length){
			$('.info-wrapper').slideUp(200, function(){				
			 $('#rcontainer').slideUp();
			});
		}
	});
	$("form.simple_form").submit(function (e) {
   var validationFailed = false;
   // do your validation here ...
   if (validationFailed) {
      e.preventDefault();
      return false;
   }
}); 

});