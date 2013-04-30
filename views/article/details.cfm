<cfoutput>#renderView("article/sidebar")#</cfoutput>

<div class="column-w573 left">
<cfif isDefined("rc.id")>
  <div class="outerbox">
    <div class="boxtab">
        <h2><cfoutput>#rc.section.getTitle()#</cfoutput></h2>
      </div>
    <div id="article" class="innerbox">
		<cfoutput>
			<h3>#rc.title#</h3>
			<span>by <cite>#rc.Author.getFullName()#</cite></span>
			<!---a href="sendlink.cfm" title="Send to a Friend" onclick="this.blur(); Modalbox.show(this.title, this.href, {width: 400, height: 300}); return false;">Send to a friend</a--->
			#rc.article.getContent()#
		</cfoutput>
      <!---<a class="yaction-link-bookmark"></a>
                    <a class="yaction-link-send"></a>
                    <a class="yaction-link-print"></a> --->
    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab"><h3>About Your Author</h3></div>
    <div class="innerbox"> 
        <p><cfoutput><img src="/includes/images/authors/#rc.Author.getImage()#" style="padding-right:5px;" vspace="5" align="left" title="#rc.Author.getFullName()#" />#rc.Author.getContent()#</cfoutput></p>
    </div>
  </div>
  <cfif rc.qRelatedArticles.recordcount GT 1>
    <div class="outerbox">
      <div class="boxtab"><h3>More Articles in this Category</h3></div>
      <div id="related-articles" class="innerbox">
        <ul>
          <cfoutput query="rc.qrelatedArticles">
            <cfif rc.qrelatedArticles.id NEQ rc.article.getID()>
                <li><a href="#getSetting("sesBaseURL")#/#event.getCurrentHandler()#/#event.getCurrentAction()#/#rc.qrelatedArticles.id#" title="#rc.qrelatedArticles.title#">#rc.qrelatedArticles.title#</a></li>
            </cfif>
          </cfoutput>
        </ul>
      </div>
    </div>
  </cfif>
  <cfelse>
  	<cfoutput>#rc.title#</cfoutput>
  </cfif>
</div>