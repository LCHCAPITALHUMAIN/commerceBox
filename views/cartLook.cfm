<span id="close">x</span>
<cfdump var="#rc.gCartItems#" expand="false" >
	<cfif rc.gCartItems.recordcount>
		<ul>
		<cfoutput query="rc.gCartItems">
		<li>
		Title: #title#<br>
		Quantity: #quantity#<br> 	
		</li>
					
				
<!---		<td>#description#</td>
		<td align="center"><input type="text" name="#model#" value="#quantity#" size="2" /></td>
		<td>#dollarformat(price)#</td>
		<td>#size#</td>
		<td>#dollarformat(total)#</td>--->
				
		</cfoutput>
		</ul>	
		<div>
			Subtotal:
			<cfoutput>#dollarFormat(rc.gCart.getCartTotal())#</cfoutput>
		</div>
		

		<!--- Output the checkout button --->
		<!---<div align="right" style="margin-top:10px;">
			<cfoutput>#rc.gCart.CreateForm()#</cfoutput>	
		</div>--->

	<cfelse>
		<h4>Your Shopping Cart is Empty</h4>
		<p>Please return to the <a href="<cfoutput>#getSetting("sesBaseURL")#</cfoutput>/product">products page</a> to select an item you would like to purchase.</p>
	</cfif>


<!---<script src="http://checkout.google.com/files/digital/ga_post.js" type="text/javascript"></script>--->