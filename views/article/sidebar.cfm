<div class="sidebar">
  <div class="outerbox">
    <h3>Article Categories</h3>
    <div class="innerbox">
        <ul>
            <cfoutput query="rc.qsections">
              <li><a href="#event.buildLink("article/list")#/#rc.qsections.id#" title="#rc.qSections.title#">#rc.qSections.title#</a></li>
            </cfoutput>
        </ul>
    </div>
  </div>
  <cfif structKeyExists(rc, "aRelatedProducts")>
  <div class="outerbox">
    <h3>Related Products</h3>
    <cfloop from="1" to="#arrayLen(rc.aRelatedProducts)#" index="i">
	<cfset product = rc.aRelatedProducts[i]>
		<cfoutput>
		  <div class="innerbox group acenter"><a href="#event.buildLink("#rc.xehProduct#")#/#product.getID()#" title="#product.getTitle()#"><img src="/includes/images/products/#product.getModel()#-SM.jpg" alt="#product.getTitle()#" /></a>
			  <p><a href="#event.buildLink("#rc.xehProduct#")#/#product.getID()#" style="text-decoration:none; font-size:80%;" title="#product.getTitle()#">#product.getTitle()#</a></p>
			</div>
		</cfoutput>
    </cfloop>
  </div>
  </cfif>
</div>