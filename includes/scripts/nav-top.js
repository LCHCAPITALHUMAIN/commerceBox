// Requires JQuery Library
jQuery(document).ready(function(){  
    
	
	
	
    /*jQuery("#nav li").hoverIntent(function(){
										   console.log($(this).children());
		jQuery(this).children().show();
						},
				   function(){
					   console.log(jQuery(this).children())
		jQuery(this).children().hide();  
							})*/
	jQuery("#nav-top ul li").mouseover(function() { //When trigger is moused over...  
  
        //Following events are applied to the subnav itself (moving subnav up and down)  
        jQuery(this).find("ul.subnav").show(); //Drop down the subnav on click  
  
        jQuery(this).hover(function() {  
        }, function(){  
            jQuery(this).find("ul.subnav").slideUp('slow'); //When the mouse hovers out of the subnav, move it back up  
        });  
  
        //Following events are applied to the trigger (Hover events for the trigger)  
        }).hover(function() {  
            jQuery(this).addClass("subhover"); //On hover over, add class "subhover"  
        }, function(){  //On Hover Out  
            jQuery(this).removeClass("subhover"); //On hover out, remove class "subhover"  
    });  
  
});