<cfset runEvent(event='viewlet.prepareSiteNav',private=true)>

<ul>
  <li><a href="/" title="Home Page">Home</a></li>
  <li><cfoutput><a href="#event.buildLink('product')#" title="Products">Products</a></cfoutput>
    <ul class="subnav">
    	<!---li><a href="<cfoutput>#getSetting("sesBaseURL")#</cfoutput>/product/list" title="All Apparel">All Apparel</a></li--->
      <cfoutput query="rc.qProductSections">
        <li><a href="#event.buildLink('product/list/section/#rc.qProductSections.id#')#" title="#rc.qProductSections.title#">#rc.qProductSections.title#</a></li>
      </cfoutput>
      <cfoutput><li><a href="#event.buildLink('cart')#" title="Shopping Cart">Checkout</a></li></cfoutput>
    </ul>
  </li>
  <cfoutput>
  <cfloop query="rc.tabs">
    <cfset tab = rc.tabService.getTab(id=rc.tabs.id)>
    <li><a href="#event.buildLink('tab/view/#rc.tabs.alias#')#" title="#rc.tabs.title#">#rc.tabs.title#</a>
      <ul class="subnav">
        <cfset aPages = "#tab.getPageArray()#">
        <cfloop array="#aPages#" index="page">
          <li><a href="#event.buildLink('page/view/#page.getid()#')#" title="#page.gettitle()#">#page.getTitle()#</a></li>
      	</cfloop>
      </ul>
    </li>
  </cfloop>
  <li><a href="#event.BuildLink('media/video')#" title="Media">Media</a>
    <ul class="subnav">
      <li><a href="#event.BuildLink('media/video')#" title="Video">Video</a></li>
      <li><a href="#event.buildLink('media/gallery')#" title="Event Gallery">Event Gallery</a></li>
    </ul>
  </li>
  <!---li><a href="<cfoutput>#getSetting("sesBaseURL")#</cfoutput>/article" title="Articles">Articles</a>
    <ul class="subnav">
    <cfoutput query="rc.qArticleSections">
        <li><a href="#getSetting("sesBaseURL")#/article/list/section/#rc.qArticleSections.id#" title="#rc.qArticleSections.title#">#rc.qArticleSections.title#</a></li>
    </cfoutput>
    </ul>
  </li--->
  <li><a href="#event.BuildLink('contact')#" title="Contact Us">Contact Us</a></li>
  </cfoutput>
</ul>
