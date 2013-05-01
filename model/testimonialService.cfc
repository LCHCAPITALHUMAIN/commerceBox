<cfcomponent name="testimonialService" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService">

	<cffunction name="init" access="public" output="false" returntype="model.testimonialService">
		<cfset super.init(entityName="Testimonial") />
		<cfreturn this/>
	</cffunction>

	<cffunction name="createtestimonial" access="public" output="false" returntype="any">
			
		<cfreturn new("Testimonial") />
	</cffunction>

	<cffunction name="gettestimonial" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="true" />

		<cfreturn get("Testimonial",arguments.id) />
	</cffunction>

	<cffunction name="gettestimonials" access="public" output="false" returntype="any">
		<cfargument name="id" type="Numeric" required="false" />
		<cfargument name="author" type="String" required="false" />
		<cfargument name="content" type="String" required="false" />
		<cfargument name="orderby" type="string" default="id" />
		<cfargument name="orderasc" type="Numeric" default=1 />
		
		<cfset var map = structNew() />
		
		<cfif structKeyExists(arguments,"id") and len(arguments.id)>
			<cfset map.id = arguments.id />
		</cfif>
		<cfif structKeyExists(arguments,"author") and len(arguments.author)>
			<cfset map.author = arguments.author />
		</cfif>
		<cfif structKeyExists(arguments,"content") and len(arguments.content)>
			<cfset map.content = arguments.content />
		</cfif>
		
		<cfreturn entityLoad("testimonial.testimonial",map,arguments.orderby,arguments.orderasc) />
	</cffunction>
	
	<cffunction name="getRandomTestimonial" access="public" output="false" returntype="any">
		<cfscript>
			var testimonials = getTestimonials();
			var testimonialid = randRange(1,testimonials.recordCount);
			
			return getTestimonial(id=testimonialid);
		</cfscript>
	</cffunction>

	<cffunction name="savetestimonial" access="public" output="false" returntype="void">
		<cfargument name="testimonial" type="any" required="true" />
		
		<cfset save(arguments.testimonial) />
	</cffunction>

	<cffunction name="deletetestimonial" access="public" output="false" returntype="void">
		<cfargument name="id" type="Numeric" required="true" />
		
		<cfset var testimonial = get("Testimonial",arguments.id) />
		<cfset delete(testimonial) />
	</cffunction>
</cfcomponent>
