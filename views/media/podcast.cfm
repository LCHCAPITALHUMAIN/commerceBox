<div class="outerbox" >
	<div class="boxtab" style="background:none;"><h2 style="background:none"><cfoutput>#getSetting("siteName")#</cfoutput> Video Podcasts</h2></div>
	<div class="innerbox">
	<cfoutput query="rc.qVideoProducts">
		<a href="itpc://revivalseminars.org/includes/feeds/#rc.qVideoProducts.model#vidcast.xml" title="#rc.qVideoProducts.title#"><img src="/includes/images/products/#rc.qVideoProducts.model#-SM.jpg" alt="#rc.qVideoProducts.title#" /></a>
		<a href="itpc://revivalseminars.org/includes/feeds/#rc.qVideoProducts.model#vidcast.xml" title="#rc.qVideoProducts.title#"><img src="/includes/images/rss/iTunes.gif" width="80" height="15" alt="Download with itTunes" /></a>
		<a href='http://subscribe.getmiro.com/?url1=http%3A//revivalseminars.org/includes/feeds/#rc.qVideoProducts.model#vidcast.xml' title='Miro: Internet TV'><img src='http://subscribe.getmiro.com/img/buttons/one-click-subscribe-88X34.png' alt='Download with Miro Video Player' border='0' id='one-click-image' /></a>
		<hr />
	</cfoutput>
	</div>
</div>
<div class="outerbox" >
	<div class="boxtab" style="background:none;"><h2 style="background:none"><cfoutput>#getSetting("siteName")#</cfoutput> Audio Podcasts</h2></div>
	<div class="innerbox">
	<cfoutput query="rc.qAudioProducts">
		<a href="itpc://revivalseminars.org/includes/feeds/#rc.qAudioProducts.model#audcast.xml" title="#rc.qAudioProducts.title#"><img src="/includes/images/products/#rc.qAudioProducts.model#-SM.jpg" alt="#rc.qAudioProducts.title#" /></a>
		<a href="itpc://revivalseminars.org/includes/feeds/#rc.qAudioProducts.model#audcast.xml" title="#rc.qAudioProducts.title#"><img src="/includes/images/rss/iTunes.gif" width="80" height="15" alt="Download with itTunes" /></a>
		<hr />
	</cfoutput>
	</div>
</div>