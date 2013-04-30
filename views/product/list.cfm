<script type="text/javascript"> 
$(function() {
	// apply cycle to all
    $('.product-images').cycle({
        fx:      'fade',
        speed:       200, 
   		timeout:     2000
    });
    // pause all by default
	$('.product-images').cycle('pause');
	// resume hovered only
	$('.product-images').mouseover(function(){
		$(this).cycle('resume');
	});
	// pause moused out only
	$('.product-images').mouseout(function(){
		$(this).cycle('pause');
	});
});
</script> 
<cfoutput>#renderView('viewlets/prodnav')#
<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab"><h2>#rc.title#</h2></div>
		<div class="innerbox">
			<div>
				<!---div class="infobox">
					<form id="sorter" name="sorter" action="#getSetting("sesBaseURL")#/#event.getCurrentHandler()#/#event.getCurrentAction()#/<cfif event.valueExists("filter")>#event.getValue("filter")#</cfif>/<cfif event.valueExists("id")>#event.getValue("id")#</cfif>" method="post">
						<label for="field">Sort products by:</label>
						<select name="sortBy" onChange="this.form.submit();">
							<option value="">Select</option>
							<option value="id">Latest</option>
							<option value="views">Popularity</option>
						</select>
						<noscript>
						<input type="submit" name="submit" value="sort" />
						</noscript>
					</form>
				</div--->
				<cfif structKeyExists(rc,"productArray") and arrayLen(rc.productArray)>
					<cfloop from="1" to="#arrayLen(rc.productArray)#" index="i">
					<cfset product = rc.productArray[i]>
					<cfset items = product.getItemArray()>
					<cfset images = product.getProductImageArray()>
					<div style="margin:5px 2px; width:240px; float:left; position:relative;">
						<div class="product-images">
							<cfloop from="1" to="#arrayLen(images)#" index="i">
								<a href="#event.buildLink(rc.xehDetails)#/#product.getID()#" title="View details for #product.getTitle()#"><img src="/includes/images/products/#images[i].getLImage()#" width="240" height="320" /></a>
							</cfloop>
						</div>
						<p><a href="#event.buildLink(rc.xehDetails)#/#product.getID()#" title="View details for #product.getTitle()#"><img src="/includes/images/view-details.jpg" width="240" height="31" /></a></p>
						<div style="z-index:9999; position:absolute; width:80px; height:30px; background:url(/includes/images/price-tag.png) no-repeat; padding-left:15px; padding-top:5px; top:5px; right:5px; color:white;">#dollarformat(items[1].getPrice())#</div>
					</div>
					</cfloop>
				<cfelse>
					<div style="color:##990000; margin:5px;"><p>Sorry, your search returned no results.</p></div>
				</cfif>
				</div>
		</div>
	</div>
</div>
</cfoutput>