<?xml version="1.0" encoding="iso-8859-1"?>
<!-- DWXMLSource="http://whitehorsemedia.com/inc/navigation/menu.xml" -->
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY mdash  "&#8212;">
	<!ENTITY ldquo  "&#8220;">
	<!ENTITY rdquo  "&#8221;"> 
	<!ENTITY pound  "&#163;">
	<!ENTITY yen    "&#165;">
	<!ENTITY euro   "&#8364;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="iso-8859-1"/>
	<xsl:template match="/">
		<ul>
			<xsl:for-each select="menu/item">
				<xsl:if test="position()=1">
					<li><a href="{@link}" title="{@name}"><xsl:value-of select="@name"/></a></li>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="menu/menu">
				<li><a href="{@link}" title="{@name}"><xsl:value-of select="@name"/></a></li>
			</xsl:for-each>
			<xsl:for-each select="menu/item">
				<xsl:if test="position()=last()">
					<xsl:if test="position()!=1">
						<li><a href="{@link}" title="{@name}"><xsl:value-of select="@name"/></a></li>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</ul>
	</xsl:template>
</xsl:stylesheet>