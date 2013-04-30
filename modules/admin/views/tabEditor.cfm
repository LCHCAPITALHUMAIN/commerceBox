<!--- Set the Request Collection Reference --->
<cfset rc = event.getCollection()>

<cfoutput>
	<h2>Edit Tab: #rc.tab.getTitle()#</h2>
	#getPlugin("messagebox").renderit()#
	<form name="editor_form" id="editor_form" action="#getSetting('sesBaseURL')#/#rc.xehSave#" method="post" >
	<input type="hidden" name="id" value="#rc.tab.getid()#" />
	<table border="0" cellpadding="5" cellspacing="0">
	<tr>
		<td><label for="title"><em>*</em>Title:</label></td>
	</tr>
	<tr>
		<td><input id="title" name="title" type="text" value="#rc.tab.gettitle()#" maxlength="75" size="40"  />
		</td>
	</tr>
	<tr>
		<td><label for="keywords">Keywords:</label></td>
	</tr>
	<tr>
		<td><textarea id="keywords" name="keywords" cols="60" rows="2">#rc.tab.getkeywords()#</textarea>
		</td>
	</tr>
	<tr>
		<td><label for="summary">Summary:</label></td>
	</tr>
	<tr>
		<td><textarea id="summary" name="summary" cols="60" rows="2">#rc.tab.getsummary()#</textarea>
		</td>
	</tr>
	<tr>
		<td><label for="content">Content:</label></td>
	</tr>
	<tr>
		<td>
		<cfscript>
			basePath = "/admin/includes/fckeditor/" ;
			fckEditor = createObject( "component", "admin.includes.fckeditor.fckeditor" ) ;
			fckEditor.instanceName	= "content" ;
			fckEditor.value			= '#rc.tab.getcontent()#' ;
			fckEditor.basePath		= #basePath# ;
			fckEditor.height		= '500';
			fckEditor.width			= '800';
			fckEditor.config['SkinPath'] = basePath & 'editor/skins/silver/';
			fckEditor.create() ; // create the editor.
		</cfscript>
		</td>
	</tr>
	<tr>
		<td><label for="publish"><em>*</em>Publish:</label> (Choosing yes will cause this page to be visible on the public website)</td>
	</tr>
	<tr>
		<td><select name="publish" id="publish">
				<option value="1" <cfif isBoolean(rc.tab.getIslive()) and rc.tab.getIsLive() >selected="selected"</cfif>>Yes</option>
				<option value="0" <cfif isBoolean(rc.tab.getIsLive()) and not rc.tab.getIsLive() >selected="selected"</cfif>>No</option>
			</select>
		</td>
	</tr>
	</table>
	<br />
	<div><strong>*</strong> Indicates required field</div>
	<br />
	<div>
		<input type="submit" value="Submit" class="" />
	</div>
	</form>
</cfoutput>