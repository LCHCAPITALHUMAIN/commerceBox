<cfsetting enablecfoutputonly="yes">
<cfset qProductFormats = "#getPlugin("ioc").getBean("productFormatService").getProductFormats(islive=1)#" >
<cfsavecontent variable="thexml"><?xml version="1.0" encoding="iso-8859-1" ?>
<menu name="navigation">
	<menu name="HOME" link="/" />
	<menu name="ABOUT US" link="/about">
		<item name="We Believe" link="/about/beliefs" />
		<item name="Staff" link="/about/staff" />
		<item name="Donate" link="/about/donate" />
		<item name="Breaking News" link="/about/news" />
		<item name="Photo Gallery" link="/about/gallery" />
		<item name="Media Kit" link="/about/media" />
	</menu>
	<menu name="RESOURCES" link="/product">
		<cfoutput query="qProductFormats">
			<item name="#qProductFormats.title#" link="#getSetting("sesBaseURL")#/#event.getCurrentHandler()#/#event.getCurrentAction()#/format/#qProductFormats.id#" />
		</cfoutput>
		<item name="Checkout" link="/cart" />
	</menu>
	<menu name="ARTICLES" link="/article" />
	<menu name="STREAMING" link="/media/video">
		<item name="Streaming Video" link="/media/video" />
		<item name="Streaming Audio" link="/media/audio" />
	</menu>
	<menu name="CONTACT US" link="/contact" />
</menu></cfsavecontent>
<cfcontent type="text/xml">
<cfoutput>#theXml#</cfoutput>
<cffile action="write" file="#expandPath("/includes/navigation")#\menu.xml" output="#trim(theXml)#">