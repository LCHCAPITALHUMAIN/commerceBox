<cfcomponent name="cart" extends="coldbox.system.eventhandler" output="false">
	
	<cffunction name="preHandler" access="public" returntype="void" output="false">
    	<cfargument name="event" required="true">
	</cffunction>
    
    <cffunction name="init" access="public" returntype="cart" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfset gCart = getPlugin("sessionstorage").getVar("gCart")>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var queryString ="">
		<cfset rc.xehUpdateCart = "cart/doUpdate">
		<cfset rc.xehEmptyCart = "cart/doEmpty">
		<cfset rc.xehAddtoCart = "cart/doAdd">
		<cfset rc.xehAddtoCartAjax = "cart/doAddAjax">
		<cfset rc.xehContinue = "cart/doContinue">
		<cfset rc.gCart = gCart>
		<cfset rc.gCartItems = gCart.getCartItems()>
		<cfif structKeyExists(rc,"cartLook")>
			<cfsetting showdebugoutput="false" >
			<cfset event.showdebugpanel("false")>
			<cfset event.setView(name="cartLook",nolayout="true")>
		<cfelseif  structKeyExists(rc,"cartHeader")>
			<cfsetting showdebugoutput="false" >
			<cfset event.showdebugpanel("false")>
			<cfset event.setView(name="cartHeader",nolayout="true")>
		<cfelse>
			<cfset event.setView("cart")>
		</cfif>
	</cffunction>
	
	<cffunction name="doAdd" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfset var rc = event.getCollection()>
        
		<cfset gCart.addCartItem(event.getValue("model"),event.getValue("title"),event.getValue("description"),event.getValue("price"),event.getValue("size",""),event.getValue("quantity"))>
		<cfset setNextRoute("cart")>
	</cffunction>
	
	<cffunction name="doAddAjax" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfset var rc = event.getCollection()>
        
		<cfset gCart.addCartItem(event.getValue("model"),event.getValue("title"),event.getValue("description"),event.getValue("price"),event.getValue("size",""),event.getValue("quantity"))>
		<cfset event.noRender()>
		<!---<cfset event.renderData('JSON','Cart updated')>--->
	</cffunction>
	
	<cffunction name="doEmpty" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfset gCart.emptyCart()>
		<cfset setNextRoute("product")>
	</cffunction>
	
	<cffunction name="doUpdate" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		<cfset var rc = event.getCollection()>
		
		<cfloop list="#rc.FIELDNAMES#" index="i">
			<cfif i NEQ "updateCart" AND i NEQ "SIZE">
				<cfset gCart.UpdateCartItem(model=i,quantity=rc[i])>
			</cfif>
		</cfloop>
		
		<cfif NOT gCart.GetCartItems().recordcount>
			<cfset setNextEvent("product")>
		</cfif>
			<cfset setNextRoute("cart")>
	</cffunction>
	
	<cffunction name="doContinue" access="public" returntype="void" output="false">
		<cfargument name="event" required="yes">
		
		<cfset setNextRoute("product")>
	</cffunction>
</cfcomponent>