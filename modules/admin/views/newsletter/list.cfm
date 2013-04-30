<cfoutput>#renderView(view="viewlets/modulesidebar",module="admin")#</cfoutput>
<div class="outerbox">
	<div class="boxtab">
		<h2>Newsletter Subscribers</h2>
	</div>
	<div class="innerbox">
<cfoutput>
<div>
[<a href="#event.buildLink(rc.xehEditor)#">Add Newsletter Subscriber</a>]
</div>
<br/><br/>
#getPlugin("messagebox").renderit()#
</cfoutput>

<table cellpadding="5" cellspacing="0">
	<cfoutput>
	<tr>
		<th><cfif rc.sortBy eq 'email'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=email&sortOrder=#rc.sortOrder#">Email</a></th>
		<th><cfif rc.sortBy eq 'date'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=date&sortOrder=#rc.sortOrder#">Date</a></th>
		<th><cfif rc.sortBy eq 'islive'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=islive&sortOrder=#rc.sortOrder#">Published</a></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	</cfoutput>
	
	<cfoutput query="rc.qnewsletter">
		<td>#email#</td>	
		<td>#dateFormat(date,"YYYY-MM-DD")#</td>	
		<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qnewsletter.islive NEQ 1>un</cfif>published.gif" /></td>
		<td align="center"><a href="#event.buildLink(rc.xehEditor)#/#id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /> </a></td>
		<td align="center"><a href="#event.buildLink(rc.xehDelete)#/#id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
	</tr>
	</cfoutput>
</table>
<cfif rc.qnewsletter.recordcount eq 0>
<h3>No records found</h3>	
</cfif>
</div></div>