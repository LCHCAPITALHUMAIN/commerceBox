<cfcomponent name="contact" extends="coldbox.system.eventhandler" output="false">

	<cffunction name="init" access="public" returntype="contact" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset rc.title="Contact Revival Seminars">
		<cfset rc.description="Contact information for Revival Seminars" >
		<cfset rc.keywords="contact, phone, Revival Seminars, Stephen Wallace">
		<cfset rc.styles="validation.css">
		<cfset rc.scripts="prototype.js,scriptaculous.js?load=effects,validation.js">
		
		<cfset event.setView("contact/index")>
	</cffunction>
	
	<cffunction name="prayer" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset title="Send Prayer Requests to Revival Seminars">
		<cfset description="Submit your prayer request to have the Revival Seminars staff pray for you" >
		<cfset keywords="prayer, contact, Revival Seminars, Stephen Wallace">
		<cfset styles="validation.css">
		<cfset scripts="prototype.js,scriptaculous.js?load=effects,validation.js">
		
		<cfset event.setView("contact/prayer")>
	</cffunction>
	
	<cffunction name="studies" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset title="Bibles studies with Junie - Revival Seminars">
		<cfset description="Online Bible studies with Bible Instructor for Revival Seminars" >
		<cfset keywords="bible, studies, guides, lessons, prophecy, Revival Seminars, Stephen Wallace, ">
		<cfset styles="validation.css">
		<cfset scripts="prototype.js,scriptaculous.js?load=effects,validation.js">
	
		<cfset event.setView("contact/studies")>
	</cffunction>
	
	<cffunction name="doContact" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var name = event.getValue("fullName","")>
		<cfset var addr = event.getValue("email","")>
		<cfset var msg = event.getValue("message","")>
		<cfset var error = structNew()>
		
		<cfscript>
			error = structNew();
			if(event.valueExists("send")){
				// make sure full name was provided and provide error if not
				if(NOT len(name)){
					error.fullName = "Please provide your full name. ";
				}
				// make sure email was provided and provide error if not
				if(NOT len(addr)){
					error.email = "Please provide your email address. ";
				}
				// make sure email is correctly formated
				else if(NOT isEmail(addr)){
					error.email = "Email is not valid. ";
				}
				// make sure a message is actually provided
				if(NOT len(msg)){
					error.message = "Please include a message. ";
				}
				// check if hidden form is filled by spam bot and provide error if so
				if(event.valueExists("password") AND len(event.getValue("password"))){
					error.password = "Humans only please. ";
				}
			 }
		</cfscript>
		
		<cfif structIsEmpty(error)>
			<cftry>
				<cfmail to="#getSetting('OwnerEmail')#" from="#trim(addr)#" subject="Website Inquiry" type="html">
				<cfoutput>
From: #name#<br />
Reply Email: #addr#<br />
Message:<br />
#paragraphFormat(msg)#
				</cfoutput>
				</cfmail>
			<cfcatch type="any">
				<cfset getplugin("messagebox").setMessage("error","Unknown error occured. Please contact Administrator.") />
			</cfcatch>
			</cftry>
			<cfset getPlugin("messagebox").setMessage("info","Your message has been sent successfully. Thank you.") />
		<cfelse>
			<cfset setErrors(error) />
		</cfif>
		
		<cfset setNextEvent("contact")>
	</cffunction>
	
	<cffunction name="doStudies" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var name = event.getValue("fullName","")>
		<cfset var addr = event.getValue("email","")>
		<cfset var msg = event.getValue("message","")>
		<cfset var error = structNew()>
		
		<cfscript>
			error = structNew();
			if(event.valueExists("send")){
				// make sure full name was provided and provide error if not
				if(NOT len(name)){
					error.fullName = "Please provide your full name. ";
				}
				// make sure email was provided and provide error if not
				if(NOT len(addr)){
					error.email = "Please provide your email address. ";
				}
				// make sure email is correctly formated
				else if(NOT isEmail(addr)){
					error.email = "Email is not valid. ";
				}
				// check if hidden form is filled by spam bot and provide error if so
				if(event.valueExists("password") AND len(event.getValue("password"))){
					error.password = "Humans only please. ";
				}
			 }
		</cfscript>
		
		<cfif structIsEmpty(error)>
			<cftry>
				<cfmail to="junie@whitehorsemedia.com" bcc="webservant@whitehorsemedia.com,gilbert@whitehorsemedia.com" from="webservant@whitehorsemedia.com" username="webservant@whitehorsemedia.com" password="gateway" subject="These Last Days Bible Study Request" type="html">
				<cfoutput>
From: #name#<br />
Reply Email: #addr#<br />
Phone: #event.getValue("phone","")#<br />
Message:<br />
#paragraphFormat(msg)#
				</cfoutput>
				</cfmail>
			<cfcatch type="any">
				<cfset getplugin("messagebox").setMessage("error","Unknown error occured. Please contact Administrator.") />
			</cfcatch>
			</cftry>
			<cfset getPlugin("messagebox").setMessage("info","Your message has been sent successfully. Thank you.") />
		<cfelse>
			<cfset setErrors(error) />
		</cfif>
		
		<cfset setNextEvent("contact.studies")>
	</cffunction>
	
	<cffunction name="doPrayer" access="public" returntype="void" output="false">
		<cfargument name="event"  required="yes">
		<cfset var rc = event.getCollection()>
		<cfset var name = event.getValue("fullName","")>
		<cfset var addr = event.getValue("email","")>
		<cfset var msg = event.getValue("message","")>
		<cfset var error = structNew()>
		
		<cfscript>
			error = structNew();
			if(event.valueExists("send")){
				// make sure full name was provided and provide error if not
				if(NOT len(name)){
					error.fullName = "Please provide your full name. ";
				}
				// make sure a message is actually provided
				if(NOT len(msg)){
					error.message = "Please include a message. ";
				}
				// check if hidden form is filled by spam bot and provide error if so
				if(event.valueExists("password") AND len(event.getValue("password"))){
					error.password = "Humans only please. ";
				}
			 }
		</cfscript>
		
		<cfif structIsEmpty(error)>
			<cftry>
				<cfmail to="admin@whitehorsemedia.com" bcc="webservant@whitehorsemedia.com,gilbert@whitehorsemedia.com" from="webservant@whitehorsemedia.com" username="webservant@whitehorsemedia.com" password="gateway" subject="WHM Website Prayer Request" type="html">
				<cfoutput>
From: #name#<br />
State/Province: #event.getValue("state","")#
Reply Email: #addr#<br />
Message:<br />
#paragraphFormat(msg)#
				</cfoutput>
				</cfmail>
			<cfcatch type="any">
				<cfset getplugin("messagebox").setMessage("error","Unknown error occured. Please contact Administrator.") />
			</cfcatch>
			</cftry>
			<cfset getPlugin("messagebox").setMessage("info","Your Prayer request has been sent successfully. We will be praying for you.") />
		<cfelse>
			<cfset setErrors(error) />
		</cfif>
		
		<cfset setNextEvent("contact.prayer")>
	</cffunction>
	
	<cffunction name="setErrors" access="private" returntype="void" output="false">
		<cfargument name="errors" required="yes" type="struct">
		<cfset var err = "">
		<cfsavecontent variable="err">
			<cfloop collection="#arguments.errors#" item="i">
				<cfoutput>#arguments.errors[i]#</cfoutput>
			</cfloop>
		</cfsavecontent>
		<cfset getPlugin("messagebox").setMessage("error","#err#")>
	</cffunction>
		
	<cffunction name="isEmail" access="private" returntype="boolean" output="false">
		<cfargument name="email" required="yes" type="string">
		<cfscript>
			if (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name))$", arguments.email)) {
					return true;
			} else {
				return false;
			}
		</cfscript>
	</cffunction>
	
</cfcomponent>