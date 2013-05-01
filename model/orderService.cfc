<cfcomponent name="orderService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.orderService">
		<cfset super.init(entityName="Order") />
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="createorder" access="public" output="false" returntype="any">
			
		<cfreturn new("Order") />
	</cffunction>

	<cffunction name="getorder" access="public" output="false" returntype="any">
		<cfargument name="id" type="String" required="true" />

		<cfreturn get("Order",arguments.id) />
	</cffunction>

	<cffunction name="getorders" access="public" output="false" returntype="any">
		<cfargument name="id" type="String" required="false" />
		<cfargument name="tax" type="Numeric" required="false" />
		<cfargument name="shipping" type="Numeric" required="false" />
		<cfargument name="total" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"tax") and len(arguments.tax)>
			<cfset map.tax = arguments.tax />
		</cfif>
		<cfif structKeyExists(arguments,"shipping") and len(arguments.shipping)>
			<cfset map.shipping = arguments.shipping />
		</cfif>
		<cfif structKeyExists(arguments,"total") and len(arguments.total)>
			<cfset map.total = arguments.total />
		</cfif>
		
		<cfreturn entityLoad("order.order",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="saveorder" access="public" output="false" returntype="void">
		<cfargument name="order" type="any" required="true" />
		
		<cfset save(arguments.order) />
	</cffunction>

	<cffunction name="deleteorder" access="public" output="false" returntype="void">
		<cfargument name="id" type="String" required="true" />
		
		<cfset var order = get("Order",arguments.id) />
		<cfset delete(order) />
	</cffunction>
	
	<!--- Billing Methods --->

	<cffunction name="createbilling" access="public" output="false" returntype="any">
			
		<cfreturn new("OrderBillingAddress") />
	</cffunction>

	<cffunction name="getbilling" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("OrderBillingAddress",arguments.id) />
	</cffunction>

	<cffunction name="getBillings" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="order_id" type="String" required="false" />
		<cfargument name="name" type="String" required="false" />
		<cfargument name="street1" type="String" required="false" />
		<cfargument name="street2" type="String" required="false" />
		<cfargument name="city" type="String" required="false" />
		<cfargument name="state" type="String" required="false" />
		<cfargument name="postal" type="String" required="false" />
		<cfargument name="country" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"order_id") and len(arguments.order_id)>
			<cfset map.order_id = arguments.order_id />
		</cfif>
		<cfif structKeyExists(arguments,"name") and len(arguments.name)>
			<cfset map.name = arguments.name />
		</cfif>
		<cfif structKeyExists(arguments,"street1") and len(arguments.street1)>
			<cfset map.street1 = arguments.street1 />
		</cfif>
		<cfif structKeyExists(arguments,"street2") and len(arguments.street2)>
			<cfset map.street2 = arguments.street2 />
		</cfif>
		<cfif structKeyExists(arguments,"city") and len(arguments.city)>
			<cfset map.city = arguments.city />
		</cfif>
		<cfif structKeyExists(arguments,"state") and len(arguments.state)>
			<cfset map.state = arguments.state />
		</cfif>
		<cfif structKeyExists(arguments,"postal") and len(arguments.postal)>
			<cfset map.postal = arguments.postal />
		</cfif>
		<cfif structKeyExists(arguments,"country") and len(arguments.country)>
			<cfset map.country = arguments.country />
		</cfif>
		
		<cfreturn entityLoad("order.billing",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="savebilling" access="public" output="false" returntype="void">
		<cfargument name="billing" type="any" required="true" />
		
		<cfset save(arguments.billing) />
	</cffunction>

	<cffunction name="deletebilling" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var billing = get("OrderBillingAddress",arguments.id) />
		<cfset delete(billing) />
	</cffunction>
	
	<!--- Item Methods --->
	
	<cffunction name="createitem" access="public" output="false" returntype="any">
			
		<cfreturn new("OrderItem") />
	</cffunction>

	<cffunction name="getitem" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("OrderItem",arguments.id) />
	</cffunction>

	<cffunction name="getitems" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="order_id" type="String" required="false" />
		<cfargument name="title" type="String" required="false" />
		<cfargument name="description" type="String" required="false" />
		<cfargument name="quantity" type="Numeric" required="false" />
		<cfargument name="price" type="Numeric" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"order_id") and len(arguments.order_id)>
			<cfset map.order_id = arguments.order_id />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			<cfset map.title = arguments.title />
		</cfif>
		<cfif structKeyExists(arguments,"description") and len(arguments.description)>
			<cfset map.description = arguments.description />
		</cfif>
		<cfif structKeyExists(arguments,"quantity") and len(arguments.quantity)>
			<cfset map.quantity = arguments.quantity />
		</cfif>
		<cfif structKeyExists(arguments,"price") and len(arguments.price)>
			<cfset map.price = arguments.price />
		</cfif>
		
		<cfreturn entityLoad("order.item",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="saveitem" access="public" output="false" returntype="void">
		<cfargument name="item" type="any" required="true" />
		
		<cfset save(arguments.item) />
	</cffunction>

	<cffunction name="deleteitem" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var item = get("OrderItem",arguments.id) />
		<cfset delete(item) />
	</cffunction>
	
	<!--- Shipping Methods --->
	
	<cffunction name="createshipping" access="public" output="false" returntype="any">
			
		<cfreturn new("OrderShippingAddress") />
	</cffunction>

	<cffunction name="getshipping" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("OrderShippingAddress",arguments.id) />
	</cffunction>

	<cffunction name="getshippings" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="order_id" type="String" required="false" />
		<cfargument name="name" type="String" required="false" />
		<cfargument name="street1" type="String" required="false" />
		<cfargument name="street2" type="String" required="false" />
		<cfargument name="city" type="String" required="false" />
		<cfargument name="state" type="String" required="false" />
		<cfargument name="postal" type="String" required="false" />
		<cfargument name="country" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"order_id") and len(arguments.order_id)>
			<cfset map.order_id = arguments.order_id />
		</cfif>
		<cfif structKeyExists(arguments,"name") and len(arguments.name)>
			<cfset map.name = arguments.name />
		</cfif>
		<cfif structKeyExists(arguments,"street1") and len(arguments.street1)>
			<cfset map.street1 = arguments.street1 />
		</cfif>
		<cfif structKeyExists(arguments,"street2") and len(arguments.street2)>
			<cfset map.street2 = arguments.street2 />
		</cfif>
		<cfif structKeyExists(arguments,"city") and len(arguments.city)>
			<cfset map.city = arguments.city />
		</cfif>
		<cfif structKeyExists(arguments,"state") and len(arguments.state)>
			<cfset map.state = arguments.state />
		</cfif>
		<cfif structKeyExists(arguments,"postal") and len(arguments.postal)>
			<cfset map.postal = arguments.postal />
		</cfif>
		<cfif structKeyExists(arguments,"country") and len(arguments.country)>
			<cfset map.country = arguments.country />
		</cfif>
		
		<cfreturn entityLoad("order.shipping",map,arguments.orderby,arguments.orderasc) />
	</cffunction>

	<cffunction name="saveshipping" access="public" output="false" returntype="void">
		<cfargument name="shipping" type="any" required="true" />
		
		<cfset save(arguments.shipping) />
	</cffunction>

	<cffunction name="deleteshipping" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var shipping = get("OrderShippingAddress",arguments.id) />
		<cfset delete(shipping) />
	</cffunction>
	
</cfcomponent>