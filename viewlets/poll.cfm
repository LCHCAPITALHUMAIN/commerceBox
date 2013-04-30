<cfset runEvent(event='viewlet.prepareFeaturedPoll',private=true)>
<cfif event.valueexists("poll")>
  <div id="poll" class="outerbox">
    <div>
      <h3 style="color:white"><cfoutput>#rc.poll.getTitle()#</cfoutput></h3>
      <div class="innerbox poller_question" id="poller_question<cfoutput>#rc.poll.getID()#</cfoutput>">
        <form action="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>" onsubmit="return false" method="post" name="poller">
			<input type="hidden" name="event" value="poll.doVote" />
          <cfloop from="1" to="#arrayLen(rc.options)#" index="i">
		  	<cfset option=rc.options[i]>
		  	<cfoutput>
              <p class="pollerOption">
                <input type="radio" value="#option.getID()#" name="vote[#rc.poll.getID()#]" id="pollerOption#option.getID()#" />
                <label for="pollerOption#option.getID()#" id="optionLabel#option.getID()#">#option.getAnswer()#</label>
              </p>
            </cfoutput>
			</cfloop>
          <a href="javascript:;" onclick="castMyVote(<cfoutput>#rc.poll.getID()#</cfoutput>,document.poller)"><img src="/includes/images/btn-vote.gif" width="45" height="22" alt="Vote" /></a>
        </form>
      </div>
    </div>
    <div class="poller_waitMessage" id="poller_waitMessage<cfoutput>#rc.poll.getID()#</cfoutput>"> Getting poll results. Please wait... </div>
    <div id="poller_results">
      <div class="poller_results" id="poller_results<cfoutput>#rc.poll.getID()#</cfoutput>">
        <!-- This div will be filled from Ajax, so leave it empty -->
      </div>
    </div>
  </div> 
  </cfif>