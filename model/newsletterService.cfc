<cfcomponent name="newsletterService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.newsletterService">
		<cfset super.init(entityName="Newsletter") />
		<cfreturn this/>
	</cffunction>

	<cffunction name="createsubscriber" access="public" output="false" returntype="any">
			
		<cfreturn new("NewsletterSubscriber") />
	</cffunction>

	<cffunction name="getsubscriber" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("NewsletterSubscriber",arguments.id) />
	</cffunction>

	<cffunction name="getsubscribers" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="email" type="String" required="false" />
		<cfargument name="date" type="string" required="false" />
		<cfargument name="islive" type="Boolean" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"email") and len(arguments.email)>
			<cfset map.email = arguments.email />
		</cfif>
		<cfif structKeyExists(arguments,"date") and len(arguments.date)>
			<cfset map.date = arguments.date />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn getTransfer().listByPropertyMap("newsletter.subscriber",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savesubscriber" access="public" output="false" returntype="void">
		<cfargument name="subscriber" type="any" required="true" />
		
		<cfset save(arguments.subscriber) />
	</cffunction>

	<cffunction name="deletesubscriber" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var subscriber = get("NewsletterSubscriber",arguments.id) />
		<cfset delete(subscriber) />
	</cffunction>
</cfcomponent>
