<cfoutput>
<div class="outerbox">
	<div class="boxtab"><h2>#getController().getSetting("siteName")# News</h2></div>
	<div class="innerbox">
        <h3>#rc.announcements.gettitle()#</h3>
        <p>#rc.announcements.getcontent()#</p>
        <a href="#getSetting("sesBaseURL")#/<cfoutput>#rc.xehList#</cfoutput>" title="Return to news archives">&lt; Return to Archives</a>
	</div>
</div>
</cfoutput>