component{
/*
Module Directives as public properties
this.title 				= "Title of the module";
this.author 			= "Author of the module";
this.webURL 			= "Web URL for docs purposes";
this.description 		= "Module description";
this.version 			= "Module Version"

Optional Properties
this.viewParentLookup   = (true) [boolean] (Optional) // If true, checks for views in the parent first, then it the module.If false, then modules first, then parent.
this.layoutParentLookup = (true) [boolean] (Optional) // If true, checks for layouts in the parent first, then it the module.If false, then modules first, then parent.
this.entryPoint  		= "" (Optional) // If set, this is the default event (ex:forgebox:manager.index) or default route (/forgebox) the framework
									       will use to create an entry link to the module. Similar to a default event.

structures to create for configuration
- parentSettings : struct (will append and override parent)
- settings : struct
- datasources : struct (will append and override parent)
- webservices : struct (will append and override parent)
- interceptorSettings : struct of the following keys ATM
	- customInterceptionPoints : string list of custom interception points
- interceptors : array
- routes : array Allowed keys are same as the addRoute() method of the SES interceptor.
- modelMappings : structure of model mappings. Allowed keys are the alias and path, same as normal model mappings.

Available objects in variable scope
- controller
- appMapping (application mapping)
- moduleMapping (include,cf path)
- modulePath (absolute path)
- log (A pre-configured logBox logger object for this object)

Required Methods
- configure() : The method ColdBox calls to configure the module.

Optional Methods
- onLoad() 		: If found, it is fired once the module is fully loaded
- onUnload() 	: If found, it is fired once the module is unloaded

*/
	
	// Module Properties
	this.title 				= "Admin";
	this.author 			= "Aaron Roberson";
	this.webURL 			= "";
	this.description 		= "A module for administration";
	this.version			= "1.0";
	this.viewParentLookup 	= false;
	this.layoutParentLookup = false;
	this.entryPoint			= "admin:main.index";
	
	// Configure the Admin Module
	function configure(){
		
		settings = {};
		
		// SES Routes ORDER MATTERS
		routes = [
			{pattern="/", handler="main",action="index"},
			{pattern="/:handler?/:action?/:id?"}
			
		];		
		
		// Defined Model Mappings for this module.
		modelMappings = {
			/*"userService" = {
				path = "model.userService"
			}*/
		};
		
		/*/ Interceptors	
		interceptors = [
			{name="moduleSecurity",
			class="#moduleMapping#.interceptors.ModuleSecurity",
			properties={}
			}
		];*/
	} // end configure
	
	// Called when the module is activated and application has loaded
	function onLoad(){
		if( controller.settingExists("sesBaseURL") ){
			this.entryPoint = "admin:main";
		}
	} // end onLoad
	
	/**
	* @eventPattern ^admin:.*
	*/
	function preProcess(){
	  // event called to module, set default layout
	  event.setLayout("main");
	} // end preProcess
  
}// end component