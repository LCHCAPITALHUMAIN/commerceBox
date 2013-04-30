<cfcomponent name="media" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="productService" inject="model">
	<cfproperty name="streamService" inject="model">
	<cfproperty name="productStreamService" inject="model">

	<cffunction name="init" access="public" returntype="media" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="preHandler" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	
	<cffunction name="audio" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			rc.xehVideo = "media/video";
			rc.title="Audio On Demand - #getController().getSetting("siteName")#";
			rc.description="#getController().getSetting("siteName")# audio sermon archives";
			rc.keywords="#getController().getSetting("siteName")#, audio, streaming, sermons, on demand, archives";
			rc.scripts="swfobject.js,streams.js";
			
			rc.qProducts = productService.getProductsByStreamFormat(isaudio=1);
			
			event.setView("media/audio");
		</cfscript>
	</cffunction>

	<cffunction name="video" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			rc.xehAudio = "media/audio";
			rc.xehPlaylist = "media/doPlaylist";
			
			rc.title="Video On Demand - #getController().getSetting("siteName")#";
			rc.description="#getController().getSetting("siteName")# streaming video sermons";
			rc.keywords="#getController().getSetting("siteName")#, video, streaming, sermons, ondemand, archives";
			rc.scripts="swfobject.js,streams.js";
			
			rc.qProducts = productService.getProductsByStreamFormat(isvideo=1);
			
			event.setView("media/video");
		</cfscript>
	</cffunction>
	
	<cffunction name="podcast" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="Audio and Video Podcasts - #getController().getSetting("siteName")#";
			rc.description="#getController().getSetting("siteName")# podcasts video audio sermons";
			rc.keywords="#getController().getSetting("siteName")#, video, audio, podcast, itunes, streaming, sermons, ondemand, archives";
			
			rc.qVideoProducts = productService.getProductsByStreamFormat(isvideo=1);
			rc.qAudioProducts = productService.getProductsByStreamFormat(isaudio=1);
			
			event.setView("media/podcast");
		</cfscript>
	</cffunction>
	
	<cffunction name="gallery" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="Event Gallery - #getController().getSetting("siteName")#";
			rc.description="#getController().getSetting("siteName")# Event Gallery";
			rc.keywords="#getController().getSetting("siteName")# Event Gallery";
			rc.scripts="AC_RunActiveContent.js";
			event.setView("media/gallery");
		</cfscript>
	</cffunction>
	
	<cffunction name="bigbear" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="Event Gallery - #getController().getSetting("siteName")#";
			rc.description="#getController().getSetting("siteName")# Event Gallery";
			rc.keywords="#getController().getSetting("siteName")# Event Gallery";
			rc.scripts="AC_RunActiveContent.js";
			event.setView("media/bigbear");
		</cfscript>
	</cffunction>
	
	<cffunction name="watts" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="Event Gallery - #getController().getSetting("siteName")#";
			rc.description="#getController().getSetting("siteName")# Event Gallery";
			rc.keywords="#getController().getSetting("siteName")# Event Gallery";
			rc.scripts="AC_RunActiveContent.js";
			event.setView("media/watts");
		</cfscript>
	</cffunction>
	
	<cffunction name="carwash" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="Event Gallery - #getController().getSetting("siteName")#";
			rc.description="#getController().getSetting("siteName")# Event Gallery";
			rc.keywords="#getController().getSetting("siteName")# Event Gallery";
			rc.scripts="AC_RunActiveContent.js";
			event.setView("media/carwash");
		</cfscript>
	</cffunction>
	
	<cffunction name="doPlaylist" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
			<cfset var rc = event.getCollection()>
			<cfset var results = "">
			<cfset var program = "">
			<cfset var streams = "">
			<cfset var product = "">
			<cfset var pid = 0>
			
			<cfif event.valueExists("productid")>
			
				<cfset pid = val(event.getValue("productid"))>
				
				<cfif event.getValue("format") IS "video">
					<cfset streams = productService.getStreamsByFormatAndProduct(isvideo=1,productid=pid)>
				<cfelse>
					<cfset streams = productService.getStreamsByFormatAndProduct(isaudio=1,productid=pid)>
				</cfif>
				<cfif streams.recordcount>
					<cfsavecontent variable="results">
						<cfoutput><ul></cfoutput>
						<cfoutput query="streams">
							<cfif streams.currentrow LT 10>
								<cfset program = "#streams.model#_0#streams.currentrow#">
							<cfelse>
								<cfset program = "#streams.model#_#streams.currentrow#">
							</cfif>
							<li><a href="###program#" onClick="loadPlayer('#program#')">#streams.title#</a></li>
							</cfoutput>
						<cfoutput></ul></cfoutput>
					</cfsavecontent>
				<cfelse>
					<cfset results = "That item has no videos.">
				</cfif>
			<cfelse>
				<cfset results = "Please select an item below.">
			</cfif>
			
			<cfset rc.data = results>
			<cfset event.setView("ajaxProxy",true)>
	</cffunction>
	
</cfcomponent> 