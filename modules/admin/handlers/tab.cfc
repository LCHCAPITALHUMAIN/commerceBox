<cfcomponent name="tab" extends="coldbox.system.eventhandler" output="false">
	
	<cffunction name="init" access="public" returntype="tab" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		
		<cfreturn this>
	</cffunction>

	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();
		var oService = getModel("tabService");
		
		//set The exit handlers
		rc.xehEditor = "tab/edit";
		rc.xehDelete = "tab/delete";
		
		//Get the listing
		rc.qtab = oService.gettabs() ;
		
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
			rc.qtab = getPlugin("queryHelper").sortQuery(rc.qtab,rc.sortBy, rc.sortOrder);
		}
		else{
			rc.sortBy = "";
		}
		
		//Set the view to render
		event.setView("tab/list");
		</cfscript>
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var service = getModel("tabService");
		
		//set the exit handlers
		rc.xehSave = "tab/save";
		rc.xehList = "tab/list";
		
		//Get tab bean with/without ID.
		rc.tab = service.gettab(event.getValue("id","0"));
		
		//Set view to render
		event.setView("tab/edit");
		</cfscript>		
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var oService = getModel("tabService");
		var otabBean = "";
		
		//get a new tab bean
		otabBean = oService.gettab(0);
		
		//Populate the bean
		getPlugin("beanFactory").populateBean(otabBean);
				
		// setup the alias by making it equal to the title but replace spaces with underscores
		otabBean.setAlias(replace(otabBean.getTitle()," ","_","all"));
		
		//Send to service for saving
		oService.savetab(otabBean);
		
		// create status response
		getPlugin("messagebox").setMessage("info","Your tab has been saved.");
		
		//Set redirect
		setNextRoute("tab/edit/#otabBean.getID()#");
		</cfscript>		
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var oService = getModel("tabService");
		
		//Remove via the incoming id
		oService.deletetab(rc.id);
		
		//Redirect with message box
		getPlugin("messagebox").setMessage("info","The record was sucessfully deleted");
		setNextRoute("tab/edit");
		</cfscript>		
	</cffunction>
	
</cfcomponent>
