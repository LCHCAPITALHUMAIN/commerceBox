<cfcomponent name="ModuleSecurity"
                         hint="Module Security Interceptor"
                         output="false">
        
        <cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method" output="false" >
                <!--- I set up myself --->
                <cfset setProperty('ConfigurationTime', now() )>
        </cffunction>
		

	<!--- Pre execution process --->
	<cffunction name="preProcess" access="public" returntype="void" hint="Executes before any event execution occurs" output="false"  eventPattern="^admin">
		<!--- ************************************************************* --->
		<cfargument name="event" required="true" type="any" hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<!--- ************************************************************* --->
		<cfscript>
			var rc = Event.getCollection();
		
			var loggingIn = FALSE;
			var session = getPlugin("sessionstorage");
		
			if(event.getCurrentEvent() EQ "admin:main.doLogin"){
				loggingIn = TRUE;
			}
		
			if( (NOT session.getVar("loggedin",FALSE)) AND NOT loggingIn){
				
				event.overrideEvent("admin:main.login");
				
				if(getPlugin("messagebox").isEmpty()){
					getPlugin("messagebox").setMessage("info", "Please log in first");
				}
			}
		
			// Logout Code
			if(Event.valueExists("logout")){
				event.overrideEvent("admin:main.doLogout");
			}
			
		</cfscript>
	</cffunction>

</cfcomponent>
