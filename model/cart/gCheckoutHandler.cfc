<cfcomponent name="gCheckoutHandler" displayname="gCheckoutHandler" hint="Processes the Response from Google" extends="gCheckoutCart">
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

Component: gCheckOutHandler
Created By: Scott Pinkston (spinkston@ozarka.edu)
Creation Date: 7/2/2006
Description:
Provides the response (notification API) and calls the response action

Change Log:
12/28/06 Rey Bango: Changed cfargument datatype for XMLData from XML to String to allow CFMX 6.1 to accept
the XML doc from Google
12/28/06 Rey Bango: Removed the loading of order.cart_items since CFMX 6.1 was not accepting the syntax for
referencing the XML nodes
12/29/06 -- Added ability to get a user defined order id
4/29/07 -- moved logging function to googlecheckout
		-- added calls to orders.cfc functions for each of the Google Notification API calls
		   this should let sites make changes to orders.cfc and hopefully they can leave this file alone

--->

	<cffunction name="OrderProcessingAPI" output="false" returntype="void" hint="Provides Level 2 intergration, sends API Commands to google">
		<cfargument name="orderType" type="string" required="true">
		<Cfargument name="orderNumber" type="string" required="true">
		<cfset var xmlData = "">

			<cfoutput>
				<cfsavecontent variable="xmldata"><?xml version="1.0" encoding="UTF-8"?>
					<#arguments.ordertype# xmlns="http://checkout.google.com/schema/2" google-order-number="#arguments.orderNumber#"/>
				</cfsavecontent>
			</cfoutput>

			<cfhttp method="post" username="#getMerchantID()#" password="#getMerchantKey()#" url="#variables.g_url##GetMerchantID()#/request">
				<cfhttpparam type="header" name="Content-type" value="application/xml">
				<cfhttpparam type="header" name="Accept" value="application/xml">
				<cfhttpparam type="xml" value="#xmlData#">
			</cfhttp>

	</cffunction>

	<cffunction name="ProcessXmlData" output="true" returntype="xml" hint="Parses the XML response from google" access="remote">
		<cfargument name="XMLData" required="true">
		<cfset var myDOM = "">
		<cfset var type= "">
		<cfset var responseType = "">
		<cfset var logText = "">

        <cfif isBinary(XMLData)>
			<cfset myDOM = XmlParse(toString(XMLData))>
		<cfelse>
			<cfset myDOM = XmlParse(XMLData)>
		</cfif>

		<cfset type = structKeyList(myDOM)>

		<cfswitch expression="#type#">
			<cfcase value="new-order-notification">
				<!--- <new-order-notification> received --->
				<cfset ProcessNewOrderNotification(myDOM)>
			</cfcase>

			<cfcase value="order-state-change-notification">
				<!--- <order-state-change-notification> received --->
				<cfset ProcessOrderStateChangeNotification(myDOM)>
			</cfcase>

			<cfcase value="charge-amount-notification">
				<!--- <charge-amount-notification> received --->
				<cfset ProcessChargeAmountNotification(myDOM)>
			</cfcase>

			<cfcase value="chargeback-amount-notification">
				<!--- <chargeback-amount-notification> received --->
				<cfset ProcessChargebackAmountNotification(myDOM)>
			</cfcase>

			<cfcase value="refund-amount-notification">
				<!--- <refund-amount-notification> received --->
				<cfset ProcessRefundAmountNotification(myDOM)>
			</cfcase>

			<cfcase value="risk-information-notification">
				<!--- <refund-amount-notification> received --->
				<cfset ProcessRiskInformationNotification(myDOM)>
			</cfcase>
		</cfswitch>

		<cfreturn myDOM>
	</cffunction>

	<cffunction name="ProcessNewOrderNotification" output="true" returntype="Any" hint="Process the new order notifications">
		<cfargument name="XMLData" type="xml" required="yes">

		<cfset var responseType="new-order-notification">
		<cfset var OrderNumber = XMLData["new-order-notification"]["google-order-number"].xmltext>
		<cfset var OrderAmount = XMLData["new-order-notification"]["order-total"].xmltext >
        <cfset var OrderTax = XMLData["new-order-notification"]["order-adjustment"]["total-tax"].xmltext>
        <cfset var OrderShipping = XMLData["new-order-notification"]["order-adjustment"]["shipping"]["flat-rate-shipping-adjustment"]["shipping-cost"].xmltext>
		<cfset var CustID = "">
		<cfset var OrderID = "">
		<cfset var order = structNew()>

		<!--- 12/29/06 -- Added ability to get a user defined order id --->
		<cfif structKeyExists(XMLData["new-order-notification"]["shopping-cart"],"merchant-private-data")>

			<cfif structKeyExists(XMLData["new-order-notification"]["shopping-cart"]["merchant-private-data"],"checkoutcfc")>
				<cfif structKeyExists(XMLData["new-order-notification"]["shopping-cart"]["merchant-private-data"]["checkoutcfc"],"custid")>
					<cfset CustID = XMLData["new-order-notification"]["shopping-cart"]["merchant-private-data"]["checkoutcfc"]["custid"].xmltext>
				</cfif>

				<cfif structKeyExists(XMLData["new-order-notification"]["shopping-cart"]["merchant-private-data"]["checkoutcfc"],"orderid")>
					<cfset OrderID = XMLData["new-order-notification"]["shopping-cart"]["merchant-private-data"]["checkoutcfc"]["orderid"].xmltext>
				</cfif>
			</cfif>
		</cfif>

		<cfset order.billing = structNew()>
		<cfset order.shipping = structNew()>
		<cfset order.cart_items = structNew()>

		<!--- Add basic order information --->
			<cfset order.custID = custID>
			<cfset order.orderID = orderID>
			<cfset order.orderNumber = orderNumber>
			<cfset order.orderAmount = orderAmount>
            <cfset order.orderTax = orderTax>
            <cfset order.orderShipping = orderShipping>

		<!--- add shipping information to order structure  --->
			<cfset order.shipping.contact_name = XMLData["new-order-notification"]["buyer-shipping-address"]["contact-name"].xmltext>
			<cfset order.shipping.address1 = XMLData["new-order-notification"]["buyer-shipping-address"]["address1"].xmltext>
			<cfset order.shipping.address2 = XMLData["new-order-notification"]["buyer-shipping-address"]["address2"].xmltext>
			<cfset order.shipping.city = XMLData["new-order-notification"]["buyer-shipping-address"]["city"].xmltext>
			<cfset order.shipping.state = XMLData["new-order-notification"]["buyer-shipping-address"]["region"].xmltext>
			<cfset order.shipping.postal_code = XMLData["new-order-notification"]["buyer-shipping-address"]["postal-code"].xmltext>
			<cfset order.shipping.country_code = XMLData["new-order-notification"]["buyer-shipping-address"]["country-code"].xmltext>

		<!--- add billing information to order structure  --->
			<cfset order.billing.contact_name = XMLData["new-order-notification"]["buyer-billing-address"]["contact-name"].xmltext>
			<cfset order.billing.address1 = XMLData["new-order-notification"]["buyer-billing-address"]["address1"].xmltext>
			<cfset order.billing.address2 = XMLData["new-order-notification"]["buyer-billing-address"]["address2"].xmltext>
			<cfset order.billing.city = XMLData["new-order-notification"]["buyer-billing-address"]["city"].xmltext>
			<cfset order.billing.state = XMLData["new-order-notification"]["buyer-billing-address"]["region"].xmltext>
			<cfset order.billing.postal_code = XMLData["new-order-notification"]["buyer-billing-address"]["postal-code"].xmltext>
			<cfset order.billing.country_code = XMLData["new-order-notification"]["buyer-billing-address"]["country-code"].xmltext>

		   <!--- add items to order structure ---->
			<cfloop from="1" to="#arrayLen(XMLData["new-order-notification"]["shopping-cart"].items.xmlChildren)#" index="i">
				<cfset order.cart_items[i] = structNew()>
				<cfset order.cart_items[i].item_name = XMLData["new-order-notification"]["shopping-cart"].items.item[i]["item-name"].xmlText>
				<cfset order.cart_items[i].item_description = XMLData["new-order-notification"]["shopping-cart"].items.item[i]["item-description"].xmlText>
				<cfset order.cart_items[i].item_quantity = XMLData["new-order-notification"]["shopping-cart"].items.item[i]["quantity"].xmlText>
				<cfset order.cart_items[i].item_price = XMLData["new-order-notification"]["shopping-cart"].items.item[i]["unit-price"].xmlText>
			</cfloop>

			<cfset logText="Google Order ##: #OrderNumber# New order #orderID# from #custID# for #OrderAmount#">

			<!--- log summary details to general/orders.log --->
			<cfset LogNotification(logtext,"general","orders")>

			<!--- check for debug log options, record xml if needed --->
			<cfif variables.logging eq "debug">
				<!--- pass details to the logNotification function --->
				<cfset logNotification(arguments.XMLData,orderNumber,responseType)>
			</cfif>

			<!--- pass off to local orders.cfc for customized processing --->
			<cfset newOrders(order,orderNumber)>

	</cffunction>

 	<cffunction name="ProcessOrderStateChangeNotification" output="false" returntype="String" hint="Change order state">
		<cfargument name="XMLData" required="true" type="xml">
		<!--- Do order state processing --->

		<cfset var order = structNew()>

		<cfset var responseType = "order-state-change-notification">
		<cfset var OrderNumber = XMLData["order-state-change-notification"]["google-order-number"].xmltext>

		<cfset order.newFinStatus = XMLData["order-state-change-notification"]["new-financial-order-state"].xmltext>>
		<cfset order.newFulStatus = XMLData["order-state-change-notification"]["new-fulfillment-order-state"].xmltext>>

		<!--- check for debug log options, record xml if needed --->
		<cfif variables.logging eq "debug">
			<!--- pass details to the logNotification function --->
			<cfset logNotification(arguments.XMLData,orderNumber,responseType)>
		</cfif>

		<!--- pass off to local orders.cfc for customized processing --->
		<cfset OrderStateChangeNotification(order,orderNumber)>

	</cffunction>

	<cffunction name="ProcessChargeAmountNotification" output="true" returntype="String" hint="add records of the payment to sonisweb">
		<cfargument name="XMLData" required="true" type="xml">
		<!--- Do payment processing --->

		<cfset var order = structNew()>

		<cfset var responseType = "charge-amount-notification">

		<cfset var OrderNumber = XMLData["charge-amount-notification"]["google-order-number"].xmltext>
		<cfset var OrderAmount = XMLData["charge-amount-notification"]["total-charge-amount"].xmltext>

		<cfset order.ordernumber = orderNumber>
		<cfset order.orderamount = OrderAmount>

		<cfset logText="#OrderNumber# New order for #OrderAmount#">

		<!--- log summary details to general/payments.log --->
		<cfset LogNotification(logtext,"general","payments")>

		<!--- check for debug log options, record xml if needed --->
		<cfif variables.logging eq "debug">
			<!--- pass details to the logNotification function --->
			<cfset logNotification(arguments.XMLData,orderNumber,responseType)>
		</cfif>

		<!--- pass off to local orders.cfc for customized processing --->
		<cfset ChargeAmountNotification(order,orderNumber)>

		<!---
			This example would tell Google merchant account that the order has shipped and to archive the order
			You would use this to change the status on the order at Google
				<cfset OrderProcessingAPI("deliver-order",ordernumber)>

				<cfset OrderProcessingAPI("archive-order",ordernumber)>
		--->
	</cffunction>

	<cffunction name="ProcessChargebackAmountNotification" output="false" returntype="String" hint="Processes chargeback notifications">
		<cfargument name="XMLData" required="true" type="xml">
		<!--- Do chargeBack processing --->

		<cfset var order = structNew()>
		<cfset var responseType = "chargeback-amount-notification">
		<cfset var OrderNumber = XMLData["chargeback-amount-notification"]["google-order-number"].xmltext>
		<cfset var OrderAmount = XMLData["chargeback-amount-notification"]["total-chargeback-amount"].xmltext>

		<cfset order.orderNumber = orderNumber>
		<cfset order.orderAmount = OrderAmount>

		<!--- check for debug log options, record xml if needed --->
		<cfif variables.logging eq "debug">
			<!--- pass details to the logNotification function --->
			<cfset logNotification(arguments.XMLData,orderNumber,responseType)>
		</cfif>

		<!--- pass off to local orders.cfc for customized processing --->
		<cfset ChargebackAmountNotification(order,orderNumber)>

	</cffunction>

	<cffunction name="ProcessRefundAmountNotification" output="false" returntype="String" hint="process refund amounts">
		<cfargument name="XMLData" required="true" type="xml">
		<!--- Do Refund amount notification processing --->

		<cfset var order = structNew()>
		<cfset var responseType="refund-amount-notification">
		<cfset var OrderNumber = XMLData["refund-amount-notification"]["google-order-number"].xmltext>
		<cfset var OrderAmount = XMLData["refund-amount-notification"]["total-refund-amount"].xmltext>

		<cfset order.ordernumber = orderNumber>
		<cfset order.orderAmount = OrderAmount>

		<!--- check for debug log options, record xml if needed --->
		<cfif variables.logging eq "debug">
			<!--- pass details to the logNotification function --->
			<cfset logNotification(arguments.XMLData,orderNumber,responseType)>
		</cfif>

		<!--- pass off to local orders.cfc for customized processing --->
		<cfset RefundAmountNotification(order,orderNumber)>

	</cffunction>

	<cffunction name="ProcessRiskInformationNotification" output="false" returntype="String" hint="Process risk notifications">
		<cfargument name="XMLData" required="true" type="xml">
		<!--- Do risk notification processing --->

		<cfset var order = structNew()>
		<cfset var responseType="risk-information-notification">
		<cfset var OrderNumber = XMLData["risk-information-notification"]["google-order-number"].xmltext>

		<cfset order.orderNumber = orderNumber>

		<!--- check for debug log options, record xml if needed --->
		<cfif variables.logging eq "debug">
			<!--- pass details to the logNotification function --->
			<cfset logNotification(arguments.XMLData,orderNumber,responseType)>
		</cfif>

		<!--- pass off to local orders.cfc for customized processing --->
		<cfset RiskInformationNotification(order,orderNumber)>

	</cffunction>

	<cffunction name="SendNotificationAcknowledgement" output="false" returntype="xml" hint="Returns the XML notification message for Google" access="Remote">
		<!---
		  The SendNotificationAcknowledgment function responds to a Google Checkout
		  notification with a <notification-acknowledgment> message. If you do
		  not send a <notification-acknowledgment> in response to a Google Checkout
		  notification, Google Checkout will resend the notification multiple times.
		--->
	   <cfset var acknowledgment = "">

		<cfsavecontent variable="acknowledgment"><?xml version="1.0" encoding="UTF-8"?>
			<notification-acknowledgment xmlns="http://checkout.google.com/schema/2"/>
		</cfsavecontent>

		<cfreturn acknowledgment>
	</cffunction>

</cfcomponent>