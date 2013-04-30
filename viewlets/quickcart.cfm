<cfsavecontent variable="tohead">
<style>
#quickcart{
	color: white; width:290px; height:44px; 
	<!---background:url(/includes/images/top-navigation-bg.png) no-repeat;--->
	padding:3px 10px; margin-right:20px;
	border: #ccc solid 0px; 
	position:relative;}
#cartHeader a {color:red;}
#cartContent{
	min-width: 290px;
	padding:5px;
	color: #111;
	border: #666 solid 1px;
	background:#fff;
	display:none;
	position:relative;
	top:0px;
	z-index:999999;}
span#close{
	position:absolute;
	right: 4px;
	cursor:pointer;
	z-index:999;
}
#cartLoading{display:none;
	background: black;
	color: #ccc;
	position:absolute;
	width:100px;
	height:40px;
}
</style>
<script type="text/javascript">
jQuery(function(){
   jQuery('input[type=submit]#add-to-cart').click(function(e) {
       //console.dir(e);
       e.preventDefault();
	   var formstring = jQuery(this).closest("form").serialize() + "&submit="+ jQuery(this).attr("name");
       
	   addToCart(formstring);
   });
   
	function addToCart(formstring){
		jQuery('#cartLoading').fadeIn();
		jQuery.post("<cfoutput>#getSetting("sesBaseURL")#/cart/doAddAjax</cfoutput>?" + formstring, function(data){
			postSubmit();
		});
   };
   
   function showCart(){
       var cartContent = jQuery("#cartContent");
       cartContent.slideDown("slow");
   };
   
   function hideCart(){
       var cartContent = jQuery("#cartContent");
       cartContent.slideUp("slow");
       //jQuery("body").unbind("click");
   };
               
	function postSubmit(){
		updateCartHeader();
		
		updateCartContent();
	};
	
	function updateCartHeader(){
		jQuery("#cartHeader").load("<cfoutput>#getSetting("sesBaseURL")#/cart/index?cartHeader</cfoutput>",function(){
			
			console.log('heaer updated');
		});
	};
	
	function updateCartContent(){
		jQuery("#cartContent").load("<cfoutput>#getSetting("sesBaseURL")#/cart/index?cartLook</cfoutput>", function(){
			
			console.log('content updated');
			jQuery('#cartLoading').fadeOut();
			showCart();
			setTimeout( hideCart, 3500);
		});
	};
   	
	function toggleLoading(){
		jQuery("#cartLoading").toggle(fadeIn,fadeOut);
	};
	
   jQuery("#viewCart").click(function(event){
       //jQuery("body").click(function(){
       //    hideCart();
       //});
       //event.stopPropagation();
       showCart();                        
   });
   jQuery("span#close").click(hideCart);
});
</script>
</cfsavecontent>
<cfhtmlhead text="#tohead#">

<cfset runEvent(event='viewlet.prepareQuickCart',private=true)>

<div id="quickcart">
	<div id="cartHeader"><div id="cartLoading">Loading...</div>
		<cfoutput>#renderView('cartHeader')#</cfoutput>
	</div>
	<div id="cartContent">
       <cfoutput>#renderView('cartLook')#</cfoutput>
   </div>
   <div class="clear"></div>
</div>