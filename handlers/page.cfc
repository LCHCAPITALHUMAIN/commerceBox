<cfcomponent name="page" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="tabService" inject="model" />
	
	<cffunction name="init" access="public" returntype="page" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="home" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			var rc = event.getCollection();
			
			rc.page = tabService.getPage(alias=event.getValue("alias","Home"));
			//--- setup page parameters ---//
			Event.setValue("styles","forms.css,ajax-poller.css");
			Event.setValue("scripts","sack.js,scriptaculous.js?load=effects,poll.js,newsletter.js,jquery.js,jquery.cycle/jquery.cycle.all.min.js");
			//--- Set the View To Display, after Logic ---//
			Event.setView("index");
		</cfscript>
	</cffunction>
	
	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			var rc = event.getCollection();
			
			//Get tab bean with/without ID.
			rc.page = tabService.getpage(id=event.getValue("id",""));
			
			rc.title= rc.page.getTitle();
			rc.keywords = rc.page.getKeywords();
			rc.summary = rc.page.getSummary();
		
			event.setView("page");
		</cfscript>
	</cffunction>
	
	<cffunction name="prayer" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			var rc = event.getCollection();
			rc.xehSend = "page/sendPrayer";
			
			rc.title= "Prayer Requests";
			rc.keywords = "prayer, intercession";
			rc.summary = "Send in your prayer requests to have the staff at Northeast Assembly pray for your needs.";
			
			event.setView("prayer");
		</cfscript>
	</cffunction>
	
	<cffunction name="sendPrayer" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		
		<cfset var rc = event.getCollection()>
		<cfset rc.xehSend = "page/sendPrayer">
			
		<cfmail to="#getSetting("OwnerEmail")#" from="#event.getValue("email",getSetting("OwnerEmail"))#" subject="Prayer Request" type="text">
#event.getValue("fname","")# #event.getValue("lname","")#
#event.getValue("email","")#
#event.getValue("message","")#
		</cfmail>
			
		<cfset getPlugin("messagebox").setMessage("info","Your prayer request has been sent. We will be praying for you!")>
		<cfset event.setView("prayer")>
	</cffunction>
	
</cfcomponent>