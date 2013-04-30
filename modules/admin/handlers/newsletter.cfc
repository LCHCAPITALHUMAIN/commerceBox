<cfcomponent name="newsletter" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="newsletterService" inject="model">

	<cffunction name="init" access="public" returntype="newsletter" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();
		var oService = getModel("newsletterService");
		
		//set The exit handlers
		rc.xehEditor = "newsletter/details";
		rc.xehDelete = "newsletter/delete";
		rc.xehList = "#getSetting('sesBaseURL')#/newsletter/list";
		
		//Get the listing
		rc.qnewsletter = oService.getSubscribers() ;
		
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
			rc.qnewsletter = getPlugin("queryHelper").sortQuery(rc.qnewsletter,rc.sortBy, rc.sortOrder);
		}
		else{
			rc.sortBy = "";
		}
		
		//Set the view to render
		event.setView("newsletter/list");
		</cfscript>
	</cffunction>

	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var oService = getModel("newsletterService");
		
		//set the exit handlers
		rc.xehSave = "newsletter/save";
		rc.xehList = "newsletter/list";
		
		//Get newsletter bean with/without ID.
		rc.newsletter = oService.getSubscriber(event.getValue("id","0"));
		
		//Set view to render
		event.setView("newsletter/details");
		</cfscript>		
	</cffunction>
	
	<cffunction name="doSignUp" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var message = "">
		<cfset var address = "">
		<cfset var subscribed ="">
		<cfset var subscriber = "">
		
		<cfscript>
			if(NOT Event.valueExists("email")){
				message = "Please enter email";
			}
			else{
				address = trim(Event.getValue("email"));
				//validate address
				if(NOT isEmail(address)){
					message="Email invalid. Try again";
				}
				else{
					subscribed = newsletterService.getSubscribers(email=address);
					if(NOT subscribed.recordCount OR NOT subscribed.islive){
						subscriber = newsletterService.createSubscriber();
						subscriber.setEmail(address);
						subscriber.setDate(dateFormat(now(), "yyyy-mm-dd"));
						subscriber.setIsLive(1);
						newsletterService.saveSubscriber(subscriber);
						message = "You have been subscribed";
					}
					else{
						message = "Thanks for your support";
					}
				}
			}
			Event.setValue("data",message);
			Event.setView("ajaxProxy",true);
		</cfscript>
	</cffunction>
	
	<cffunction name="isEmail" access="private" returntype="boolean" output="false">
		<cfargument name="str" type="string" required="true">
		
		<cfreturn (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name|jobs|travel))$",
		   arguments.str) AND len(listGetAt(arguments.str, 1, "@")) LTE 64 AND
		   len(listGetAt(arguments.str, 2, "@")) LTE 255) IS 1>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var subscriber = "";

		//get a new Subscriber bean
		subscriber = newsletterService.getSubscriber(event.getValue("id",0));

		//Populate the bean
		getPlugin("beanFactory").populateBean(subscriber);
		
		//Send to service for saving
		newsletterService.saveSubscriber(subscriber);

		getPlugin("messagebox").setMessage("info","You have sucessfully saved the subscription.");
		//Set redirect
		setNextRoute("newsletter/details/#subscriber.getID()#");
		</cfscript>		
	</cffunction>
	
	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var oService = getModel("newsletterService");
		
		//Remove via the incoming id
		oService.deleteSubscriber(rc.id);
		
		//Redirect with message box
		getPlugin("messagebox").setMessage("info","The subscriber was sucessfully deleted");
		setNextRoute("newsletter/list");
		</cfscript>		
	</cffunction>
	
</cfcomponent>
