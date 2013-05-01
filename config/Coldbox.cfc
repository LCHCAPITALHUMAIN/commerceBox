component {

/*
structures/arrays to create for configuration

- coldbox (struct)
- settings (struct)
- conventions (struct)
- environments (struct)
- ioc (struct)
- models (struct)
- debugger (struct)
- mailSettings (struct)
- i18n (struct)
- bugTracers (struct)
- webservices (struct)
- datasources (struct)
- layoutSettings (struct)
- layouts (array of structs)
- cacheEngine (struct)
- interceptorSettings (struct)
- interceptors (array of structs)
- modules (struct)
- logBox (struct)

Available objects in variable scope
- controller
- logBoxConfig
- appMapping (auto calculated by ColdBox)

Required Methods
- configure() : The method ColdBox calls to configure the application.
Optional Methods
- detectEnvironment() : If declared the framework will call it and it must return the name of the environment you are on.
- {environment}() : The name of the environment found and called by the framework.

*/
	
	// Configure ColdBox Application
	function configure(){
	
		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "Stand4SA",
			eventName 				= "event",
			
			//Development Settings
			debugMode				= false,
			debugPassword			= "stand",
			reinitPassword			= "stand",
			handlersIndexAutoReload = false,
			configAutoReload		= false,
			
			//Implicit Events
			defaultEvent			= "main.index",
			requestStartHandler		= "main.onRequestStart",
			requestEndHandler		= "main.onRequestEnd",
			applicationStartHandler = "main.onApplicationStart",
			applicationEndHandler	= "main.onApplicationEnd",
			sessionStartHandler 	= "main.onSessionStart",
			sessionEndHandler		= "main.onSessionEnd",
			missingTemplateHandler	= "main.onMissingTemplate",
			
			//Extension Points
			UDFLibraryFile 			= "includes/helpers/ApplicationHelper.cfm",
			coldboxExtensionsLocation = "",
			modulesLocation			= "",
			pluginsExternalLocation = "",
			viewsExternalLocation	= "",
			layoutsExternalLocation = "",
			handlersExternalLocation  = "",
			requestContextDecorator = "",
			
			//Error/Exception Handling
			exceptionHandler		= "",
			onInvalidEvent			= "",
			customErrorTemplate		= "",
				
			//Application Aspects
			handlerCaching 			= true,
			eventCaching			= true,
			proxyReturnCollection 	= false,
			flashURLPersistScope	= "session"	
		};
	
		// custom settings
		settings = {
			siteName 			= "Stand 4 Second Ammendment",
			tagLine 			= "",
            keywords			= "second ammendment, national rifle association", 
			PagingMaxRows		= "10",
			PagingBandGap		= "10"
		};
		
		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "^local."
		};
		
		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = true,
			// An array of modules names to load, empty means all of them
			include = ['admin'],
			// An array of modules names to NOT load, empty means none
			exclude = [] 
		};
		
		//Layout Settings
		layoutSettings = {
			defaultLayout = "main.cfm",
			defaultView   = "index.cfm"
		};
		
		//cacheEngine
		cacheEngine = {
			objectDefaultTimeout = 30,
			objectDefaultLastAccessTimeout = 20,
			reapFrequency = 1,
			freeMemoryPercentageThreshold = 0,
			useLastAccessTimeouts = true,
			evictionPolicy = "LRU",
			evictCount = 1,
			maxObjects = 50
		};
	
		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptors = ""
		};
		
		//Register interceptors as an array, we need order
		interceptors = [
			//Autowire
			{class="coldbox.system.interceptors.Autowire",
			 	properties={}
			},
			//SES
			{class="coldbox.system.interceptors.SES",
			 	properties={configFile="config/Routes.cfm"}
			},
			/*/ Transfer
			{class="coldbox.system.orm.transfer.TransferLoader",
                properties={
                    ConfigPath="/config/transfer.xml.cfm",
                    definitionPath="/model/definitions",
                    datasourceAlias="gromore",
                    transferFactoryClassPath="transfer.transferFactory",
                    transferConfigurationClassPath="transfer.com.config.Configuration"}
			},*/
			// Security
			{
				class="coldbox.system.interceptors.security",
				name="ApplicationSecurity",
				properties={
					useRegex = true,
					rulesSource = "xml",
					rulesFile = "config/security.xml.cfm",
                    validatorModel = "security.SecurityService"}
			}
		];
		
		//Register Layouts
		layouts = {
			login = {
				file = "login.cfm",
				views = "login",
				folders = "views"
			}
		};
		
		// orm
		orm = {
			// entity injection
			injection = {
				// enable it
				enabled = true,
				// the include list for injection
				include = "",
				// the exclude list for injection
				exclude = ""
			}
		};
		
		//Datasources
		datasources = {
			dsn   = {name="stand4sa", dbType="mysql"}
		};
		
		//Model Integration
		models = {
			objectCaching = false,
			definitionFile = "config/modelMappings.cfm",
			SetterInjection = true,
			DICompleteUDF = "onDIComplete"
		};
		
		//Conventions
		conventions = {
			handlersLocation = "handlers",
			pluginsLocation  = "plugins",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "model",
			modulesLocation  = "modules",
			eventAction 	 = "index"
		};
		
		//Mailsettings
		mailSettings = {
			server = "mail.stand4secondammendment.com",
			username = "",
			password = "",
			port = 25
		};
        
        //LogBox DSL
        logBox = {
            // Define Appenders
            appenders = {
                coldboxTracer = {class="coldbox.system.logging.appenders.ColdboxTracerAppender"},
                fileLog = {class="coldbox.system.logging.appenders.RollingFileAppender",
                	properties = {filePath = "logs/",
                    				fileName = "${AppName}"}
                }
            },
            // Root Logger
            root = { levelmax="INFO", appenders="*" },
            // Implicit Level Categories
            info = [ "coldbox.system" ] 
        };

		
		/*
		//i18n & Localization
		i18n = {
			defaultResourceBundle = "includes/i18n/main",
			defaultLocale = "en_US",
			localeStorage = "session",
			unknownTranslation = "**NOT FOUND**"		
		};
		
		//bug tracers
		bugTracers = {
			enabled = false,
			bugEmails = "",
			mailFrom = "",
			customEmailBugReport = ""
		};
		
		//webservices
		webservices = {
			testWS = "http://www.test.com/test.cfc?wsdl",
			AnotherTestWS = "http://www.coldbox.org/distribution/updatews.cfc?wsdl"	
		};
		*/
    
	}// end configure method
    
     // Development Settings
    function development(){
        
        coldbox.debugmode					= true;
        coldbox.debugPassword 				= "";
        coldbox.reinitPassword				= "";
        coldbox.configAutoReload 			= false;
        coldbox.handlderCaching 			= false;
        coldbox.handlersIndexAutoReload 	= true;
        coldbox.handlerCaching 				= false;
        coldbox.eventCaching				= false;
        
        //Debugger Settings
        debugger = {
            enableDumpVar = false,
            persistentRequestProfilers = true,
            maxPersistentRequestProfilers = 10,
            maxRCPanelQueryRows = 50,
            //Panels
            showTracerPanel = true,
            expandedTracerPanel = false,
            showInfoPanel = true,
            expandedInfoPanel = false,
            showCachePanel = true,
            expandedCachePanel = false,
            showRCPanel = true,
            expandedRCPanel = false,
            showModulesPanel = true,
            expandedModulesPanel = false
        };
        
    }// end development enviroment method
	
} //end component