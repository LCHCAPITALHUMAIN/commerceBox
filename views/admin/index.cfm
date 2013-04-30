<div class="sidebar">
  <div class="outerbox"><a href="/media/video" title="Streaming Video"><img src="../../includes/images/watch-now.jpg" width="190" height="146" alt="Streaming Video" /></a> </div>
  <div class="outerbox"><a href="/media/audio" title="Streaming Audio"><img src="../../includes/images/listen-now.jpg" width="190" height="125" alt="Streaming Audio" /></a> </div>
  <div class="outerbox"><a href="/article" title="Product Articles"><img src="../../includes/images/read-now.jpg" width="190" height="100" alt="Biblical Articles" /></a> </div>
</div>

<div class="column-w370 left">
  <div id="news" class="outerbox">
    <div class="boxtab"><h3><a href="/about/news">Breaking News</a></h3>
    </div>
    <div class="innerbox">
      <ul>
        <cfoutput query="rc.newsletters" maxrows="2">
          <li><a href="/about/news/details/#rc.newsletters.id#" title="#rc.newsletters.title#">#rc.newsletters.title#</a></li>
        </cfoutput>
      </ul>
    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab">
    	<h3><a href="/product">Featured Products</a></h3>
    </div>
    <div class="innerbox" style="text-align:center">
      <cfoutput query="rc.featuredProducts" maxrows="2">
        <a href="/product/details/#rc.featuredProducts.id#" title="#rc.featuredProducts.title#"><img src="/includes/images/products/#rc.featuredProducts.model#-SM.jpg" alt="#rc.featuredProducts.title#" style="padding:0 20px;"/></a>		</cfoutput>    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab"><h3><a href="/article">Featured Articles</a></h3>
    </div>
    <div class="innerbox">
      <ul>
        <cfoutput query="rc.featuredArticles" maxrows="2">
          <li><a href="/article/details/#rc.featuredArticles.id#" title="#rc.featuredArticles.title#">#rc.featuredArticles.title#</a></li>
        </cfoutput>
      </ul>
    </div>
  </div>
</div>
<div class="column-w2 right" style="margin-bottom:-14px;">
  <div id="subscribe" class="outerbox">
    <h3>Newsletter Sign-up</h3>
    <div class="innerbox">
      <form action="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>" method="post" name="newsletter" id="newsletter">
	  	<input type="hidden" name="event" value="newsletter.doSignUp" />
        <input name="email" id="email" type="text" class="text" style="width:130px;" value="Enter your email" onfocus="if(this.value=='Enter your email')this.value='';"  />
        <input name="Submit" id="Submit" type="image" src="/includes/images/btn-join.gif" value="Join" align="bottom" />
      </form>
      <p id="response" style="font-size:11px;margin-top:5px;margin-bottom:0;padding:0;visibility:hidden"></p>
    </div>
  </div>
  <div class="outerbox">
		<h3>Make a Donation</h3>
		<div class="innerbox">
		<script type="text/javascript">
			function updateDonation(e){
				document.getElementById('model').value=e.value
			}
		</script>
		<form name="donation" action="/cart/doAdd" method="post">
		<input type="hidden" name="model" id="model" value="DON-General" />
		<input type="hidden" name="quantity" value="1" />
		<input type="hidden" name="title" value="Donation" />
		<label for="donation">Amount:</label>
		<input name="donation" type="text" style="width:50px;" value="0.00" />
		<input name="price" type="hidden" style="width:50px;" value="0.00" />
		<select name="description" onchange="updateDonation(this)">
			<option value="DON-General">Where Needed</option>
			<option value="DON-Video">Video Production</option>
			<option value="DON-Website">Website Outreach</option>
		</select>
		<input type="submit" value="Donate Now" name="addToCart" alt="Add your donation to the cart" />
		</form>
		</div>
	</div>
  <div id="poll" class="outerbox">
    <div>
      <h3><cfoutput>#rc.poll.title#</cfoutput></h3>
      <div class="innerbox poller_question" id="poller_question<cfoutput>#rc.poll.id#</cfoutput>">
        <form action="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>" onsubmit="return false" method="post" name="poller">
			<input type="hidden" name="event" value="pollVote.doVote" />
          <cfoutput query="rc.pollOptions">
              <p class="pollerOption">
                <input type="radio" value="#rc.pollOptions.id#" name="vote[#rc.poll.id#]" id="pollerOption#rc.pollOptions.id#" />
                <label for="pollerOption#rc.pollOptions.id#" id="optionLabel#rc.pollOptions.id#">#rc.pollOptions.answer#</label>
              </p>
            </cfoutput>
          <a href="javascript:;" onclick="castMyVote(<cfoutput>#rc.poll.id#</cfoutput>,document.poller)"><img src="/includes/images/btn-vote.gif" width="45" height="22" alt="Vote" /></a>
        </form>
      </div>
    </div>
    <div class="poller_waitMessage" id="poller_waitMessage<cfoutput>#rc.poll.id#</cfoutput>"> Getting poll results. Please wait... </div>
    <div id="poller_results">
      <div class="poller_results" id="poller_results<cfoutput>#rc.poll.id#</cfoutput>">
        <!-- This div will be filled from Ajax, so leave it empty -->
      </div>
    </div>
  </div> 
  	<div class="outerbox">
    	<div class="innerbox">
        <span><strong>Current Visitors:</strong> <cfoutput>#structCount(application.visitors)#</cfoutput></span>
        </div>
    </div>
  </div>
<div class="column-w573 left" style="clear:left;">
  <div class="outerbox">
    <div class="boxtab"><h3>Testimonials</h3></div>
    <div class="innerbox">
      <blockquote>
        <p><cfoutput>#rc.randomTestimonial.getContent()# &mdash;<cite>#rc.randomTestimonial.getAuthor()#</cite></cfoutput></p>
      </blockquote>
    </div>
  </div>
  <div class="outerbox">
    <div class="boxtab">
    	<h3>From the Pen of Inspiration</h3>
    </div>
      <div class="innerbox">
            <blockquote>
               <cfoutput><p>#rc.randomQuote.getContent()# &mdash;<cite>#rc.randomQuote.getAuthor()#</cite></p></cfoutput>
            </blockquote>      
		</div>
  </div>
</div>