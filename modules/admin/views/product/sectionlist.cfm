<cfoutput>#renderView(view="viewlets/prodsidebar",module="admin")#</cfoutput>

<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab"><h2><cfoutput>#rc.title#</cfoutput></h2></div>
		<div class="innerbox">
			<div class="infobox"> 
				<cfoutput>
				<form name="sort" action="#getSetting("sesBaseURL")#/#event.getCurrentHandler()#/#event.getCurrentAction()#/#event.getValue("id","")#" id="sort" method="post">
					<label for="field">Sort Categories By:</label>
					<select name="sortBy" onChange="this.form.submit();">
						<option selected="selected" value="">Select</option>
						<option value="id">Latest</option>
						<option value="title">Title</option>
						<option value="views">Popularity</option>
					</select>
					<noscript><input type="submit" name="submit" value="sort" /></noscript>
				</form>
				</cfoutput>
			</div>
			<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:500px;">Title</th>
				<th>Views</th>
				<th>Published</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
        <cfoutput query="rc.qSections">
			<tr>
				<td><a href="#event.buildLink(rc.xehSectionDetail)#/#rc.qSections.id#" title="#rc.qSections.title#">#rc.qSections.title#</a></td>
				<td align="center">#rc.qSections.views#</td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qSections.islive NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehSectionDetail)#/#rc.qSections.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
				<td align="center"><a href="#event.buildLink(rc.xehSectionDelete)#/#rc.qSections.id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehSectionDetail)#" title="Add product Category"><img src="/modules/admin/includes/images/add.gif" alt="Add product Category" /></a> <a href="#event.buildLink(rc.xehSectionDetail)#" title="Add product Category">Add product Category</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
		</div>
	</div>
</div>