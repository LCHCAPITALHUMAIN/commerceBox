<cfoutput>#renderView(view="viewlets/prodsidebar",module="admin")#</cfoutput>

<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab"><h2><cfoutput>#rc.title#</cfoutput></h2></div>
		<div class="innerbox">
			<cfoutput>#getPlugin("messagebox").renderit()#</cfoutput>
			<div>
				<div class="infobox"> 
					<cfoutput>
					<form id="sorter" name="sorter" action="#getSetting("sesBaseURL")#/#event.getCurrentHandler()#/#event.getCurrentAction()#/<cfif event.valueExists("filter")>#event.getValue("filter")#</cfif>/<cfif event.valueExists("id")>#event.getValue("id")#</cfif>" method="post">
						<label for="field">Sort Resources by:</label>
						<select name="sortBy" onChange="this.form.submit();">
							<option value="">Select</option>
							<option value="id">Latest</option>
							<option value="views">Popularity</option>
						</select>
						<noscript>
						<input type="submit" name="submit" value="sort" />
						</noscript>
					</form>
					</cfoutput>
				</div>
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
			<tr><td><a href="#event.buildLink(rc.xehDetail)#" title="Add Product"><img src="/modules/admin/includes/images/add.gif" alt="Add Product" /></a> <a href="#event.buildLink(rc.xehDetail)#" title="Add Product">Add Product</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
				</div>
		</div>
	</div>
</div>
