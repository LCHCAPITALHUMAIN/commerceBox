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
  ela.innerHTML = "<img src='/admin/includes/images/delete.gif' alt='Delete field' />";
  el.appendChild(ela);
  Dom.add(el, 'added');
  Event.add(ela, 'click', function(e) {
	Dom.remove(el);
  });
});
});
</script>
<script type="text/javascript" language="javascript">
function addAnswer(i){
	var el = document.createElement('li');
	el.innerHTML = "<label for='answer"+i+"'>Answer: </label><input type='text' name='answer"+i+"' value='' maxlength='30' size='30' /><input type='hidden' name='optionid"+i+"' value='0' />";
	var ela = document.createElement('span');
  	ela.innerHTML = "<img src='/admin/includes/images/delete.gif' alt='Delete field' />";
 	el.appendChild(ela);
	Dom.add(el, 'added'+i);
	Event.add(ela, 'click', function(e){
		Dom.remove(el);
	});
}

function addQuestion(i){
	var k=i+1;
	var el = document.createElement('li');
	el.innerHTML = "<label for='title'>Question: </label><input type='text' name='title' value='' maxlength='30' size='30' /><input type='hidden' name='questionid' value='0' />";
	var ela = document.createElement('span');
  	ela.innerHTML = "<img src='/admin/includes/images/delete.gif' alt='Delete field' />";
	var elb = document.createElement('li');
	elb.innerHTML = "<a href='javascript:addAnswer("+ i + ");'><img src='/admin/includes/images/add.gif'> Add Answer</a>";
	var elc = document.createElement("div");
	elc.id = "added"+k;
	var eld = document.createElement("div");
	eld.id = "added"+i;
	ele = document.createElement("div");
	ele.innerHTML = "<span style='padding-left:5px;' id='ques"+k+"'><a href='javascript:addQuestion("+k+");'><img src='/admin/includes/images/add.gif'> Add Question</a></span>";
	elf = document.createElement("div");
	elf.id = "qadded" +k;
	el.appendChild(ela);
	el.appendChild(elb);
	el.appendChild(elc);
	el.appendChild(eld);
	el.appendChild(ele);
	el.appendChild(elf);
	Dom.add(el, 'qadded'+i);
	var rmv = document.getElementById("ques"+i);
	rmv.style.display = "none";
	Event.add(ela, 'click', function(e){
		Dom.remove(el);
	});
}
</script>
<style type="text/css">
#added span{
	padding-left:5px;
}
</style>
<div>
<div class="outerbox">
	<div class="boxtab">
		<h2><cfif rc.survey.getid() eq 0>
				Add
				<cfelse>
				Edit
			</cfif> Survey</h2></div>
		<div class="innerbox"><cfoutput>
				<div> [<a href="#getSetting('sesBaseURL')#/#rc.xehList#">Back To Listing</a>] </div>
				<br/>
				#getPlugin("messagebox").renderit()#
			</cfoutput>
			<cfoutput>
				<form name="editor_form" id="editor_form" action="#event.buildLink(rc.xehSave)#" method="post" >
					<input type="hidden" name="id" value="#rc.survey.getid()#" />
                    <fieldset>
                    <legend>Survey Information</legend>
                    <label for="surveytitle"><em>*</em>Survey Title:</label>
                    <input id="surveytitle" name="surveytitle" type="text" value="#rc.survey.getTitle()#" maxlength="100" size="60" />
                   	<br /><label for="description"><em>*</em>Survey Description:</label><br />
                    <textarea name="description" cols="60" rows="4">#rc.survey.getDescription()#</textarea>
                    <br /><label for="exitmsg"><em>*</em>Survey Thank You Message:</label><br />
                    <textarea name="exitmsg" cols="60" rows="4">#rc.survey.getExitMsg()#</textarea>
                    
					<ul class="formLayout">
                    	<li>
                        	<label for="password">Survey Password (optional):</label>
                            <input type="text" id="password" name="password" maxlength="75" size="30" value="#rc.survey.getPassword()#" />
                        </li>
                    	<li>
                        	<label for="datebegin"><em>*</em>Date Begin:</label>
                            <input type="text" id="datebegin" name="datebegin" maxlength="75" size="10" value="#rc.survey.getdatebegin()#" />
                        </li>
                        <li>
                        	<label for="dateend"><em>*</em>Date End:</label>
                            <input type="text" id="dateend" name="dateend" maxlength="75" size="10" value="#rc.survey.getDateEnd()#" />
                        </li>
						<li>
							<label for="isfeatured"><em>*</em>Featured:</label>
							<select name="isfeatured" id="isfeatured">
								<option value="1" <cfif isBoolean(rc.survey.getisfeatured()) and rc.survey.getisfeatured() >selected="selected"</cfif>>Yes</option>
								<option value="0" <cfif isBoolean(rc.survey.getisfeatured()) and not rc.survey.getisfeatured() >selected="selected"</cfif>>No</option>
							</select>
						</li>
                        </ul>
                        </fieldset>
                        <fieldset>
                        <legend>Survey Questions</legend>
                        <ul class="formLayout">
						<cfif arrayLen(rc.aQuestions)>
                        <cfloop from="1" to="#arraylen(rc.aQuestions)#" index="i">
                        <cfset question = rc.aQuestions[i]>
						<li>
                        	<input type="hidden" name="questionid" value="#question.getID()#" />
                            <input type="hidden" name="type" value="#question.getType()#" />
							<label for="title"><em>*</em>Question:</label>
							<input id="title" name="title" type="text" value="#question.gettitle()#" maxlength="75" size="40" />
                         
                            <select name="questiontype">
                            <cfloop query="rc.qQuestionTypes">
                            	<option value="#rc.qQuestionTypes.id#" <cfif rc.qQuestionTypes.id eq question.getType()>selected="selected"</cfif>>#rc.qQuestionTypes.title#</option>
                            </cfloop>
                            </select>
                         
                            <br /><span style="padding-left:5px;"><a href="javascript:addAnswer(#i#);"><img src="/admin/includes/images/add.gif"> Add Answer</a></span>
						</li>
						<cfif arrayLen(question.getOptionArray())>
                        <cfset options = question.getOptionArray()>
							<cfloop from="1" to="#arraylen(options)#" index="j">
							<cfset option = options[j]>
							<li>
								<label for="answer#i#">Answer:</label>
								<input type="text" name="answer#i#" value="#option.getAnswer()#" maxlength="30" size="30" />
								<input type="hidden" name="optionid#i#" value="#option.getID()#" />
							</li>
							</cfloop>
						</cfif>
						<div id="added#i#"></div>
                        </cfloop>
                        </cfif>
                        <span style="padding-left:5px;" id="ques1"><a href="javascript:addQuestion(1);"><img src="/admin/includes/images/add.gif"> Add Question</a></span><br />
                        <div id="qadded1"></div>
                        <div id="added1"></div>
                         
					</ul>
                    </fieldset>
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
