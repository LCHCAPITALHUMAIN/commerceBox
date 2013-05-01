<cfcomponent name="viewlet" extends="coldbox.system.eventhandler" output="false">
	
    <cfproperty name="productService" inject="model" />
    <cfproperty name="articleService" inject="model" />
    <cfproperty name="pollService" inject="model" />
    <cfproperty name="announcementService" inject="model" />
    <cfproperty name="testimonialService" inject="model" />
    <cfproperty name="quoteService" inject="model" />
    <cfproperty name="tabService" inject="model" />
    
	<cffunction name="init" access="public" returntype="viewlet" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
    
    <cffunction name="prepareSiteNav" output="false" returntype="void" access="private">
      <cfargument name="event">
      <cfscript>
	  		var rc = event.getCollection();
			rc.tabService = tabService;
      		rc.tabs = entityToQuery(rc.tabService.getTabs());
			rc.qProductSections = entityToQuery(productService.getSections(orderby="views",orderasc=0));
			rc.qArticleSections = entityToQuery(articleService.getSections(orderby="views",orderasc=0));
      </cfscript>
	</cffunction>
	
    <cffunction name="prepareProdNav" output="false" returntype="void" access="private">
      <cfargument name="event">
      <cfscript>
	  		var rc = event.getCollection();
      		rc.qSizes = productService.getSizes(islive=1,orderby="id", orderasc=1);
			rc.qSections = productService.getSections(islive=1,orderby="views", orderasc=0);
			rc.qFormats = productService.getFormats(islive=1);
      </cfscript>
	</cffunction>
    
    <cffunction name="prepareFeaturedPoll" output="false" returntype="void" access="private">
      <cfargument name="event">
      <cfscript>
	  		var rc = event.getCollection();
			// ---- Setup Poll ---- //
      		var featuredPoll = pollService.getPolls(isfeatured=1);
			if(featuredPoll.recordcount){
				rc.poll = pollService.getPoll(featuredPoll.id);
				rc.options = rc.poll.getOptionArray();
			}
      </cfscript>
	</cffunction>
    
    <cffunction name="prepareAnnouncement" output="false" returntype="void" access="private">
      <cfargument name="event">
      <cfscript>
	  		var rc = event.getCollection();
			// ---- Setup Announcements ---- //
			rc.announcements = announcementService.getannouncements(orderby="id", orderasc=0);
      </cfscript>
	</cffunction>
    
    <cffunction name="prepareRandomTestimonial" output="false" returntype="void" access="private">
      <cfargument name="event">
      <cfscript>
	  		var rc = event.getCollection();
			// ---- Setup Random Testimonial ---- //
			rc.randomTestimonial = testimonialService.getRandomTestimonial();
      </cfscript>
	</cffunction>
    
    <cffunction name="prepareRandomQuote" output="false" returntype="void" access="private">
      <cfargument name="event">
      <cfscript>
	  		var rc = event.getCollection();
			// ---- Setup Random Testimonial ---- //
			rc.randomQuote = quoteService.getRandomQuote();
      </cfscript>
	</cffunction>
    
    <cffunction name="prepareQuickCart" output="false" returntype="void" access="private">
      <cfargument name="event">
      <cfscript>
    	var rc = event.getCollection();
        rc.gCart = getPlugin("sessionstorage").getVar("gCart");;
		rc.gCartItems = rc.gCart.getCartItems();
      </cfscript>
    </cffunction>

</cfcomponent>