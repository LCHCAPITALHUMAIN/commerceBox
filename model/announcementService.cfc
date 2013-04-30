<cfcomponent name="announcementService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.announcementService">
		<cfset super.init(entityName="Announcement")>
		<cfreturn this/>
	</cffunction>

	<cffunction name="createannouncement" access="public" output="false" returntype="any">
			
		<cfreturn new("Announcement") />
	</cffunction>

	<cffunction name="getannouncement" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("announcement",arguments.id) />
	</cffunction>

	<cffunction name="getannouncements" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="summary" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="date" type="string" required="false" />
		<cfargument name="islive" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"summary") and len(arguments.summary)>
			<cfset map.summary = arguments.summary />
		</cfif>
		<cfif structKeyExists(arguments,"content") and len(arguments.content)>
			<cfset map.content = arguments.content />
		</cfif>
		<cfif structKeyExists(arguments,"date") and len(arguments.date)>
			<cfset map.date = arguments.date />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn getTransfer().listByPropertyMap("announcement.announcement",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="saveannouncement" access="public" output="false" returntype="void">
		<cfargument name="announcement" type="any" required="true" />
		
		<cfset save(arguments.announcement) />
	</cffunction>

	<cffunction name="deleteannouncement" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var announcement = get("announcement",arguments.id) />
		<cfset delete(announcement) />
	</cffunction>
</cfcomponent>
