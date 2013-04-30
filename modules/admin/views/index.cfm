<cfoutput>#renderView(view="viewlets/modulesidebar",module="admin")#</cfoutput>

<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab">
			<h3>Testimonials</h3>
		</div>
		<div class="innerbox">
			<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:400px;">Content</th>
				<th>Author</th>
				<th>Update</th>
			</tr>
			<cfoutput query="rc.qTestimonials">
			<tr>
				<td>#left(rc.qTestimonials.content,50)# ...</td>
				<td>#rc.qTestimonials.author#</td>
				<td align="center"><a href="#event.buildLink(rc.xehTestimonialDetail)#/#rc.qtestimonials.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehTestimonialDetail)#" title="Add Testimony"><img src="/modules/admin/includes/images/add.gif" alt="Add Testimony" /></a> <a href="#event.buildLink(rc.xehTestimonialDetail)#" title="Add Testimony">Add Testimony</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
		</div>
	</div>
	<div class="outerbox">
		<div class="boxtab">
			<h3>Quotes</h3>
		</div>
		<div class="innerbox">
			<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:310px;">Content</th>
				<th>Author</th>
				<th>Update</th>
			</tr>
			<cfoutput query="rc.qQuotes">
			<tr>
				<td>#left(rc.qQuotes.content,35)# ...</td>
				<td>#rc.qQuotes.author#</td>
				<td align="center"><a href="#event.buildLink(rc.xehQuoteDetail)#/#rc.qQuotes.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehQuoteDetail)#" title="Add Quote"><img src="/modules/admin/includes/images/add.gif" alt="Add Quote" /></a> <a href="#event.buildLink(rc.xehQuoteDetail)#" title="Add Quote">Add Quote</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
		</div>
	</div>
	<div class="outerbox">
		<div class="boxtab">
			<h3>Polls</h3>
		</div>
		<div class="innerbox">
			<table width="100%" cellspacing="2" cellpadding="2">
			<tr>
				<th align="left" style="width:600px;">Title</th>
				<th>Published</th>
				<th>Featured</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
        <cfoutput query="rc.qPolls">
			<tr>
				<td><a href="#event.buildLink(rc.xehPollDetail)#/#rc.qPolls.id#" title="#rc.qPolls.title#">#rc.qPolls.title#</a></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qPolls.islive NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><img src="/modules/admin/includes/images/<cfif rc.qPolls.isfeatured NEQ 1>un</cfif>published.gif" /></td>
				<td align="center"><a href="#event.buildLink(rc.xehPollDetail)#/#rc.qPolls.id#"><img src="/modules/admin/includes/images/update.gif" title="Edit Record" width="16" height="16" /></a></td>
				<td align="center"><a href="#event.buildLink(rc.xehPollDelete)#/#rc.qPolls.id#"><img src="/modules/admin/includes/images/delete.gif" title="Delete Record" width="16" height="16" /></a></td>
			</tr>
			</cfoutput>
			<cfoutput>
			<tr><td><a href="#event.buildLink(rc.xehPollDetail)#" title="Add Poll"><img src="/modules/admin/includes/images/add.gif" alt="Add Poll" /></a> <a href="#event.buildLink(rc.xehPollDetail)#" title="Add Poll">Add Poll</a></td>
			<td colspan="3"></td></tr>
			</cfoutput>
		</table>
		</div>
	</div>
</div>