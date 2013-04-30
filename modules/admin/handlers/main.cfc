<!-----------------------------------------------------------------------
Author 	 :	Aaron Roberson
Date     :	06/15/2010
Description :
	This is a ColdBox event handler where all implicit methods can go.
	Thus its the main handler.

Please note that the extends needs to point to the eventhandler.cfc
in the ColdBox system directory.
extends = coldbox.system.eventhandler

----------------------------------------------------------------------->
<cfcomponent name="main" extends="coldbox.system.eventhandler" output="false">
	<cfproperty name="userService" inject="model">
	<cfproperty name="testimonialService" inject="model">
	<cfproperty name="quoteService" inject="model">
	<cfproperty name="announcementService" inject="model">
	<cfproperty name="pollService" inject="model">
	<cfproperty name="productService" inject="model">
	<cfproperty name="articleService" inject="model">

	<cffunction name="preHandler" access="public" returntype="void" output="false">
    	<cfargument name="event" required="true">
	</cffunction>
	
	<cffunction name="login" access="public" returntype="void" output="false">
		<cfargument name="Event" required="true">
		<cfset var rc = Event.getCollection() />
		<cfset rc.xehLogin = "admin:main.doLogin" />
		<cfset Event.setLayout("login") />
		<cfset Event.setView("login") />
	</cffunction>
	
	<cffunction name="doLogin" access="public" returntype="void" output="false">
		<cfargument name="Event" required="true">
		<cfset var validator = "">
		<!--- handle security --->
		<cfset validator = userService.validateUser(trim(Event.getValue("email","")), trim(Event.getValue("password","")))>
		<cfif validator.results>
			<!--- good logon --->
            <cfset getPlugin("sessionStorage").setVar("user",validator.user)>
			<cfset getPlugin("sessionstorage").setVar("loggedin",true)>
		<cfelse>
			<!--- bad logon --->
			<cfset getPlugin("messagebox").setMessage(validator.messageType,validator.message)>
			<cfset setNextRoute("admin:main/login")>
		</cfif>
		<!-- Set NExt Event --->
		<cfset setNextRoute("admin:main/index")>
	</cffunction>
	
	<cffunction name="doLogout" access="public" returntype="void" output="false">
		<cfargument name="Event" required="true">
		
		<cfset getPlugin("sessionstorage").deleteVar("loggedin")>
		<cfset getPlugin("messagebox").setMessage("info","You have been logged out.")>
		<cfset setNextRoute("admin:main/login")>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="Event" required="true">
		<cfscript>
			var rc = event.getCollection();
			
			// Setup objects and recordsets
			rc.qTestimonials = testimonialService.getTestimonials();
			rc.qQuotes = quoteService.getQuotes();
			rc.newsletters = announcementService.getannouncements();
			rc.qPolls = pollService.getPolls();
			
			Event.setView("index");
		</cfscript>
	</cffunction>
	
	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("watch") AND len(trim(event.getValue("watch")))>
			<cffile action="upload" filefield="watch" destination="#expandpath("/includes/images/")#" nameconflict="overwrite" >
			<cffile action="rename" source="#expandpath("/includes/images/")##cffile.clientfile#" destination="#expandpath("/includes/images/")#watch-now.jpg" nameconflict="overwrite">
		</cfif>
		<cfif event.valueExists("listen") AND len(trim(event.getValue("listen")))>
			<cffile action="upload" filefield="listen" destination="#expandpath("/includes/images/")#" nameconflict="overwrite" >
			<cffile action="rename" source="#expandpath("/includes/images/")##cffile.clientfile#" destination="#expandpath("/includes/images/")#listen-now.jpg" nameconflict="overwrite">
		</cfif>
		<cfif event.valueExists("read") AND len(trim(event.getValue("read")))>
			<cffile action="upload" filefield="read" destination="#expandpath("/includes/images/")#" nameconflict="overwrite" >
			<cffile action="rename" source="#expandpath("/includes/images/")##cffile.clientfile#" destination="#expandpath("/includes/images/")#read-now.jpg" nameconflict="overwrite">
		</cfif>
		
		<cfset getPlugin("messagebox").setMessage("info","File has been successfully saved. Refresh the browser to view changes.")>
		<cfset setNextRoute("admin:main/index")>
			
	</cffunction>
	
</cfcomponent>