<!---  Execute Event --->
<cfset runEvent(event='viewlet.prepareProdNav',private=true)>

<div class="sidebar">
  <div class="outerbox">
    <div class="boxtab">
      <h3>Categories</h3>
    </div>
    <div class="innerbox">
      <div class="navLeft">
        <ul>
          <cfoutput query="rc.qSections">
          <li><a href="#getSetting("sesBaseURL")#/#rc.xehList#/section/#rc.qSections.id#" title="#rc.qSections.title#">#rc.qSections.title#</a></li>
          </cfoutput>
        </ul>
      </div>
    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab">
      <h3>Sizes</h3>
    </div>
    <div class="innerbox">
      <div class="navLeft">
        <ul>
          <cfoutput query="rc.qSizes">
          <li><a href="#getSetting("sesBaseURL")#/#rc.xehList#/size/#rc.qSizes.id#" title="#rc.qSizes.title#">#rc.qSizes.title#</a></li>
          </cfoutput>
        </ul>
      </div>
    </div>
  </div>
  <!---div class="outerbox">
    <div class="boxtab">
      <h3>Color</h3>
    </div>
    <div class="innerbox">
      <div class="navLeft">
        <ul>
          <cfoutput query="rc.qFormats">
          <li><a href="#getSetting("sesBaseURL")#/#rc.xehList#/format/#rc.qFormats.id#" title="#rc.qFormats.title#">#rc.qFormats.title#</a></li>
          </cfoutput>
        </ul>
      </div>
    </div>
  </div--->
</div>
