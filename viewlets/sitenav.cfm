<cfset runEvent(event='viewlet.prepareSiteNav',private=true)>

<cfoutput>
<ul class="nav nav-pills">
  <li><a href="/" title="Home Page">Home</a></li>
  <li class="dropdown"><a href="#getSetting("sesBaseURL")#/article" title="News Articles" class="dropdown-toggle" data-toggle="dropdown">News/Facts <b class="caret"></b></a>
    <ul class="dropdown-menu">
    <cfloop query="#rc.qArticleSections#">
        <li><a href="#getSetting("sesBaseURL")#/article/list/section/#rc.qArticleSections.id#" title="#rc.qArticleSections.title#">#rc.qArticleSections.title#</a></li>
    </cfloop>
    </ul>
  </li>
  <li class="dropdown"><a href="#event.buildLink('product')#" title="Products" class="dropdown-toggle" data-toggle="dropdown">Products <b class="caret"></b></a>
    <ul class="dropdown-menu">
    	<!---li><a href="#getSetting("sesBaseURL")#/product/list" title="All Apparel">All Apparel</a></li--->
      <cfloop query="rc.qProductSections">
        <li><a href="#event.buildLink('product/list/section/#rc.qProductSections.id#')#" title="#rc.qProductSections.title#">#rc.qProductSections.title#</a></li>
      </cfloop>
      <li><a href="#event.buildLink('cart')#" title="Shopping Cart">Checkout</a></li>
    </ul>
  </li>
  <cfloop query="rc.tabs">
    <cfset tab = rc.tabService.getTab(id=rc.tabs.id)>
    <li class="dropdown"><a href="#event.buildLink('tab/view/#rc.tabs.alias#')#" title="#rc.tabs.title#" class="dropdown-toggle" data-toggle="dropdown">#rc.tabs.title# <b class="caret"></b></a>
      <ul class="dropdown-menu">
        <cfset aPages = "#tab.getPageArray()#">
        <cfloop array="#aPages#" index="page">
          <li><a href="#event.buildLink('page/view/#page.getid()#')#" title="#page.gettitle()#">#page.getTitle()#</a></li>
      	</cfloop>
      </ul>
    </li>
  </cfloop>
  <li class="dropdown"><a href="#event.BuildLink('media/video')#" title="Media" class="dropdown-toggle" data-toggle="dropdown">Media <b class="caret"></b></a>
    <ul class="dropdown-menu">
      <li><a href="#event.BuildLink('media/video')#" title="Video">Video</a></li>
      <li><a href="#event.buildLink('media/gallery')#" title="Event Gallery">Event Gallery</a></li>
    </ul>
  </li>
  <li><a href="#event.BuildLink('contact')#" title="Contact Us">Contact Us</a></li>
  
</ul>
</cfoutput>