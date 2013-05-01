<cfcomponent name="quoteService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.quoteService">
		<cfset super.init(entityName="Quote") />
		<cfreturn this/>
	</cffunction>

	<cffunction name="createquote" access="public" output="false" returntype="any">
			
		<cfreturn new("Quote") />
	</cffunction>

	<cffunction name="getquote" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("Quote",arguments.id) />
	</cffunction>

	<cffunction name="getquotes" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="author" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"author") and len(arguments.author)>
			<cfset map.author = arguments.author />
		</cfif>
		<cfif structKeyExists(arguments,"content") and len(arguments.content)>
			<cfset map.content = arguments.content />
		</cfif>
		
		<cfreturn entityLoad("quote.quote",map,arguments.orderby,arguments.orderasc) />
	</cffunction>
	
	<cffunction name="getRandomQuote" access="public" output="false" returntype="any">
		<cfscript>
			var quotes = getQuotes();
			var quoteid = randRange(1,quotes.recordCount);
			
			return getQuote(quoteid);
		</cfscript>
	</cffunction>

	<cffunction name="savequote" access="public" output="false" returntype="void">
		<cfargument name="quote" type="any" required="true" />
		
		<cfset save(arguments.quote) />
	</cffunction>

	<cffunction name="deletequote" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var quote = get("Quote",arguments.id) />
		<cfset delete(quote) />
	</cffunction>
</cfcomponent>
