// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
	$('.remove-favorite').click(function(e){
		e.preventDefault();
		$.ajax({
			url: '/favorite/remove',
			type: 'POST',
			dataType: 'json',
			data: {id: $(this).attr('favorite-id')},
			success: function(data){
				console.log(data);
				if(data.success == true){
					$('#block-favorite-' + data.id).parents('.box-favorite').remove();
				}else{
					console.log(data.message);
				}
			},
			error: function() {
				console.log("error");
			}
		})
	})
});

