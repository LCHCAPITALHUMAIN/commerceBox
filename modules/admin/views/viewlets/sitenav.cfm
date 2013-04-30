<cfset runEvent(event='admin:viewlet.prepareSiteNav',private=true)>
<cfoutput>
<ul id="nav">
    <li><a href="#event.buildLink('admin')#" title="Home Page">Home</a></li>
    <li><a href="#event.buildLink('admin/product')#" title="Products">Products</a>
    <ul class="subnav">
    
        <li><a href="#event.buildLink('admin/product/details/')#" title="Add Product">Add Product</a></li>
    
    </ul></li>
    <cfloop query="rc.tabs">
    <cfset tab = rc.tabService.getTab(id=rc.tabs.id)>
    <li><a href="#event.buildLink('admin/tab/edit/')##rc.tabs.id#" title="#rc.tabs.title#">#rc.tabs.title#</a>
        <ul class="subnav">
            <cfset aPages = "#tab.getPageArray()#">
            <cfloop array="#aPages#" index="page">
                <li><a href="#event.buildLink('admin/page/edit/')##page.getId()#" title="#page.gettitle()#">#page.getTitle()#</a></li>
            </cfloop>
            <li><a href="#event.buildLink('admin/page/edit/')#" title="Add New Page">Add New Page</a></li>
        </ul>
    </li>
    </cfloop>
    <li><a href="#event.buildLink('admin/media')#" title="Media">Media</a></li>
    <!---li><a href="#getSetting("sesBaseURL")#/article" title="Articles">Articles</a>
    <ul class="subnav">
    <cfloop query="rc.qArticleSections">
        <li><a href="#getSetting("sesBaseURL")#/article/sectionDetails/#rc.qArticleSections.id#" title="#rc.qArticleSections.title#">#rc.qArticleSections.title#</a></li>
    </cfloop>
    </ul>
    </li--->
    <li><a href="#event.buildLink('admin/contact')#" title="Contact Us">Contact Us</a></li>
</ul>
</cfoutput>