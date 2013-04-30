<cfcomponent name="page" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="tabService" inject="model" />
	
	<cffunction name="init" access="public" returntype="page" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
    
     <cffunction name="preHandler" access="public" returntype="void" output="false">
    	<cfargument name="event" required="true">
        <cfscript>
			var rc = event.getCollection();
			rc.xehSave = "admin/page/save";
			rc.xehDelete = "admin/page/delete";
		</cfscript>
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		
		rc.qtabs = tabService.getTabs();
		
		//Get page bean with/without ID.
		rc.page = tabService.getpage(event.getValue("id","0"));
		
		//Set view to render
		event.setView("page/edit");
		</cfscript>		
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var page = "";
		var tab = "";
		var alias = "";
		
		//get a new page bean
		page = tabService.getpage(event.getValue("id",0));
		tab = tabService.getTab(event.getValue("tab_id"));
		
		
		//Populate the bean
		getPlugin("beanFactory").populateBean(page);
		
		page.setParentTab(tab);
		
		page.setAlias(replace(page.getTitle()," ","_","all"));
				
		//Send to service for saving
		tabService.savepage(page);
		
		getPlugin("messagebox").setMessage("info","Your page has been saved.");
		
		//Set redirect
		setNextRoute("page/edit/#page.getID()#");
		</cfscript>		
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		
		//Remove via the incoming id
		tabService.deletepage(rc.id);
		
		//Redirect with message box
		getPlugin("messagebox").setMessage("info","The record was sucessfully deleted");
		setNextRoute("page/edit/");
		</cfscript>		
	</cffunction>
	
</cfcomponent>
