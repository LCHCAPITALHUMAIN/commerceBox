<cfcomponent name="product" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="productService" inject="model" />

	<cffunction name="init" access="public" returntype="product" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>

		<cfreturn this>
	</cffunction>
    
    <cffunction name="preHandler" access="public" returntype="void" output="false">
    	<cfargument name="event" required="true">
        <cfscript>
			var rc = event.getCollection();
			
			// product exit handlers
			rc.xehList = "admin/product/list";
			rc.xehDetail = "admin/product/details";
			rc.xehSave = "admin/product/save";
			rc.xehDelete = "admin/product/delete";
			// Format exit handlers
			rc.xehFormatList = "admin/product/formatlist";
			rc.xehFormatDetail = "admin/product/formatdetail";
			rc.xehFormatSave = "admin/product/saveFormat";
			rc.xehFormatDelete = "admin/product/deleteFormat";
			// size exit handlers
			rc.xehsizeList = "admin/product/sizelist";
			rc.xehsizeDetail = "admin/product/sizedetail";
			rc.xehsizeSave = "admin/product/saveSize";
			rc.xehsizeDelete = "admin/product/deleteSize";
			// featured exit handlers
			rc.xehFeaturedList = "admin/product/featuredlist";
			rc.xehFeaturedDetail = "admin/product/featureddetail";
			rc.xehFeaturedSave = "admin/product/saveFeatured";
			rc.xehFeaturedDelete = "admin/product/deleteFeatured";
		</cfscript>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			rc = event.getCollection();
		
			rc.qProducts = productService.getProducts(orderby="id",orderasc=1);
			rc.qSections = productService.getSections(orderby="views",orderasc=0);
			rc.qSizes = productService.getSizes(orderby="id",orderasc=0);
			rc.qFeatured = productService.getFeaturedProducts();
			rc.qFormats = productService.getFormats();
		
			event.setView("product/index");
		</cfscript>
	</cffunction>	
		
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
		//Get references
		var rc = event.getCollection();
		
		// setup the page
		rc.title="All Products";
		
		rc.qSections = productService.getSections(orderby="views", orderasc=0);
		rc.qSizes = productService.getSizes(orderby="id",orderasc=0);
		rc.qFormats = productService.getFormats();
		//Get the all the active product listings
		rc.qProducts = productService.getproducts(orderby="views", orderasc=0);
		
		if (event.valueExists("filter")){
			if(event.getValue("filter") eq "section"){			
				rc.Section = productService.getSection(val(event.getValue("id",0)));
				rc.Array = rc.Section.getProductArray();
				// increment product section views by 1 and save it
				
				// set the page title to the product section title
				rc.title = "Category: #rc.Section.getTitle()#";
			}
			else if(event.getValue("filter") IS "format"){
				rc.Format = productService.getFormat(val(event.getValue("id",0)));
				rc.Array = rc.Format.getItemArray();
				// set the page title to the product format title
				rc.title = "Format: #rc.Format.getTitle()#";
			}else if(event.getValue("filter") eq "size"){			
				rc.Size = productService.getSize(val(event.getValue("id",0)));
				rc.Array = rc.Size.getProductArray();
				
				// set the page title to the product size title
				rc.title = "Size: #rc.Size.getTitle()#";
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
		event.setView("product/list");
		</cfscript>		
	</cffunction>
	
	<cffunction name="details" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			var rc = event.getCollection();
			var sections = "";
			var sizes = "";
			
			//setup page parameters
			if(event.valueExists("id")){
				rc.product = productService.getProduct(val(event.getValue("id",0)));
			}else{
				rc.product = productService.createProduct();
			}
			rc.title = "Edit Product";
			
			// setup related sections
			rc.lsections = "";
			sections = productService.listByJoin("product.section","product.product", "id", rc.product.getID());
			for(i = 1; i lte sections.recordcount; i = i + 1)
			{
				rc.lsections = ListAppend(rc.lsections, sections['id'][i]);
			}
			
			// setup related sizes
			rc.lsizes = "";
			sizes = productService.listByJoin("product.size","product.product","id",rc.product.getID());
			for(i = 1; i lte sizes.recordCount; i = i + 1)
			{
				rc.lsizes = ListAppend(rc.lsizes, sizes['id'][i]);
			}
			
			// get product Items, streams and reviews
			rc.aItems = rc.product.getItemArray();
			rc.aStreams = rc.product.getStreamArray();
			rc.aReviews = rc.product.getReviewArray();
			// set up the queries for the navigation
			rc.qSections = sections;
			rc.qSizes = sizes;
			rc.qFormats = productService.getFormats();
		
			event.setValue("scripts","swfobject2.js,jquery.uploadify.v2.1.0.min.js");
			event.setValue("styles","uploadify.css");
			event.setView("product/details");
			</cfscript>
	</cffunction>
	
	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			var rc = event.getCollection();
			var product = "";
			var sections = "";
			var section = "";
			var sizes = "";
			var size ="";
			var items = "";
			var item = "";
			var itemtitles = "";
			var prices = "";
			var specialprices = "";
			var formats = "";
			var format = "";
			var stream = "";
			var streams = "";
			var streamtitles = "";
			var streamviews = "";
			var isaudio = "";
			var isvideo = "";
			var streamislive = "";
			var images = "";
			//get the format object
			product = productService.getproduct(val(event.getValue("id",0)));
			//Populate the bean
			populateModel(product);
			product.clearSection();
			//loop through the related products and add them back in
			sections = listToArray(event.getValue("sectionid",""));
			for(i = 1; i lte arraylen(sections); i = i + 1)
			{
				section = productService.getSection(sections[i]);
				product.addSection(section);
			}
			// clear size from product to avoid problem with dirty object
			product.clearSize();
			//loop through the related products and add them back in
			sizes = listToArray(event.getValue("sizeid",""));
			for(i = 1; i lte arraylen(sizes); i = i + 1)
			{
				size = productService.getSize(sizes[i]);
				product.addSize(size);
			}
			//setup items
			items = listtoArray(event.getValue("itemid",""));
			itemtitles = listToArray(event.getValue("description",""));
			prices = listToArray(event.getValue("price",""));
			//specialprices = listToArray(event.getValue("specialprice",""));
			formats = listToArray(event.getValue("formatid",""));
			//loop through the items and setup the item
			for(i = 1; i lte arrayLen(items); i = i + 1)
			{
				//setup the item
				item = productService.getItem(val(items[i]));
				item.setTitle(itemtitles[i]);
				item.setPrice(decimalFormat(prices[i]));
				item.setIsSpecial(0);
				item.setSpecialPrice("0.00");
				//item.setSpecialPrice(decimalFormat(specialprices[i]));
				// setup parent format
				format = productService.getFormat(val(formats[i]));
				item.setParentFormat(format);
				item.setParentProduct(product);
				productService.saveProduct(product);
				productService.saveItem(item);
			}
			//setup items
			streams = listtoArray(event.getValue("streamid",""));
			streamtitles = listToArray(event.getValue("streamtitle",""));
			streamviews = listToArray(event.getValue("streamviews",""));
			isaudio = listToArray(event.getValue("isaudio",""));
			isvideo = listToArray(event.getValue("isvideo",""));
			streamislive = listToArray(event.getValue("streamislive",""));
			//loop through the items and setup the item
			for(i = 1; i lte arrayLen(streams); i = i + 1)
			{
				//setup the stream
				stream = productService.getStream(val(streams[i]));
				stream.setTitle(streamtitles[i]);
				stream.setViews(val(streamviews[i]));
				stream.setisAudio(val(isaudio[i]));
				stream.setIsVideo(val(isvideo[i]));
				stream.setIsLive(val(streamislive[i]));
				stream.setParentProduct(product);
				productService.saveStream(stream);
			}
			// Save the product
			productService.saveProduct(product);
			// Set a happy message
			getPlugin("messagebox").setMessage("info","The resource has been successfully saved");
			// display the page
			setNextRoute("product/details/#product.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset productService.deleteproduct(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The resource has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("product/list")>
	</cffunction>
    
    <cffunction name="uploadProductImage" access="public" returntype="void">
		<cfargument name="event"  required="yes">
        <cfset var rc = event.getCollection()>
        <cfset var status = 1>
		<cfset var product = productService.getProduct(event.getValue("productID"))>
        <cfset var image = productService.createImage()>
        <cfset var fileName = "">
        <!--- Upload and resize image --->
        <cflock name="imageUplaod" timeout="30" throwontimeout="yes">
            <cffile action="upload" filefield="fileData" destination="#expandpath('/includes/images/products/')#" nameconflict="makeunique">
            <cfset fileName = cffile.clientfile>
            <!--- save in multiple sizes--->
            <cfimage action="resize" width="240" height="320" name="large" source="#expandpath("/includes/images/products/")##fileName#" destination="#expandpath('/includes/images/products/')#240x320-#fileName#" overwrite="yes">
            <cfimage action="resize" width="180" height="240" name="medium" source="#expandpath("/includes/images/products/")##fileName#" destination="#expandpath('/includes/images/products/')#180x240-#fileName#" overwrite="yes">
            <cfimage action="resize" width="120" height="160" name="small" source="#expandpath("/includes/images/products/")##fileName#" destination="#expandpath('/includes/images/products/')#120x160-#fileName#" overwrite="yes">
            <cfimage action="resize" width="55" height="75" name="xsmall" source="#expandpath("/includes/images/products/")##fileName#" destination="#expandpath('/includes/images/products/')#55x75-#fileName#" overwrite="yes">
        </cflock>
        <cftry>
			<!--- persist the images to the database --->
            <cfset image.setXLImage(fileName)>
            <cfset image.setLImage("240x320-" & fileName)>
            <cfset image.setMImage("180x240-" & fileName)>
            <cfset image.setSImage("120x160-" & fileName)>
            <cfset image.setXSImage("55x75-" & fileName)>
			<cfset image.setParentProduct(product)>
        	<cfset productService.saveImage(image)>
            <cfcatch type="any">
            	<cfset getPlugin("logger").error("Error uploading file. File data : " & fileData & " message: " & cfcatch.message)>
                <cfset status = 0>
            </cfcatch>
        </cftry>
        
        <cfset event.renderData("PLAIN",status)>
    </cffunction>
	
	<cffunction name="reviews" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			var rc = event.getCollection();
			
			
			// calls to model
			productService = beanFactory.getBean("productService");
			rc.product = productService.getProduct(val(event.getValue("id",0)));
			rc.qProductReviews = productService.getProductReviews(productid=val(event.getValue("id",0)));
			// navigation
			rc.qSections = productService.getSections(orderby="views",orderasc=0);
			rc.qSizes = productService.getSize(orderby="id",orderasc=0);
			rc.qFormats = productService.getFormats();
			
			rc.title="Readers Respond to #rc.product.getTitle()#";
			rc.description="#rc.product.getSummary()#";
			rc.keywords="";
			
			event.setView("product/reviews");
		</cfscript>
	</cffunction>
	
	<!--- format --->
	
	<cffunction name="formatlist" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";

		// product exit handlers
		
		
		event.setValue("title","Format Administration");
		
		// Setup products for navigation, sorted by most views
		rc.qformats = productService.getformats();
		
		//Get the full listing of all products
		rc.qproducts = productService.getproducts();
		rc.title = "All Formats";
		// List by category if filter is present
		
		//Sorting Logic.
		if (event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			if (event.getValue("sortBy") IS "title" ){order = "asc";}
			rc.qproducts = getPlugin("queryHelper").sortQuery(rc.qproducts,rc.sortBy, order);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("product/formatlist");
		</cfscript>
	</cffunction>
	
	<cffunction name="formatdetails" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
			<cfscript>
				var rc = event.getCollection();
				
				// setup the page parameters
				rc.title = "Add Product Format";
				if(event.valueExists("id")){
					rc.format = productService.getformat(val(event.getValue("id",0)));
				}else{
					rc.format = productService.createFormat();
				}
				if(event.valueExists("id")){
					rc.title = "Edit Resource Category";
					rc.aItems = rc.format.getItemArray();
				}
				// set view
				event.setView("product/formatdetails");				
			</cfscript>
	</cffunction>
	
	<cffunction name="saveformat" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var format = "">
		
		<cfscript>
			//get the format object
			format = productService.getformat(event.getValue("id",0));
	
			//Populate the bean
			getPlugin("beanFactory").populateBean(format);
			
			//Send to service for saving
			productService.saveformat(format);
		
			getPlugin("messagebox").setMessage("info","The format has been successfully saved");
			setNextRoute("product/formatdetails/#format.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteformat" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset productService.deleteformat(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The category has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("product/formatlist")>
	</cffunction>
	
	<!--- section --->
	
	<cffunction name="sectionlist" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";

		event.setValue("title","Section Administration");
		
		// Setup products for navigation, sorted by most views
		rc.qSections = productService.getSections(orderby="views",orderasc=0);
		
		//Get the full listing of all products
		rc.qproducts = productService.getproducts();
		rc.title = "All Categories";
		// List by category if filter is present
		
		//Sorting Logic.
		if (event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			if (event.getValue("sortBy") IS "title" ){order = "asc";}
			rc.qproducts = getPlugin("queryHelper").sortQuery(rc.qproducts,rc.sortBy, order);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("product/sectionlist");
		</cfscript>
	</cffunction>
	
	<cffunction name="sectiondetails" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
			<cfscript>
				var rc = event.getCollection();
			
				// setup the page parameters
				rc.title = "Add Resource Category";
				if(event.valueExists("id")){
					rc.section = productService.getSection(val(event.getValue("id",0)));
				}else{
					rc.section = productService.createSection();
				}
				if(event.valueExists("id")){
					rc.title = "Edit Resource Category";
					rc.qRelatedproducts = productService.getProductsBySection(rc.section.getID());
				}
				// set view
				event.setView("product/sectiondetails");
				
			</cfscript>
	</cffunction>
	
	<cffunction name="saveSection" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var section = "">
		
		<cfscript>
			//get the Section object
			if(event.valueExists("id") AND event.getValue("id","") IS NOT 0){
				section = productService.getSection(event.getValue("id",0));
			}else{
				section = productService.createSection();
			}
	
			//Populate the bean
			getPlugin("beanFactory").populateBean(section);
			
			//Send to service for saving
			productService.saveSection(section);
		
			getPlugin("messagebox").setMessage("info","The category has been successfully saved");
			setNextRoute("product/sectiondetails/#section.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteSection" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset productService.deleteSection(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The category has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("product/sectionlist")>
	</cffunction>
    
    <!--- size --->
	
	<cffunction name="sizelist" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";

		
		
		event.setValue("title","Size Administration");
		
		// Setup products for navigation, sorted by most views
		rc.qsizes = productService.getsizes(orderby="id",orderasc=0);
		
		//Get the full listing of all products
		rc.qproducts = productService.getproducts();
		rc.title = "All Categories";
		// List by category if filter is present
		
		//Sorting Logic.
		if (event.getValue("sortBy","") neq "" ){
			//Sort via Query Helper.
			if (event.getValue("sortBy") IS "title" ){order = "asc";}
			rc.qproducts = getPlugin("queryHelper").sortQuery(rc.qproducts,rc.sortBy, order);
		}
		else{
			rc.sortBy = "";
		}

		//Set the view to render
		event.setView("product/sizelist");
		</cfscript>
	</cffunction>
	
	<cffunction name="sizedetails" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
			<cfscript>
				var rc = event.getCollection();
			
				// setup the page parameters
				rc.title = "Add Resource Size";
				if(event.valueExists("id")){
					rc.size = productService.getsize(val(event.getValue("id",0)));
				}else{
					rc.size = productService.createsize();
				}
				if(event.valueExists("id")){
					rc.title = "Edit Resource Category";
					rc.qRelatedproducts = productService.getProductsBysize(rc.size.getID());
				}
				// set view
				event.setView("product/sizedetails");
				
			</cfscript>
	</cffunction>
	
	<cffunction name="savesize" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var size = "">
		
		<cfscript>
			//get the size object
			if(event.valueExists("id") AND event.getValue("id","") IS NOT 0){
				size = productService.getsize(event.getValue("id",0));
			}else{
				size = productService.createsize();
			}
	
			//Populate the bean
			getPlugin("beanFactory").populateBean(size);
			
			//Send to service for saving
			productService.savesize(size);
		
			getPlugin("messagebox").setMessage("info","The category has been successfully saved");
			setNextRoute("product/sizedetails/#size.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="deletesize" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset productService.deletesize(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The category has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("product/sizelist")>
	</cffunction>
	
	<!--- Featured --->
	
	<cffunction name="featureddetails" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>
			var rc = event.getCollection();
		
			// setup the page parameters
			rc.title = "Schedule Featured Resource";
			rc.scripts ="calendar/calendar.js";
			
			rc.qproducts = productService.getproducts(islive=1);
			rc.featured = productService.getFeatured(val(event.getValue("id",0)));
			if(event.valueExists("id")){
				rc.title = "Edit Feature Schedule";
			}
			// set view
			event.setView("product/featureddetails");
			
		</cfscript>
	</cffunction>
	
	<cffunction name="featuredlist" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfscript>

		//Get request collection
		var rc = event.getCollection();
		var order = "desc";

		event.setValue("title","Section Administration");
		
		// Setup products for navigation, sorted by most views
		rc.qFeatured = productService.getFeaturedproducts();
		
		rc.title = "Complete Feature Schedule";
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
		event.setView("product/featuredlist");
		</cfscript>
	</cffunction>
	
	<cffunction name="saveFeatured" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var featured = "">
		<cfset var product = "">
		
		<cfscript>
			//get the Section object
			featured = productService.getFeatured(event.getValue("id",0));
			product = productService.getproduct(event.getValue("productid",0));
	
			//Populate the bean
			featured.setStart(event.getValue("start",dateformat(now(),"YYYY-MM-DD")));
			featured.setEnd(event.getValue("end",dateformat(now()+7,"YYYY-MM-DD")));
			featured.setproduct(product);
			//Send to service for saving
			productService.saveFeatured(featured);
		
			getPlugin("messagebox").setMessage("info","The featured schedule has been successfully saved");
			setNextRoute("product/featureddetails/#featured.getID()#");
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteFeatured" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfif event.valueExists("id") AND event.getValue("id") IS NOT "" AND event.getValue("id") NEQ 0>
			<cfset productService.deleteFeatured(event.getValue("id"))>
			<cfset getPlugin("messagebox").setMessage("info","The featured schedule has been completely deleted.")>
		</cfif>
		
		<cfset setNextRoute("product/featuredlist")>
	</cffunction>
	
</cfcomponent>