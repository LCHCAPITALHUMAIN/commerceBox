<cfoutput>#renderView("admin/viewlets/modulesidebar")#</cfoutput>
<div>
	<div class="outerbox">
		<div class="boxtab">
			<h2>Poll List</h2>
		</div>
		<div class="innerbox">
<cfoutput>
<div>
[<a href="#getSetting('sesBaseURL')#/#rc.xehEditor#">Add New Poll</a>]
</div>
<br/><br/>
#getPlugin("messagebox").renderit()#
</cfoutput>

<table width="70%" cellpadding="5" cellspacing="0">
	<cfoutput>
	<tr>
		<th><cfif rc.sortBy eq 'title'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=title&sortOrder=#rc.sortOrder#">Title</a></th>
		<th><cfif rc.sortBy eq 'islive'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=islive&sortOrder=#rc.sortOrder#">Published</a></th>
		<th><cfif rc.sortBy eq 'isfeatured'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=isfeatured&sortOrder=#rc.sortOrder#">Featured</a></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	</cfoutput>
	
	<cfoutput query="rc.qpoll">
		<td>#title#</td>	
		<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qPoll.islive NEQ 1>un</cfif>published.gif" /></td>	
		<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qPoll.isfeatured NEQ 1>un</cfif>published.gif" /></td>
		<td align="center"><a href="#getSetting('sesBaseURL')#/#rc.xehEditor#?id=#id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /> </a></td>
		<td align="center"><a href="#getSetting('sesBaseURL')#/#rc.xehDelete#?id=#id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
		
	</tr>
	</cfoutput>
</table>
<cfif rc.qpoll.recordcount eq 0>
<h3>No records found</h3>	
</cfif>
</div></div></div>