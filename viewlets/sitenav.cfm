<cfset runEvent(event='viewlet.prepareSiteNav',private=true)>

<cfoutput>
<ul class="nav nav-pills">
  <li><a href="/" title="Home Page">Home</a></li>
  <li><a href="#getSetting("sesBaseURL")#/article" title="Articles">News/Facts</a>
    <ul class="subnav">
    <cfloop query="#rc.qArticleSections#">
        <li><a href="#getSetting("sesBaseURL")#/article/list/section/#rc.qArticleSections.id#" title="#rc.qArticleSections.title#">#rc.qArticleSections.title#</a></li>
    </cfloop>
    </ul>
  </li>
  <li><a href="#event.buildLink('product')#" title="Products">Products</a>
    <ul class="subnav">
    	<!---li><a href="#getSetting("sesBaseURL")#/product/list" title="All Apparel">All Apparel</a></li--->
      <cfloop query="rc.qProductSections">
        <li><a href="#event.buildLink('product/list/section/#rc.qProductSections.id#')#" title="#rc.qProductSections.title#">#rc.qProductSections.title#</a></li>
      </cfloop>
      <li><a href="#event.buildLink('cart')#" title="Shopping Cart">Checkout</a></li>
    </ul>
  </li>
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
  <li><a href="#event.BuildLink('contact')#" title="Contact Us">Contact Us</a></li>
  
</ul>
</cfoutput>