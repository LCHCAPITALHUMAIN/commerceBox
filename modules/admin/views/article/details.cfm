<cfscript>
	basePath = "/admin/includes/fckeditor/" ;
	fckEditor = createObject( "component", "admin.includes.fckeditor.fckeditor" ) ;
	fckEditor.instanceName	= "content" ;
	fckEditor.value			= '#rc.article.getcontent()#' ;
	fckEditor.basePath		= #basePath# ;
	fckEditor.height		= '500';
	fckEditor.width			= '100%';
	fckEditor.config['SkinPath'] = basePath & 'editor/skins/silver/';
</cfscript>
<cfoutput>#renderView("article/sidebar")#</cfoutput>

<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab">
			<h2><cfoutput>#rc.title#</cfoutput></h2>
		</div>
		<div id="article" class="innerbox">
			<cfoutput>#getPlugin("messagebox").renderIt()#</cfoutput>
			<table width="100%">
			<form name="editor_form" id="editor_form" action="<cfoutput>#Event.buildLink(rc.xehSave)#</cfoutput>" method="post" >
				<input type="hidden" name="id" value="<cfoutput>#rc.article.getid()#</cfoutput>" />
				<tr><td>
				<label for="title"><em>*</em>Title:</label>
				</td></tr>
				<tr><td>
				<input id="title" name="title" type="text" value="<cfoutput>#rc.article.gettitle()#</cfoutput>" maxlength="75" size="60"  />
				</td></tr>
				<tr><td>									
				<label for="summary" class="block">Summary:</label>
				<textarea name="summary" style="width:99%; height:100px;" id="summary"><cfoutput>#rc.article.getsummary()#</cfoutput></textarea>
				</td></tr>
				<tr><td>
				<label for="content" class="block">Content:</label>
				<cfoutput>#fckEditor.create()#</cfoutput>
				</td></tr>
				<tr><td>
				<label for="sectionid"><em>*</em>Section:</label>
				<select id="sectionid" name="sectionid">
					<cfoutput query="rc.qSections">
						<option value="#rc.qSections.id#"<cfif rc.Section.getID() EQ rc.qSections.id> selected="selected"</cfif>>#rc.qSections.title#</option>
					</cfoutput>
				</select>
				</td></tr>
				<tr><td>
				<label for="authorid"><em>*</em>Author:</label>
				<select id="authorid" name="authorid">
					<cfoutput query="rc.qAuthors">
						<option value="#rc.qAuthors.id#"<cfif rc.Author.getID() EQ rc.qAuthors.id> selected="selected"</cfif>>#rc.qAuthors.firstname# #rc.qAuthors.lastname#</option>
					</cfoutput>
				</select>
				</td></tr>
				<tr><td>
				<label for="productid" style="float:left"><em>*</em>Related Resources:</label>
				</td></tr>
				<tr><td>
				<select name="productid" size="5" multiple="multiple" id="productid">
					<cfoutput query="rc.qProducts">
						<option value="#rc.qProducts.id#"<cfif listFind(rc.lproducts,rc.qProducts.id)> selected="selected"</cfif>>#rc.qProducts.title#</option>
					</cfoutput>
				</select>
				</td></tr>
				<tr><td>
				<label for="views"><em>*</em>Views:</label><input id="views" name="views" type="text" value="<cfoutput>#rc.article.getviews()#</cfoutput>" size="4"  />
				</td></tr>
				<tr><td>
				<label for="islive"><em>*</em>Publish:</label>
				<select name="islive" id="islive">
					<option value="1"<cfif isBoolean(rc.article.getIsLive()) and rc.article.getIsLive()> selected="selected"</cfif>>Yes</option>
					<option value="0"<cfif isBoolean(rc.article.getIsLive()) and not rc.article.getIsLive()> selected="selected"</cfif>>No</option>
				</select>
				</td></tr>
				<tr><td>
				<p><strong>*</strong> Indicates required field</p>
				<input type="submit" value="Save Article" class="" />
				</td></tr>
			</form>
			</table>
		</div>
	</div>
	<cfif structKeyExists(rc,"qRelatedArticles")>
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
					<cfif rc.qrelatedArticles.id NEQ rc.article.getID()>
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