<!---
File: sidebar.cfm
Description: Sidebar controller for various sections of the site
Author: AAR
Created:	4/12/2006
--->

<!---Define the loop --->
<cfloop list=#Event.getValue('sidebar',""))# index="i" delimiters=",">
	<!--- include the sidebar using an element from the list --->
	<cfinclude template="#request.root#inc/sidebar/#i#">
</cfloop>