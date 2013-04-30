<cfoutput>
	<cfif rc.gCartItems.recordcount>
		<span>Shopping Cart:</span>
    	<p>#rc.gCartItems.recordcount# Item<cfif rc.gCartItems.recordcount gt 1>s</cfif><!---. Subtotal: #dollarFormat(rc.gCart.getCartTotal())#--->
		&nbsp;&nbsp;
		<a id="viewCart" href="javascript:void(0)">View</a>
		&nbsp;&nbsp;
		<a id="checkOut" href="#event.buildLink('cart/')#">Check out</a><p>
    <cfelse>
    	<p>Your cart is empty.</p>
    </cfif>
</cfoutput>
