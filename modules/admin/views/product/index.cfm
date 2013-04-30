<cfoutput>#renderView(view="viewlets/prodsidebar",module="admin")#</cfoutput>

<div class="column-w573 left">
  <div class="outerbox">
    <div class="boxtab">
      <h3>Resources</h3>
    </div>
    <div class="innerbox">
		<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:600px;">Title</th>
				<th>Published</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
        <cfoutput query="rc.qProducts">
			<tr>
				<td><a href="#event.buildLink(rc.xehDetail)#/#rc.qProducts.id#" title="#rc.qProducts.title#">#rc.qProducts.title#</a></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qProducts.islive NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehDetail)#/#rc.qProducts.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
				<td align="center"><a href="#event.buildLink(rc.xehDelete)#/#rc.qProducts.id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehDetail)#" title="Add Resource"><img src="/modules/admin/includes/images/add.gif" alt="Add Resource" /></a> <a href="#event.buildLink(rc.xehDetail)#" title="Add Product">Add Resource</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
    </div>
  </div>
  <!--- Formats --->
  <div class="outerbox">
    <div class="boxtab">
      <h3>Resource Colors</h3>
    </div>
    <div class="innerbox">
		<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:600px;">Title</th>
				<th>Published</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
        <cfoutput query="rc.qFormats">
			<tr>
				<td><a href="#event.buildLink(rc.xehFormatDetail)#/#rc.qFormats.id#" title="#rc.qFormats.title#">#rc.qFormats.title#</a></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qFormats.islive NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehFormatDetail)#/#rc.qFormats.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
				<td align="center"><a href="#event.buildLink(rc.xehFormatDelete)#/#rc.qFormats.id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehFormatDetail)#" title="Add Resource Format"><img src="/modules/admin/includes/images/add.gif" alt="Add Product Category" /></a> <a href="#event.buildLink(rc.xehFormatDetail)#" title="Add Resource Format">Add Resource Color</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
    </div>
  </div>
  <!--- Sections --->
  <div class="outerbox">
    <div class="boxtab">
      <h3>Resource Categories</h3>
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
			<tr><td><a href="#event.buildLink(rc.xehSectionDetail)#" title="Add Resource Category"><img src="/modules/admin/includes/images/add.gif" alt="Add Product Category" /></a> <a href="#event.buildLink(rc.xehSectionDetail)#" title="Add Resource Category">Add Resource Category</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
    </div>
  </div>
  <!--- Featured --->
  <div class="outerbox">
    <div class="boxtab">
      <h3>Featured Resources</h3>
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
			<tr><td><a href="#event.buildLink(rc.xehFeaturedDetail)#" title="Add Featured Resource"><img src="/modules/admin/includes/images/add.gif" alt="Add Featured Resource" /></a> <a href="#event.buildLink(rc.xehFeaturedDetail)#" title="Add Featured Resource">Add Featured Resource</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
    </div>
  </div>
</div>