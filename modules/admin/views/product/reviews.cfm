#renderView(view="viewlets/prodsidebar",module="admin")#

<div class="column-w573 left">
	<!---cfinclude template="/includes/utilities/quickcart.cfm" /--->
	<div class="outerbox">
		<div class="boxtab"><h3>Readers Respond to <cfoutput>#rc.product.getTitle()#</cfoutput></h3></div>
		<div class="innerbox">
		
			<div class="infobox"><cfoutput><a href="#getSetting("sesBaseURL")#/#rc.xehDetail#/#rc.product.getID()#" title="#rc.product.getTitle()#">Return to item description</a></cfoutput></div>
			<h4>Reviews</h4>
			<cfoutput query="rc.qReivews">
				<cfif rc.qReivews.title IS NOT ""><h4>#rc.qReivews.title#</h4></cfif>
				<div class="reviews"><blockquote><p>#rc.qReivews.content#</p></blockquote>
				<p style="text-align:right">&mdash; #rc.qReivews.author#</p></div>
			</cfoutput>
			<h2><cfoutput>#rc.product.getTitle()#</cfoutput></h2>
			<cfoutput><a href="#getSetting("sesBaseURL")#/#rc.xehDetail#/#rc.product.getID()#" title="#rc.product.getTitle()#"><img src="/includes/images/products/#rc.product.getModel()#-SM.jpg" style="float:left;" /></a>
			<p>#rc.product.getSummary()#</p></cfoutput>
			<div class="infobox" style="clear:both"><cfoutput><a href="#getSetting("sesBaseURL")#/#rc.xehDetail#/#rc.product.getID()#" title="#rc.product.getTitle()#">Return to item description</a></cfoutput></div>
		</div>
    </div>
</div>