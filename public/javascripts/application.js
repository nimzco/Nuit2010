var $j = jQuery;

/**
 * Add the class classToAdd to the wrapper div. 
 * Add the event onClick to the button div.
 * 		On click, add classTop and remove classDown. And Vice-versa
 */
function showAndHideMe(wrapper, button, classToRemoveAtFirst, classToAdd, classTop, classDown, classToAddForButton, buttonIdSupp){
		var isClicked = false;
		var menuWrapper = $j(wrapper);
		menuWrapper.addClass(classToAdd);
		menuWrapper.removeClass(classToRemoveAtFirst);
		menuWrapper.addClass(classToAdd);
		var menuButton = $j(button);
		menuButton.click(function() {
				if (!isClicked){
					menuWrapper.removeClass(classTop);
					menuWrapper.addClass(classDown);
					menuButton.addClass(classToAddForButton);
					isClicked = true;
				} else {
					menuWrapper.removeClass(classDown);
					menuWrapper.addClass(classTop);
					menuButton.removeClass(classToAddForButton);
					isClicked = false;
				}
		});		

		if (buttonIdSupp != '#'){
			var menuButton2 = $j(buttonIdSupp);
			menuButton2.click(function() {
					if (!isClicked){
						menuWrapper.removeClass(classTop);
						menuWrapper.addClass(classDown);
						menuButton.addClass(classToAddForButton);
						isClicked = true;
					} else {
						menuWrapper.removeClass(classDown);
						menuWrapper.addClass(classTop);
						menuButton.removeClass(classToAddForButton);
						isClicked = false;
					}
			});	
		}

		
}

/**************************************** Login ****************************************/		
function initLogin(){
		buttonLogin = $j('#button-link');
		loginWrap = $j('#topnav');
		var heightWrap = $j('#login-div').height() + 2;
		loginWrap.css('top', '-' + heightWrap + 'px');
		var isOpen = false;
		buttonLogin.click(function(){
				if (isOpen){
						loginWrap.animate({top:  '-' + heightWrap + 'px'}, 300);		
						isOpen = false;
				} else {
						loginWrap.animate({top: 0}, 500);		
						isOpen = true;
				}
		});
}
$j(document).ready(function() {


/**************************************** Menu ****************************************/		

		$j('#menu-wrap').css('menu-animate first-time');
		showAndHideMe('#menu-wrap', '#button-menu', 'menu-non-animate', 'menu-animate first-time', 'menu-top', 'menu-down', 'fleche-haut' );

/**************************************** Notice/Error Box ****************************************/		

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
/**************************************** Scroll To in Maps ****************************************/		

		$j('#pull_the_page_to_map').click(function(){
				$j(window).scrollTo('#map_canvas', 500);
		});

/**************************************** Statistics ****************************************/		
		
});
