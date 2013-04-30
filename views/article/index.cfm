<cfoutput>#renderView("article/sidebar")#</cfoutput>

<div class="column-w573 left">
  <div class="outerbox">
    <div class="boxtab">
      <h3>Latest <cfoutput>#getSetting("siteName")#</cfoutput> Articles</h3>
    </div>
    <div class="innerbox">
        <cfoutput query="rc.qLatestArticles" maxrows="2">
          <h4><a href="#getSetting("sesBaseURL")#/#rc.xehDetail#/#rc.qLatestArticles.id#" title="#rc.qLatestArticles.title#">#rc.qLatestArticles.title#</a></h4>
          <p>
            <cfif rc.qLatestArticles.summary IS "">
              <p>This article does not have a summary.</p>
              <cfelse>
              #rc.qLatestArticles.summary#
            </cfif>
          </p>
        </cfoutput>
    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab">
      <h3>Featured <cfoutput>#getSetting("siteName")#</cfoutput> Articles</h3>
    </div>
    <div class="innerbox">
        <cfoutput query="rc.qFeaturedArticles" maxrows="2">
          <h4><a href="#getSetting("sesBaseURL")#/#rc.xehDetail#/#rc.qFeaturedArticles.id#" title="#rc.qFeaturedArticles.title#">#rc.qFeaturedArticles.title#</a></h4>
          <p>
            <cfif rc.qFeaturedArticles.summary IS "">
              <p>This article does not have a summary.</p>
              <cfelse>
              #rc.qFeaturedArticles.summary#
            </cfif>
          </p>
        </cfoutput>
    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab">
      <h3>Most Frequently Viewed Articles</h3>
    </div>
    <div class="innerbox">
      <cfoutput query="rc.qPopularArticles" maxrows="4">
        <div style="width:48%; display:inline;">
          <div class="numbered-row" style="border:none;">
              <div class="number-col"> <span class="number"><a href="#getSetting("sesBaseURL")#/#rc.xehDetail#/#rc.qPopularArticles.id#" title="#rc.qPopularArticles.title#">#rc.qPopularArticles.currentRow#</a></span> </div>
              <div class="details">
                <h4><a href="#getSetting("sesBaseURL")#/#rc.xehDetail#/#rc.qPopularArticles.id#" title="#rc.qPopularArticles.title#">#rc.qPopularArticles.title#</a></h4>
                <p>#rc.qPopularArticles.summary#</p>
              </div>
          </div>
        </div>
      </cfoutput>
    </div>
  </div>
</div>