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
<!-- Product Streams -->
Event.add('add-stream', 'click', function() {
  var sl = document.createElement('li');
  sl.innerHTML = "<input type='hidden' name='streamid' value='0' /><input type='hidden' name='streamviews' value='0' /><label for='streamtitle'>Title: </label><input type='text' name='streamtitle' maxlength='100' size='40' value='' /> <label for='isaudio'>Audio: </label><select name='isaudio'><option value='1'>Yes</option><option value='0'>No</option></select> <label for='isvideo'>Video: </label><select name='isvideo'><option value='1'>Yes</option><option value='0'>No</option></select> <label for='streamislive'>Publish: </label><select name='streamislive'><option value='1'>Yes</option><option value='0'>No</option></select>";
  var sla = document.createElement('span');
  sla.innerHTML = "<img src='/admin/includes/images/delete.gif' alt='Delete Stream' />";
  sl.appendChild(sla);
  Dom.add(sl, 'stream-added');
  Event.add(sla, 'click', function(e) {
	Dom.remove(sl);
  });
});
});
</script>
<style type="text/css">
#added span, #stream-added span { padding-left:5px; }
</style>


	<div class="outerbox">
		<div class="boxtab">
			<h2><cfoutput>#rc.title#</cfoutput></h2>
		</div>
		<div class="innerbox">
		<cfoutput>[<a href="#event.buildlink(rc.xehList)#">Back to Resource Streams List</a>]<br />
		#getPlugin("messagebox").renderit()#</cfoutput>
			<form name="editor_form" id="editor_form" action="<cfoutput>#Event.buildLink(rc.xehSave)#</cfoutput>" method="post" >
				<table width="100%">
					<input type="hidden" name="id" value="<cfoutput>#rc.product.getid()#</cfoutput>" />
					<tr>
						<td><h3>Edit Streams for <cfoutput>#rc.product.gettitle()#</cfoutput></h3></td>
					</tr>
					<tr>
						<td>
							<h4 style="display:inline">Streaming Items</h4>
							<span style="padding-left:5px;"><a href="javascript:;" id="add-stream"><img src="/modules/admin/includes/images/add.gif"> Add Item</a></span>
							<ul class="formLayout">
								<cfif arrayLen(rc.aStreams)>
									<cfloop from="1" to="#arrayLen(rc.aStreams)#" index="i">
										<cfset stream = rc.aStreams[i]>
										<cfoutput>
											<li>
											<input type="hidden" name="streamid" value="#stream.getID()#" />
											<input type="hidden" name="streamviews" value="#stream.getViews()#" />
											<label for="streamtitle">Title: </label>
											<input type="text" name="streamtitle" maxlength="100" size="40" value="#stream.getTitle()#" />
											<label for="isaudio">Audio:</label>
											<select name="isaudio" id="isaudio">
												<option value="1"<cfif isBoolean(stream.getIsAudio()) and stream.getIsAudio()> selected="selected"</cfif>>Yes</option>
												<option value="0"<cfif isBoolean(stream.getIsAudio()) and not stream.getIsAudio()> selected="selected"</cfif>>No</option>
											</select>
											<label for="isvideo">Video:</label>
											<select name="isvideo" id="isvideo">
												<option value="1"<cfif isBoolean(stream.getIsVideo()) and stream.getIsVideo()> selected="selected"</cfif>>Yes</option>
												<option value="0"<cfif isBoolean(stream.getIsVideo()) and not stream.getIsVideo()> selected="selected"</cfif>>No</option>
											</select>
											<label for="streamislive">Publish:</label>
											<select name="streamislive">
												<option value="1"<cfif isBoolean(stream.getIsLive()) and stream.getIsLive()> selected="selected"</cfif>>Yes</option>
												<option value="0"<cfif isBoolean(stream.getIsLive()) and not stream.getIsLive()> selected="selected"</cfif>>No</option>
											</select>
										</li>
										</cfoutput>
									</cfloop>
								</cfif>
								<div id="stream-added"></div>
							</ul></td>
					</tr>
					<tr>
						<td><input type="submit" value="Save Streams" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>