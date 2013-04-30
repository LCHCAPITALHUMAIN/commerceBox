<cfcomponent name="product" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="productService" inject="model" />

	<cffunction name="init" access="public" returntype="product" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="preHandler" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfscript>
			var rc = event.getCollection();
			
			//set The exit handlers
			rc.title = getController().getSetting("siteName");
			rc.description = getController().getSetting("tagline");
			rc.keywords= getController().getSetting("keywords");
			
			rc.xehDetails = "product/details";
			rc.xehAddToCart = "cart/doAdd";
			rc.xehAddtoCartAjax = "cart/doAddAjax";
			rc.xehList = "product/list";
			rc.xehDetails = "product/details";
			rc.xehReviews = "product/reviews";
		</cfscript>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			rc = event.getCollection();
		
			rc.qLatestProducts = productService.getProducts(orderby="id", orderasc=0,islive=1);
			rc.qPopularProducts = productService.getProducts(orderby="views", orderasc=0,islive=1);
			rc.qFeaturedProducts = productService.getFeaturedProducts(dateformat(now(),"yyyy-mm-dd"));
			
			event.setView("product/index");
		</cfscript>
	</cffunction>
		
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();
		// setup the page
		rc.title= getController().getSetting("siteName") & "All Apparel";
		
		//Get the all the active product listings
		if (event.valueExists("filter")){
			if(event.getValue("filter") eq "section"){
				rc.productFilter = productService.getSection(val(event.getValue("id",0)));
				rc.productArray = rc.productFilter.getProductArray();
				// increment product section views by 1 and save it
				if(rc.productFilter.getID() NEQ 0){
					rc.productFilter.setViews(val(rc.productFilter.getViews())+1);
					productService.saveSection(rc.productFilter);
				}
				// set the page title to the product section title
				rc.title = getController().getSetting("siteName") & " " & rc.productFilter.getTitle();
				
			}
			else if(event.getValue("filter") IS "format"){
				rc.productFilter = productService.getFormat(val(event.getValue("id",0)));
				rc.productArray = productService.readByProperty("product.product","format",rc.productFilter.getID());
				// set the page title to the product format title
				rc.title = getController().getSetting("siteName") & " " & rc.productFilter.getTitle();
				event.setView("product/list");
			}else if(event.getValue("filter") eq "size"){	
				rc.productFilter = productService.getSize(val(event.getValue("id",0)));
				rc.productArray = rc.productFilter.getProductArray();
				// increment product section views by 1 and save it
				if(rc.productFilter.getID() NEQ 0){
					rc.productFilter.setViews(val(rc.productFilter.getViews())+1);
					productService.saveSize(rc.productFilter);
				}
				// set the page title to the product section title
				rc.title = getController().getSetting("siteName") & " " & rc.productFilter.getTitle();
				
			}
		}

		//Sorting Logic.
		if ( event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			rc.qProducts = getPlugin("queryHelper").sortQuery(rc.qProducts,rc.sortBy, "desc");
		}
		else{
			rc.sortBy = "";
		}
		rc.scripts="jquery.cycle/jquery.cycle.min.js";
		event.setView("product/list");
		</cfscript>
	</cffunction>
	
	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			var rc = event.getCollection();
			// setup eXit Event Handlers
			//setup page parameters
			rc.product = productService.getProduct(val(event.getValue("id",0)));
			rc.title = "#rc.product.getTitle()# - #getController().getSetting("siteName")#";
			rc.description = rc.product.getSummary();
			rc.keywords="";
			rc.styles="tinybox.css";
			rc.scripts="jquery.cycle/jquery.cycle.min.js";
			
			// increment product views
			rc.product.setViews(rc.product.getViews()+1);
			productService.saveProduct(rc.product);
			// get product Items, streams and reviews
			rc.aItems = rc.product.getItemArray();
			rc.qSizes = productService.listByJoin("product.size","product.product","id",rc.product.getID());
			//rc.qProductStreams = productService.getProductStreams(product_id=val(event.getValue("id",0)));
			rc.aReviews = rc.product.getReviewArray();
			// set up the queries for the navigation
			rc.aProducts = rc.product.getProductImageArray();
		</cfscript>
		
		<cfset event.setView("product/details")>
		
	</cffunction>
	
	<cffunction name="reviews" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfscript>
			var rc = event.getCollection();
			
			// calls to model
			productService = beanFactory.getBean("productService");
			rc.product = productService.getProduct(val(event.getValue("id",0)));
			rc.qReviews = productService.getReviews(productid=val(event.getValue("id",0)));
			// navigation
			
			rc.title="Reviews for #rc.product.getTitle()#";
			rc.description="#rc.product.getSummary()#";
			rc.keywords="#getController().getSetting("siteName")#";
			
			event.setView("product/reviews");
		</cfscript>
	</cffunction>
	
</cfcomponent>