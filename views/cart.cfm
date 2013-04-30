<div class="outerbox" >
	<div class="boxtab"><h3><cfoutput>#getSetting("siteName")#</cfoutput> Shopping Cart</h3></div>
	<div class="innerbox">
	<cfif rc.gCartItems.recordcount>
		<table class="table1">
			<tbody>
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th align="center">Quantity</th>
					<th>Price</th>
					<th>Size</th>
					<th>Total</th>
				</tr>	
			<form action="<cfoutput>#getSetting("sesBaseURL")#/#rc.xehUpdateCart#</cfoutput>" method="post" name="cart">
			<cfoutput query="rc.gCartItems">
				<tr>
					<td>#title#</td>
					<td>#description#</td>
					<td align="center"><input type="text" name="#model#" value="#quantity#" size="2" /></td>
					<td>#dollarformat(price)#</td>
					<td>#size#</td>
					<td>#dollarformat(total)#</td>
				</tr>
			 </cfoutput>
				<tr>
					<td colspan="5" align="right">Subtotal:</td>
					<td><cfoutput>#dollarFormat(rc.gCart.getCartTotal())#</cfoutput></td>
				</tr>
				<tr>
					<td colspan="6">
						<input type="button" name="emptyCart" value="Empty Cart" onclick="javascript:document.location= '<cfoutput>#getSetting("sesBaseURL")#/#rc.xehEmptyCart#</cfoutput>';" />
						<input type="submit" name="updateCart" value="Update Cart" />
						<input type="button" name="continue" value="Continue Shopping" onclick="javascript:document.location= '<cfoutput>#getSetting("sesBaseURL")#/#rc.xehContinue#</cfoutput>';" />
					</td>
				</tr>
			 </form>
			 </tbody>
		</table>

		<!--- Output the checkout button --->
		<div align="right" style="margin-top:10px;">
			<cfoutput>#rc.gCart.CreateForm()#</cfoutput>	
		</div>

	<cfelse>
		<h4>Your Shopping Cart is Empty</h4>
		<p>Please return to the <a href="<cfoutput>#getSetting("sesBaseURL")#</cfoutput>/product">products page</a> to select an item you would like to purchase.</p>
	</cfif>
	</div>
</div>
<div class="outerbox" >
	<div class="boxtab"><h3>Make an Online Donation</h3></div>
	<div class="innerbox">
		<form name="donation" action="<cfoutput>#getSetting("sesBaseURL")#/#rc.xehAddToCart#</cfoutput>" method="post">
			<input type="hidden" name="model" id="model" value="General" />
			<input type="hidden" name="quantity" value="1" />
			<input type="hidden" name="title" value="Donation" />
			<label for="donation">Donation Amount:</label>
			<input name="price" type="text" style="width:50px;" value="0.00" />
			<select name="description" onchange="javascript:document.getElementById('model').value=this.value;">
				<option value="General" selected="selected">Where Needed</option>
				<option value="VideoProduction">Video Production</option>
				<option value="WebsiteAdvertising">Website Outreach</option>
			</select>
			<input type="submit" value="Add To Cart" name="addToCart" alt="Add your donation to the cart" />
		</form>
	</div>
</div>

<script src="http://checkout.google.com/files/digital/ga_post.js" type="text/javascript"></script>