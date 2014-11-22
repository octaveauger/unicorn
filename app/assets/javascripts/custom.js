$(function () {
  $('[data-toggle="tooltip"]').tooltip();
})

$(function() {
	$('[data-role="transition-user-activity"]').click(function(e) {
		e.preventDefault();
		$('#error').text('');
		$.ajax({
			type: "POST",
			url: $(this).attr('data-url'),
			data: "user_activity_id="+$(this).attr('data-id'),
			dataType: 'json',
			success: function(data){
				$.each(data, function(index, value) {
					$('[data-role="transition-user-activity"][data-id="'+value.id+'"]')
						.removeClass('user-activity-stopped user-activity-started')
						.addClass('user-activity-'+value.state);
				});
			},
			error: function(data){
				$('#error').text('An error has occurred');
			}
		});
	});
});