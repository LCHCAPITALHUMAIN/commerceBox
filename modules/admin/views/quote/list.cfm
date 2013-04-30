<cfoutput>#renderView(view="viewlets/modulesidebar",module="admin")#
<div>
	<div class="outerbox">
		<div class="boxtab">
			<h2>Quote List</h2>
		</div>
		<div class="innerbox">


<div>
[<a href="#event.buildLink(rc.xehEditor)#">Add New Quote</a>]
</div>
<br/><br/>
#getPlugin("messagebox").renderit()#

<table width="100%" cellpadding="5" cellspacing="0">
	
	<tr>
<th><cfif rc.sortBy eq 'author'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=author&sortOrder=#rc.sortOrder#">Author</a></th>
		<th><cfif rc.sortBy eq 'content'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#rc.xehList#?sortBy=content&sortOrder=#rc.sortOrder#">Content</a></th>
		<th>Edit</th>
	</tr>
	</cfoutput>
	
	<cfoutput query="rc.qquote">
	<tr <cfif currentrow mod 2 eq 0>class="even"</cfif>>
<td>#author#</td>	
		<td>#left(content,65)# ...</td>
		<td align="center"><a href="#event.buildLink(rc.xehEditor)#/#id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /> </a></td>
		
	</tr>
	</cfoutput>
</table>
<cfif rc.qquote.recordcount eq 0>
<h3>No records found</h3>	
</cfif>
</div></div></div>