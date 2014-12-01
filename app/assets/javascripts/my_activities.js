$(function() {
	// Control transitions in user activities
	$('[data-role="transition-user-activity"]').click(function(e) {
		manage_timer({action: 'stop'}); //pause the timer
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
					if(value.state == 'started') {
						manage_timer({ action: 'start', time: 'now' }); //re-init the timer
					}
				});
			},
			error: function(data){
				$('#error').text('An error has occurred');
			}
		});
	});

	 // Page load: init the timer based on div data values
	manage_timer();
});

function manage_timer(params) {
	if(typeof params === 'undefined' || typeof params.action === 'undefined') {
		params = {action: $('#activity-start-time').attr('data-action'),
				time: $('#activity-start-time').attr('data-date')};
	}

	$('#activity-start-time').attr('data-action', params.action);
	
	if(params.action == 'start') {
		if(typeof params.time === 'undefined') params.time = 'now';
		if(params.time == 'now') $('#activity-start-time').attr('data-date', time_format_utc());
		else $('#activity-start-time').attr('data-date', params.time);

		$('#activity-start-time').data('date', $('#activity-start-time').attr('data-date'));
		$('#activity-start-time').TimeCircles().start();
	}
	else if(params.action == 'stop') {
		$('#activity-start-time').TimeCircles().stop();
	}
}

// Make timer responsive
$(window).resize(function(){
    $('#activity-start-time').TimeCircles().rebuild();
    if($('#activity-start-time').attr('data-action') == 'stop') $('#activity-start-time').TimeCircles().stop();
});