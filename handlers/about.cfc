<cfcomponent name="about" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="announcementService" inject="model">

	<cffunction name="init" access="public" returntype="about" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="About " & Event.getValue('title', '#getController().getSetting('siteName')#');
			rc.description= Event.getValue('tagline', '#getController().getSetting('tagline')#'); 
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			
			event.setView("about/beliefs");
		</cfscript>
	</cffunction>
		
	<cffunction name="beliefs" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="#Event.getValue('title', getController().getSetting('siteName'))# Beliefs";
			rc.description="The truths of God's Word as understood and taught by #getController().getSetting("siteName")#"; 
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			
			event.setView("about/beliefs");
		</cfscript>
	</cffunction>
    
    <cffunction name="banners" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="Support " & Event.getValue('title', '#getController().getSetting('siteName')#');
			rc.description="Acedia Apparel as seen on Animal Planet's Pitboss with Shorty Rossi"; 
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			
			event.setView("about/banners");
		</cfscript>
	</cffunction>
	
	<cffunction name="staff" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
	
			rc.title="Staff - #getController().getSetting("siteName")#";
			rc.description="Proclaiming His Salvation, Truth, and Triumphant Return through radio, television, books, CDs, DVDs, public seminars, and the World Wide Web.";
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			
			event.setView("about/staff");
		</cfscript>
	</cffunction>
	
	<cffunction name="donate" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
	
			rc.title="Donate Online - #getController().getSetting("siteName")#";
			rc.description="Proclaiming His Salvation, Truth, and Triumphant Return through radio, television, books, CDs, DVDs, public seminars, and the World Wide Web.";
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			
			event.setView("about/donate");
		</cfscript>
	</cffunction>
	
	<cffunction name="gallery" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="Photo Gallery - #getController().getSetting("siteName")#";
			rc.description="#getController().getSetting("siteName")# photo gallery";
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			rc.styles="lightbox.css";
			rc.scripts="";
			
		</cfscript>
		<cfswitch expression="#event.getValue("album","")#">
			<cfcase value="wohlberg">
				<cfset event.setView("about/gallery/wohlberg")>
			</cfcase>
			<cfcase value="booth">
				<cfset event.setView("about/gallery/booth")>
			</cfcase>
			<cfcase value="ultpass">
				<cfset event.setView("about/gallery/ultpass")>
			</cfcase>
			<cfdefaultcase>
				<cfset event.setView("about/gallery/index")>
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="media" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
	
			rc.title="Media Kit - #getController().getSetting("siteName")#";
			rc.description="Proclaiming His Salvation, Truth, and Triumphant Return through radio, television, books, CDs, DVDs, public seminars, and the World Wide Web.";
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			
			event.setView("about/media");
		</cfscript>
	</cffunction>
	
	<cffunction name="news" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			rc.xehDetails = "about/newsdetails";
			rc.title="Breaking News - #getController().getSetting("siteName")#";
			rc.description="Breaking news #getController().getSetting("siteName")#.";
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			
			rc.qannouncements = announcementService.getannouncements(orderby="id",orderasc=0);
		
			event.setView("about/news/index");
		</cfscript>
	</cffunction>
	
	<cffunction name="newsdetails" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			rc.xehList = "about/news";
			rc.announcements = announcementService.getannouncement(id=val(event.getValue("id",0)));
			
			rc.title="#rc.announcements.gettitle()#";
			rc.description="Breaking news from #getController().getSetting("siteName")#.";
			rc.keywords=Event.getValue('title', '#getController().getSetting('keywords')#');
			
			event.setView("about/news/details");
		</cfscript>
	</cffunction>		
	
</cfcomponent>