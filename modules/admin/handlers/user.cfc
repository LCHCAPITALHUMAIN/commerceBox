<cfcomponent name="user" extends="coldbox.system.eventhandler" output="false">

	<cffunction name="init" access="public" returntype="user" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfset beanFactory = getPlugin("ioc") />
		<cfset userService = beanFactory.getBean("userService")>
		
		<cfreturn this>
	</cffunction>
		
	<cffunction name="dspList" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();

		//set The exit handlers
		rc.xehEditor = "user/dspEditor";
		rc.xehDelete = "user/doDelete";

		//Get the listing
		rc.quser = userService.getusers() ;

		//Sorting Logic.
		if ( event.getValue("sortOrder","") neq ""){
			if (rc.sortOrder eq "asc")
				rc.sortOrder = "desc";
			else
				rc.sortOrder = "asc";
		}
		else{
			rc.sortOrder = "asc";
		}
		if ( event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			rc.quser = getPlugin("queryHelper").sortQuery(rc.quser,rc.sortBy, rc.sortOrder);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("userList");
		</cfscript>
	</cffunction>

	<cffunction name="dspEditor" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();

		//set the exit handlers
		rc.xehSave = "user/doSave";
		rc.xehList = "user/dspList";

		//Get user bean with/without ID.
		rc.user = userService.getuser(event.getValue("id","0"));

		//Set view to render
		event.setView("userEditor");
		</cfscript>		
	</cffunction>

	<cffunction name="doSave" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var user = "";

		//get a new user bean
		user = userService.getuser(0);

		//Populate the bean
		getPlugin("beanFactory").populateBean(user);
		
		//Send to service for saving
		userService.saveuser(user);

		//Set redirect
		setNextEvent("user.dspList");
		</cfscript>		
	</cffunction>

	<cffunction name="doDelete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
	
		<cfscript>
			//References
			var rc = event.getCollection();
		
			//Remove via the incoming id
			userService.deleteuser(rc.id);
		
			//Redirect with message box
			getPlugin("messagebox").setMessage("info","The record was successfully deleted");
			setNextEvent("user.dspList");
		</cfscript>
	
	</cffunction>
	
</cfcomponent>
