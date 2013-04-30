<cfset runEvent(event='admin:viewlet.prepareProdSidebar',private=true)>

<div class="sidebar">
	<div class="outerbox">
		<h3>Manage Resources</h3>
		<div class="innerbox">
			<ul>
				<li><a href="<cfoutput>#event.buildLink(rc.xehDetail)#</cfoutput>">Add Resource</a></li>
				<li><a href="<cfoutput>#event.buildLink(rc.xehList)#</cfoutput>">Edit Resources</a></li>
			</ul>
		</div>
	</div>
	<div class="outerbox">
    <h3>Manage Colors</h3>
    <div class="innerbox">
        <ul>
			<li><a href="<cfoutput>#event.buildLink(rc.xehFormatDetail)#</cfoutput>">Add Color</a></li>
           	<li><a href="<cfoutput>#event.buildLink(rc.xehFormatList)#</cfoutput>">Edit Colors</a></li>
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
    <h3>Manage Featured</h3>
    <div class="innerbox">
        <ul>
			<li><a href="<cfoutput>#event.buildLink(rc.xehFeaturedDetail)#</cfoutput>">Add Schedule</a></li>
			<li><a href="<cfoutput>#event.buildLink(rc.xehFeaturedList)#</cfoutput>">Edit Schedules</a></li>
        </ul>
    </div>
  </div>
</div>