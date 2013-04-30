<cfcomponent hint="Provides function for local control of orders" output="false">

<!---
*******************************************************************************
 Copyright (C) 2007 Scott Pinkston

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*******************************************************************************

Component: gCheckoutOrders.cfc
Created By: Scott Pinkston (spinkston@ozarka.edu)
Creation Date: 4/29/2007
Description: Provides local functions for orders.  This file should be changed to handle your
local functions, such as entering new orders into your database or recording payments
History:
	4/29/2007 - initial release

 --->
	<cfset this = structNew() />
	
	<cffunction name="NewOrders" output="false" returntype="void" hint="Process the new order">
		<cfargument name="orderData" type="struct" required="yes">
		<cfargument name="orderNumber" type="numeric" required="yes">
		<cfset this.orderData = "#arguments.orderData#" />
		<cfset this.orderNumber = "#arguments.orderNumber#" />
		
        <cfset insertOrder() />
		<cfset insertShipping() />
		<cfset insertBilling() />
		<cfset insertOrderItems() />

	</cffunction>
	
	<cffunction name="insertOrder" output="false" returntype="numeric" hint="Persist order">
		<cfset var qOrder ="">
		
		<cfquery name="qOrder" datasource="#application.dsn#">
        	INSERT INTO orders(ordernumber,
                tax,
                shipping,
                total)
             VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.orderNumber#" />,
			 	<cfqueryparam cfsqltype="cf_sql_double" value="#this.orderData.orderTax#" />,
				<cfqueryparam cfsqltype="cf_sql_double" value="#this.orderData.orderShipping#" />,
				<cfqueryparam cfsqltype="cf_sql_double" value="#this.orderData.orderAmount#" />)
        </cfquery>
		
	</cffunction>
	
	<cffunction name="insertOrderItems" output="false" returntype="void" hint="Persist order items">
		<cfset var qOrderItems ="">
		
		<cftry>
		
		<cfloop collection="#this.orderData.cart_items#" item="i">
			<cfquery name="qOrderItems" datasource="#application.dsn#">
				INSERT INTO order_items(ordernumber,
					title,
					description,
					quantity,
					price,
					donation)
				 VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.orderNumber#" />,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.cart_items[i].item_name#" />,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.cart_items[i].item_description#" />,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#this.orderData.cart_items[i].item_quantity#" />,
					<cfqueryparam cfsqltype="cf_sql_double" value="#this.orderData.cart_items[i].item_price#" />,
					<cfqueryparam cfsqltype="cf_sql_double" value="#this.orderData.cart_items[i].item_donation#" />)
			</cfquery>
		</cfloop>
			<cfcatch type="any">
				<cfmail from="webservant@revivalseminars.org" to="webservant@revivalseminars.org" subject="Order Items Error" type="html">
					<cfoutput>
					 <!--- and the diagnostic message from the ColdFusion server --->
					 <p>#cfcatch.message#</p>
					 <p>Caught an exception, type = #CFCATCH.TYPE# </p>
					 <p>The contents of the tag stack are:</p>
					 <cfloop index = j from = 1 
						   to = #ArrayLen(CFCATCH.TAGCONTEXT)#>
						<cfset sCurrent = "#CFCATCH.TAGCONTEXT[j]#">
						<br>#j# #sCurrent["ID"]# 
						   (#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) 
						   #sCurrent["TEMPLATE"]#
					 </cfloop>
				  </cfoutput>
				</cfmail>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="insertShipping" output="false" returntype="numeric" hint="Persist order">
		<cfset var qShipping ="">
		
		<cfquery name="qShipping" datasource="#application.dsn#">
        	INSERT INTO order_shipping(ordernumber,
                name,
                street1,
                street2,
				city,
				state,
				postal,
				country)
             VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.orderNumber#" />,
			 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.shipping.contact_name#" />,
			 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.shipping.address1#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.shipping.address2#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.shipping.city#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.shipping.state#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.shipping.postal_code#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.shipping.country_code#" />)
        </cfquery>
		
	</cffunction>
	
	<cffunction name="insertBilling" output="false" returntype="numeric" hint="Persist order">
		<cfset var qBilling ="">
		
		<cfquery name="qBilling" datasource="#application.dsn#">
        	INSERT INTO order_billing(ordernumber,
                name,
                street1,
                street2,
				city,
				state,
				postal,
				country)
             VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.orderNumber#" />,
			 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.billing.contact_name#" />,
			 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.billing.address1#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.billing.address2#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.billing.city#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.billing.state#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.billing.postal_code#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderData.billing.country_code#" />)
        </cfquery>
		
	</cffunction>

 	<cffunction name="OrderStateChangeNotification" output="false" returntype="String" hint="Change order state">
		<cfargument name="OrderData" type="struct" required="yes">
		<cfargument name="orderNumber" type="string" required="yes">

		<cfreturn>
	</cffunction>

	<cffunction name="ChargeAmountNotification" output="true" returntype="String" hint="add records of the payment">
		<cfargument name="OrderData" type="struct" required="yes">
		<cfargument name="orderNumber" type="string" required="yes">

		<cfreturn>
	</cffunction>

	<cffunction name="ChargebackAmountNotification" output="false" returntype="String" hint="Processes chargeback notifications">
		<cfargument name="OrderData" type="struct" required="yes">
		<cfargument name="orderNumber" type="string" required="yes">

		<cfreturn>
	</cffunction>

	<cffunction name="RefundAmountNotification" output="false" returntype="String" hint="process refund amounts">
		<cfargument name="OrderData" type="struct" required="yes">
		<cfargument name="orderNumber" type="string" required="yes">

		<cfreturn>
	</cffunction>

	<cffunction name="RiskInformationNotification" output="false" returntype="String" hint="Process risk notifications">
		<cfargument name="OrderData" type="struct" required="yes">
		<cfargument name="orderNumber" type="string" required="yes">

		<cfreturn>
	</cffunction>
</cfcomponent>