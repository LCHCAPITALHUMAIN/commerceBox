<div class="outerbox" style="width:830px">
	<div class="boxtab" style="background:none;"><h2 style="background:none"><cfoutput>#getSetting("siteName")#</cfoutput> Streaming Audio</h2></div>
	<div class="innerbox">
		<div style="width:315px; float:left">
		<div id="screen" style="background-color:#999999; padding:5px; padding-bottom:0; width:315px; height:60px;">
			<div id="player" style="height:60px;"></div>
		</div>
		<div id="que" style="background-color:#999; padding:5px; width:315px; height:320px; margin-bottom:5px;">
			<div id="inner-que" style="background-color:#fff; height:320px; overflow:auto; padding:0 2px;">
				<h3 style="text-align:center;">Programs Playlist</h3>
				<div id="playlist">
					<p>Click a title to load its playlist.</p>
				</div>
			</div>
		</div>
		</div>
		<div id="list" style="border:5px solid #999; padding:5px; width:470px; height:375px; overflow:auto; float:right;">
			<cfoutput query="rc.qProducts">
				<div style="float:left; width:120px; text-align:center; margin-bottom:5px;">
					<a href="javascript:;" onclick="play(#rc.qProducts.id#,'audio');" title="#rc.qProducts.title#"><img src="/includes/images/products/#rc.qProducts.model#-SM.jpg" alt="#rc.qProducts.title#" /></a>
				</div>
			</cfoutput>
		</div>
		<div style="clear:both"></div>
	</div>
</div>
<cfoutput>
<script type="text/javascript">
	var so = new SWFObject('/includes/movies/mediaplayer.swf','mpl',315,60,'7',"##000");
	so.addVariable("autostart","true");
	so.write('player');
	function loadPlayer(id) {
		var so = new SWFObject('/includes/movies/mediaplayer.swf','mpl',315,60,'7',"##000");
		so.addParam('allowscriptaccess','always');
		so.addParam('allowfullscreen','false');
		so.addVariable('width','315');
		so.addVariable('height','60');
		so.addVariable("file","#getSetting('streamURL')#/video");
		so.addVariable("id","mp3:"+id);
		so.addVariable("autostart","true");
		so.addVariable('showeq','true');
		so.write('player');
	};
</script>
</cfoutput>