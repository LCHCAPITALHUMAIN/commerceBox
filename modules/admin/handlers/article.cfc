<cfcomponent name="article" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="articleService" inject="model">
	<cfproperty name="productService" inject="model">

	<cffunction name="init" access="public" returntype="article" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
    
     <cffunction name="preHandler" access="public" returntype="void" output="false">
    	<cfargument name="event" required="true">
        <cfscript>
			var rc = event.getCollection();
			rc.xehList = "admin/article/list";
			rc.xehDetail = "admin/article/details";
			rc.xehSave = "admin/article/save";
			rc.xehDelete = "admin/article/delete";
			// section exit handlers
			rc.xehSectionList = "admin/article/sectionList";
			rc.xehSectionDetail = "admin/article/sectionDetails";
			rc.xehSectionSave = "admin/article/saveSection";
			rc.xehSectionDelete = "admin/article/deleteSection";
			// featured exit handlers
			rc.xehFeaturedList = "admin/article/featuredList";
			rc.xehFeaturedDetail = "admin/article/featuredDetails";
			rc.xehFeaturedSave = "admin/article/saveFeatured";
			rc.xehFeaturedDelete = "admin/article/deleteFeatured";
			// author exit handlers
			rc.xehAuthorList = "admin/article/AuthorList";
			rc.xehAuthorDetail = "admin/article/AuthorDetails";
			rc.xehAuthorSave = "admin/article/saveAuthor";
			rc.xehAuthorDelete = "admin/article/deleteAuthor";
		</cfscript>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
				
		<cfscript>
			var rc = event.getCollection();
			event.setValue("title","Article Administration");
			
			rc.articles = articleService.getArticles(orderby="id",orderasc=1);
			rc.qSections = articleService.getSections(orderby="views",orderasc=0);
			rc.qFeatured = articleService.getFeaturedArticles();
			rc.qAuthors = articleService.getAuthors();
			
		</cfscript>
		
		<cfset event.setView("article/index")>
	</cffunction>
		
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";

		event.setValue("title","Article Administration");
		
		// Setup articles for navigation, sorted by most views
		rc.qSections = articleService.getSections(orderby="views",orderasc=0);
		
		rc.title = "All Articles";
		// List by category if filter is present
		if (event.valueExists("id")){
			rc.qarticles = articleService.getBySection(sectionid=val(event.getValue("id",0)));
			rc.Section = articleService.getSection(id=val(event.getValue("id",0)));
			//check if Section exists
			if (rc.Section.getID() NEQ 0){
				// increment views and persist to database
				if (rc.Section.getViews() IS ""){
					rc.Section.setViews(0);
				}
				rc.Section.setViews(val(rc.Section.getViews()+1));
				articleService.saveSection(rc.Section);
			}
			// set the title for the page
			rc.title = "#rc.Section.getTitle()#";
			// set the value for Sectionid on the sort form
			rc.asid = "#rc.Section.getID()#";
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
		
		//Set the view to render
		event.setView("article/list");
		</cfscript>
	</cffunction>

	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
			<cfscript>
				var rc = event.getCollection();
				var count = 0;
				var products ="";
			
				// setup the page parameters
				rc.title = "Edit Article";
				
				rc.qSections = articleService.getSections(orderby="title");
				rc.qAuthors = articleService.getAuthors(orderby="firstname");
				rc.qProducts = productService.getProducts(orderby="title");
				// get the article by the id passed in
				if (event.valueExists("id")){
					rc.article = articleService.getArticle(val(event.getValue("id",0)));
					// setup related resources
					rc.lproducts = "";
					products = rc.article.getProductArray();
					count = ArrayLen(products);
					for(counter = 1; counter lte count; counter = counter + 1)
					{
						rc.product = products[counter];
						rc.lproducts = ListAppend(rc.lproducts, rc.product.getID());
					}
					// setup article sections
					rc.Section = rc.article.getSection();
					rc.Author = rc.article.getAuthor();
					rc.qRelatedArticles = articleService.getArticlesBySection(sectionid=rc.section.getID());
					rc.aRelatedProducts = rc.article.getProductArray();
					// set view
					event.setView("article/details");
				}else{
					rc.title = "Add Article";
					event.setView("article/create");
				}
			</cfscript>
	</cffunction>
	
	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			var article = "";
			var section = "";
			var author = "";
			var product = "";
			var products = "";
			var count = 0;
			
			article = articleService.getArticle(event.getValue("id",0));
			// populate article
			article.setTitle(event.getValue("title",""));
			article.setSummary(event.getValue("summary",""));
			article.setContent(event.getValue("content",""));
			article.setViews(event.getValue("views",""));
			article.setIsLive(event.getValue("islive",""));
			// setup section
			section = articleService.getSection(id=event.getValue("sectionid",0));
			article.setSection(section);
			// setup author
			author = articleService.getAuthor(id=event.getValue("authorid",0));
			article.setAuthor(author);
			// clear related products
			article.clearProduct();
			//loop through the related products and add them back in
			products = listToArray(event.getValue("productid",""));
			count = ArrayLen(products);
			for(i = 1; i lte count; i = i + 1)
			{
				product = productService.getProduct(products[i]);
				article.addProduct(product);
			}
			
			// save the article and all of it's relationships
			articleService.saveArticle(article);
			// set confirmation message and redirect
			getPlugin("messagebox").setMessage("info","The article has been successfully saved");
			setNextRoute("article/details/#article.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset articleService.deleteArticle(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The article has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("article/list")>
	</cffunction>
	
	<!--- author --->
	
	<cffunction name="authorlist" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";

		// article exit handlers
		rc.xehList = xehList;
		rc.xehDetail = xehDetail;
		rc.xehSave = xehSave;
		rc.xehDelete = xehDelete;
		// Author exit handlers
		rc.xehAuthorList = xehAuthorList;
		rc.xehAuthorDetail = xehAuthorDetail;
		rc.xehAuthorSave = xehAuthorSave;
		rc.xehAuthorDelete = xehAuthorDelete;
		// section exit handlers
		rc.xehSectionList = xehSectionList;
		rc.xehSectionDetail = xehSectionDetail;
		rc.xehSectionSave = xehSectionSave;
		rc.xehSectionDelete = xehSectionDelete;
		// featured exit handlers
		rc.xehFeaturedList = xehFeaturedList;
		rc.xehFeaturedDetail = xehFeaturedDetail;
		rc.xehFeaturedSave = xehFeaturedSave;
		rc.xehFeaturedDelete = xehFeaturedDelete;
		
		event.setValue("title","Author Administration");
		
		// Setup articles for navigation, sorted by most views
		rc.qAuthors = articleService.getAuthors();
		
		rc.title = "All Author";
		// List by category if filter is present
		
		//Sorting Logic.
		if (event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			if (event.getValue("sortBy") IS "firstname" or  event.getValue("sortBy") IS "lastname"){order = "asc";}
			rc.qauthors = getPlugin("queryHelper").sortQuery(rc.qauthors,rc.sortBy, order);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("article/authorlist");
		</cfscript>
	</cffunction>
	
	<cffunction name="authordetails" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			var rc = event.getCollection();
		
			// setup the page parameters
			rc.title = "Add Article Author";
			
			rc.author = articleService.getAuthor(val(event.getValue("id",0)));
			if(event.valueExists("id")){
				rc.title = "Edit Article Author";
			}
			// set view
			event.setView("article/authordetails");
		</cfscript>
	</cffunction>
	
	<cffunction name="saveAuthor" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var author = "">
		
		<cfscript>
			//get the Section object
			author = articleService.getAuthor(event.getValue("id",0));
	
			//Populate the bean
			getPlugin("beanFactory").populateBean(author);
			
			</cfscript>
			<cfif event.valueExists("image") AND len(trim(event.getValue("image")))>
				<cffile action="upload" filefield="image" destination="#expandpath("../includes/images/authors/")#" nameconflict="overwrite">
				<cfimage action="resize" height="150" width="112" name="small" source="#expandpath("../includes/images/authors/")##cffile.clientfile#" destination="#expandpath("../includes/images/authors/")##cffile.clientfile#"overwrite="yes">
			</cfif>
			<cfset author.setImage("#cffile.clientfile#")>
			<cfscript>
			//Send to service for saving
			articleService.saveAuthor(author);
		
			getPlugin("messagebox").setMessage("info","The author has been successfully saved");
			setNextRoute("article/authordetails/#author.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteAuthor" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset articleService.deleteAuthor(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The author has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("article/authorlist")>
	</cffunction>
	
	<!--- section --->
	
	<cffunction name="sectionlist" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";

		event.setValue("title","Category Administration");
		
		// Setup articles for navigation, sorted by most views
		rc.qSections = articleService.getSections(orderby="views",orderasc=0);
		
		//Get the full listing of all articles
		rc.qarticles = articleService.getarticles();
		rc.title = "All Categories";
		// List by category if filter is present
		
		//Sorting Logic.
		if (event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			if (event.getValue("sortBy") IS "title" ){order = "asc";}
			rc.qarticles = getPlugin("queryHelper").sortQuery(rc.qarticles,rc.sortBy, order);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("article/sectionlist");
		</cfscript>
	</cffunction>
	
	<cffunction name="sectiondetails" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
			<cfscript>
				var rc = event.getCollection();
			
				// setup the page parameters
				rc.title = "Add Article Category";
				
				rc.section = articleService.getSection(val(event.getValue("id",0)));
				if(event.valueExists("id")){
					rc.title = "Edit Article Category";
					rc.qRelatedArticles = articleService.getArticlesBySection(sectionid=rc.section.getID());
				}
				// set view
				event.setView("article/sectiondetails");

				
			</cfscript>
	</cffunction>
	
	<cffunction name="saveSection" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var section = "">
		
		<cfscript>
			//get the Section object
			section = articleService.getSection(event.getValue("id",0));
	
			//Populate the bean
			getPlugin("beanFactory").populateBean(section);
			
			//Send to service for saving
			articleService.saveSection(section);
		
			getPlugin("messagebox").setMessage("info","The category has been successfully saved");
			setNextRoute("article/sectiondetails/#section.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteSection" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset articleService.deleteSection(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The category has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("article/sectionlist")>
	</cffunction>
	
	<!--- Featured --->
	
	<cffunction name="featureddetails" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
			<cfscript>
				var rc = event.getCollection();
			
				// setup the page parameters
				rc.title = "Schedule Article to Featured";
				rc.scripts ="calendar/calendar.js";
				
				rc.qArticles = articleService.getArticles(islive=1);
				rc.featured = articleService.getFeatured(val(event.getValue("id",0)));
				if(event.valueExists("id")){
					rc.title = "Edit Article Featured Schedule";
				}
				// set view
				event.setView("article/featureddetails");
				
			</cfscript>
	</cffunction>
	
	<cffunction name="featuredlist" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";
		
		event.setValue("title","Section Administration");
		
		// Setup articles for navigation, sorted by most views
		rc.qFeatured = articleService.getFeaturedArticles();
		
		rc.title = "Complete Schedule for Featured Articles";
		// List by category if filter is present
		
		//Sorting Logic.
		if (event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			if (event.getValue("sortBy") IS "title" ){order = "asc";}
			rc.qFeatured = getPlugin("queryHelper").sortQuery(rc.qFeatured,rc.sortBy, order);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("article/featuredlist");
		</cfscript>
	</cffunction>
	
	<cffunction name="saveFeatured" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var featured = "">
		<cfset var article = "">
		
		<cfscript>
			//get the Section object
			featured = articleService.getFeatured(event.getValue("id",0));
			article = articleService.getArticle(event.getValue("articleid",0));
			featured.setArticle(article);
	
			//Populate the bean
			getPlugin("beanFactory").populateBean(featured);
			
			//Send to service for saving
			articleService.saveFeatured(featured);
		
			getPlugin("messagebox").setMessage("info","The featured schedule has been successfully saved");
			setNextRoute("article/featureddetails/#featured.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteFeatured" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset articleService.deleteFeatured(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The featured schedule has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("article/featuredlist")>
	</cffunction>
	
</cfcomponent>