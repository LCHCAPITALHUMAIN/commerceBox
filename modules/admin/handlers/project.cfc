<cfcomponent name="project" extends="coldbox.system.eventhandler" output="false">

	<cffunction name="init" access="public" returntype="project" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfset beanFactory = getPlugin("ioc") />
		<cfset projectService = beanFactory.getBean("projectService")>
		
		<cfreturn this>
	</cffunction>
		
	<cffunction name="dspList" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();

		//set The exit handlers
		rc.xehEditor = "project/dspEditor";
		rc.xehDelete = "project/doDelete";

		//Get the listing
		rc.qproject = projectService.getprojects() ;

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
			rc.qproject = getPlugin("queryHelper").sortQuery(rc.qproject,rc.sortBy, rc.sortOrder);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("projectList");
		</cfscript>
	</cffunction>

	<cffunction name="dspEditor" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();

		//set the exit handlers
		rc.xehSave = "project/doSave";
		rc.xehList = "project/dspList";

		//Get project bean with/without ID.
		rc.project = projectService.getproject(event.getValue("id","0"));

		//Set view to render
		event.setView("projectEditor");
		</cfscript>		
	</cffunction>

	<cffunction name="doSave" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var project = "";

		//get a new project bean
		project = projectService.getproject(0);

		//Populate the bean
		getPlugin("beanFactory").populateBean(project);
		
		//Send to service for saving
		projectService.saveproject(project);

		//Set redirect
		setNextEvent("project.dspList");
		</cfscript>		
	</cffunction>

	<cffunction name="doDelete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
	
		<cfscript>
			//References
			var rc = event.getCollection();
		
			//Remove via the incoming id
			projectService.deleteproject(rc.id);
		
			//Redirect with message box
			getPlugin("messagebox").setMessage("info","The record was successfully deleted");
			setNextEvent("project.dspList");
		</cfscript>
	
	</cffunction>
	
</cfcomponent>
