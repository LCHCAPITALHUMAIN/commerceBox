	<!--- Event Context Methods --->
	<cfset event= getController().getRequestService().getContext()>
	
	<cffunction name="setNextSESEvent" access="Public" returntype="void" hint="I Set the next event to run and relocate the browser to that event."  output="false">
		<cfargument name="event"  			hint="The name of the event to run." 			type="string" required="No" default="#getSetting("DefaultEvent")#" >
		<cfargument name="queryString"  	hint="The query string to append, if needed."   type="string" required="No" default="" >
		<cfargument name="addToken"			hint="Wether to add the tokens or not. Default is false" type="boolean" required="false" default="false"	>
		<!--- ************************************************************* --->
		<cfset var EventName = getSetting("EventName")>
		
		<!--- Cleanup Event --->
		<cfif len(trim(arguments.event)) eq 0>
			<cfset arguments.event = getSetting("DefaultEvent")>
		</cfif>
		
		<!--- Check if query String needs appending --->
		<cfif len(trim(arguments.queryString)) eq 0>
			<cflocation url="/#arguments.event#" addtoken="#arguments.addToken#">
		<cfelse>
			<cflocation url="/#arguments.event#/#arguments.queryString#" addtoken="#arguments.addToken#">
		</cfif>
	</cffunction>
	
	<cffunction name="getCurrentSESEvent" access="public" hint="Gets the current set handler" returntype="string" output="false">
		<cfreturn replace(event.getCurrentEvent(), ".", "/") />
	</cffunction>
	
<cffunction name="addToCart" output="false" access="public" returntype="any">
	<cfargument name="model" required="true">
	<cfargument name="title" required="true">
    <cfargument name="description" required="true">
    <cfargument name="price" required="true">
    <cfargument name="quantity" required="true">
	<cfreturn session.googleCart.addCartItem(argumentCollection=arguments) />
</cffunction>