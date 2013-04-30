<cfcomponent name="article" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="articleService" inject="model">

	<cffunction name="init" access="public" returntype="article" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfset rc = event.getCollection()>
		
		<cfset event.setValue("title","Articles - #getController().getSetting("siteName")#")>
		<cfset event.setValue("description","Resourceful articles from #getController().getSetting("siteName")#'s director Stephen Wallace")>
		<cfset event.setValue("keyword","articles, salvation, law, grace, tribulation, rapture, revelations, millenium, antichrist, ribera, jesuit, Harry Potter, #getController().getSetting("siteName")#, Stephen Wallace, sabbath, catholic, witchcraft, hell, death")>
		
		<cfscript>
			//set the exit event handlers
			rc.xehList = "article/list";
			rc.xehDetail = "article/details";
			
			rc.qFeaturedArticles = articleService.getFeaturedArticles();
			rc.qLatestArticles = articleService.getArticles(orderby="id", orderasc=0);
			rc.qPopularArticles = articleService.getArticles(orderby="views", orderasc=0);
			rc.qSections = articleService.getSections(islive=1,orderby="views", orderasc=0);
			
		</cfscript>
		
		<cfset event.setView("article/index")>
	</cffunction>
		
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";

		//set The exit handlers
		rc.xehDetails = "article/details";
		// set the value for sectionid on the sort form
		rc.asid = "";
		
		// Setup articles for navigation, sorted by most views
		rc.qsections = articleService.getSections(islive=1,orderby="views",orderasc=0);
		
		rc.title = "All Articles";
		// List by category if filter is present
		if (event.valueExists("id")){
			rc.qarticles = articleService.getArticlesBySection(sectionid=val(event.getValue("id",0)));
			rc.section = articleService.getSection(id=val(event.getValue("id",0)));
			//check if section exists
			if (rc.section.getID() NEQ 0){
				// increment views and persist to database
				if (rc.section.getViews() IS ""){
					rc.section.setViews(0);
				}
				rc.section.setViews(val(rc.section.getViews()+1));
				articleService.saveSection(rc.section);
			}
			// set the title for the page
			rc.title = "#rc.section.getTitle()#";
			// set the value for sectionid on the sort form
			rc.asid = "#rc.section.getID()#";
		}else{
			//Get the full listing of all articles
			rc.qarticles = articleService.getarticles(orderby="id",orderasc=1);
		}
		
		//Sorting Logic.
		if (event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			if (event.getValue("sortBy") IS "title" ){order = "asc";}
			rc.qarticles = getPlugin("queryHelper").sortQuery(rc.qarticles,rc.sortBy, order);
		}
		else{
			rc.sortBy = "";
		}
		
		// check if user is logged in
		if (getPlugin("sessionStorage").getVar("loggedIn",false)){
			event.setValue("scripts", "");	
		}

		//Set the view to render
		event.setView("article/list");
		</cfscript>
	</cffunction>

	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
			<cfscript>
				var rc = event.getCollection();
				
				//setup eXit Event Handlers
				rc.xehList = "article/list";
				rc.xehProduct = "product/details";
				// setup the page parameters
				rc.title = "Article Does Not Exist";
				rc.scripts = "pullquote.js";
				
				
				rc.qsections = articleService.getSections(islive=1,orderby="id", orderasc=0);
				// get the article by the id passed in
				if (event.valueExists("id")){
					rc.article = articleService.getArticle(id=val(event.getValue("id")));
					// setup article sections
					rc.section = rc.article.getsection();
					rc.Author = rc.article.getAuthor();
					rc.qRelatedArticles = articleService.getArticlesBySection(sectionid=rc.section.getID());
					rc.aRelatedProducts = rc.article.getProductArray();
					//increment article views by 1
					rc.article.setViews(rc.article.getViews()+1);
					articleService.saveArticle(rc.article);
					
					rc.title = "#rc.article.getTitle()#";
				}
				
				event.setView("article/details");
			</cfscript>
	</cffunction>	
	
	<cffunction name="doSectionSave" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var section = "">
		
		<cfscript>
			//get the section object
			section = articleService.getSection(event.getValue("id",0));
	
			//Populate the bean
			getPlugin("beanFactory").populateBean(section);
			
			//Send to service for saving
			articleService.savesection(section);
		</cfscript>
		
		<cfset event.setValue("data",section.getTitle())>
		<cfset event.setView("ajaxProxy",true)>
	</cffunction>
	
</cfcomponent>