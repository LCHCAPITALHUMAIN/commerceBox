<cfcomponent name="surveyService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.surveyService">
		<cfset super.init(entityName="Survey") />
		<cfreturn this/>
	</cffunction>

	<!--- Survey methods --->
    <cffunction name="createsurvey" access="public" output="false" returntype="any">
			
		<cfreturn new("Survey") />
	</cffunction>

	<cffunction name="getsurvey" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("Survey",arguments.id) />
	</cffunction>

	<cffunction name="getsurveys" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
        <cfargument name="description" type="String" required="false" />
        <cfargument name="datebegin" type="date" required="false" />
        <cfargument name="dateend" type="date" required="false" />
        <cfargument name="exitmsg" type="String" required="false" />
        <cfargument name="password" type="String" required="false" />
        <cfargument name="author" type="String" required="false" />
		<cfargument name="isfeatured" type="Boolean" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
        <cfif structKeyExists(arguments,"description") and len(arguments.description)>
			<cfset map.description = arguments.description />
		</cfif>
        <cfif structKeyExists(arguments,"datebegin") and len(arguments.datebegin)>
			<cfset map.datebegin = arguments.datebegin />
		</cfif>
        <cfif structKeyExists(arguments,"dateend") and len(arguments.dateend)>
			<cfset map.dateend = arguments.dateend />
		</cfif>
        <cfif structKeyExists(arguments,"exitmsg") and len(arguments.exitmsg)>
			<cfset map.exitmsg = arguments.exitmsg />
		</cfif>
        <cfif structKeyExists(arguments,"password") and len(arguments.password)>
			<cfset map.password = arguments.password />
		</cfif>
        <cfif structKeyExists(arguments,"author") and len(arguments.author)>
			<cfset map.author = arguments.author />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		<cfif structKeyExists(arguments,"isfeatured") and len(arguments.isfeatured)>
			<cfset map.isfeatured = arguments.isfeatured />
		</cfif>
		
		<cfreturn entityLoad("survey.survey",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savesurvey" access="public" output="false" returntype="void">
		<cfargument name="survey" type="any" required="true" />
		
		<cfset save(arguments.survey) />
	</cffunction>

	<cffunction name="deletesurvey" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var survey = get("Survey",arguments.id) />
		<cfset delete(survey) />
	</cffunction>
    
	<!--- Question methods --->
	<cffunction name="createQuestion" access="public" output="false" returntype="any">
			
		<cfreturn new("SurveyQuestion") />
	</cffunction>

	<cffunction name="getQuestion" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("SurveyQuestion",arguments.id) />
	</cffunction>

	<cffunction name="getquestions" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
        <cfargument name="type" type="numeric" required="true" />
		<cfargument name="islive" type="Boolean" required="false" />
		<cfargument name="isfeatured" type="Boolean" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
        <cfif structKeyExists(arguments,"type") and len(arguments.type)>
			<cfset map.type = arguments.type />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		<cfif structKeyExists(arguments,"isfeatured") and len(arguments.isfeatured)>
			<cfset map.isfeatured = arguments.isfeatured />
		</cfif>
		
		<cfreturn entityLoad("survey.question",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savequestion" access="public" output="false" returntype="void">
		<cfargument name="question" type="any" required="true" />
		
		<cfset save(arguments.question) />
	</cffunction>

	<cffunction name="deletequestion" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var question = get("SurveyQuestion",arguments.id) />
		<cfset delete(question) />
	</cffunction>
    
    <!--- Question Type Methods --->
	<cffunction name="createQuestionType" access="public" output="false" returntype="any">
			
		<cfreturn new("SurveyQuestionType") />
	</cffunction>

	<cffunction name="getQuestionType" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("SurveyQuestionType",arguments.id) />
	</cffunction>

	<cffunction name="getquestionTypes" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		
		<cfreturn entityLoad("SurveyQuestionType",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savequestionType" access="public" output="false" returntype="void">
		<cfargument name="question" type="any" required="true" />
		
		<cfset save(arguments.question_type) />
	</cffunction>

	<cffunction name="deletequestionType" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var question_type = get("SurveyQuestionType",arguments.id) />
		<cfset delete(question_type) />
	</cffunction>
	
	<!--- Option Methods --->
	
	<cffunction name="createoption" access="public" output="false" returntype="any">
			
		<cfreturn new("SurveyOption") />
	</cffunction>

	<cffunction name="getoption" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("SurveyOption",arguments.id) />
	</cffunction>

	<cffunction name="getoptions" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="answer" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"answer") and len(arguments.answer)>
			<cfset map.answer = arguments.answer />
		</cfif>
		
		<cfreturn entityLoad("survey.option",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="saveoption" access="public" output="false" returntype="void">
		<cfargument name="option" type="any" required="true" />
		
		<cfset save(arguments.option) />
	</cffunction>

	<cffunction name="deleteoption" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var option = get("SurveyOption",arguments.id) />
		<cfset delete(option) />
	</cffunction>
	
	<!--- Answer Methods --->
	
	<cffunction name="createAnswer" access="public" output="false" returntype="any">
			
		<cfreturn new("SurveyAnswer") />
	</cffunction>

	<cffunction name="getAnswer" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("SurveyAnswer",arguments.id) />
	</cffunction>

	<cffunction name="getAnswers" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="ipaddress" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"ipaddress") and len(arguments.ipaddress)>
			<cfset map.ipaddress = arguments.ipaddress />
		</cfif>
		
		<cfreturn entityLoad("survey.answer",map,arguments.orderby,arguments.orderasc) />
	</cffunction>
	
	<cffunction name="getAnswerCount" access="public" output="false" returntype="numeric">
    	<cfargument name="optionid" type="Numeric" required="true" />
		
		<cfset var result = "">
		<cfquery name="result" datasource="#datasource#">
			SELECT answer.id 
			FROM survey_options as o JOIN survey_answers as answer 
			WHERE o.id = <cfqueryparam value="#arguments.optionid#" cfsqltype="cf_sql_bigint" /> 
		</cfquery>
        
        <cfreturn result.recordcount />        
    </cffunction>

	<cffunction name="saveAnswer" access="public" output="false" returntype="void">
		<cfargument name="answer" type="any" required="true" />
		
		<cfset save(arguments.answer) />
	</cffunction>

	<cffunction name="deleteAnswer" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var answer = get("SurveyAnswer",arguments.id) />
		<cfset delete(answer) />
	</cffunction>
	
</cfcomponent>