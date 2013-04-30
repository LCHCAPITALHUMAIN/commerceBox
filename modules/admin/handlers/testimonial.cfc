<cfcomponent name="testimonial" extends="coldbox.system.eventhandler" output="false">

	<cffunction name="init" access="public" returntype="testimonial" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfset beanFactory = getPlugin("ioc") />
		<cfset testimonialService = beanFactory.getBean("testimonialService")>
		
		<cfreturn this>
	</cffunction>
		
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();

		//set The exit handlers
		rc.xehEditor = "admin/testimonial/details";
		rc.xehDelete = "admin/testimonial/delete";
		rc.xehList = "admin/testimonial/list";

		//Get the listing
		rc.qtestimonial = testimonialService.gettestimonials() ;

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
			rc.qtestimonial = getPlugin("queryHelper").sortQuery(rc.qtestimonial,rc.sortBy, rc.sortOrder);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("testimonial/list");
		</cfscript>
	</cffunction>

	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();

		//set the exit handlers
		rc.xehSave = "admin/testimonial/save";
		rc.xehList = "admin/testimonial/list";

		//Get testimonial bean with/without ID.
		rc.testimonial = testimonialService.gettestimonial(event.getValue("id","0"));

		//Set view to render
		event.setView("testimonial/details");
		</cfscript>		
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var testimonial = "";

		//get a new testimonial bean
		testimonial = testimonialService.gettestimonial(event.getValue("id",0));

		//Populate the bean
		getPlugin("beanFactory").populateBean(testimonial);
		
		//Send to service for saving
		testimonialService.savetestimonial(testimonial);
		
		getPlugin("messagebox").setMessage("info","The testimony has been successfully saved.");
		//Set redirect
		setNextRoute("admin:testimonial/details/#testimonial.getID()#");
		</cfscript>		
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
	
		<cfscript>
			//References
			var rc = event.getCollection();
		
			//Remove via the incoming id
			testimonialService.deletetestimonial(rc.id);
		
			//Redirect with message box
			getPlugin("messagebox").setMessage("info","The record was successfully deleted");
			setNextRoute("admin:testimonial/list");
		</cfscript>
	
	</cffunction>
	
</cfcomponent>
