<cfcomponent name="productService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.productService">
		<cfset super.init(entityName="Product") />
		<cfreturn this/>
	</cffunction>

	<cffunction name="createproduct" access="public" output="false" returntype="any">
			
		<cfreturn new("Product") />
	</cffunction>

	<cffunction name="getproduct" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("Product",arguments.id) />
	</cffunction>

	<cffunction name="getproducts" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="model" type="String" required="false" />
		<cfargument name="summary" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="views" type="Numeric" required="false" />
		<cfargument name="islive" type="Boolean" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"model") and len(arguments.model)>
			<cfset map.model = arguments.model />
		</cfif>
		<cfif structKeyExists(arguments,"summary") and len(arguments.summary)>
			<cfset map.summary = arguments.summary />
		</cfif>
		<cfif structKeyExists(arguments,"content") and len(arguments.content)>
			<cfset map.content = arguments.content />
		</cfif>
		<cfif structKeyExists(arguments,"views") and len(arguments.views)>
			<cfset map.views = arguments.views />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
	<cfreturn entityLoad("Product",map) />
	</cffunction>
	
	<cffunction name="getProductsByStreamFormat" access="public" output="false" returntype="query">
		<cfargument name="isvideo" type="Numeric" required="false" />
		<cfargument name="isaudio" type="Numeric" required="false" />
		<cfset var rs = "">
		<cfquery name="rs" datasource="#datasource#">
			<cfif structKeyExists(arguments,"isvideo") and len(arguments.isvideo)>
				SELECT Product.id, Product.title, Product.Model FROM products AS Product JOIN product_streams AS Stream WHERE Stream.isvideo = 1
			<cfelseif structKeyExists(arguments,"isaudio") and len(arguments.isaudio)>
				SELECT Product.id, Product.title, Product.Model FROM products AS Product JOIN product_streams AS Stream WHERE Stream.isaudio = 1
			</cfif>
		</cfquery>
		
		<cfreturn rs />
	</cffunction>
	
	<cffunction name="getProductsBySection" access="public" output="false" returntype="query">
		<cfargument name="sectionid" type="Numeric" required="false" />
		<cfset var rs = "">
		<cfquery name="rs" datasource="#datasource#">
			FROM products AS Product JOIN product_sections AS Section WHERE Section.id = <cfqueryparam value="#arguments.sectionid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfreturn rs />
	</cffunction>
    
    <cffunction name="getProductsBySize" access="public" output="false" returntype="query">
		<cfargument name="sizeid" type="Numeric" required="false" />
		<cfset var rs = "">
		<cfquery name="rs" datasource="#datasource#">
			FROM products AS Product JOIN product_sizes AS Size WHERE Size.id = <cfqueryparam value="#arguments.sizeid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfreturn rs />
	</cffunction>
	
	<cffunction name="getProductsByFormat" access="public" output="false" returntype="query">
		<cfargument name="formatid" type="Numeric" required="false" />
		<cfset var rs = "">
		<cfquery name="rs" datasource="#datasource#">
			FROM products AS Product JOIN product_items JOIN product.format AS Format WHERE Format.id = <cfqueryparam value="#arguments.formatid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfreturn rs />
	</cffunction>
	
	<cffunction name="getFeaturedProducts" access="public" output="false" returntype="query">
		<cfargument name="curdate" required="false" default="#dateFormat(now(),"yyyy-mm-dd")#">
		<cfset var rs = "" />
		<cfquery name="rs" datasource="#datasource#">
			SELECT *, Featured.id as fid FROM products as Product
			JOIN product_featured as Featured
			WHERE Product.islive = 1
			AND Featured.islive = 1
			AND Featured.datestart < <cfqueryparam value="#arguments.curdate#" cfsqltype="cf_sql_date" />
			AND Featured.dateend > <cfqueryparam value="#arguments.curdate#" cfsqltype="cf_sql_date" />
			ORDER BY Featured.dateend DESC
		</cfquery>
		
		<cfreturn rs>
	</cffunction>

	<cffunction name="saveproduct" access="public" output="false" returntype="void">
		<cfargument name="product" type="any" required="true" />
		
		<cfset save(arguments.product) />
	</cffunction>

	<cffunction name="deleteproduct" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var product = get("product",arguments.id) />
		<cfset delete(product) />
	</cffunction>
	
	<!--- Customer Methods --->
	
	<cffunction name="createcustomer" access="public" output="false" returntype="any">
			
		<cfreturn new("Customer") />
	</cffunction>

	<cffunction name="getcustomer" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("customer",arguments.id) />
	</cffunction>

	<cffunction name="getcustomers" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="firstname" type="String" required="false" />
		<cfargument name="lastname" type="String" required="false" />
		<cfargument name="street1" type="String" required="false" />
		<cfargument name="street2" type="String" required="false" />
		<cfargument name="postal" type="Numeric" required="false" />
		<cfargument name="city" type="String" required="false" />
		<cfargument name="state" type="String" required="false" />
		<cfargument name="country" type="String" required="false" />
		<cfargument name="ship_street1" type="String" required="false" />
		<cfargument name="ship_street2" type="String" required="false" />
		<cfargument name="ship_city" type="String" required="false" />
		<cfargument name="ship_state" type="String" required="false" />
		<cfargument name="ship_postal" type="Numeric" required="false" />
		<cfargument name="ship_country" type="String" required="false" />
		<cfargument name="affiliate" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"firstname") and len(arguments.firstname)>
			<cfset map.firstname = arguments.firstname />
		</cfif>
		<cfif structKeyExists(arguments,"lastname") and len(arguments.lastname)>
			<cfset map.lastname = arguments.lastname />
		</cfif>
		<cfif structKeyExists(arguments,"street1") and len(arguments.street1)>
			<cfset map.street1 = arguments.street1 />
		</cfif>
		<cfif structKeyExists(arguments,"street2") and len(arguments.street2)>
			<cfset map.street2 = arguments.street2 />
		</cfif>
		<cfif structKeyExists(arguments,"postal") and len(arguments.postal)>
			<cfset map.postal = arguments.postal />
		</cfif>
		<cfif structKeyExists(arguments,"city") and len(arguments.city)>
			<cfset map.city = arguments.city />
		</cfif>
		<cfif structKeyExists(arguments,"state") and len(arguments.state)>
			<cfset map.state = arguments.state />
		</cfif>
		<cfif structKeyExists(arguments,"country") and len(arguments.country)>
			<cfset map.country = arguments.country />
		</cfif>
		<cfif structKeyExists(arguments,"ship_street1") and len(arguments.ship_street1)>
			<cfset map.ship_street1 = arguments.ship_street1 />
		</cfif>
		<cfif structKeyExists(arguments,"ship_street2") and len(arguments.ship_street2)>
			<cfset map.ship_street2 = arguments.ship_street2 />
		</cfif>
		<cfif structKeyExists(arguments,"ship_city") and len(arguments.ship_city)>
			<cfset map.ship_city = arguments.ship_city />
		</cfif>
		<cfif structKeyExists(arguments,"ship_state") and len(arguments.ship_state)>
			<cfset map.ship_state = arguments.ship_state />
		</cfif>
		<cfif structKeyExists(arguments,"ship_postal") and len(arguments.ship_postal)>
			<cfset map.ship_postal = arguments.ship_postal />
		</cfif>
		<cfif structKeyExists(arguments,"ship_country") and len(arguments.ship_country)>
			<cfset map.ship_country = arguments.ship_country />
		</cfif>
		<cfif structKeyExists(arguments,"affiliate") and len(arguments.affiliate)>
			<cfset map.affiliate = arguments.affiliate />
		</cfif>
		
		<cfreturn entityLoad("ProductCustomer",map) />
	</cffunction>

	<cffunction name="savecustomer" access="public" output="false" returntype="void">
		<cfargument name="customer" type="any" required="true" />
		
		<cfset save(arguments.customer) />
	</cffunction>

	<cffunction name="deletecustomer" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var customer = get("customer",arguments.id) />
		<cfset delete(customer) />
	</cffunction>
	
	<!--- Featured Methods --->
	
	<cffunction name="createfeatured" access="public" output="false" returntype="any">
			
		<cfreturn new("Featured") />
	</cffunction>

	<cffunction name="getfeatured" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("featured",arguments.id) />
	</cffunction>

	<cffunction name="getfeatureds" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="start" type="String" required="false" />
		<cfargument name="end" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"start") and len(arguments.start)>
			<cfset map.start = arguments.start />
		</cfif>
		<cfif structKeyExists(arguments,"end") and len(arguments.end)>
			<cfset map.end = arguments.end />
		</cfif>
		
		<cfreturn entityLoad("ProductFeatured",map) />
	</cffunction>

	<cffunction name="savefeatured" access="public" output="false" returntype="void">
		<cfargument name="featured" type="any" required="true" />
		
		<cfset save(arguments.featured) />
	</cffunction>

	<cffunction name="deletefeatured" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var feature = get("featured",arguments.id) />
		<cfset delete(feature) />
	</cffunction>
	
	<!--- Format Methods --->
	
	<cffunction name="createformat" access="public" output="false" returntype="any">
			
		<cfreturn new("Format") />
	</cffunction>

	<cffunction name="getformat" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("format",arguments.id) />
	</cffunction>

	<cffunction name="getformats" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="prefix" type="String" required="false" />
		<cfargument name="islive" type="Boolean" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"prefix") and len(arguments.prefix)>
			<cfset map.prefix = arguments.prefix />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn entityLoad("ProductFormat",map) />
	</cffunction>

	<cffunction name="saveformat" access="public" output="false" returntype="void">
		<cfargument name="format" type="any" required="true" />
		
		<cfset save(arguments.format) />
	</cffunction>

	<cffunction name="deleteformat" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var format = get("format",arguments.id) />
		<cfset delete(format) />
	</cffunction>
	
	<!--- Item Methods --->
	
	<cffunction name="createitem" access="public" output="false" returntype="any">
			
		<cfreturn new("Item") />
	</cffunction>

	<cffunction name="getitem" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("item",arguments.id) />
	</cffunction>

	<cffunction name="getitems" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="product_id" type="Numeric" required="false" />
		<cfargument name="product_format_id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="price" type="Numeric" required="false" />
		<cfargument name="isspecial" type="Boolean" required="false" />
		<cfargument name="specialprice" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"product_id") and len(arguments.product_id)>
			<cfset map.product_id = arguments.product_id />
		</cfif>
		<cfif structKeyExists(arguments,"product_format_id") and len(arguments.product_format_id)>
			<cfset map.product_format_id = arguments.product_format_id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"price") and len(arguments.price)>
			<cfset map.price = arguments.price />
		</cfif>
		<cfif structKeyExists(arguments,"isspecial") and len(arguments.isspecial)>
			<cfset map.isspecial = arguments.isspecial />
		</cfif>
		<cfif structKeyExists(arguments,"specialprice") and len(arguments.specialprice)>
			<cfset map.specialprice = arguments.specialprice />
		</cfif>
		
		<cfreturn entityLoad("ProductItem",map) />
	</cffunction>

	<cffunction name="saveitem" access="public" output="false" returntype="void">
		<cfargument name="item" type="any" required="true" />
		
		<cfset save(arguments.item) />
	</cffunction>

	<cffunction name="deleteitem" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var item = get("item",arguments.id) />
		<cfset delete(item) />
	</cffunction>
	
	<!--- Review Methods --->
	
	<cffunction name="createreview" access="public" output="false" returntype="any">
			
		<cfreturn new("Review") />
	</cffunction>

	<cffunction name="getreview" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("review",arguments.id) />
	</cffunction>

	<cffunction name="getreviews" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="product_id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="author" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="islive" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"product_id") and len(arguments.product_id)>
			<cfset map.product_id = arguments.product_id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"author") and len(arguments.author)>
			<cfset map.author = arguments.author />
		</cfif>
		<cfif structKeyExists(arguments,"content") and len(arguments.content)>
			<cfset map.content = arguments.content />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn entityLoad("ProductReview",map) />
	</cffunction>

	<cffunction name="savereview" access="public" output="false" returntype="void">
		<cfargument name="review" type="any" required="true" />
		
		<cfset save(arguments.review) />
	</cffunction>

	<cffunction name="deletereview" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var review = get("review",arguments.id) />
		<cfset delete(review) />
	</cffunction>
	
	<!--- Section Methods --->
	
	<cffunction name="createsection" access="public" output="false" returntype="any">
			
		<cfreturn new("Section") />
	</cffunction>

	<cffunction name="getsection" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("section",arguments.id) />
	</cffunction>

	<cffunction name="getsections" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="views" type="Numeric" required="false" />
		<cfargument name="islive" type="Boolean" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"views") and len(arguments.views)>
			<cfset map.views = arguments.views />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn entityLoad("ProductSection",map) />
	</cffunction>

	<cffunction name="savesection" access="public" output="false" returntype="void">
		<cfargument name="section" type="any" required="true" />
		
		<cfset save(arguments.section) />
	</cffunction>

	<cffunction name="deletesection" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var section = get("section",arguments.id) />
		<cfset delete(section) />
	</cffunction>
    
    <!--- Size Methods --->
	
	<cffunction name="createsize" access="public" output="false" returntype="any">
			
		<cfreturn new("Size") />
	</cffunction>

	<cffunction name="getsize" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("size",arguments.id) />
	</cffunction>

	<cffunction name="getsizes" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="islive" type="Boolean" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn entityLoad("ProductSize",map) />
	</cffunction>

	<cffunction name="savesize" access="public" output="false" returntype="void">
		<cfargument name="size" type="any" required="true" />
		
		<cfset save(arguments.size) />
	</cffunction>

	<cffunction name="deletesize" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var size = get("size",arguments.id) />
		<cfset delete(size) />
	</cffunction>
	
	<!--- Stream Methods --->
	
	<cffunction name="createstream" access="public" output="false" returntype="any">
			
		<cfreturn new("Stream") />
	</cffunction>

	<cffunction name="getstream" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("stream",arguments.id) />
	</cffunction>

	<cffunction name="getstreams" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="isaudio" type="Boolean" required="false" />
		<cfargument name="isvideo" type="Boolean" required="false" />
		<cfargument name="views" type="Numeric" required="false" />
		<cfargument name="islive" type="Boolean" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"isaudio") and len(arguments.isaudio)>
			<cfset map.isaudio = arguments.isaudio />
		</cfif>
		<cfif structKeyExists(arguments,"isvideo") and len(arguments.isvideo)>
			<cfset map.isvideo = arguments.isvideo />
		</cfif>
		<cfif structKeyExists(arguments,"views") and len(arguments.views)>
			<cfset map.views = arguments.views />
		</cfif>
		<cfif structKeyExists(arguments,"islive") and len(arguments.islive)>
			<cfset map.islive = arguments.islive />
		</cfif>
		
		<cfreturn entityLoad("ProductStream",map) />
	</cffunction>
	
	<cffunction name="getStreamsByFormatAndProduct" access="public" output="false" returntype="query">
		<cfargument name="isvideo" type="Numeric" required="false" />
		<cfargument name="isaudio" type="Numeric" required="false" />
		<cfargument name="productid" type="numeric" required="true" />
		<cfset var rs = "">
		
		<cfquery name="rs" datasource="#datasource#">
			<cfif structKeyExists(arguments,"isvideo") and len(arguments.isvideo)>
				SELECT *, Product.model FROM product_streams AS Stream JOIN products AS Product WHERE Product.id = <cfqueryparam value="#arguments.productid#" cfsqltype="cf_sql_integer" /> AND Stream.isvideo = 1
			<cfelseif structKeyExists(arguments,"isaudio") and len(arguments.isaudio)>
				SELECT *, Product.model FROM product_streams AS Stream JOIN products AS Product WHERE Product.id = <cfqueryparam value="#arguments.productid#" cfsqltype="cf_sql_integer" /> AND Stream.isaudio = 1
			</cfif>
		</cfquery>
		
		<cfreturn rs />
	</cffunction>

	<cffunction name="savestream" access="public" output="false" returntype="void">
		<cfargument name="stream" type="any" required="true" />
		
		<cfset save(arguments.stream) />
	</cffunction>

	<cffunction name="deletestream" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var stream = get("stream",arguments.id) />
		<cfset delete(stream) />
	</cffunction>
    
    <!--- product image --->
    
    <cffunction name="createImage" access="public" output="false" returntype="any">
			
		<cfreturn new("Image") />
	</cffunction>

	<cffunction name="getImage" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("image",arguments.id) />
	</cffunction>

	<cffunction name="getImages" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="image" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"image") and len(arguments.image)>
			<cfset map.image = arguments.image />
		</cfif>
		
		<cfreturn entityLoad("ProductImage",map) />
	</cffunction>

	<cffunction name="saveImage" access="public" output="false" returntype="void">
		<cfargument name="image" type="any" required="true" />
		
		<cfset save(arguments.image) />
	</cffunction>

	<cffunction name="deleteImage" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var image = get("image",arguments.id) />
		<cfset delete(image) />
	</cffunction>
	
</cfcomponent>