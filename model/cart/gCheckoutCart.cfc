<cfcomponent name="gCheckoutCart" displayname="gCheckoutCart" hint="Create checkout carts using the Google CheckOut API" extends="gCheckoutOrders">
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

Component: gcheckoutCart
Created By: Scott Pinkston (spinkston@ozarka.edu)
Creation Date: 6/29/2006
Description:

Additional Requirements:
cf_hmac module
from http://www.adobe.com/cfusion/exchange/index.cfm?view=sn131&extID=1003921
Tim McCarthy (tim@timmcc.com)
(included with the code - if I need to remove the file, please let me know)

12/29/06 -- Added ability to pass a user defined order id  to CreateForm() and  CreateCartXML()
12/29/06 Rey Bango - Added condition to check if shipping options should be set
4/29/07 -
		beefed up logging
		added orders.cfc	
		changed from expandpath to a funky gettemplatepath for apache mod_rewrite issues
		added version 
5/5/07 - The British are coming: added support for countrycode, localecode and currencycode.  These can be set in the ini file.
--->

	<cfscript>
		variables.version = ".901";
	
		//--- Set the cart up ---//
		variables.cart = structNew();
		
		//---This mess is for Apache mod_rewrite issues - expandPath was not returning the correct path ----//
		if (server.os.name contains "Windows"){
				variables.sep = "\";
			}else{
				variables.sep="/";
		}
	
		variables.iniFile = expandPath("/config/googlecheckout.ini.cfm");
		
		//--- Set the Google checkout URL to production or sandbox based on config setting ---//
		if (GetProfileString(variables.iniFile, "default","demosite")){
			variables.g_url = GetProfileString(variables.iniFile, "google","sandboxURL");
		}else{
			variables.g_url = GetProfileString(variables.iniFile, "google","productionURL");
		}
	
		variables.ContinueURL = GetProfileString(variables.iniFile, "default","continueurl");
		variables.EditCartURL = GetProfileString(variables.iniFile, "default","editcarturl");
	
		//--- Simple tax handling (only charge tax if delivery to your state) --->
		variables.ChargeTax= GetProfileString(variables.iniFile, "default","chargetax");
		variables.StateToChargeTax=GetProfileString(variables.iniFile, "default","statetochargetax");
		variables.TaxRate=GetProfileString(variables.iniFile, "default","taxrate");
	
		//--- Simple flat rate shipping --->
		variables.ChargeShipping=GetProfileString(variables.iniFile, "default","chargeshipping");
		variables.allowFreePickup=GetProfileString(variables.iniFile, "default","allowfreepickup");
	
		//--- setup logging options ---->
		variables.logging = GetProfileString(variables.iniFile, "default","logging");
		variables.log_location = GetProfileString(variables.iniFile, "default","log_location");
	
		//--- locale country and currency vars --->
		variables.CountryCode=GetProfileString(variables.iniFile, "default","countrycode");
		variables.CurrencyCode=GetProfileString(variables.iniFile, "default","currencycode");
		variables.LocaleCode=GetProfileString(variables.iniFile, "default","localecode");
	</cfscript>

	<cffunction name="init" access="public" hint="Initialize the object">
		<cfreturn this>
	</cffunction>

	<cffunction name="AddCartItem" returntype="query" output="false" hint="Gets the list of cart items">
		<cfargument name="model" required="true">
        <cfargument name="title" required="true">
		<cfargument name="description" required="true">
		<cfargument name="price" required="true">
		<cfargument name="size" required="false">
		<cfargument name="quantity" required="true" type="numeric">
        
        <cfscript>
			var tmpCart = "";
			if (structkeyExists(variables.cart,arguments.model)){
				//--- already in cart, update item --->
				structUpdate(cart[arguments.model],"quantity",cart[arguments.model].quantity + arguments.quantity);
			}else{
				//--- add to cart structure --->
				cart[arguments.model] = structNew();
				cart[arguments.model].title = REReplace(arguments.title, "[^0-9a-zA-Z_]", "", "ALL");
				cart[arguments.model].description = REReplace(arguments.description, "[^0-9a-zA-Z_]", "", "ALL");
				cart[arguments.model].price = arguments.price;
				cart[arguments.model].size = arguments.size;
				cart[arguments.model].quantity = arguments.quantity;
			}
			return getCartItems();
		</cfscript>

	</cffunction>

	<cffunction name="CreateCartXML" output="false" returntype="string" hint="Creates the xml for google checkout">
		<cfargument name="CustNumber" required="false" type="string" default="">
		<cfargument name="OrderID" required="false" type="string" default="">

		<cfset var CartXMLHeader = "">
		<cfset var CartXMLItems = "">
		<cfset var CartXMLfooter = "">
		<Cfset var CartXML = "">

		<cfset var CartItems = GetCartItems()>
		<cfset var USShippingOptions = GetUSShippingOptions()>
        <cfset var IntShippingOptions = getIntShippingOptions()>

		<cfoutput>
		<cfsavecontent variable="cartXMLHeader">
		<?xml version="1.0" encoding="UTF-8"?>
		<checkout-shopping-cart xmlns="http://checkout.google.com/schema/2">
		  <shopping-cart>
		    <items>
		</cfsavecontent>

		<cfsavecontent variable="cartXMLItems">
		<cfloop query="cartItems">
	      <item>
        	<item-name>#model#</item-name>
	   	    <item-description>#title# - #description#</item-description>
            <item-size>#size#</item-size>
		   	<unit-price currency="#variables.CurrencyCode#">#price#</unit-price>
        	<quantity>#quantity#</quantity>
	      </item>
		</cfloop>
		</cfsavecontent>

		<!--- *RYAN*  --->
		<cfsavecontent variable="cartXMLTax">
			<cfif variables.ChargeTax>
				<tax-tables merchant-calculated="false">
					<default-tax-table>
						<tax-rules>
							<default-tax-rule>
								<shipping-taxed>false</shipping-taxed>
								<rate>#variables.TaxRate#</rate>
								<tax-area>
									<us-state-area>
										<state>#variables.StateToChargeTax#</state>
									</us-state-area>
								</tax-area>
							</default-tax-rule>
						</tax-rules>
					</default-tax-table>
				</tax-tables>
			</cfif>
		</cfsavecontent>

		<!--- *RYAN*  --->
		<cfsavecontent variable="cartXMLShipping">
			<!--- 12/29/06 Rey Bango - Added condition to check if shipping options should be set --->
			<cfif variables.chargeshipping>
				<shipping-methods>
					<cfloop query="USShippingOptions">
						 <flat-rate-shipping name="#shipMethod#">
						  <price currency="#variables.CurrencyCode#">#shipPrice#</price>
						  <shipping-restrictions>
							<allowed-areas>
                                 <us-country-area country-area="CONTINENTAL_48"/>
							</allowed-areas>
						  </shipping-restrictions>
						</flat-rate-shipping>
					</cfloop>
                    <cfloop query="IntShippingOptions">
						 <flat-rate-shipping name="#shipMethod#">
						  <price currency="#variables.CurrencyCode#">#shipPrice#</price>
						  <shipping-restrictions>
							<allowed-areas>
							  	<world-area/>
							</allowed-areas>
                            <excluded-areas>
                            	<us-country-area country-area="CONTINENTAL_48"/>
                            </excluded-areas>
						  </shipping-restrictions>
						</flat-rate-shipping>
					</cfloop>
					<cfif variables.allowFreePickup>
						<pickup name="Pickup">
					  		<price currency="#variables.CurrencyCode#">0.00</price>
						</pickup>
					</cfif>
				 </shipping-methods>
			</cfif>
		</cfsavecontent>

		<cfsavecontent variable="cartXMLFooter">
		    </items>
		 	<merchant-private-data>
					<checkoutcfc>
						<custid>
							#arguments.CustNumber#
						</custid>
						<orderid>
							#arguments.OrderID#
						</orderid>
					</checkoutcfc>
		 	</merchant-private-data>
		  </shopping-cart>
		  <checkout-flow-support>
		    <merchant-checkout-flow-support>
			   	<edit-cart-url>#Variables.EditCartURL#</edit-cart-url>
				<continue-shopping-url>#Variables.ContinueURL#</continue-shopping-url>
				#variables.cartXMLTax#
				#variables.cartXMLShipping#
			</merchant-checkout-flow-support>
		  </checkout-flow-support>

		</checkout-shopping-cart>
		</cfsavecontent>
		</cfoutput>

		<cfset cartXMLData = cartXMLheader & cartXMLItems & cartXMLFooter>
		<cfreturn cartXMLData>
	</cffunction>

	<cffunction name="CreateForm" output="false" hint="Creates the form & submit button" returntype="string">
		<cfargument name="CustNumber" required="false" type="string" default="">
		<cfargument name="OrderID" required="false" type="string" default="">

			<cfset var cartXML = CreateCartXML(custNumber=arguments.custNumber,orderID=arguments.orderID)>
			<cfset var signature = HMAC_SHA1(cartXML)>
			<cfset var g_form = "">

			<!--- The link for the button is coded for ssl, change to plain http if desired --->

		<cfoutput>
			<cfsavecontent variable="g_form">
				<form action="#variables.g_url##GetMerchantID()#/checkout" method="post" onsubmit="setUrchinInputCode(pageTracker);">
				  <input type="hidden" name="cart" value="#toBase64(cartXML)#">
				  <input type="hidden" name="signature" value="#signature#">
                  <input type="hidden" name="analyticsdata" value="">
				  <input type="image" name="Google Checkout" alt="Fast checkout through Google" src="https://checkout.google.com/buttons/checkout.gif?merchant_id=#GetMerchantID()#&w=180&h=46&style=white&variant=text&loc=#variables.LocaleCode#" height="46" width="180">
				</form>
			</cfsavecontent>
		</cfoutput>

		<cfreturn g_form>
	</cffunction>

	<cffunction name="EmptyCart" returntype="void" output="false" hint="Empties the cart">
		<cfset structClear(variables.cart)>
	</cffunction>

	<cffunction name="GetCartItems" returntype="query" output="false" hint="Gets the list of cart items">
		<cfset var cartitems = QueryNew("model,title,description,price,size,quantity,total")>
		<Cfset var temp = "">

		<!--- Loop over the structure and set as a query ---->
		<cfloop collection="#cart#" item="key">
			<cfset queryaddrow(cartItems,1)>
			<cfset QuerySetCell(cartitems, "model", key)>
            <cfset QuerySetCell(cartitems, "title", cart[key].title)>
			<cfset QuerySetCell(cartitems, "description", cart[key].description)>
			<cfset QuerySetCell(cartitems, "price", cart[key].price)>
			<cfset QuerySetCell(cartitems, "size", cart[key].size)>
			<cfset QuerySetCell(cartitems, "quantity", cart[key].quantity)>
			<cfset QuerySetCell(cartitems, "total", cart[key].quantity * (cart[key].price))>
		</cfloop>

		<cfreturn cartitems>
	</cffunction>
    
    <cffunction name="getCartTotal" returntype="numeric" output="false" hint="Returns Grand total from cart">
    	<cfset var grandtotal = 0>
        <cfset var cart = getCartItems()>
        <cfloop query="cart">
        	<cfset grandtotal = grandtotal + cart.total>
        </cfloop>
        
		<cfreturn grandtotal>	
    </cffunction>

	<cffunction name="GetHttpAUTH" output="false" returntype="string" hint="returns the encoded AUTH key for basic user authentication">
		<cfset var strCredential = getMerchantID() & ":" & getMerchantKey()>
		<cfreturn toBase64(strCredential)>
	</cffunction>

	<cffunction name="GetMerchantID" output="false" returntype="string" hint="returns the merchantID">
		<cfscript>
			var merchid = "";
			if (GetProfileString(variables.iniFile, "default","demosite")){
				merchid = getProfileString(variables.iniFile, "default", "sandboxid");
			}else{
				merchid = getProfileString(variables.iniFile, "default", "merchantid");
			}
			return trim(merchid);
        </cfscript>
	</cffunction>

	<cffunction name="GetMerchantKey" output="false" returntype="string" hint="returns the merchant Key for checkout">
		<cfscript>
			var merchkey = "";
			if (GetProfileString(variables.iniFile, "default","demosite")){
				merchkey = GetProfileString(variables.iniFile, "default","sandboxkey");
			}else{
				merchkey = GetProfileString(variables.iniFile, "default","merchantkey");
			}
			return trim(merchkey);
       </cfscript>
	</cffunction>

	<cffunction name="GetVersion" output="false" returntype="string" hint="returns the version Number">
		<cfreturn variables.version>
	</cffunction>
	
	
	<cffunction name="GetUSShippingOptions" returntype="query" output="false" hint="Gets the available shipping methods and pricing">
        
        <cfscript>
			// create shipping options query
			var so = QueryNew("shipMethod,shipPrice");
			var total = getCartTotal();
			
			// fill the shipping options query
			queryAddRow(so,1);
			if(total GT 0 AND total LTE 9.95){
				querySetCell(so,"shipMethod","USPS First Class", 1);
				querySetCell(so,"shipPrice",6.50,1);
			}
			if(total GT 9.95 AND total LTE 20.00){
				querySetCell(so,"shipMethod","USPS Priority Flat", 1);
				querySetCell(so,"shipPrice",7.75,1);
			}
			if(total GT 20.00 AND total LTE 50.00){
				querySetCell(so,"shipMethod","USPS Priority Parcel", 1);
				querySetCell(so,"shipPrice",10.50,1);
			}
			if(total GT 50.00 AND total LTE 100.00){
				querySetCell(so,"shipMethod","USPS Priority Parcel", 1);
				querySetCell(so,"shipPrice",13.00,1);
			}
			if(total GT 100.00 AND total LTE 200.00){
				querySetCell(so,"shipMethod","USPS Priority Parcel", 1);
				querySetCell(so,"shipPrice",15.50,1);
			}
			if(total GT 200.00){
				querySetCell(so,"shipMethod","USPS Priority Parcel", 1);
				querySetCell(so,"shipPrice",25.00,1);
			}
			return so;
		</cfscript>

	</cffunction>
    
    <cffunction name="GetIntShippingOptions" returntype="query" output="false" hint="Gets the available shipping methods and pricing">
        
        <cfscript>
			// create shipping options query
			var so = QueryNew("shipMethod,shipPrice");
			var total = getCartTotal();
			
			// fill the shipping options query
			queryAddRow(so,1);
			if(total GT 0 AND total LTE 9.95){
				querySetCell(so,"shipMethod","USPS International", 1);
				querySetCell(so,"shipPrice",10.50,1);
			}
			if(total GT 9.95 AND total LTE 20.00){
				querySetCell(so,"shipMethod","USPS International", 1);
				querySetCell(so,"shipPrice",16.50,1);
			}
			if(total GT 20.00 AND total LTE 50.00){
				querySetCell(so,"shipMethod","USPS International", 1);
				querySetCell(so,"shipPrice",21.00,1);
			}
			if(total GT 50.00 AND total LTE 100.00){
				querySetCell(so,"shipMethod","USPS International", 1);
				querySetCell(so,"shipPrice",26.00,1);
			}
			if(total GT 100.00 AND total LTE 200.00){
				querySetCell(so,"shipMethod","USPS International", 1);
				querySetCell(so,"shipPrice",31.00,1);
			}
			if(total GT 200.00){
				querySetCell(so,"shipMethod","USPS International", 1);
				querySetCell(so,"shipPrice",40.00,1);
			}
			return so;
		</cfscript>

	</cffunction>
	
	<!--- *RYAN*  --->
	<cffunction name="HMAC_SHA1" output="false" hint="Creates the HMAC_SHA1 encrypted cart & key" returntype="string">
		<cfargument name="cartXML" required="true" type="string">

		<!--- call the module cf_hmac --->
		<cfmodule template="/includes/hmac.cfm" key="#getMerchantKey()#" data="#Arguments.cartXML#" hash_function="sha1"></cfmodule>

		<cfreturn toBase64(Hex2Bin(digest, "hex"))>
	</cffunction>

	<cffunction name="Hex2Bin" returntype="any" hint="Converts a Hex string to binary">
		<cfargument name="inputString" type="string" required="true" hint="The hexadecimal string to be written.">

		<cfset var outStream = CreateObject("java",
			"java.io.ByteArrayOutputStream").init()>

		<cfset var inputLength = Len(arguments.inputString)>
		<cfset var outputString = "">
		<cfset var i = 0>
		<cfset var ch = "">

		<cfif inputLength mod 2 neq 0>
			<cfset arguments.inputString = "0" & inputString>
		</cfif>

		<cfloop from="1" to="#inputLength#" index="i" step="2">
			<cfset ch = Mid(inputString, i, 2)>
				<cfset outStream.write(javacast("int", InputBaseN(ch, 16)))>
		</cfloop>

		<cfset outStream.flush()>
		<cfset outStream.close()>

		<cfreturn outStream.toByteArray()>
	</cffunction>

	<cffunction name="LogNotification" output="false" returntype="void" hint="logging tool">
		<cfargument name="LogData" required="true" type="string">
		<cfargument name="orderNumber" required="true" type="string">
		<cfargument name="responseType" required="true" type="string">

			<!---  make sure folder exists, create it if we need to --->
			<cfif not DirectoryExists(variables.log_location & variables.sep & arguments.orderNumber)>
				 <cfdirectory action = "create" directory = "#variables.log_location##variables.sep##arguments.orderNumber#" >
  			</cfif>

			<cfif not FileExists(variables.log_location & variables.sep & arguments.orderNumber & variables.sep & arguments.responseType & ".log")>
				<cffile action="write" output="--CheckoutCFC LOG FILE--" file="#variables.log_location##variables.sep##arguments.orderNumber##variables.sep##arguments.responseType#.log">
			</cfif>

			<cffile action="append" output="#arguments.LogData#" addnewLine="true" file="#variables.log_location##variables.sep##arguments.orderNumber##variables.sep##arguments.responseType#.log">

	</cffunction>

	<cffunction name="RemoveCartItem" returntype="void" output="false" hint="Removes an item from the cart">
		<cfargument name="tmpRemoveItem" required="true">
		<cfset structDelete(variables.cart,arguments.tmpRemoveItem)>
	</cffunction>

	<cffunction name="UpdateCartItem" returntype="void" output="false" hint="Updates the Cart Quantity">
		<cfargument name="model" required="true">
		<cfargument name="quantity" required="true">
		<cfargument name="size" required="false">

			<cfif arguments.quantity lt 1>
					<cfset RemoveCartItem(arguments.model)>
				<cfelse>
					<cfset structUpdate(cart[arguments.model],"quantity",arguments.quantity)>
					<cfif structKeyExists(arguments,"size")><cfset structUpdate(cart[arguments.model],"size",arguments.size)></cfif>
			</cfif>

	</cffunction>
	
	<cffunction name="encode" access="private" returntype="string" output="no" hint="This scans through a string, finds any characters that have a higher ASCII numeric value greater than 127 and automatically convert them to a hexadecimal numeric character">
    <cfargument name="text" type="string" required="yes">
    <cfscript>
      var i = 0;
      var tmp = '';
      while(ReFind('[^\x00-\x7F]',text,i,false))
      {
        i = ReFind('[^\x00-\x7F]',text,i,false); // discover high chr and save it's numeric string position.
        tmp = '&##x#FormatBaseN(Asc(Mid(text,i,1)),16)#;'; // obtain the high chr and convert it to a hex numeric chr.
        text = Insert(tmp,text,i); // insert the new hex numeric chr into the string.
        text = RemoveChars(text,i,1); // delete the redundant high chr from string.
        i = i+Len(tmp); // adjust the loop scan for the new chr placement, then continue the loop.
      }
      return text;
    </cfscript>
  </cffunction>

</cfcomponent>