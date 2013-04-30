<script type="text/javascript"> 
$(function() {
    $('#product-images').cycle({
        fx:      'fade',
        speed:       200, 
   		timeout:     3000, 
    	pauseOnPagerHover: true,
        pager:   '#product-thumbs',
        pagerAnchorBuilder: pagerFactory
    });
 
    function pagerFactory(idx, slide) {
        var s = idx > 2 ? ' style="display:none"' : '';
        return '<li class="product-thumb"><a href=""><img src="'+slide.src+'" width="55" height="75" /></a></li>';
    };
	$('#product-images img').hover(function() { 
		$('#product-images').cycle('pause');
	});
	$('#product-images img').mouseout(function() { 
		$('#product-images').cycle('resume');
	});
});
</script> 
<style type="text/css">
div#product-description {
	float:right;
	width:350px;
	padding-right:10px;
}
div#product-description h1{
	margin-top:0; padding-top:0;
}
#product-image{
	width:360px;
	float:left;
	text-align:center;
}
#product-images img{
	border:1px solid black;
}
ul#product-thumbs{
	margin:0; margin-top:5px;
	padding:0;
}
ul#product-thumbs li{
	padding:0;
	margin-right:2px;
	float:left;
	width:55px; height:75px;
	border:1px solid black;
}
#add-to-cart{
	font-size:1em; padding:.5em; 
	border:1px solid #666; 
	background-color:#333; 
	color:white
}
#add-to-cart:hover{
	border-color:black;
	background-color:#666;
}
</style>
<cfoutput>
#renderView('viewlets/prodnav')#
  <div class="column-w573 left">
    <div class="outerbox">
      <div class="boxtab">
        <h3>#rc.product.getTitle()#</h3>
      </div>
      <div class="innerbox">
        <div class="containment">
        <div id="product-image">
            <div id="product-images">
                <cfloop from="1" to="#arrayLen(rc.aProducts)#" index="i">
                    <cfset image = rc.aProducts[i]>
                    <img width="355" height="475" src="/includes/images/products/#image.getXLImage()#" />
                </cfloop> 
            </div>
            <ul id="product-thumbs"></ul>
          </div>
          <div id="product-description">
            <h1>#rc.product.getTitle()#</h1>
            <p>#rc.product.getContent()#</p>
              <cfloop from="1" to="#arrayLen(rc.aItems)#" index="i">
                  <cfset item = rc.aItems[i]>
                    <form action="#getSetting("sesBaseURL")#/#rc.xehAddToCart#" method="post" name="addToCart#item.getID()#">
                      <input type="hidden" name="model" id="model"  value="#rc.product.getModel()#-#item.getTitle()#<cfif rc.qSizes.recordCount>-#rc.qSizes.title#</cfif>" />
                      <input type="hidden" name="title" value="#rc.product.getTitle()#" />
                      <input type="hidden" name="description" value="#item.getTitle()#" />
                      <input type="hidden" name="price" value="#item.getPrice()#" />
                      <h5>#item.getTitle()#</h5>
                      <cfif rc.qSizes.recordCount>
                      	<p>
	                        <select name="size" id="size" onchange="javascript:getElementById('model').value='#rc.product.getModel()#-#item.getTitle()#-' +this.value;">
	                          <cfloop query="rc.qSizes">
	                          <option value="#rc.qSizes.title#" >#rc.qSizes.title#</option>
	                          </cfloop>
	                        </select>
                        </p>
                      </cfif>
                          <p>Price: #dollarformat(item.getPrice())#</td>
                          <input type="hidden" name="quantity" value="1" />
                          <input type="submit" id="add-to-cart" border="0" value="Add to Cart" name="addToCart" alt="Add to Cart" />
                    	</p>
                    </form>
              </cfloop>
          </div>
      
    </div>
  </div>
  <cfif NOT arrayIsEmpty(rc.aReviews)>
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
  </cfoutput>
