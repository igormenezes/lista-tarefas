// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$('.task-update').click(function(){
		$.ajax({
			url: '/task/update',
			type: 'POST',
			dataType: 'json',
			data: {id: $(this).attr('id') , user: $(this).attr('user')},
			success: function(data){
				if(data.success == true){
					$('#task-' + data.id).children('td').eq(1).html(0);
					$('#task-' + data.id).children('td').eq(2).html('Closed Task');
				}else{
					console.log(data.message);
				}
			},
			error: function() {
				console.log("error");
			}
		})
	})
})

