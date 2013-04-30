<!---
File: scripts.cfm
Description: Dynamic controller for javascripts
Author:	AAR
Created:	4/12/2006
Updates:
3/27/2007 - Changed to no longer require extention
--->

<!---Define the loop --->
<cfloop list=#Event.getValue('scripts',"")# index="i" delimiters=",">
	<!--- include an element from the list --->
	<script src="/includes/scripts/<cfoutput>#i#</cfoutput>" type="text/javascript"></script>
</cfloop>