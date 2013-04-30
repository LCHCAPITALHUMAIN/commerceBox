<!---
[google]
; You should not need to change these unless Google changes the URLs
sandboxURL=https://sandbox.google.com/checkout/cws/v2/Merchant/
productionURL=https://checkout.google.com/cws/v2/Merchant/

[default]
; your Google Checkout merchant ID
merchantid=154075307245724

; merchand ID for sandbox account
sandboxid=550932676673595

;your Google Checkout Merchant Key
merchantkey=Moc9jNLpUwoLlsLzjTWqBg

; Merchant Key for sandbox account
sandboxkey=TSvgGs88bLlWmRyJN9UV_g

; the URL to direct the customer to after they complete a purchase
continueurl=http://stand4secondammendment.com/index.cfm/product

; the URL to direct the customer to for changing cart items
editcarturl=http://stand4secondammendment.com/index.cfm/cart

; true/false for charging tax
chargetax=true

; tax rate to charge, ignored if chargetax=false
taxrate=.0785

; State tax is charged to
statetochargetax=CA

; Shipping charges - setup shipping.xml.cfm with shipping options
chargeshipping=true

; allow Free pickup
allowfreepickup=false

; Currency & location settings
countrycode=US
localecode=en_US
currencycode=USD

; set to false for production sites
demosite=false

; True logs all responses sent from Google to googlemessages.log
; anything other than debug logs summary data
; logging=debug logs full XML responses
; a folder named the order number will be created under the logs location then
; a file will be created for each type of response type
; suggest logging=basic for production
logging=debug

; set fullpath for log files, defaults to ./logs
; recommend moving to folder outside web root
; examples: /var/log/checkout
; c:\logs
log_location=/logs

--->