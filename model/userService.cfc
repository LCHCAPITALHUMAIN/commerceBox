<cfcomponent name="userService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.userService">
		<cfset super.init(entityName="User") />
		<cfreturn this/>
	</cffunction>

	<cffunction name="createuser" access="public" output="false" returntype="any">
			
		<cfreturn new("User") />
	</cffunction>

	<cffunction name="getuser" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("User",arguments.id) />
	</cffunction>

	<cffunction name="getusers" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="firstname" type="String" required="false" />
		<cfargument name="lastname" type="String" required="false" />
		<cfargument name="email" type="String" required="false" />
		<cfargument name="password" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"firstname") and len(arguments.firstname)>
			<cfset map.firstname = arguments.firstname />
		</cfif>
		<cfif structKeyExists(arguments,"lastname") and len(arguments.lastname)>
			<cfset map.lastname = arguments.lastname />
		</cfif>
		<cfif structKeyExists(arguments,"email") and len(arguments.email)>
			<cfset map.email = arguments.email />
		</cfif>
		<cfif structKeyExists(arguments,"password") and len(arguments.password)>
			<cfset map.password = arguments.password />
		</cfif>
		
		<cfreturn entityLoad("user.user",map,arguments.orderby,arguments.orderasc) />
	</cffunction>
	
	<cffunction name="validateUser" access="public" returntype="struct" output="false">
		<cfargument name="email" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<cfset var stReturn = structnew()>
		<cfset stReturn.results = false />
		<cfset stReturn.message = "User Not Validated." />
		<cfset stReturn.messageType = "error" />
		
		<cfif not len(arguments.email) or not len(arguments.password)>
			<cfset stReturn.message = "No email or password defined." />
		<cfelse>
			<cfset arguments.password = hash(arguments.password) />
			<cfset stReturn.user = getTransfer().readByPropertyMap('user.user',arguments) />
			
			<cfif stReturn.user.getIsLoaded()>
				<cfset stReturn.results = true />
				<cfset stReturn.message = "Valid User" />
				<cfset stReturn.messageType = "info" />
			<cfelse>
				<cfset stReturn.message = "Invalid User Information." />
			</cfif>
		</cfif>
		
		<cfreturn stReturn />
	</cffunction>

	<cffunction name="saveuser" access="public" output="false" returntype="void">
		<cfargument name="user" type="any" required="true" />
		
		<cfset save(arguments.user) />
	</cffunction>

	<cffunction name="deleteuser" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var user = get("User",arguments.id) />
		<cfset delete(user) />
	</cffunction>
</cfcomponent>
