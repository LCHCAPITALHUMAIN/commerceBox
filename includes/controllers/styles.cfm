<!---
File: styles.cfm
Description: Dynamic controller for css styles
Author: AAR
Created: 2/12/2006
Updates:
3/27/2007 - Changed to not require extention
--->

<!---Define the loop --->
<cfloop list=#Event.getValue('styles',"")# index="i" delimiters=",">
	<!--- Write the style declaration, using an element from the list --->
	<link href="/includes/styles/<cfoutput>#i#</cfoutput>" rel="stylesheet" type="text/css" media="screen" />
</cfloop>