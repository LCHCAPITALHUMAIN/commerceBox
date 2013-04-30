<div class="sidebar">
	<div class="outerbox">
		<h3>Manage Articles</h3>
		<div class="innerbox">
			<ul>
				<li><a href="<cfoutput>#event.buildLink(rc.xehDetail)#</cfoutput>">Add Article</a></li>
				<li><a href="<cfoutput>#event.buildLink(rc.xehList)#</cfoutput>">Edit Articles</a></li>
			</ul>
		</div>
	</div>
  <div class="outerbox">
    <h3>Manage Categories</h3>
    <div class="innerbox">
        <ul>
			<li><a href="<cfoutput>#event.buildLink(rc.xehSectionDetail)#</cfoutput>">Add Category</a></li>
           	<li><a href="<cfoutput>#event.buildLink(rc.xehSectionList)#</cfoutput>">Edit Categories</a></li>
        </ul>
    </div>
  </div>
  <div class="outerbox">
    <h3>Manage Authors</h3>
    <div class="innerbox">
        <ul>
			<li><a href="<cfoutput>#event.buildLink(rc.xehAuthorDetail)#</cfoutput>">Add Author</a></li>
           	<li><a href="<cfoutput>#event.buildLink(rc.xehAuthorList)#</cfoutput>">Edit Authors</a></li>
        </ul>
    </div>
  </div>
  <div class="outerbox">
    <h3>Manage Featured</h3>
    <div class="innerbox">
        <ul>
			<li><a href="<cfoutput>#event.buildLink(rc.xehFeaturedDetail)#</cfoutput>">Add Schedule</a></li>
			<li><a href="<cfoutput>#event.buildLink(rc.xehFeaturedList)#</cfoutput>">Edit Schedules</a></li>
        </ul>
    </div>
  </div>
  <cfif structKeyExists(rc, "aRelatedProducts")>
  <div class="outerbox">
    <h3>Related Resources</h3>
    <cfloop from="1" to="#arrayLen(rc.aRelatedProducts)#" index="i">
	<cfset product = rc.aRelatedProducts[i]>
		<cfoutput>
		  <div class="innerbox group acenter"><a href="#event.buildLink("product/detail")#/#product.getID()#" title="#product.getTitle()#"><img src="/includes/images/products/#product.getModel()#-SM.jpg" alt="#product.getID()#" /></a>
			  <p><a href="#event.buildLink("product/detail")#/#product.getID()#" style="text-decoration:none; font-size:80%;" title="#product.getTitle()#">#product.getTitle()#</a></p>
			</div>
		</cfoutput>
    </cfloop>
  </div>
  </cfif>
</div>