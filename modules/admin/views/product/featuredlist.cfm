<cfoutput>#renderView(view="viewlets/prodsidebar",module="admin")#</cfoutput>

<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab"><h2><cfoutput>#rc.title#</cfoutput></h2></div>
		<div class="innerbox">
			<div class="infobox"> 
				<cfoutput>
				<form name="sort" action="#getSetting("sesBaseURL")#/#event.getCurrentHandler()#/#event.getCurrentAction()#/#event.getValue("id","")#" id="sort" method="post">
					<label for="field">Sort Featured Schedule By:</label>
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
			<tr>
			<td><a href="#event.buildLink(rc.xehFeaturedDetail)#" title="Add Featured product"><img src="/modules/admin/includes/images/add.gif" alt="Add Featured product" /></a> <a href="#event.buildLink(rc.xehFeaturedDetail)#" title="Add Featured product">Add Featured Resource</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
		</div>
	</div>
</div>