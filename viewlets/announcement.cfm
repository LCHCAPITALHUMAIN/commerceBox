<cfset runEvent(event='viewlet.prepareAnnouncement',private=true)>

<div id="news" class="outerbox">
    <div class="boxtab"><h3><cfoutput><a href="#getSetting("sesBaseURL")#/about/news">#getSetting("siteName")# Activity</a></cfoutput></h3>
    </div>
    <div class="innerbox">
      <ul>
        <cfoutput query="rc.announcements" maxrows="2">
          <li><a href="#getSetting("sesBaseURL")#/about/newsdetails/#rc.announcements.id#" title="#rc.announcements.title#">#rc.announcements.title#</a></li>
        </cfoutput>
      </ul>
    </div>
</div>