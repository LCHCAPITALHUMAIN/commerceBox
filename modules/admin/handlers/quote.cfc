<cfcomponent name="quote" extends="coldbox.system.eventhandler" output="false">

	<cffunction name="init" access="public" returntype="quote" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfset beanFactory = getPlugin("ioc") />
		<cfset quoteService = beanFactory.getBean("quoteService")>
		
		<cfreturn this>
	</cffunction>
		
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();

		//set The exit handlers
		rc.xehEditor = "quote/details";
		rc.xehDelete = "quote/delete";
		rc.xehList = "quote/list";

		//Get the listing
		rc.qquote = quoteService.getquotes() ;

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
			rc.qquote = getPlugin("queryHelper").sortQuery(rc.qquote,rc.sortBy, rc.sortOrder);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("quote/list");
		</cfscript>
	</cffunction>

	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();

		//set the exit handlers
		rc.xehSave = "quote/save";
		rc.xehList = "quote/list";

		//Get quote bean with/without ID.
		rc.quote = quoteService.getquote(event.getValue("id","0"));

		//Set view to render
		event.setView("quote/details");
		</cfscript>		
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var quote = "";

		//get a new quote bean
		quote = quoteService.getquote(event.getValue("id",0));

		//Populate the bean
		quote.setAuthor(event.getValue("author",""));
		quote.setContent(event.getValue("content",""));
		
		//Send to service for saving
		quoteService.savequote(quote);
		
		getPlugin("messagebox").setMessage("info","Your quote has been sucessfully saved.");
		//Set redirect
		setNextRoute("quote/details/#quote.getID()#");
		</cfscript>		
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
	
		<cfscript>
			//References
			var rc = event.getCollection();
		
			//Remove via the incoming id
			quoteService.deletequote(rc.id);
		
			//Redirect with message box
			getPlugin("messagebox").setMessage("info","The quote was successfully deleted.");
			setNextRoute("quote/list");
		</cfscript>
	
	</cffunction>
	
</cfcomponent>
