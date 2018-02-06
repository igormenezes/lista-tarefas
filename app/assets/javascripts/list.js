// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
	$('.add-task').click(function(){
		$('#form-list .last-input').after(
			"<div class='form-group'>"
			+ "<label for='task[]' class='col-sm-2 control-label'>Task</label>"
			+ "<div class='col-sm-10'>"
			+	"<input type='text' class='form-control' name='task[]' required='true'>"
			+ "</div>" 
			+ "</div>"
		);

		$('.button-submit').attr('disabled', false);
	});
});

