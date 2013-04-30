<cfcomponent name="pollService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.pollService">
		<cfset super.init(entityName="Poll") />
		<cfreturn this/>
	</cffunction>

	<cffunction name="createpoll" access="public" output="false" returntype="any">
			
		<cfreturn new("Poll") />
	</cffunction>

	<cffunction name="getpoll" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("Poll",arguments.id) />
	</cffunction>

	<cffunction name="getpolls" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
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
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		<cfif structKeyExists(arguments,"isfeatured") and len(arguments.isfeatured)>
			<cfset map.isfeatured = arguments.isfeatured />
		</cfif>
		
		<cfreturn listByPropertyMap("poll.poll",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savepoll" access="public" output="false" returntype="void">
		<cfargument name="poll" type="any" required="true" />
		
		<cfset save(arguments.poll) />
	</cffunction>

	<cffunction name="deletepoll" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var poll = get("Poll",arguments.id) />
		<cfset delete(poll) />
	</cffunction>
	
	<!--- Option Methods --->
	
	<cffunction name="createoption" access="public" output="false" returntype="any">
			
		<cfreturn new("PollOption") />
	</cffunction>

	<cffunction name="getoption" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("PollOption",arguments.id) />
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
		
		<cfreturn listByPropertyMap("poll.option",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="saveoption" access="public" output="false" returntype="void">
		<cfargument name="option" type="any" required="true" />
		
		<cfset save(arguments.option) />
	</cffunction>

	<cffunction name="deleteoption" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var option = get("PollOption",arguments.id) />
		<cfset delete(option) />
	</cffunction>
	
	<!--- Vote Methods --->
	
	<cffunction name="createvote" access="public" output="false" returntype="any">
			
		<cfreturn new("PollVote") />
	</cffunction>

	<cffunction name="getvote" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("PollVote",arguments.id) />
	</cffunction>

	<cffunction name="getvotes" access="public" output="false" returntype="any">
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
		
		<cfreturn listByPropertyMap("poll.vote",map,arguments.orderby,arguments.orderasc) />
	</cffunction>
	
	<cffunction name="getVoteCount" access="public" output="false" returntype="numeric">
    	<cfargument name="optionid" type="Numeric" required="true" />
		
		<cfset var result = "">
		<cfset var tql = createQuery("SELECT vote.id FROM poll.option as o JOIN poll.vote as vote WHERE o.id = :oid")>
		<cfset tql.setParam("oid",arguments.optionid)>
		<cfset result = listByQuery(tql)>
        
        <cfreturn result.recordcount />        
    </cffunction>

	<cffunction name="savevote" access="public" output="false" returntype="void">
		<cfargument name="vote" type="any" required="true" />
		
		<cfset save(arguments.vote) />
	</cffunction>

	<cffunction name="deletevote" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var vote = get("PollVote",arguments.id) />
		<cfset delete(vote) />
	</cffunction>
	
</cfcomponent>