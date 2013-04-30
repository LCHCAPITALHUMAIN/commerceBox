<cfoutput>#renderView(view="viewlets/modulesidebar",module="admin")#</cfoutput>
<div>
	<div class="outerbox">
		<div class="boxtab">
			<h2>Quote Editor :
				<cfif rc.quote.getid() eq 0 >
					Add
					<cfelse>
					Edit
				</cfif>
				Record</h2>
		</div>
		<div class="innerbox"><cfoutput>
				<div> [<a href="#event.buildLink(rc.xehList)#">Back To Listing</a>] </div>
				<br/>
				#getPlugin("messagebox").renderit()#
			</cfoutput><cfoutput>
				<form name="editor_form" id="editor_form" action="#event.buildLink(rc.xehSave)#" method="post" >
					<input type="hidden" name="id" value="#rc.quote.getid()#" />
					<ul class="formLayout">
						<li>
							<label for="author"><em>*</em>Author:</label>
							<input id="author" name="author" type="text" value="#rc.quote.getauthor()#" maxlength="75" size="40" />
						</li>
						<li>
							<label for="content"><em>*</em>Content:</label>
							<textarea id="content" name="content" cols="60" rows="3" style="width:99%">#rc.quote.getcontent()#</textarea>
						</li>
					</ul>
					<br/>
					<div><strong>*</strong> Indicates required field</div>
					<br/>
					<div>
						<input type="submit" value="Submit" class="" />
					</div>
				</form>
			</cfoutput></div>
	</div>
</div>
