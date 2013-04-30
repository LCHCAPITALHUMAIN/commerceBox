<cfcomponent name="about" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="announcementService" inject="model">

	<cffunction name="init" access="public" returntype="about" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
    
    <cffunction name="preHandler" access="public" returntype="void" output="false">
    	<cfargument name="event" required="true">
        <cfscript>
			var rc = event.getCollection();
			
			rc.xehList = "admin/about/index";
			rc.xehDetail = "admin/about/details";
			rc.xehDelete = "admin/about/delete";
			rc.xehSave = "admin/about/save";
		</cfscript>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="About Management";
			rc.qAnnouncements = announcementService.getAnnouncements();
			
			event.setView("about/index");
		</cfscript>
	</cffunction>
	
	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			
			rc.title="Edit News";
			rc.scripts = "calendar/calendar.js";
			
			rc.announcement = announcementService.getannouncement(id=val(event.getValue("id",0)));
			if(rc.announcement.getID() EQ 0){
				rc.title="Add News";
				rc.announcement.setDate(dateFormat(now(),"YYYY-MM-DD"));
				
			}
			
			event.setView("about/details");
		</cfscript>
	</cffunction>
	
	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			//Get references
			var rc = event.getCollection();
			var announcement = announcementService.getannouncement(id=val(event.getValue("id",0)));
			
			getPlugin("beanFactory").populateBean(announcement);
			
			// save the announcement
			announcementService.saveAnnouncement(announcement);
			// set confirmation message and redirect
			getPlugin("messagebox").setMessage("info","The news has been successfully saved");
			setNextRoute("about/details/#announcement.getID()#");
		</cfscript>
	</cffunction>
		
</cfcomponent>