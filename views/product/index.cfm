<cfoutput>#renderView('viewlets/prodnav')#</cfoutput>

<div class="column-w573 left">
  <div class="outerbox">
    <div class="boxtab">
      <h3>Featured <cfoutput>#getSetting("siteName")#</cfoutput> Products</h3>
    </div>
    <div class="innerbox">
        <cfoutput query="rc.qFeaturedProducts" maxrows="2">
          <div class="left" style="width:48%"> <a href="#getSetting("sesBaseURL")#/#rc.xehDetails#/#rc.qFeaturedProducts.id#" title="#rc.qFeaturedProducts.title#"><img src="/includes/images/products/#rc.qFeaturedProducts.model#-SM.jpg" alt="#rc.qFeaturedProducts.title#" style="padding:0 20px;" /></a> </div>
        </cfoutput>
      <div style="clear:both;"></div>
    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab">
      <h3>Latest <cfoutput>#getSetting("siteName")#</cfoutput> Products</h3>
    </div>
    <div class="innerbox">
		<cfoutput query="rc.qLatestProducts" maxrows="2">
        <div style="width:48%;" class="left"><a href="#getSetting("sesBaseURL")#/#rc.xehDetails#/#rc.qLatestProducts.id#" title="#rc.qLatestProducts.title#"><img src="/includes/images/products/#rc.qLatestProducts.model#-SM.jpg" alt="#rc.qLatestProducts.title#" style="padding:0 20px;" /></a>
		</div>
		</cfoutput>
      <div style="clear:both;"></div>
    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab">
      <h3>Most Frequently Viewed Products</h3>
    </div>
    <div class="innerbox">
		<cfoutput query="rc.qPopularProducts" maxrows="4">
        <div style="width:24%;" class="left">
          <a href="#getSetting("sesBaseURL")#/#rc.xehDetails#/#rc.qPopularProducts.id#" title="#rc.qPopularProducts.title#"><img src="/includes/images/products/#rc.qPopularProducts.model#-SM.jpg" alt="#rc.qPopularProducts.title#" class="left"></a>
        </div>
		</cfoutput>
      <div style="clear:both;"></div>
    </div>
  </div>
</div>