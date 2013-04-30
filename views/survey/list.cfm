<div>
	<div class="outerbox">
		<div class="boxtab">
			<h2>Survey List</h2>
		</div>
		<div class="innerbox">
<cfoutput>
<div>
[<a href="#event.buildLink(rc.xehEditor)#">Add New Survey</a>]
</div>
<br/><br/>
#getPlugin("messagebox").renderit()#
</cfoutput>

<cfif rc.qsurvey.recordcount eq 0>
<h3>No surveys currently exist. Please <a href="#event.buildLink(rc.xehEditor)#">create a survey</a> to begin.</h3>
<cfelse>
<table width="70%" cellpadding="5" cellspacing="0">
	<cfoutput>
	<tr>
		<th><cfif rc.sortBy eq 'title'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=title&sortOrder=#rc.sortOrder#">Title</a></th>
       	<th><cfif rc.sortBy eq 'datebegin'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=datebegin&sortOrder=#rc.sortOrder#">Date Begin</a></th>
		<th><cfif rc.sortBy eq 'dateend'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=dateend&sortOrder=#rc.sortOrder#">Date End</a></th>
		<th><cfif rc.sortBy eq 'islive'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=islive&sortOrder=#rc.sortOrder#">Published</a></th>
		<th><cfif rc.sortBy eq 'isfeatured'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=isfeatured&sortOrder=#rc.sortOrder#">Featured</a></th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	</cfoutput>
	
	<cfoutput query="rc.qsurvey">
		<td><a href="#getSetting('sesBaseURL')#/#rc.xehEditor#/#id#">#title#</a></td>
        <td align="center">#dateFormat(rc.qsurvey.datebegin,"YYYY-MM-DD")#</td>	
		<td align="center">#dateFormat(rc.qsurvey.dateend,"YYYY-MM-DD")#</td>	
		<td align="center"><img src="/admin/includes/images/<cfif rc.qsurvey.islive NEQ 1>un</cfif>published.gif" /></td>	
		<td align="center"><img src="/admin/includes/images/<cfif rc.qsurvey.isfeatured NEQ 1>un</cfif>published.gif" /></td>
		<td align="center"><a href="#getSetting('sesBaseURL')#/#rc.xehEditor#?id=#id#"><img src="/admin/includes/images/update.gif" title="Edit Survey" width="16" height="16" /> </a></td>
		<td align="center"><a href="#getSetting('sesBaseURL')#/#rc.xehDelete#?id=#id#"><img src="/admin/includes/images/delete.gif" title="Delete Survey" width="16" height="16" /></a></td>
		
	</tr>
	</cfoutput>
</table>	
</cfif>
</div></div></div>