<!-----------------------------------------------------------------------
Author 	 :	Aaron Roberson
Date     :	September 25, 2007
Description :
	This is a ColdBox event handler where all implicit methods can go.
	Thus its the main handler.

Please note that the extends needs to point to the eventhandler.cfc
in the ColdBox system directory.
extends = coldbox.system.eventhandler

----------------------------------------------------------------------->
<cfcomponent name="main" extends="coldbox.system.eventhandler" output="false">

	<cfproperty name="productService" inject="model" />

	<!--- This init format is mandatory if you are writing init code else is optional,
	      include the super.init(arguments.controller). --->
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="controller" type="any">
		<cfset super.init(arguments.controller)>
		<!--- Any constructor code here --->
		<cfreturn this>
	</cffunction>
    
    <cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="Event" required="true">
		<cfscript>
			var rc = event.getCollection();
			rc.featuredProducts = productService.getFeaturedProducts();
			//rc.featuredArticles = articleService.getFeaturedArticles();
		</cfscript>
		
		<!--- setup page parameters --->
		<cfset Event.setValue("styles","forms.css,ajax-poller.css,slideshow.css")>
		<cfset Event.setValue("scripts","newsletter.js,jquery.cycle/jquery.cycle.min.js")>
		<!--- Set the View To Display, after Logic --->
		<cfset Event.setView("index")>
	</cffunction>

	<cffunction name="onApplicationStart" access="public" returntype="void" output="false">
		<cfargument name="Event" required="true">
		<!--- ON Application Start Here --->
		<cfset application.visitors = structNew()>
	</cffunction>
	
	<cffunction name="onSessionStart" access="public" returntype="void" output="false">
		<cfset var gCart = createObject("component","model.cart.gCheckoutCart")>
		<cfset getPlugin("sessionstorage").setVar("gCart",gCart)>
		<cfset getPlugin("sessionstorage").setVar("started",now())>
		<!--- track session length and total session count --->
		<cfset application.visitors[session.urltoken] = 1>
	</cffunction>

	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="Event" required="true"> 
		<cfset var sessionScope = event.getValue("sessionReference")>
		<cfset var appScope = event.getValue("applicationReference")>
		<!--- // remove session from session count --->
		<cfset structDelete(arguments.appScope.visitors, arguments.sessionScope.urltoken)>
	</cffunction>

	<cffunction name="onRequestStart" access="public" returntype="void" output="false">
		<cfargument name="Event" required="true">
		<!--- On Request Start Code Here --->
	</cffunction>

	<cffunction name="onRequestEnd" access="public" returntype="void" output="false">
		<cfargument name="Event" required="true">
		<!--- ON Request End Here --->
	</cffunction>

	<cffunction name="onException" returntype="void" output="false">
		<cfargument name="event" required="true">
		<cfscript>
			//Grab Exception From request collection, placed by ColdBox
			var exceptionBean = event.getValue("ExceptionBean");
			//Place exception handler below:

		</cfscript>
	</cffunction>
	
	<cffunction name="onMissingTemplate" returntype="void" output="false">
		<cfargument name="event" required="true">
		<cfscript>
			//Grab missingTemplate From request collection, placed by ColdBox
			var missingTemplate = event.getValue("missingTemplate");
			
		</cfscript>
	</cffunction>

</cfcomponent>