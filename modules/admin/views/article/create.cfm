<cfscript>
	basePath = "/admin/includes/fckeditor/" ;
	fckEditor = createObject( "component", "admin.includes.fckeditor.fckeditor" ) ;
	fckEditor.instanceName	= "content" ;
	fckEditor.value			= '' ;
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
				<input type="hidden" name="id" value="0" />
				<tr><td>
				<label for="title"><em>*</em>Title:</label>
				</td></tr>
				<tr><td>
				<input id="title" name="title" type="text" value="" maxlength="75" size="60"  />
				</td></tr>
				<tr><td>									
				<label for="summary" class="block">Summary:</label>
				<textarea name="summary" style="width:99%; height:100px;" id="summary"></textarea>
				</td></tr>
				<tr><td>
				<label for="content" class="block">Content:</label>
				<cfoutput>#fckEditor.create()#</cfoutput>
				</td></tr>
				<tr><td>
				<label for="sectionid"><em>*</em>Section:</label>
				<select id="sectionid" name="sectionid">
					<cfoutput query="rc.qSections">
						<option value="#rc.qSections.id#">#rc.qSections.title#</option>
					</cfoutput>
				</select>
				</td></tr>
				<tr><td>
				<label for="authorid"><em>*</em>Author:</label>
				<select id="authorid" name="authorid">
					<cfoutput query="rc.qAuthors">
						<option value="#rc.qAuthors.id#">#rc.qAuthors.firstname# #rc.qAuthors.lastname#</option>
					</cfoutput>
				</select>
				</td></tr>
				<tr><td>
				<label for="productid" style="float:left"><em>*</em>Related Resources:</label>
				</td></tr>
				<tr><td>
				<select name="productid" size="5" multiple="multiple" id="productid">
					<cfoutput query="rc.qProducts">
						<option value="#rc.qProducts.id#">#rc.qProducts.title#</option>
					</cfoutput>
				</select>
				</td></tr>
				<tr><td>
				<label for="views"><em>*</em>Views:</label><input id="views" name="views" type="text" value="0" size="4"  />
				</td></tr>
				<tr><td>
				<label for="islive"><em>*</em>Publish:</label>
				<select name="islive" id="islive">
					<option value="1">Yes</option>
					<option value="0">No</option>
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
</div>