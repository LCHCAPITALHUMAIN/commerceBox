<cfcomponent name="viewlet" extends="coldbox.system.eventhandler" output="false" autowire="true">
	<cfproperty name="productService" inject="model" />
    
	<cffunction name="init" access="public" returntype="viewlet" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
    
    <cffunction name="prepareSiteNav" output="false" returntype="void" access="private">
      <cfargument name="Event" >
      <cfscript>
	  		var rc = event.getCollection();
			rc.tabService = getModel("tabService");
      		rc.tabs = rc.tabService.getTabs();
			rc.qProductSections = getModel("productService").getSections(orderby="views",orderasc=0);
			rc.qArticleSections = getModel("articleService").getSections(orderby="views",orderasc=0);
			//event.setView(view="viewlet/sitenav",module="admin");
      </cfscript>
	</cffunction>
	
    <cffunction name="prepareProdSideBar" output="false" returntype="void" access="private">
      <cfargument name="Event" >
      <cfscript>
	  		var rc = event.getCollection();
      		// product exit handlers
			rc.xehList = "admin/product/list";
			rc.xehDetail = "admin/product/details";
			rc.xehSave = "admin/product/save";
			rc.xehDelete = "admin/product/delete";
			// format exit handlers
			rc.xehFormatList = "admin/product/formatList";
			rc.xehFormatDetail = "admin/product/formatDetails";
			rc.xehFormatSave = "admin/product/saveFormat";
			rc.xehFormatDelete = "admin/product/deleteFormat";
			// section exit handlers
			rc.xehSectionList = "admin/product/sectionList";
			rc.xehSectionDetail = "admin/product/sectionDetails";
			rc.xehSectionSave = "admin/product/saveSection";
			rc.xehSectionDelete = "admin/product/deleteSection";
			// featured exit handlers
			rc.xehFeaturedList = "admin/product/featuredList";
			rc.xehFeaturedDetail = "admin/product/featuredDetails";
			rc.xehFeaturedSave = "admin/product/saveFeatured";
			rc.xehFeaturedDelete = "admin/product/deleteFeatured";
      </cfscript>
	</cffunction>
    
    <cffunction name="prepareModuleSideBar" output="false" returntype="void" access="private">
      <cfargument name="Event" >
      <cfscript>
	  		var rc = event.getCollection();
      		rc.xehTestimonialDetail = "admin/testimonial/details";
			rc.xehTestimonialList = "admin/testimonial/list";
			rc.xehQuoteDetail = "admin/quote/details";
			rc.xehQuoteList = "admin/quote/list";
			rc.xehSubscriberDetail = "admin/newsletter/details";
			rc.xehSubscriberList = "admin/newsletter/list";
			rc.xehPollDetail = "admin/poll/details";
			rc.xehPollList = "admin/poll/list";
			rc.xehPollDelete = "admin/poll/delete";
			rc.xehSave = "admin/main/save";
      </cfscript>
	</cffunction>
</cfcomponent>