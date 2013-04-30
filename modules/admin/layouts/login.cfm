
<!---
	Description: ColdBox layout
	Author:		Aaron Roberson
	Created:	4/9/2008
--->

<!--- Initialize sensable defaults for controller includes --->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><cfoutput>#Event.getValue('title', "#getController().getSetting("siteName")# Administration")#</cfoutput></title>
	<meta name="description" content="<cfoutput>#Event.getValue("description","")#</cfoutput>" />
	<meta name="keywords" content="<cfoutput>#Event.getValue("keywords","")#</cfoutput>" />
	<meta name="revisit-after" content="<cfoutput>#Event.getValue("revisit","15 days")#</cfoutput>" />
	<meta name="copyright" content="<cfoutput>#getController().getSetting("siteName")#</cfoutput> Copyright <cfoutput>#year(Now())#</cfoutput>. Limited non-commercial duplication and distribution permitted. All rights reserved." />
	<link href="/favicon.ico" rel="shortcut icon" type="image/ico" />
	<cfinclude template="/includes/controllers/styles.cfm" />
	<link href="/includes/styles/tags.css" rel="stylesheet" type="text/css" />
	<link href="/includes/styles/layout.css" rel="stylesheet" type="text/css" />
    <link href="/includes/styles/print.css" rel="stylesheet" type="text/css" media="print" />
	
    <!--[if IE]>
    <style type="text/css">
		.boxtab h2,.boxtab h3{float:left;margin-top:-2px;display:block;background-position:2px right;}
	</style>
    <![endif]-->
	
	<cfinclude template="/includes/controllers/scripts.cfm" />
	<script src="/includes/scripts/swfobject.js" type="text/javascript"></script>
</head>

<body>
<div id="wrapper">
    <div id="header">
       <cfoutput><h1><a href="#getSetting("sesBaseURL")#" title="Return to #getController().getSetting("sitename")# home page"><img src="/includes/images/logo.png" alt="#getController().getSetting("siteName")#" /></a></h1></cfoutput>
        <p class="tagline"><cfoutput>#getController().getSetting("tagLine")#</cfoutput></p>
    </div>
    <div id="content">
        <cfoutput>#renderView()#</cfoutput>
    </div>
    <div id="footer">
        <div id="footer">
        <span class="copyright">Copyright &copy; <cfoutput>#year(Now())# #getController().getSetting("siteName")#</cfoutput>. All Rights Reserved.</span>
    </div>
    <div id="utilities"></div>
    </div>
</div>
</body>
</html>