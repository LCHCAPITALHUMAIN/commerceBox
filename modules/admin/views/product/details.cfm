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
  el.innerHTML = "<input type='hidden' name='itemid' value='0' /><label for='description'>Description: </label><input type='text' name='description' maxlength='70' value='Description' /> <label for='price'>Price: </label><input type='text' name='price' size='3' value='0' /> <select name='formatid'><cfoutput query='rc.qFormats'><option value='#rc.qFormats.id#'>#rc.qFormats.title#</option></cfoutput></select>";
  var ela = document.createElement('span');
  ela.innerHTML = "<img src='/admin/includes/images/delete.gif' alt='Delete Item' />";
  el.appendChild(ela);
  Dom.add(el, 'added');
  Event.add(ela, 'click', function(e) {
	Dom.remove(el);
  });
});
<!-- Product Streams -->
Event.add('add-stream', 'click', function() {
  var sl = document.createElement('li');
  sl.innerHTML = "<input type='hidden' name='streamid' value='0' /><input type='hidden' name='streamviews' value='0' /><label for='streamtitle'>Title: </label><input type='text' name='streamtitle' maxlength='100' size='25' value='' /> <label for='isaudio'>Audio: </label><select name='isaudio'><option value='1'>Yes</option><option value='0'>No</option></select> <label for='isvideo'>Video: </label><select name='isvideo'><option value='1'>Yes</option><option value='0'>No</option></select> <label for='streamislive'>Publish: </label><select name='streamislive'><option value='1'>Yes</option><option value='0'>No</option></select>";
  var sla = document.createElement('span');
  sla.innerHTML = "<img src='/admin/includes/images/delete.gif' alt='Delete Stream' />";
  sl.appendChild(sla);
  Dom.add(sl, 'stream-added');
  Event.add(sla, 'click', function(e) {
	Dom.remove(sl);
  });
});
});
// Uploadify
$(document).ready(function() {
	$('#imageUpload').uploadify({
		'uploader': '/includes/movies/uploadify.swf',
		'script': '/index.cfm/admin/product/uploadProductImage',
		'folder': '/includes/images/product/temp',
		'cancelImg': '/includes/images/cancel.png',
		'scriptData': {'productID' : '<cfoutput>#rc.product.getid()#</cfoutput>'},
		'multi': true,
		'auto': true
	});
});
</script>
<style type="text/css">
#added span, #stream-added span { padding-left:5px; }
</style>
<cfoutput>
#renderView(view="viewlets/prodsidebar",module="admin")#
<div class="column-w573 left">
  <div class="outerbox">
  <div class="boxtab">
    <h3>
     #rc.title#
    </h3>
  </div>
  <div class="innerbox">
 #getPlugin("messagebox").renderit()#
  <form name="editor_form" id="editor_form" action="#Event.buildLink(rc.xehSave)#" method="post" enctype="multipart/form-data">
  <ul id="crumbs">
    <li class="currentStep"><a href="javascript:void(0)">Step 1</a></li>
    <li><a href="#event.BuildLink('')#/#rc.product.getID()#">Step 2</a></li>
  </ul>
  <table width="100%">
    <input type="hidden" name="id" value="#rc.product.getid()#" />
    <tr>
      <td><label for="title"><em>*</em>Title:</label></td>
    </tr>
    <tr>
      <td><input id="title" name="title" type="text" value="#rc.product.gettitle()#" maxlength="75" size="60"  /></td>
    </tr>
    <tr>
      <td><label for="summary" class="block">Summary:</label>
        <textarea name="summary" style="width:99%; height:100px;" id="summary">#rc.product.getsummary()#
</textarea></td>
    </tr>
    <tr>
      <td><label for="content" class="block">Content:</label></td>
    </tr>
    <tr>
      <td>
      <label for="image">Image:</label><br />
	  <div id="imageUpload"></div>
	  </td>
    </tr>
    <tr>
      <td><label for="sectionid" style="float:left"><em>*</em>Categories:</label></td>
    </tr>
    <tr>
      <td><select name="sectionid" size="5" multiple="multiple" id="sectionid">
          <cfloop query="rc.qSections">
          <option value="#rc.qSections.id#"<cfif listFind(rc.lsections,rc.qSections.id)> selected="selected"</cfif>>#rc.qSections.title#</option>
          </cfloop>
        </select></td>
    </tr>
    <tr>
      <td><label for="sizeid" style="float:left"><em>*</em>Size:</label></td>
    </tr>
    <tr>
      <td><select name="sizeid" size="5" multiple="multiple" id="sizeid">
          <cfloop query="rc.qSizes">
          <option value="#rc.qSizes.id#"<cfif listFind(rc.lsizes,rc.qSizes.id)> selected="selected"</cfif>>#rc.qSizes.title#</option>
          </cfloop>
        </select></td>
    </tr>
    <tr>
      <td><label for="views"><em>*</em>Model:</label>
        <input id="model" name="model" type="text" value="#rc.product.getModel()#" size="10"  /></td>
    </tr>
    <tr>
      <td><label for="views"><em>*</em>Views:</label>
        <input id="views" name="views" type="text" value="#val(rc.product.getviews())#" size="4"  /></td>
    </tr>
    <tr>
      <td><label for="islive"><em>*</em>Publish:</label>
        <select name="islive" id="islive">
          <option value="1"<cfif isBoolean(rc.product.getIsLive()) and rc.product.getIsLive()> selected="selected"</cfif>>Yes</option>
          <option value="0"<cfif isBoolean(rc.product.getIsLive()) and not rc.product.getIsLive()> selected="selected"</cfif>>No</option>
        </select></td>
    </tr>
    <tr>
      <td><h3 style="display:inline">Resource Options</h3>
        <span style="padding-left:5px;"><a href="javascript:;" id="add-element"><img src="/modules/admin/includes/images/add.gif"> Add Item</a></span>
        <ul class="formLayout">
          <cfif arrayLen(rc.aItems)>
            <cfloop from="1" to="#arrayLen(rc.aItems)#" index="i">
            <cfset item = rc.aItems[i]>
            <li>
            <input type="hidden" name="itemid" value="#item.getID()#" />
            <label for="description">Description: </label>
            <input type="text" name="description" maxlength="70" value="#item.getTitle()#" />
            <label for="price">Price: </label>
            <input type="text" name="price" size="3" value="#decimalformat(item.getPrice())#" />
            <select name="formatid">
              <cfloop query="rc.qFormats">
              <option value="#rc.qFormats.id#" <cfif item.getParentFormat().getID() EQ rc.qFormats.id> selected="selected"</cfif>>#rc.qFormats.title#</option>
              </cfloop>
            </select>
            </li>
            </cfloop>
          </cfif>
          <div id="added"></div>
        </ul>
        <h3 style="display:inline">Streaming Items</h3>
        <span style="padding-left:5px;"><a href="javascript:;" id="add-stream"><img src="/modules/admin/includes/images/add.gif"> Add Item</a></span>
        <ul class="formLayout">
          <cfif arrayLen(rc.aStreams)>
            <cfloop from="1" to="#arrayLen(rc.aStreams)#" index="i">
            <cfset stream = rc.aStreams[i]>
            <li>
              <input type="hidden" name="streamid" value="#stream.getID()#" />
              <input type="hidden" name="streamviews" value="#stream.getViews()#" />
              <label for="streamtitle">Title: </label>
              <input type="text" name="streamtitle" maxlength="100" size="25" value="#stream.getTitle()#" />
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
            </cfloop>
          </cfif>
          <div id="stream-added"></div>
        </ul></td>
    </tr>
    <tr>
      <td><p><strong>*</strong>Indicates required field</p>
		<input type="submit" class="btn" id="saveProduct" name="save" value="Save" />
		
		<input type="button" class="btn" id="next" name="saveProduct?step=fields" value="Next" />
		<input type="reset" id="cancel" name="viewProduct" value="Cancel" />
		<cfif rc.product.getID()>
			<input type="button" class="btn" id="clone" name="cloneProduct" value="Clone" />
			<input type="button" class="btn" id="delete" name="deleteProduct" value="Delete" />
		</cfif></td>
    </tr>
  </table>
  </form>
  </div>
  </div>
  <cfif arraylen(rc.aReviews)>
    <div class="outerbox">
      <div class="boxtab">
        <h3 style="margin-top:1.2em;">Readers Respond</h3>
      </div>
      <div class="innerbox">
        <cfloop from="1" to="#arrayLen(rc.aReviews)#" index="i">
        <cfset review = rc.aReviews[i]>
        <cfif review.getTitle() IS NOT "">
          <h4>#review.getTitle()#</h4>
        </cfif>
        <p>#review.getContent()#</p>
        <div style="text-align:right;">
          <p>&mdash; #review.getAuthor()#</p>
          <p><a href="#getSetting("sesBaseURL")#/#rc.xehReviews#/#rc.product.getID()#" title="Read All Reviews">see all #arayLen(rc.aReviews)# reviews &raquo;</a></p>
        </div>
        </cfloop>
      </div>
    </div>
  </cfif>
  </div>
  </div>
</cfoutput>