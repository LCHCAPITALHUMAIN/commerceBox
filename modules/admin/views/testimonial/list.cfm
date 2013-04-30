<cfoutput>#renderView(view="viewlets/modulesidebar",module="admin")#</cfoutput>
<div>
	<div class="outerbox">
		<div class="boxtab">
			<h2>Testimonial List</h2>
		</div>
		<div class="innerbox"><cfoutput>
<div>
[<a href="#event.buildLink(rc.xehEditor)#">Add New Testimonial</a>]
</div>
<br/><br/>
#getPlugin("messagebox").renderit()#
</cfoutput>

<table cellpadding="5" cellspacing="0" width="100%">
	<cfoutput>
	<tr>
		<th><cfif rc.sortBy eq 'author'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#event.buildLink(rc.xehList)#?sortBy=author&sortOrder=#rc.sortOrder#">author</a></th>
		<th><cfif rc.sortBy eq 'content'><cfif rc.sortOrder eq "asc">&##8249;<cfelse>&##8250;</cfif></cfif>
			<a href="#event.buildLink(rc.xehList)#?sortBy=content&sortOrder=#rc.sortOrder#">content</a></th>
		<th>Edit</th>
	</tr>
	</cfoutput>
	
	<cfoutput query="rc.qtestimonial">			
		<td>#author#</td>	
		<td>#left(content,70)# ...</td>
		<td align="center"><a href="#event.buildLink(rc.xehEditor)#/#id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
		
	</tr>
	</cfoutput>
</table>
<cfif rc.qtestimonial.recordcount eq 0>
<h3>No records found</h3>	
</cfif>
</div></div></div>