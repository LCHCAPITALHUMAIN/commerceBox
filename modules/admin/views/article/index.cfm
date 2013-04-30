<cfoutput>#renderView("article/sidebar")#</cfoutput>

<div class="column-w573 left">
  <div class="outerbox">
    <div class="boxtab">
      <h3>Articles</h3>
    </div>
    <div class="innerbox">
		<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:600px;">Title</th>
				<th>Published</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
        <cfoutput query="rc.articles">
			<tr>
				<td><a href="#event.buildLink(rc.xehDetail)#/#rc.articles.id#" title="#rc.articles.title#">#rc.articles.title#</a></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.articles.islive NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehDetail)#/#rc.articles.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
				<td align="center"><a href="#event.buildLink(rc.xehDelete)#/#rc.articles.id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehDetail)#" title="Add Article"><img src="/modules/admin/includes/images/add.gif" alt="Add Article" /></a> <a href="#event.buildLink(rc.xehDetail)#" title="Add Article">Add Article</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
    </div>
  </div>
  <!--- Sections --->
  <div class="outerbox">
    <div class="boxtab">
      <h3>Article Categories</h3>
    </div>
    <div class="innerbox">
		<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:600px;">Title</th>
				<th>Published</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
        <cfoutput query="rc.qSections">
			<tr>
				<td><a href="#event.buildLink(rc.xehSectionDetail)#/#rc.qSections.id#" title="#rc.qSections.title#">#rc.qSections.title#</a></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qSections.islive NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehSectionDetail)#/#rc.qSections.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
				<td align="center"><a href="#event.buildLink(rc.xehSectionDelete)#/#rc.qSections.id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehSectionDetail)#" title="Add Article Category"><img src="/modules/admin/includes/images/add.gif" alt="Add Article Category" /></a> <a href="#event.buildLink(rc.xehSectionDetail)#" title="Add Article Category">Add Article Category</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
    </div>
  </div>
  <!--- Authors --->
  <div class="outerbox">
    <div class="boxtab">
      <h3>Article Authors</h3>
    </div>
    <div class="innerbox">
		<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:600px;">Name</th>
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
  <!--- Featured --->
  <div class="outerbox">
    <div class="boxtab">
      <h3>Featured Articles</h3>
    </div>
    <div class="innerbox">
		<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:600px;">Title</th>
				<th>Current</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
        <cfoutput query="rc.qFeatured">
			<tr>
				<td><a href="#event.buildLink(rc.xehFeaturedDetail)#/#rc.qFeatured.fid#" title="#rc.qFeatured.title#">#rc.qFeatured.title#</a></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qFeatured.start LT dateformat(now(),"yyy-mm-dd") AND rc.qFeatured.end GT dateformat(now(),"yyy-mm-dd")>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehFeaturedDetail)#/#rc.qFeatured.fid#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
				<td align="center"><a href="#event.buildLink(rc.xehFeaturedDelete)#/#rc.qFeatured.fid#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehFeaturedDetail)#" title="Add Featured Article"><img src="/modules/admin/includes/images/add.gif" alt="Add Featured Article" /></a> <a href="#event.buildLink(rc.xehFeaturedDetail)#" title="Add Featured Article">Add Featured Article</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
    </div>
  </div>
</div>