<cfoutput>
<script type="text/javascript" language="javascript">
var Dom = {
get: function(el) {
  if (typeof el === 'string') {
	return document.getElementById(el);
  } else {
	return el;
  }
},
add: function(el, dest) {
  var el = this.get(el);
  var dest = this.get(dest);
  dest.appendChild(el);
},
remove: function(el) {
  var el = this.get(el);
  el.parentNode.removeChild(el);
}
};
var Event = {
add: function() {
  if (window.addEventListener) {
	return function(el, type, fn) {
	  Dom.get(el).addEventListener(type, fn, false);
	};
  } else if (window.attachEvent) {
	return function(el, type, fn) {
	  var f = function() {
		fn.call(Dom.get(el), window.event);
	  };
	  Dom.get(el).attachEvent('on' + type, f);
	};
  }
}()
};
Event.add(window, 'load', function() {
var i = 0;
Event.add('add-element', 'click', function() {
  var el = document.createElement('li');
  el.innerHTML = "<label for='answer'>Answer: </label><input type='text' name='answer' value='' maxlength='30' size='30' /><input type='hidden' name='optionid' value='0' />";
  var ela = document.createElement('span');
  ela.innerHTML = "<img src='/modules/admin/includes/images/delete.gif' alt='Delete field' />";
  el.appendChild(ela);
  Dom.add(el, 'added');
  Event.add(ela, 'click', function(e) {
	Dom.remove(el);
  });
});
});
</script>
<style type="text/css">
##added span{
	padding-left:5px;
}
</style>
#renderView(view="viewlets/modulesidebar",module="admin")#
<div>
<div class="outerbox">
	<div class="boxtab">
		<h2><cfif rc.poll.getid() eq 0 >
				Add
				<cfelse>
				Edit
			</cfif> Poll</h2></div>
		<div class="innerbox">
				<div> [<a href="#event.BuildLink(rc.xehList)#">Back To Listing</a>] </div>
				<br/>
				#getPlugin("messagebox").renderit()#
				<form name="editor_form" id="editor_form" action="#event.buildLink(rc.xehSave)#" method="post" >
					<input type="hidden" name="id" value="#rc.poll.getid()#" />
					<ul class="formLayout">
						<li>
							<label for="title"><em>*</em>Question:</label>
							<input id="title" name="title" type="text" value="#rc.poll.gettitle()#" maxlength="75" size="40" /><span style="padding-left:5px;"><a href="javascript:;" id="add-element"><img src="/modules/admin/includes/images/add.gif"> Add Answer</a></span>
						</li>
						<cfif arrayLen(rc.aOptions)>
							<cfloop from="1" to="#arraylen(rc.aOptions)#" index="i">
							<cfset option = rc.aOptions[i]>
							<li>
								<label for="answer">Answer:</label>
								<input type="text" name="answer" value="#option.getAnswer()#" maxlength="30" size="30" />
								<input type="hidden" name="optionid" value="#option.getID()#" />
							</li>
							</cfloop>
						</cfif>
						<div id="added"></div>
						<li>
							<label for="islive"><em>*</em>Publish:</label>
							<select name="islive" id="islive">
								<option value="1" <cfif isBoolean(rc.poll.getislive()) and rc.poll.getislive() >selected="selected"</cfif>>Yes</option>
								<option value="0" <cfif isBoolean(rc.poll.getislive()) and not rc.poll.getislive() >selected="selected"</cfif>>No</option>
							</select>
						</li>
						<li>
							<label for="isfeatured"><em>*</em>Featured:</label>
							<select name="isfeatured" id="isfeatured">
								<option value="1" <cfif isBoolean(rc.poll.getisfeatured()) and rc.poll.getisfeatured() >selected="selected"</cfif>>Yes</option>
								<option value="0" <cfif isBoolean(rc.poll.getisfeatured()) and not rc.poll.getisfeatured() >selected="selected"</cfif>>No</option>
							</select>
						</li>
					</ul>
					<br/>
					<div><strong>*</strong> Indicates required field</div>
					<br/>
					<div>
						<input type="submit" value="Submit" class="" />
					</div>
				</form>
			</div>
	</div>
</div>
</cfoutput>