<!-----------------------------------------------------------------------
Template : baseService.cfc
Author 	 : Aaron Roberson
Date     : 6/5/2010
Description :
	This is a base service that will be extended by every service
	that needs transfer connectivity

Modification History:
6/5/2010 - Created Template
---------------------------------------------------------------------->
<cfcomponent name="BaseService" hint="A base transfer service object" output="false">

	<cfproperty name="transfer" 	scope="instance" inject="cachebox:Transfer">
	<cfproperty name="transaction" 	scope="instance" inject="cachebox:TransferTransaction">
<!----------------------------------- CONSTRUCTOR ------------------------------>
	
	<cfscript>
		variables.instance = structnew();
	</cfscript>

	<cffunction name="init" hint="Constructor" access="public" returntype="any" output="false">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	<!--- onDIComplete --->
    <cffunction name="onDIComplete" output="false" access="public" returntype="void" hint="Processed after DI">
    	
    	<cfscript>
			// Transaction the create + save + deletes 
			instance.transaction.advise(this, "^create");
			instance.transaction.advise(this, "^save");
			instance.transaction.advise(this, "^cascade");
			instance.transaction.advise(this, "^delete");
		</cfscript>
    </cffunction>

	
<!----------------------------------- PUBLIC ------------------------------>

	<cffunction name="new" hint="create a generic TO" access="public" output="false" returntype="any">
		<!--- ************************************************************* --->
		<cfargument name="class" 		type="string" 		required="true"/>
		<!--- ************************************************************* --->
		<cfreturn new(arguments.genericTO)>
	</cffunction>
	
	<cffunction name="get" hint="get a generic TO" access="public" output="false" returntype="any">
		<!--- ************************************************************* --->
		<cfargument name="class" 		type="string" 		required="true"/>
		<cfargument name="key" 			type="any" 			required="true"/>
		<!--- ************************************************************* --->
		<cfreturn get(arguments.class,arguments.key)>
	</cffunction>
	
	<cffunction name="readByProperty" hint="returns a query of all records" access="public" output="false" returntype="any">
		<!--- ************************************************************* --->
		<cfargument name="class" 		type="string"		required="true"/>
		<cfargument name="property" 	type="string" 		required="true"/>
		<cfargument name="value" 		type="any" 		required="true"/>
		<!--- ************************************************************* --->
		<cfreturn readByProperty(arguments.class,arguments.property,arguments.value)>
	</cffunction>
	
	<cffunction name="readByPropertyMap" hint="returns a query filtered by multiple columns" access="public" output="false" returntype="any">
		<!--- ************************************************************* --->
		<cfargument name="class" 		type="string"		required="true"/>
		<cfargument name="map" 			type="struct"		required="true"/>
		<!--- ************************************************************* --->
		<cfreturn readByPropertyMap(arguments.class,arguments.map)>
	</cffunction>
	
	<cffunction name="list" hint="returns a query of all records" access="public" output="false" returntype="any">
		<!--- ************************************************************* --->
		<cfargument name="class" 		type="string"		required="true"/>
		<cfargument name="orderby" 		type="string" 		default=""/>
		<cfargument name="orderasc" 	type="boolean" 		default="false"/>
		<!--- ************************************************************* --->
		<cfreturn list(arguments.class,arguments.orderby,arguments.orderasc)>
	</cffunction>
	
	<cffunction name="listByProperty" hint="returns a query of all records" access="public" output="false" returntype="query">
		<!--- ************************************************************* --->
		<cfargument name="class" 		type="string"		required="true"/>
		<cfargument name="property" 	type="string" 		required="true"/>
		<cfargument name="value" 		type="string" 		required="true"/>
		<cfargument name="orderby" 		type="string" 		default=""/>
		<cfargument name="orderasc" 	type="boolean" 		default="false"/>
		<!--- ************************************************************* --->
		<cfreturn listByProperty(arguments.class,arguments.property,arguments.value,arguments.orderby,arguments.orderasc)>
	</cffunction>
	
	<cffunction name="listByPropertyMap" hint="returns a query filtered by multiple columns" access="public" output="false" returntype="query">
		<!--- ************************************************************* --->
		<cfargument name="class" 		type="string"		required="true"/>
		<cfargument name="map" 			type="struct"		required="true"/>
		<cfargument name="orderby" 		type="string" 		default=""/>
		<cfargument name="orderasc" 	type="boolean" 		default="false"/>
		<!--- ************************************************************* --->
		<cfreturn listByPropertyMap(arguments.class,arguments.map,arguments.orderby,arguments.orderasc)>
	</cffunction>
	
	<cffunction name="listByJoin" access="public" returntype="query" output="false" hint="Get a Lookup's joint query listing.">
		<!--- ************************************************************* --->
		<cfargument name="fromClass" 	type="string" 		required="true" >
		<cfargument name="toClass"  	type="string" 		required="true" >
		<cfargument name="property"  	type="string" 		required="true" >
		<cfargument name="value"  		type="any" 			required="true" >
		<!--- ************************************************************* --->
		<cfscript>
			var query = createQuery("FROM #arguments.fromClass# 
													JOIN #arguments.toClass# 
													WHERE #arguments.toClass#.#arguments.property# = :pk");
			query.setParam("pk",arguments.value);
			return listByQuery(query);
		</cfscript>
	</cffunction>
	
	<cffunction name="create" hint="creates a generic TO" access="public" output="false" returntype="any">
		<!--- ************************************************************* --->
		<cfargument name="genericTO" 	type="any" 		required="true"/>
		<!--- ************************************************************* --->
		<cfreturn create(arguments.genericTO)>
	</cffunction>
	
	<cffunction name="save" hint="Save a generic TO" access="public" output="false" returntype="void">
		<!--- ************************************************************* --->
		<cfargument name="genericTO" 	type="any" 		required="true"/>
		<!--- ************************************************************* --->
		<cfset save(arguments.genericTO)>
	</cffunction>
	
	<cffunction name="cascadeSave" hint="Save a generic TO and all of its children" access="public" output="false" returntype="void">
		<!--- ************************************************************* --->
		<cfargument name="genericTO" 	type="any" 		required="true"/>
		<cfargument name="depth" type="numeric" default="0" hint="the number of levels in which to cascade, 0 is unlimited">
		<!--- ************************************************************* --->
		<cfset cascadeSave(arguments.genericTO,arguments.depth)>
	</cffunction>
	
	<cffunction name="delete" hint="delete a generic TO" access="public" output="false" returntype="void">
		<!--- ************************************************************* --->
		<cfargument name="genericTO" 	type="any" 		required="true"/>
		<!--- ************************************************************* --->
		<cfset delete(arguments.genericTO)>
	</cffunction>
	
	<cffunction name="cascadeDelete" hint="Delete a generic TO and all of its children" access="public" output="false" returntype="void">
		<!--- ************************************************************* --->
		<cfargument name="genericTO" 	type="any" 		required="true"/>
		<cfargument name="depth" hint="the number of levels in which to cascade, 0 is unlimited" type="numeric" required="No" default="0">
		<!--- ************************************************************* --->
		<cfset cascadeDelete(arguments.genericTO,arguments.depth)>
	</cffunction>



<!----------------------------------- PRIVATE ------------------------------>

	<!--- Get/set Transfer --->
	<cffunction name="getTransfer" access="private" returntype="any" output="false">
		<cfreturn instance.Transfer>
	</cffunction>
    
</cfcomponent>