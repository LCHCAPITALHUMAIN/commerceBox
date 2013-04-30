<cfcomponent name="articleService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.articleService">
		<cfset super.init(entityName="Article")>
		<cfreturn this/>
	</cffunction>

	<cffunction name="createarticle" access="public" output="false" returntype="model.article">
			
		<cfreturn new("Article") />
	</cffunction>

	<cffunction name="getarticle" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("Article",arguments.id) />
	</cffunction>

	<cffunction name="getarticles" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="summary" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="views" type="Numeric" required="false" />
		<cfargument name="islive" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"article_section_id") and len(arguments.article_section_id)>
			<cfset map.article_section_id = arguments.article_section_id />
		</cfif>
		<cfif structKeyExists(arguments,"article_author_id") and len(arguments.article_author_id)>
			<cfset map.article_author_id = arguments.article_author_id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"summary") and len(arguments.summary)>
			<cfset map.summary = arguments.summary />
		</cfif>
		<cfif structKeyExists(arguments,"content") and len(arguments.content)>
			<cfset map.content = arguments.content />
		</cfif>
		<cfif structKeyExists(arguments,"views") and len(arguments.views)>
			<cfset map.views = arguments.views />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn getTransfer().listByPropertyMap("article.article",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savearticle" access="public" output="false" returntype="void">
		<cfargument name="article" type="any" required="true" />
		
		<cfset save(arguments.article) />
	</cffunction>

	<cffunction name="deletearticle" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var article = get("article",arguments.id) />
		<cfset delete(article) />
	</cffunction>
	
	<cffunction name="getArticlesBySection" access="public" output="false" returntype="query">
		<cfargument name="sectionid" required="true" default="0">
		<cfset var rs = "">
		<cfquery name="rs" datasource="#datasource#">
			SELECT *, Section.id FROM articles as Article 
			JOIN article_sections as Section 
			where Article.islive = 1 
			AND Section.id = <cfqueryparam value="#arguments.sectionid#" cfsqltype="cf_sql_integer"> 
			ORDER BY Article.id
		</cfquery>
		
		<cfreturn rs />
	</cffunction>
	
	<cffunction name="getFeaturedArticles" access="public" output="false" returntype="query">
		<cfargument name="curdate" required="false" default="#dateFormat(now(),"yyyy-mm-dd")#">
		<cfset var rs = "">
		<cfquery name="rs" datasource="#datasource#">
			SELECT *, Featured.id as fid 
			FROM articles as Article JOIN article_featured as Featured 
			where Article.islive = 1 
			AND Featured.datestart < <cfqueryparam value="#arguments.curdate#" cfsqltype="cf_sql_date"> 
			AND Featured.dateend > <cfqueryparam value="#arguments.sectionid#" cfsqltype="cf_sql_date"> 
			ORDER BY Featured.end DESC
		</cfquery>
		
		<cfreturn rs />
	</cffunction>
	
	<!--- Author Methods --->
	
	<cffunction name="createauthor" access="public" output="false" returntype="any">
			
		<cfreturn new("Author") />
	</cffunction>

	<cffunction name="getauthor" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("Author",arguments.id) />
	</cffunction>

	<cffunction name="getauthors" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="firstname" type="String" required="false" />
		<cfargument name="lastname" type="String" required="false" />
		<cfargument name="image" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="islive" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"firstname") and len(arguments.firstname)>
			<cfset map.firstname = arguments.firstname />
		</cfif>
		<cfif structKeyExists(arguments,"lastname") and len(arguments.lastname)>
			<cfset map.lastname = arguments.lastname />
		</cfif>
		<cfif structKeyExists(arguments,"image") and len(arguments.image)>
			<cfset map.image = arguments.image />
		</cfif>
		<cfif structKeyExists(arguments,"content") and len(arguments.content)>
			<cfset map.content = arguments.content />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn getTransfer().listByPropertyMap("article.author",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="saveauthor" access="public" output="false" returntype="void">
		<cfargument name="author" type="any" required="true" />
		
		<cfset save(arguments.author) />
	</cffunction>

	<cffunction name="deleteauthor" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var author = get("Author",arguments.id) />
		<cfset delete(author) />
	</cffunction>
	
	<!--- Section Methods --->
	
	<cffunction name="createsection" access="public" output="false" returntype="any">
			
		<cfreturn new("ArticleSection") />
	</cffunction>

	<cffunction name="getsection" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("ArticleSection",arguments.id) />
	</cffunction>

	<cffunction name="getsections" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="summary" type="String" required="false" />
		<cfargument name="views" type="Numeric" required="false" />
		<cfargument name="islive" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"summary") and len(arguments.summary)>
			<cfset map.summary = arguments.summary />
		</cfif>
		<cfif structKeyExists(arguments,"views") and len(arguments.views)>
			<cfset map.views = arguments.views />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn getTransfer().listByPropertyMap("article.section",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savesection" access="public" output="false" returntype="void">
		<cfargument name="section" type="any" required="true" />
		
		<cfset save(arguments.section) />
	</cffunction>

	<cffunction name="deletesection" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var section = get("ArticleSection",arguments.id) />
		<cfset delete(section) />
	</cffunction>
	
	<!--- Featured Methods --->
	
	<cffunction name="createfeatured" access="public" output="false" returntype="any">
			
		<cfreturn new("ArticleFeatured") />
	</cffunction>

	<cffunction name="getfeatured" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("ArticleFeatured",arguments.id) />
	</cffunction>

	<cffunction name="getfeatureds" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="article_id" type="Numeric" required="false" />
		<cfargument name="start" type="String" required="false" />
		<cfargument name="end" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"article_id") and len(arguments.article_id)>
			<cfset map.article_id = arguments.article_id />
		</cfif>
		<cfif structKeyExists(arguments,"start") and len(arguments.start)>
			<cfset map.start = arguments.start />
		</cfif>
		<cfif structKeyExists(arguments,"end") and len(arguments.end)>
			<cfset map.end = arguments.end />
		</cfif>
		
		<cfreturn getTransfer().listByPropertyMap("article.featured",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savefeatured" access="public" output="false" returntype="void">
		<cfargument name="featured" type="any" required="true" />
		
		<cfset save(arguments.featured) />
	</cffunction>

	<cffunction name="deletefeatured" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var feature = get("ArticleFeatured",arguments.id) />
		<cfset delete(feature) />
	</cffunction>
	
</cfcomponent>