<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	10/16/2007
Description :
	This file is used by the BeanFactory plugin to read off model mappings.
	This is a great place to alias model paths into names so when you 
	refactor you can easily do this.
	
	All you need to do is call one method: addModelMapping(alias,path)
	
	Alias : The alias to create
	Path : The model class path to alias.
	
	Example:
	
	addModelMapping('FormBean',"security.test.FormBean");
	
----------------------------------------------------------------------->
<cfscript>
	
	addModelMapping(alias="announcementService",path="announcementService");
	addModelMapping(alias="articleService",path="articleService");
	addModelMapping(alias="articleService",path="articleService");
	addModelMapping(alias="newsletterService",path="newsletterService");
	addModelMapping(alias="pollService",path="pollService");
	addModelMapping(alias="productService",path="productService");
	addModelMapping(alias="surveyService",path="surveyService");
	addModelMapping(alias="tabService",path="tabService");
	addModelMapping(alias="testimonialService",path="testimonialService");
	addModelMapping(alias="userService",path="userService");
	addModelMapping(alias="quoteService",path="quoteService");
	
</cfscript>