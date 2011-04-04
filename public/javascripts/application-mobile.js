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


$j(document).ready(function() {
/*
 **********************************************************************************************  Login
 */		
		buttonLogin = $j('#button-link');
		loginWrap = $j('#login-wrap');
		$j('#login-div.without-js').removeClass('without-js');
		
		$j('#button-link a').attr('href','#')
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

/*
 ********************************************************************************************** Menu
 */				

// See OnComplete of the Ajax request when the page load
		
});
