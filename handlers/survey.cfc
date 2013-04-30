<cfcomponent name="survey" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="surveyService" inject="model">

	<cffunction name="init" access="public" returntype="survey" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
		
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();

		//set The exit handlers
		rc.xehEditor = "survey/details";
		rc.xehDelete = "survey/delete";
		rc.xehList = "survey/list";

		//Get the listing
		rc.qsurvey = surveyService.getSurveys() ;

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
			rc.qsurvey = getPlugin("queryHelper").sortQuery(rc.qsurvey,rc.sortBy, rc.sortOrder);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("survey/list");
		</cfscript>
	</cffunction>

	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();

		//set the exit handlers
		rc.xehSave = "survey/save";
		rc.xehList = "survey/list";

		//Get poll bean with/without ID.
		rc.survey = surveyService.getSurvey(event.getValue("id","0"));
		rc.aQuestions = rc.survey.getQuestionArray();
		rc.qQuestionTypes = surveyService.getQuestionTypes();

		//Set view to render
		event.setView("survey/details");
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
				poll = surveyService.getPoll(pid);
				options = poll.getPollOptionArray();
				
				</cfscript>
				<cfscript>
				
				// limit the number of votes the same ip adress could cast. --->
				if(NOT surveyService.getVotes(optionid=oid, ipaddress=CGI.REMOTE_ADDR).recordcount){
					vote = surveyService.createVote(0,oid,CGI.REMOTE_ADDR);
					// Insert new vote into the database --->
					surveyService.saveVote(vote);
				}
				
			</cfscript>	

			<cfsavecontent variable="results">
			<?xml version="1.0" ?>
				<pollerTitle><cfoutput>#poll.gettitle()#</cfoutput></pollerTitle>
				<cfloop from="1" to="#arrayLen(options)#" index="i">
				<cfset option = options[i]>
					<cfoutput>
						<cfset voteCount = surveyService.getVoteCount(option.getid()) />
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
		<cfargument name="event" required="yes">
		<cfscript>
		//References
		var rc = event.getCollection();
		var survey = "";
		var question = "";
		var questions = arrayNew(1);
		var option = "";
		var options = structNew();
		var answers = structNew();
		var titles = arrayNew(1);
		var types = arrayNew(1);
		
		//get a new survey bean
		survey = surveyService.getSurvey(event.getValue("id",0));
		//Populate the survey
		getPlugin("beanFactory").populateBean(survey);
		survey.setTitle(event.getValue("surveytitle",""));
		// save the survey
		//surveyService.saveSurvey(survey);
		//setup options for saving
		questions = listtoArray(event.getValue("questionid",""));
		titles = listtoArray(event.getValue("title",""));
		types = listToArray(event.getValue("questiontype",""));
		
		for(i = 1; i lte arrayLen(questions); i = i + 1)
		{
			question = surveyService.getQuestion(val(questions[i]));
			question.removeParentSurvey();
			question.setParentSurvey(survey);
			question.setTitle(titles[i]);
			question.setType(types[i]);
			surveyService.saveQuestion(question);
			answers[i] = listtoArray(event.getValue("answer#i#",""));
			options[i] = listtoArray(event.getValue("optionid#i#",""));
			
			for(j = 1; j lte arrayLen(options[i]); j = j + 1)
			{
				option = surveyService.getOption(val(options[i][j]));
				option.removeParentQuestion();
				option.setParentQuestion(question);
				option.setAnswer(answers[i][j]);
				surveyService.saveOption(option);
			}
		}
		getPlugin("messagebox").setMessage("info","The Survey has been sucessfully saved");
		//Set redirect
		setNextRoute("survey/details/#survey.getID()#");
		</cfscript>		
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
	
		<cfscript>
			//References
			var rc = event.getCollection();
		
			//Remove via the incoming id
			surveyService.deleteSurvey(rc.id);
		
			//Redirect with message box
			getPlugin("messagebox").setMessage("info","The survey was successfully deleted");
			setNextRoute("survey/list");
		</cfscript>
	
	</cffunction>
	
</cfcomponent>
