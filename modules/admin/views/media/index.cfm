  <div class="outerbox">
    <div class="boxtab">
      <h3>Streams By Resource</h3>
    </div>
    <div class="innerbox">
		<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:600px;">Title</th>
				<th>Published</th>
				<th>Update</th>
			</tr>
        <cfoutput query="rc.qProducts">
			<tr>
				<td><a href="#event.buildLink(rc.xehDetail)#/#rc.qProducts.id#" title="#rc.qProducts.title#">#rc.qProducts.title#</a></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qProducts.islive NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehDetail)#/#rc.qProducts.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehDetail)#" title="Add Resource"><img src="/modules/admin/includes/images/add.gif" alt="Add Resource" /></a> <a href="#event.buildLink(rc.xehDetail)#" title="Add Product">Add Resource</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
    </div>
  </div>
  </div>