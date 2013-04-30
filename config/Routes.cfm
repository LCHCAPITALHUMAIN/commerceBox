<cfscript>
	// General Properties
	setEnabled(true);
	setUniqueURLS(false);
	//setAutoReload(false);
	
	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#/index.cfm");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	}
	
	addModuleRoutes(pattern="/admin",module="admin");
	
	addRoute(pattern="product/list/:filter/:id",
			handler="product",
			action="list");
	// default
	addRoute(pattern=":handler/:action?/:id?");
</cfscript>