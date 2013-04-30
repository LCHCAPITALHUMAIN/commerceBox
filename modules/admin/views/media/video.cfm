<div class="outerbox" style="width:830px;">
	<div class="boxtab" style="background:none;"><h2 style="background:none">Streaming Video</h2></div>
		<div class="innerbox">
		<div id="que" style="background-color:#999; padding:5px; width:315px; height:360px; margin-bottom:5px; float:left">
			<div id="inner-que" style="background-color:#fff; height:360px; overflow:auto; padding:0 5px;">
				<h3 style="text-align:center;">Programs Playlist</h3>
				<div id="playlist">
					<p>Click a title below to load its playlist.</p>
				</div>
			</div>
		</div>
		<div id="screen" style="background-color:#999; padding:5px; width:480px; height:360px; float:right">
			<div id="player" style="height:360px; background-color:#000;"></div>
		</div>
		<div id="list" style="border:5px solid #999; padding:5px; width:800px; clear:both; height:1%">
			<cfoutput query="rc.qProducts">
				<div style="float:left; width:20%; text-align:center; margin-bottom:5px;">
					<a href="javascript:;" onclick="play(#rc.qProducts.id#,'video');" title="#rc.qProducts.title#"><img src="/includes/images/products/#rc.qProducts.model#-SM.jpg" alt="#rc.qProducts.title#" /></a>
				</div>
			</cfoutput>
			<br clear="all" />
		</div>
	</div>
</div>
<cfoutput>
<script type="text/javascript">
	function loadPlayer(id) {
		var so = new SWFObject('/includes/movies/mediaplayer.swf','mpl',480,360,'7',"##000");
		so.addParam("allowfullscreen","true");
		so.addVariable('displayheight',360);
		so.addVariable("file","#getSetting('streamURL')#/video");
		so.addVariable("id",id);
		so.addVariable("start",0);
		so.addVariable("autostart","true");
		so.write('player');
	};
</script>
</cfoutput>