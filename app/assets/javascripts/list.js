// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
	$('.add-task').click(function(){
		$('#form-list .last-input').before(
			"<div class='form-group group-task'>"
			+ "<label for='task' class='col-sm-2 control-label'>Name Task</label>"
			+ "<div class='col-sm-10'>"
			+	"<input type='text' class='form-control' name='task[]' required='true'>"
			+ "</div>" 
			+ "</div>"
			);

		if ($('.group-task').length) {
			$('.remove-task').show();
		}
		$('.button-submit').attr('disabled', false);
	});

	$('.remove-task').click(function(){
		$('.group-task').last().remove();

		if($('.group-task').length == 0){
			$('.remove-task').hide();
			$('.button-submit').attr('disabled', true);
		}
	});

	$('.add-favorite').click(function(e){
		e.preventDefault();
		$.ajax({
			url: '/favorite/add',
			type: 'POST',
			dataType: 'json',
			data: {id: $(this).attr('id')},
			success: function(data){
				console.log(data);
				if(data.success == true){
					$('#block-list-' + data.id).remove();
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

