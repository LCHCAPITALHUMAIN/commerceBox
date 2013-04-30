<cfoutput>#renderView("article/sidebar")#</cfoutput>

<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab">
			<h2><cfoutput>#rc.title#</cfoutput></h2>
		</div>
		<div id="article" class="innerbox">
			<cfoutput>#getPlugin("messagebox").renderIt()#</cfoutput>
			<table width="100%">
			<form name="editor_form" id="editor_form" action="<cfoutput>#Event.buildLink(rc.xehSectionSave)#</cfoutput>" method="post" >
				<input type="hidden" name="id" value="<cfoutput>#rc.section.getid()#</cfoutput>" />
				<tr><td>
				<label for="title"><em>*</em>Title:</label>
				</td></tr>
				<tr><td>
				<input id="title" name="title" type="text" value="<cfoutput>#rc.section.gettitle()#</cfoutput>" maxlength="75" size="60"  />
				</td></tr>
				<tr><td>									
				<label for="summary" class="block">Summary:</label>
				<textarea name="summary" style="width:99%; height:100px;" id="summary"><cfoutput>#rc.section.getsummary()#</cfoutput></textarea>
				</td></tr>
				<tr><td>
				<label for="views"><em>*</em>Views:</label><input id="views" name="views" type="text" value="<cfif rc.section.getID() NEQ 0><cfoutput>#rc.section.getviews()#</cfoutput><cfelse>0</cfif>" size="4"  />
				</td></tr>
				<tr><td>
				<label for="islive"><em>*</em>Publish:</label>
				<select name="islive" id="islive">
					<option value="1"<cfif isBoolean(rc.section.getIsLive()) and rc.section.getIsLive()> selected="selected"</cfif>>Yes</option>
					<option value="0"<cfif isBoolean(rc.section.getIsLive()) and not rc.section.getIsLive()> selected="selected"</cfif>>No</option>
				</select>
				</td></tr>
				<tr><td>
				<p><strong>*</strong> Indicates required field</p>
				<input type="submit" value="Save Section" class="" />
				</td></tr>
			</form>
			</table>
		</div>
	</div>
	<cfif structKeyExists(rc,"qRelatedArticles") AND rc.qRelatedArticles.recordcount NEQ 0>
		<div class="outerbox">
			<div class="boxtab">
				<h3>More Articles in this Category</h3>
			</div>
			<div id="related-articles" class="innerbox">
				<table width="100%" cellspacing="2" cellpadding="2">
					<tr>
						<th align="left">Title</th>
						<th>Published</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
				<cfoutput query="rc.qRelatedArticles">
					<cfif rc.qrelatedArticles.id NEQ rc.section.getID()>
					<tr>
						<td><a href="#event.buildLink(rc.xehDetail)#/#rc.qRelatedArticles.id#" title="#rc.qRelatedArticles.title#">#rc.qRelatedArticles.title#</a></td>
						<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qRelatedArticles.islive NEQ 1>un</cfif>published.gif" alt="Publish" /></td>
						<td align="center"><a href="#event.buildLink(rc.xehDetail)#/#rc.qRelatedArticles.id#"><img src="/modules/admin/includes/images/update.gif" alt="Update" width="16" height="16" title="Edit Record" /></a></td>
						<td align="center"><a href="#event.buildLink(rc.xehDelete)#/#rc.qRelatedArticles.id#"><img src="/modules/admin/includes/images/delete.gif" alt="Delete" width="16" height="16" title="Delete Record" /></a></td>
					</tr>
					</cfif>
					</cfoutput>
				</table>
			</div>
		</div>
	</cfif>
</div>