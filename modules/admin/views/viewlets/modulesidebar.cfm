<cfset runEvent(event='admin:viewlet.prepareModuleSidebar',private=true)>

<div class="sidebar">
	<div class="outerbox">
		<h3>Manage Testimonies</h3>
		<div class="innerbox">
			<ul>
				<li><a href="<cfoutput>#event.buildLink(rc.xehTestimonialDetail)#</cfoutput>">Add Testimony</a></li>
				<li><a href="<cfoutput>#event.buildLink(rc.xehTestimonialList)#</cfoutput>">Edit Testimonies</a></li>
			</ul>
		</div>
	</div>
  <div class="outerbox">
    <h3>Manage Quotes</h3>
    <div class="innerbox">
        <ul>
			<li><a href="<cfoutput>#event.buildLink(rc.xehQuoteDetail)#</cfoutput>">Add Quotes</a></li>
           	<li><a href="<cfoutput>#event.buildLink(rc.xehQuoteList)#</cfoutput>">Edit Quotes</a></li>
        </ul>
    </div>
  </div>
  <div class="outerbox">
    <h3>Manage Subscribers</h3>
    <div class="innerbox">
        <ul>
			<li><a href="<cfoutput>#event.buildLink(rc.xehSubscriberDetail)#</cfoutput>">Add Subscriber</a></li>
			<li><a href="<cfoutput>#event.buildLink(rc.xehSubscriberList)#</cfoutput>">Edit Subscribers</a></li>
        </ul>
    </div>
  </div>
  <div class="outerbox">
    <h3>Manage Polls</h3>
    <div class="innerbox">
        <ul>
			<li><a href="<cfoutput>#event.buildLink(rc.xehPollDetail)#</cfoutput>">Add Poll</a></li>
			<li><a href="<cfoutput>#event.buildLink(rc.xehPollList)#</cfoutput>">Edit Polls</a></li>
        </ul>
    </div>
  </div>
</div>