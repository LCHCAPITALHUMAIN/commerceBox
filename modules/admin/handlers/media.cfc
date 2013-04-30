<cfcomponent name="media" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="productService" inject="model">
	<cfproperty name="streamService" inject="model">

	<cffunction name="init" access="public" returntype="media" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfscript>
			super.init(arguments.controller);
		
			xehList = "media/index";
			xehDetail = "media/details";
			xehSave = "media/save";
			xehDelete = "media/delete";
			
			return this;
		</cfscript>
	</cffunction>
		
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			rc = event.getCollection();
			
			rc.xehList = xehList;
			rc.xehDetail = xehDetail;
			rc.xehSave = xehSave;
			rc.xehDelete = xehDelete;
		
			rc.qProducts = productService.getProducts(orderby="id",orderasc=1);
		
			event.setView("media/index");
		</cfscript>
	</cffunction>
	
	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			var rc = event.getCollection();
			var sections = "";
			
			rc.xehList = xehList;
			rc.xehDetail = xehDetail;
			rc.xehSave = xehSave;
			rc.xehDelete = xehDelete;
			//setup page parameters
			rc.product = productService.getProduct(val(event.getValue("id",0)));
			rc.title = "Edit Resource Streams";
			
			rc.aStreams = rc.product.getStreamArray();
		
			event.setView("media/details");
			</cfscript>
	</cffunction>
	
	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">		
		<cfscript>
			var rc = event.getCollection();
			var product = "";
			var stream = "";
			var streams = "";
			var streamtitles = "";
			var streamviews = "";
			var isaudio = "";
			var isvideo = "";
			var streamislive = "";
			var fs = structNew();
			var enclosure_url = arrayNew(1);
			var enclosure_length = arrayNew(1);
			var enclosure_type = arrayNew(1);
			var duration = arrayNew(1);
			var keywords = arrayNew(1);
			var subtitle = arrayNew(1);
			var author = arrayNew(1);
			var path = "";
			//get the product object
			product = productService.getproduct(event.getValue("id",0));
			productService.saveProduct(product);
			//setup streams
			streams = listtoArray(event.getValue("streamid",""));
			streamtitles = listToArray(event.getValue("streamtitle",""));
			streamviews = listToArray(event.getValue("streamviews",""));
			isaudio = listToArray(event.getValue("isaudio",""));
			isvideo = listToArray(event.getValue("isvideo",""));
			streamislive = listToArray(event.getValue("streamislive",""));
			//loop through the streams and setup the item
			for(i = 1; i lte arrayLen(streams); i = i + 1)
			{
				//setup the stream
				stream = productService.getStream(val(streams[i]));
				stream.setTitle(streamtitles[i]);
				stream.setViews(val(streamviews[i]));
				stream.setisAudio(val(isaudio[i]));
				stream.setIsVideo(val(isvideo[i]));
				stream.setIsLive(val(streamislive[i]));
				// setup parent product
				stream.setParentProduct(product);
				// save stream
				productService.saveStream(stream);
			}
			
			fs.title = product.getTitle() & ", " & getSetting("siteName") & " Video Podcast";
			fs.link = "http://revivalseminars.org";
			fs.author = "#getSetting("siteName")#";
			fs.copyright ="#dateformat(now(),"YYYY")# #getSetting("siteName")#";
			fs.summary = product.getSummary(); "Podcasts of materials from #getSetting("siteName")#. #getSetting("tagLine")#";
			fs.description = product.getSummary();
			fs.ownerName = fs.author;
			fs.ownerEmail = getSetting("ownerEmail");
			fs.category = "Religion & Spirituality";
			fs.subcategory = "Christianity";
			fs.image = structNew();
			fs.image.url = fs.link & "/includes/images/products/" & product.getModel() & "-POD.jpg";
			fs.image.title = fs.title;
			fs.image.link = fs.link;
			fs.image.width = "150";
			fs.image.height = "150";
			fs.image.description = fs.title;
			//audio
			fs.items = productService.getStreamsByFormatandProduct(isvideo=1,productid=product.getID());
			</cfscript>
			<cfoutput query="fs.items">
				<cfset enclosure_url[fs.items.currentrow] = "http://revivalstreaming.org/media/#fs.items.model#_#fs.items.currentrow#.m4v">
				<cfif fs.items.currentrow lt 10>
				<cfset enclosure_url[fs.items.currentrow] = "http://revivalstreaming.org/media/#fs.items.model#_0#fs.items.currentrow#.m4v">
				</cfif>
				<cfset enclosure_length[fs.items.currentrow] = 0>
				<cfset enclosure_type[fs.items.currentrow] = "video/x-m4v">
				<cfset duration[fs.items.currentrow] = "58:30">
				<cfset keywords[fs.items.currentrow] = "video, sermon, revival, stephen wallace, steve, vincint, adventist, pastor">
				<cfset subtitle[fs.items.currentrow] = fs.items.title & " - " & product.gettitle()>
				<cfset author[fs.items.currentrow] = fs.author>
			</cfoutput>
			<cfscript>
			queryAddColumn(fs.items,"enclosure_url","varchar",enclosure_url);
			queryAddColumn(fs.items,"enclosure_length","varchar",enclosure_length);
			queryAddColumn(fs.items,"enclosure_type","varchar",enclosure_type);
			queryAddColumn(fs.items,"duration","varchar",duration);
			queryAddColumn(fs.items,"keywords","varchar",keywords);
			queryAddColumn(fs.items,"subtitle","varchar",subtitle);
			
			path = "/includes/feeds/" & product.getModel() & "vidcast.xml";
			getMyPlugin("podcastGenerator").createFeed(feedStruct=fs,outputfile=expandPath(path));
			
			// audio
			fs.title = product.getTitle() & ", " & getSetting("siteName") & " Audio Podcast";
			fs.items = productService.getStreamsByFormatandProduct(isaudio=1,productid=product.getID());
			</cfscript>
			<cfoutput query="fs.items">
				<cfset enclosure_url[fs.items.currentrow] = "http://revivalstreaming.org/media/#fs.items.model#_#fs.items.currentrow#.mp3">
				<cfif fs.items.currentrow lt 10>
				<cfset enclosure_url[fs.items.currentrow] = "http://revivalstreaming.org/media/#fs.items.model#_0#fs.items.currentrow#.mp3">
				</cfif>
				<cfset enclosure_length[fs.items.currentrow] = 0>
				<cfset enclosure_type[fs.items.currentrow] = "audio/mpeg">
				<cfset duration[fs.items.currentrow] = "58:30">
				<cfset keywords[fs.items.currentrow] = "audio, sermon, revival, stephen wallace, steve, vincint, adventist, pastor">
				<cfset subtitle[fs.items.currentrow] = fs.items.title & " - " & product.gettitle()>
				<cfset author[fs.items.currentrow] = fs.author>
			</cfoutput>
			<cfscript>
			queryAddColumn(fs.items,"enclosure_url","varchar",enclosure_url);
			queryAddColumn(fs.items,"enclosure_length","varchar",enclosure_length);
			queryAddColumn(fs.items,"enclosure_type","varchar",enclosure_type);
			queryAddColumn(fs.items,"duration","varchar",duration);
			queryAddColumn(fs.items,"keywords","varchar",keywords);
			queryAddColumn(fs.items,"subtitle","varchar",subtitle);
			
			path = "/includes/feeds/" & product.getModel() & "audcast.xml";
			getMyPlugin("podcastGenerator").createFeed(feedStruct=fs,outputfile=expandPath(path));
		
			getPlugin("messagebox").setMessage("info","The streams have been successfully saved.");
			setNextRoute("media/details/#product.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset productService.deletestream(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The resource has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("media/list")>
	</cffunction>
</cfcomponent>