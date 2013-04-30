<!-----------------------------------------------------------------------
Template : baseDecorator.cfc
Author 	 : Aaron Roberson
Date     : 6/15/2010
Description :
	THis is our base transfer decorator object.  Please update the extends attribute
	according to the version of Transfer you are using.

Modification History:
6/15/2010 - Created Template
---------------------------------------------------------------------->

<cfcomponent name="BaseDecorator" 
			 hint="This is the baseDecorator component" 
			 output="false" 
			 extends="transfer.com.TransferDecorator">
	
	<!--- Scaffolding Table Config --->
	<cffunction name="gettableConfig" access="public" returntype="struct" output="false" hint="Get the table config for scaffolding">
		<cfreturn instance.tableConfig>
	</cffunction>
	<cffunction name="settableConfig" access="public" returntype="void" output="false" hint="Set the table config for scaffolding">
		<cfargument name="tableConfig" type="struct" required="true">
		<cfset instance.tableConfig = arguments.tableConfig>
	</cffunction>
	
	<!--- Get PK Column --->
	<cffunction name="__getPKColumn" access="public" output="false" returntype="any" hint="Returns the name of the PK column">

	    <cfreturn getTransfer()
	                .getTransferMetaData(getClassName())
	                .getPrimaryKey()
	                .getColumn() />
	
	</cffunction>
	
	<!--- Get PK Column --->
	<cffunction name="__getPKAlias" access="public" output="false" returntype="any" hint="Returns the alias of the PK column">

	    <cfreturn getTransfer()
	                .getTransferMetaData(getClassName())  
	                .getPrimaryKey()
	                .getName() />
	
	</cffunction>
	
	<!--- Get PK Value --->
	<cffunction name="__getPKValue" access="public" output="false" returntype="any" hint="Returns the value of the PK column">
	    <cfset var pkMethod = this["get#__getPKAlias()#"] />
	    <cfreturn pkMethod() />
	</cffunction>
	
	<!--- Save Yourself --->
	<cffunction name="save" access="public" output="false" returntype="void" hint="Calls getTransfer().save().">
        <cfset getTransfer().save(this) />
    </cffunction>
	
	<!--- Delete Yourself --->
    <cffunction name="delete" access="public" output="false" returntype="void" hint="Calls delete().">
        <cfset delete(this) />
    </cffunction>

<!------------------------------------------- Configuration  ------------------------------------------>

	<cffunction name="configure" access="private" returntype="void" hint="I am like init() but for decorators">
    	<cfscript>
			setTableConfig( structnew() );
		</cfscript>
	</cffunction>
	
	
</cfcomponent>