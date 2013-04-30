<cfcomponent name="poll" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="pollService" inject="model">

	<cffunction name="init" access="public" returntype="poll" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfset beanFactory = getPlugin("ioc") />
		
		<cfreturn this>
	</cffunction>
    
     <cffunction name="preHandler" access="public" returntype="void" output="false">
    	<cfargument name="event" required="true">
        <cfscript>
			var rc = event.getCollection();
			rc.xehEditor = "admin/poll/details";
			rc.xehDelete = "admin/poll/delete";
			rc.xehList = "admin/poll/list";
			rc.xehSave = "admin/poll/save";
		</cfscript>
	</cffunction>
		
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();

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
		event.setView("poll/list");
		</cfscript>
	</cffunction>

	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();

		//Get poll bean with/without ID.
		rc.poll = pollService.getpoll(event.getValue("id","0"));
		rc.aOptions = rc.poll.getOptionArray();	

		//Set view to render
		event.setView("poll/details");
		</cfscript>	
	</cffunction>
	
	<cffunction name="doVote" access="remote" returntype="void" output="false">
		<cfargument name="event"  required="yes">
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
				options = poll.getPollOptionArray();
				
				</cfscript>
				<cfscript>
				
				// limit the number of votes the same ip adress could cast. --->
				if(NOT pollService.getVotes(optionid=oid, ipaddress=CGI.REMOTE_ADDR).recordcount){
					vote = pollService.createVote(0,oid,CGI.REMOTE_ADDR);
					// Insert new vote into the database --->
					pollService.saveVote(vote);
				}
				
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

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var poll = "";
		var option = "";
		var options = arrayNew(1);
		var answers = arrayNew(1);

		//get a new poll bean
		poll = pollService.getpoll(event.getValue("id",0));
		//Populate the poll
		getPlugin("beanFactory").populateBean(poll);
		// save the poll
		pollService.savePoll(poll);
		//setup options for saving
		options = listtoArray(event.getValue("optionid",""));
		answers = listtoArray(event.getValue("answer",""));
		for(i = 1; i lte arrayLen(options); i = i + 1)
		{
			option = pollService.getOption(val(options[i]));
			option.removeParentPoll();
			option.setParentPoll(poll);
			option.setAnswer(answers[i]);
			pollService.saveOption(option);
		}
		getPlugin("messagebox").setMessage("info","The poll has been sucessfully saved");
		//Set redirect
		setNextRoute("poll/details/#poll.getID()#");
		</cfscript>		
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
	
		<cfscript>
			//References
			var rc = event.getCollection();
		
			//Remove via the incoming id
			pollService.deletepoll(rc.id);
		
			//Redirect with message box
			getPlugin("messagebox").setMessage("info","The poll was successfully deleted");
			setNextRoute("poll/list");
		</cfscript>
	
	</cffunction>
	
</cfcomponent>
