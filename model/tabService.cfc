<cfcomponent name="tabService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.tabService">
		<cfset super.init(entityName="Tab") />
		<cfreturn this/>
	</cffunction>

	<cffunction name="createtab" access="public" output="false" returntype="any">
			
		<cfreturn new("Tab") />
	</cffunction>

	<cffunction name="gettab" access="public" output="false" returntype="any">
    	<cfargument name="id" type="numeric" required="false" />
		<cfargument name="alias" type="string" required="false" />
        
        <cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
        <cfif structKeyExists(arguments,"alias") and len(arguments.alias)>
			<cfset map.alias = arguments.alias />
		</cfif>

		<cfreturn entityLoad("Tab",map) />
	</cffunction>

	<cffunction name="gettabs" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
        <cfargument name="alias" type="String" required="false" />
		<cfargument name="title" type="String" required="false" />
        <cfargument name="keywords" type="String" required="false" />
		<cfargument name="summary" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="islive" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
        <cfif structKeyExists(arguments,"alias") and len(arguments.alias)>
			<cfset map.alias = arguments.alias />
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
		<cfif structKeyExists(arguments,"keywords") and len(arguments.keywords)>
			<cfset map.keywords = arguments.keywords />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn entityLoad("Tab",map) />
	</cffunction>

	<cffunction name="savetab" access="public" output="false" returntype="void">
		<cfargument name="tab" type="any" required="true" />
		
		<cfset save(arguments.tab) />
	</cffunction>

	<cffunction name="deletetab" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var tab = get("Tab",arguments.id) />
		<cfset delete(tab) />
	</cffunction>
    
    <!--- PAGE METHODS --->
    <cffunction name="createPage" access="public" output="false" returntype="any">
			
		<cfreturn new("Page") />
	</cffunction>

	<cffunction name="getPage" access="public" output="false" returntype="any">
		<cfargument name="id" type="numeric" required="false" />
		<cfargument name="alias" type="string" required="false" />
        
        <cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
        <cfif structKeyExists(arguments,"alias") and len(arguments.alias)>
			<cfset map.alias = arguments.alias />
		</cfif>

		<cfreturn getTransfer().readByPropertyMap("tab.page",map) />
	</cffunction>

	<cffunction name="getPages" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
        <cfargument name="alias" type="String" required="false" />
		<cfargument name="title" type="String" required="false" />
        <cfargument name="keywords" type="String" required="false" />
		<cfargument name="summary" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="islive" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
        <cfif structKeyExists(arguments,"alias") and len(arguments.alias)>
			<cfset map.alias = arguments.alias />
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
		<cfif structKeyExists(arguments,"keywords") and len(arguments.keywords)>
			<cfset map.keywords = arguments.keywords />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn entityLoad("tab.page",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savePage" access="public" output="false" returntype="void">
		<cfargument name="page" type="any" required="true" />
		
		<cfset save(arguments.page) />
	</cffunction>

	<cffunction name="deletePage" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var page = get("Page",arguments.id) />
		<cfset delete(page) />
	</cffunction>
</cfcomponent>
