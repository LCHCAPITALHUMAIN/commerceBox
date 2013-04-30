<cfoutput>#renderView(view="viewlets/modulesidebar",module="admin")#</cfoutput>
<div>
<div class="outerbox">
	<div class="boxtab">
		<h2>Testimonial Editor :
			<cfif rc.testimonial.getid() eq 0 >
				Add
				<cfelse>
				Edit
			</cfif>
			Record</h2></div>
		<div class="innerbox">
		<cfoutput>
<div>
[<a href="#event.buildLink(rc.xehList)#">Back To Listing</a>]
</div>
<br/>
#getPlugin("messagebox").renderit()#
</cfoutput>

<cfoutput>
<form name="editor_form" id="editor_form" action="#event.buildLink(rc.xehSave)#" method="post" >
<input type="hidden" name="id" value="#rc.testimonial.getid()#" />


<ul class="formLayout">

<li><label for="author">Author:</label>
<input id="author" name="author" type="text" value="#rc.testimonial.getauthor()#" maxlength="75" size="40" /></li>


<li><label for="content">Content:</label>
<textarea name="content" type="text" cols="60" rows="3" style="width:99%">#rc.testimonial.getcontent()#</textarea></li>
</ul>
<br/>
<div><strong>*</strong> Indicates required field</div>
<br/>
<div>
<input type="submit" value="Submit" class="" />
</div>
</form>
</cfoutput>
</div></div></div>