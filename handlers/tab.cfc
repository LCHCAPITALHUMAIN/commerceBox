<cfcomponent name="tab" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="tabService" inject="model" />
	
	<cffunction name="init" access="public" returntype="tab" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>

	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			var rc = event.getCollection();
			
			//Get tab bean with/without ID.
			rc.page = tabService.getTab(alias=urlencodedFormat(event.getValue("alias","")));
			
			rc.title= rc.page.getTitle();
			rc.keywords = rc.page.getKeywords();
			rc.summary = rc.page.getSummary();
		
			event.setView("page");
		</cfscript>
	</cffunction>
	
</cfcomponent>
