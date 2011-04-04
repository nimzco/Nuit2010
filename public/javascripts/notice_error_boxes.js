var $j = jQuery;
$j(document).ready(function() {


		noticeDiv = $j('#notice');
		if (noticeDiv != null){
				noticeDiv.click(function() {
						$j(this).clearQueue();
						$j(this).stop();
						$j(this).fadeOut();
				});
				noticeDiv.effect('slide',{direction: 'right'}, 500);
				noticeDiv.queue(function(){
						$j(this).delay(3000).fadeOut();
						$j(this).dequeue();
				});
		}	

		errorDiv = $j('#error');
		if (errorDiv != null){
				errorDiv.click(function() {
						$j(this).clearQueue();
						$j(this).stop();
						$j(this).fadeOut();
				});
				errorDiv.effect('slide',{direction: 'right'}, 500);
				errorDiv.queue(function(){
						$j(this).delay(3000).fadeOut();
						$j(this).dequeue();
				});
		}
});