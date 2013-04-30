<!-----------------------------------------------------------------------
Author     :	Aaron Roberson
Date        :	12-May-2010 1:39:12 PM
Description :	Provides security for anything in the securelist

----------------------------------------------------------------------->
<cfcomponent name="SecurityService" output="false" hint="My application security service">

	<!--- Dependencies --->
	<cfproperty name="sessionStorage" inject="coldbox:plugin:sessionStorage" scope="variables" />
    <cfproperty name="userService" inject="model" scope="instance" />

<!------------------------------------------- CONSTRUCTOR ------------------------------------------>

	<cfscript>
		instance = structnew();
	</cfscript>

	<cffunction name="init" access="public" output="false" returntype="SecurityService" hint="Initialize the SecurityService object">
		<cfscript>
            return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------>
	<!--- userValidator --->
	<cffunction name="userValidator" access="public" returntype="Boolean" output="false" >
		<cfargument name="rule" 	  required="true" type="struct" hint="rule" />
		<cfargument name="messagebox" required="true" type="any"    hint="ColdBox Messagebox"/>
		<cfargument name="controller" type="any" required="true" hint="The coldbox controller" />

		<cfscript>
			var result = false;
			if (variables.sessionstorage.exists("user")){
				var user = sessionStorage.getVar("user");
				if (variables.sessionstorage.getVar("loggedin", false) OR listFind(arguments.rule['roles'], user.getRole())){
					// good logon --->
					variables.sessionstorage.setVar("loggedin",true);
					result = true;
				}else{
					//--- bad logon --->
					arguments.messagebox.setMessage(validator.messageType,validator.message);
				}
			}
			// Return result boolean --->
			return result;
		</cfscript>
	</cffunction>

<!------------------------------------------- PRIVATE ------------------------------------------>

	<cffunction name="dump" access="private" returntype="void" output="false">
		<cfargument name="v" type="any" required="true">
		<cfdump var="#v#">
	</cffunction>

	<cffunction name="abort" access="private" returntype="void" output="false">
		<cfabort>
	</cffunction>

	<cffunction name="isAjaxRequest" output="false" returntype="boolean" access="public">
    	<cfset var headers = getHttpRequestData().headers />
   		<cfreturn structKeyExists(headers, "X-Requested-With") and (headers["X-Requested-With"] eq "XMLHttpRequest") />
	</cffunction>
    
</cfcomponent>