<cfcomponent name="poll" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="pollService" inject="model">

	<cffunction name="init" access="public" returntype="poll" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfset beanFactory = getPlugin("ioc") />
		
		<cfreturn this>
	</cffunction>
		
	<cffunction name="dspList" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();

		//set The exit handlers
		rc.xehEditor = "poll/dspEditor";
		rc.xehDelete = "poll/doDelete";

		//Get the listing
		rc.qpoll = pollService.getpolls() ;

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
			rc.qpoll = getPlugin("queryHelper").sortQuery(rc.qpoll,rc.sortBy, rc.sortOrder);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("pollList");
		</cfscript>
	</cffunction>
	
	<cffunction name="doVote" access="remote" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfset var oid = 0>
		<cfset var pid = 0>
		<cfset var poll = 0>
		<cfset var vote = 0>
		<cfset var options =0>
		<cfset var option =0>
		<cfset var voteCount = 0>
		<cfset var results = "">
		
		<cfif event.valueExists("pollid") AND event.valueExists("optionid")>
			<cfscript>
				//remove comma followed by digits to strip it down to single digit for option id
				oid = event.getValue("optionid");
				oid = REReplace(oid,",[0-9]","");
				pid = event.getValue("pollid");
				pid = REReplace(pid,",[0-9]","");
				
				// setup poll and options
				poll = pollService.getPoll(pid);
				options = poll.getOptionArray();
				// setup vote
				vote = pollService.createVote();
				vote.setIPAddress(CGI.REMOTE_ADDR);
				// setup option
				option = pollService.getOption(oid);
				vote.setOption(option);
				// save vote
				pollService.saveVote(vote);
				//if(vote.getID() NEQ oid AND vote.getIPAdress() NEQ CGI.REMOTE_ADDR)){
					// Insert new vote into the database --->
				//pollService.saveOption(option);
				//}
				
			</cfscript>

			<cfsavecontent variable="results">
			<?xml version="1.0" ?>
				<pollerTitle><cfoutput>#poll.gettitle()#</cfoutput></pollerTitle>
				<cfloop from="1" to="#arrayLen(options)#" index="i">
				<cfset option = options[i]>
					<cfoutput>
						<cfset voteCount = pollService.getVoteCount(option.getid()) />
						<option>
							<optionText>#option.getAnswer()# (#voteCount#)</optionText>				
							<optionId>#option.getID()#</optionId>
							<votes>#voteCount#</votes>								
						</option>			
					</cfoutput>
				</cfloop>
			</cfsavecontent>
			<cfset event.setValue("data",results)>			
		<cfelseif event.valueExists("pollid")>
			<cfset event.setValue("data",results)>
		<cfelse>
			<cfset event.setValue("data","No success... sorry :(")>
		</cfif>
		
		<cfset event.setView("ajaxProxy",true)>
	</cffunction>

	<cffunction name="doSave" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var poll = "";

		//get a new poll bean
		poll = pollService.getpoll(0);

		//Populate the bean
		getPlugin("beanFactory").populateBean(poll);
		
		//Send to service for saving
		pollService.savepoll(poll);

		//Set redirect
		setNextEvent("poll.dspList");
		</cfscript>		
	</cffunction>

	<cffunction name="doDelete" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
	
		<cfscript>
			//References
			var rc = event.getCollection();
		
			//Remove via the incoming id
			pollService.deletepoll(rc.id);
		
			//Redirect with message box
			getPlugin("messagebox").setMessage("info","The record was successfully deleted");
			setNextEvent("poll.dspList");
		</cfscript>
	
	</cffunction>
	
</cfcomponent>
