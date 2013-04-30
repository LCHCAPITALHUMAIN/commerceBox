<cfoutput>#renderView("article/sidebar")#</cfoutput>

<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab"><h2><cfoutput>#rc.title#</cfoutput></h2></div>
		<div class="innerbox">
			<div class="infobox"> 
				<cfoutput>
				<form name="sort" action="#getSetting("sesBaseURL")#/#event.getCurrentHandler()#/#event.getCurrentAction()#/#event.getValue("id","")#" id="sort" method="post">
					<label for="field">Sort Authors By:</label>
					<select name="sortBy" onChange="this.form.submit();">
						<option selected="selected" value="">Select</option>
						<option value="id">Latest</option>
						<option value="firstname">First Name</option>
						<option value="lastname">Last Name</option>
					</select>
					<noscript><input type="submit" name="submit" value="sort" /></noscript>
				</form>
				</cfoutput>
			</div>
			<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:500px;">Name</th>
				<th>Published</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
        <cfoutput query="rc.qAuthors">
			<tr>
				<td><a href="#event.buildLink(rc.xehAuthorDetail)#/#rc.qAuthors.id#" title="#rc.qAuthors.lastname#">#rc.qAuthors.lastname#, #rc.qAuthors.firstname#</a></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qAuthors.islive NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehAuthorDetail)#/#rc.qAuthors.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
				<td align="center"><a href="#event.buildLink(rc.xehAuthorDelete)#/#rc.qAuthors.id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehAuthorDetail)#" title="Add Article Author"><img src="/modules/admin/includes/images/add.gif" alt="Add Article Author" /></a> <a href="#event.buildLink(rc.xehAuthorDetail)#" title="Add Article Author">Add Article Author</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
		</div>
	</div>
</div>