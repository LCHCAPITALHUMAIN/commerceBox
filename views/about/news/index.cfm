<div class="outerbox" >
	<div class="boxtab"><h2>Breaking News</h2></div>
	<div class="innerbox">
		<cfoutput>
			<p><a href="#event.buildLink(rc.xehDetails)#/#rc.qannouncements.id#" title="#rc.qannouncements.title#"><strong>#rc.qannouncements.title#</strong></a><br />
			<em>Published on #dateformat(rc.qannouncements.date, "mmmm dd, YYYY")#</em></p>
			<p>#rc.qannouncements.summary#</p>
			<div style="text-align:right"><a href="#event.buildLink(rc.xehDetails)#/#rc.xehDetails#/#rc.qannouncements.id#" title="View #rc.qannouncements.title#"><img src="/includes/images/icon_more.gif" alt="view more" /></a></div>
		</cfoutput>
	</div>
</div>
<cfif rc.qannouncements.recordcount gt 1>
<div class="outerbox">
	<div class="boxtab"><h2>Past News</h2></div>
	<div class="innerbox">
		<cfoutput query="rc.qannouncements">
			<cfif dateDiff("m",rc.qannouncements.date,now()) LT 3 AND rc.qannouncements.currentrow GT 1>
				<p><a href="#event.buildLink(rc.xehDetails)#/#rc.qannouncements.id#" title="#rc.qannouncements.title#"><strong>#rc.qannouncements.title#</strong></a><br />
				<em>Published on #dateformat(rc.qannouncements.date, "mmmm dd, YYYY")#</em></p>
				<div style="text-align:right"><a href="#event.buildLink(rc.xehDetails)#/#rc.qannouncements.id#" title="View #rc.qannouncements.title#"><img src="/includes/images/icon_more.gif" alt="view more" /></a></div>
			</cfif>
		</cfoutput>
	</div>
</div>
</cfif>