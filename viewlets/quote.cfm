<cfset runEvent(event='viewlet.prepareRandomQuote',private=true)>
<div class="outerbox">
    <div class="boxtab">
    	<h3>Quote</h3>
    </div>
    <div class="innerbox">
        <blockquote>
           <cfoutput><p>#rc.randomQuote.getContent()# &mdash;<cite>#rc.randomQuote.getAuthor()#</cite></p></cfoutput>
        </blockquote>      
    </div>
</div>