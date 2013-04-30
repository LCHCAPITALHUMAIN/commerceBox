<cfoutput>#renderView("article/sidebar")#</cfoutput>

<cfscript>
	basePath = "/admin/includes/fckeditor/" ;
	fckEditor = createObject( "component", "admin.includes.fckeditor.fckeditor" ) ;
	fckEditor.instanceName	= "content" ;
	fckEditor.value			= '#rc.author.getcontent()#' ;
	fckEditor.basePath		= #basePath# ;
	fckEditor.height		= '200';
	fckEditor.width			= '100%';
	fckEditor.config['SkinPath'] = basePath & 'editor/skins/silver/';
</cfscript>
<div class="column-w573 left">
	<div class="outerbox">
		<div class="boxtab">
			<h2><cfoutput>#rc.title#</cfoutput></h2>
		</div>
		<div id="article" class="innerbox">
			<cfoutput>#getPlugin("messagebox").renderIt()#</cfoutput>
			<table width="100%">
			<form name="editor_form" id="editor_form" action="<cfoutput>#Event.buildLink(rc.xehauthorSave)#</cfoutput>" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="<cfoutput>#rc.author.getid()#</cfoutput>" />
				<tr><td>
				<label for="lastname">Last Name:</label>
				<input id="lastname" name="lastname" type="text" value="<cfoutput>#rc.author.getLastName()#</cfoutput>" maxlength="75" size="60"  />
				</td></tr>
				<tr><td>									
				<label for="firstname">First Name:</label>
				<input id="firstname" name="firstname" type="text" value="<cfoutput>#rc.author.getFirstName()#</cfoutput>" maxlength="75" size="60"  />
				</td></tr>
				<tr><td>
				<label for="content">Short Bio:</label>
				</td></tr>
				<tr><td>
				<cfoutput>#fckEditor.create()#</cfoutput>
				</td></tr>
				<tr>
							<td><label for="image" style="float:left">Image:</label> <input type="file" name="image" accept="image/jpeg" /></td>
						</tr>
				<tr><td>
				<label for="islive">Publish:</label>
				<select name="islive" id="islive">
					<option value="1"<cfif isBoolean(rc.author.getIsLive()) and rc.author.getIsLive()> selected="selected"</cfif>>Yes</option>
					<option value="0"<cfif isBoolean(rc.author.getIsLive()) and not rc.author.getIsLive()> selected="selected"</cfif>>No</option>
				</select>
				</td></tr>
				<tr><td>
				<input type="submit" value="Save Author" />
				</td></tr>
			</form>
			</table>
		</div>
	</div>
</div>