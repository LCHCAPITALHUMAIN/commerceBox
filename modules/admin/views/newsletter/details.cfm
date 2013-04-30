<cfoutput>#renderView(view="viewlets/modulesidebar",module="admin")#

<div class="outerbox">
<div class="innerbox">
<div>
[<a href="#event.BuildLink(rc.xehList)#">Back To Listing</a>]
</div>
<br/>
#getPlugin("messagebox").renderit()#

<form name="editor_form" id="editor_form" action="#event.BuildLink(rc.xehSave)#" method="post" >
<input type="hidden" name="id" value="#rc.newsletter.getid()#" />

<fieldset>
<legend>Newsletter Subscriber Editor : <cfif rc.newsletter.getid() eq 0 >Add<cfelse>Edit</cfif> Record</legend>

<ul class="formLayout">


<li><label for="email"><em>*</em>Email:</label>
<input id="email" name="email" type="text" value="#rc.newsletter.getemail()#" maxlength="75" size="40" /></li>


<li><label for="date">Date:</label>
<input id="date" name="date" type="text" <cfif rc.newsletter.getdate() eq "">value="#dateFormat(now(), "yyyy-mm-dd")#"<cfelse>value="#dateFormat(rc.newsletter.getdate(), "yyyy-mm-dd")#"</cfif> size="40"  /></li>


<li><label for="islive"><em>*</em>Publish:</label>

<select name="islive" id="islive">
<option value="1" <cfif isBoolean(rc.newsletter.getislive()) and rc.newsletter.getislive() >selected="selected"</cfif>>Yes</option>
<option value="0" <cfif isBoolean(rc.newsletter.getislive()) and not rc.newsletter.getislive() >selected="selected"</cfif>>No</option>
</select>
</li>
</ul>
<br/>
<div><strong>*</strong> Indicates required field</div>
<br/>
<div>
<input type="submit" value="Submit" class="" />
</div>
</fieldset>
</form>
</cfoutput>
</div>
</div>