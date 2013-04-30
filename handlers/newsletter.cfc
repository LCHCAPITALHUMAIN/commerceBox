<cfcomponent name="newsletter" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="newsletterService" inject="model">

	<cffunction name="init" access="public" returntype="newsletter" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="doSignUp" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
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

	<cffunction name="doSave" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var Subscriber = "";

		//get a new Subscriber bean
		Subscriber = NewsletterService.getSubscriber(0);

		//Populate the bean
		getPlugin("beanFactory").populateBean(Subscriber);
		
		//Send to service for saving
		NewsletterService.saveSubscriber(Subscriber);

		//Set redirect
		setNextEvent("Subscriber.dspList");
		</cfscript>		
	</cffunction>
	
</cfcomponent>
