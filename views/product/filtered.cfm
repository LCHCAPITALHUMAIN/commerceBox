<cfoutput>#renderView('viewlets/prodnav')#</cfoutput>
<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab"><h2><cfoutput>#rc.title#</cfoutput></h2></div>
		<div class="innerbox">
			<div>
				<cfif structKeyExists(rc,"Array") and arrayLen(rc.array)>
					<cfloop from="1" to="#arrayLen(rc.Array)#" index="i">
					<cfset item = rc.Array[i]>
					<cfif item.hasParentProduct()>
					<cfset product = item.getParentProduct()>
					<cfoutput>
					<table cellspacing="0" cellpadding="7">
						<tr style="margin-bottom:10px;">
							<td><a href="#getSetting("sesBaseURL")#/#rc.xehDetails#/#product.getID()#" title="Pricing and available formats for #product.getTitle()#"><img src="/includes/images/products/#product.getModel()#-SM.jpg" /></a></td>
							<td><h3 style="margin-top:0">#product.gettitle()#</h3>
								<p>#product.getsummary()#</p>
								<table cellspacing="0" style="width:590px; margin:5px 0; padding:5px; border:1px solid silver">
									<tr>
										<td width="250">#item.getTitle()#</td>
										<td width="110">Price: #dollarformat(item.getPrice()+item.getspecialprice())#	</td>
										<td width="70"><a href="#getSetting("sesBaseURL")#/#rc.xehDetails#/#product.getID()#" title="More information for #rc.qproducts.title#"><img src="/includes/images/ui_readmore.gif" alt="#product.getTitle()#" width="65" height="19" /></a></td>
										<td width="60"><form name="googleCheckout#item.getID()#" method="POST" action="#getSetting("sesBaseURL")#/#rc.xehAddToCart#">
												<input type="hidden" name="model" value="#product.getModel()#-#item.getParentFormat().getPrefix()#" />
												<input type="hidden" name="title" value="#product.getTitle()#" />
												<input type="hidden" name="description" value="#item.getTitle()#" />
												<input type="hidden" name="price" value="#item.getPrice()#" />
												<input type="hidden" name="donation" value="#item.getSpecialPrice()#" />
												<input type="hidden" name="quantity" value="1" />
												<input type="image" src="/includes/images/ui_addtocart.gif" value="Add to Cart" name="addToCart" alt="Add to Cart" />
											</form></td>
									</tr>
								</table>
							</td>
						</tr>
					</table></cfoutput>
					</cfif>
					</cfloop>
				<cfelse>
					<div style="color:#990000; margin:5px;"><p>Sorry, your search returned no results.</p></div>
				</cfif>
				</div>
		</div>
	</div>
</div>