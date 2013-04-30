<!--- Set the Request Collection Reference --->
<cfset rc = event.getCollection()>

<cfoutput>
	<div id="utilities">
		<a href="#getSetting("sesBaseURL")#/page/dspEditor/"><img src="/manage/images/add.gif" alt="Add" border="0" hspace="5" />Add New Page</a>
		<a href="#getSetting("sesBaseURL")#/#rc.xehDelete#/#rc.page.getid()#"><img src="/manage/images/delete.gif" alt="Delete" border="0" hspace="5" />Delete This Page</a></div>
	<h2><cfif rc.page.getid() eq 0 >Add New Page<cfelse>Edit Page: #rc.page.getTitle()#</cfif></h2>
	#getPlugin("messagebox").renderit()#
	<form name="editor_form" id="editor_form" action="#getSetting('sesBaseURL')#/#rc.xehSave#" method="post" >
	<input type="hidden" name="id" value="#rc.page.getid()#" />
	<table border="0" cellpadding="5" cellspacing="0">
</cfoutput>
<tr>
		<td><label for="alias"><em>*</em>Tab:</label></td>
	</tr>
<tr>
	<td>
		<select name="tab_id">
			<option value="0">Select One</option>
			<option value="0">No Tab</option>
			<cfoutput query="rc.qtabs" maxrows="7">
				<option value="#rc.qtabs.id#">#rc.qtabs.title#</option>
			</cfoutput>
		</select>
	</td>
</tr>
<cfoutput>
	<tr>
		<td><label for="title"><em>*</em>Title:</label></td>
	</tr>
	<tr>
		<td><input id="title" name="title" type="text" value="#rc.page.gettitle()#" maxlength="75" size="40"  />
		</td>
	</tr>
	<tr>
		<td><label for="keywords">Keywords:</label></td>
	</tr>
	<tr>
		<td><textarea id="keywords" name="keywords" cols="60" rows="2">#rc.page.getkeywords()#</textarea>
		</td>
	</tr>
	<tr>
		<td><label for="summary">Summary:</label></td>
	</tr>
	<tr>
		<td><textarea id="summary" name="summary" cols="60" rows="2">#rc.page.getsummary()#</textarea>
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
			fckEditor.value			= '#rc.page.getcontent()#' ;
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
				<option value="1" <cfif isBoolean(rc.page.getIsLive()) and rc.page.getIsLive() >selected="selected"</cfif>>Yes</option>
				<option value="0" <cfif isBoolean(rc.page.getIsLive()) and not rc.page.getIsLive() >selected="selected"</cfif>>No</option>
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