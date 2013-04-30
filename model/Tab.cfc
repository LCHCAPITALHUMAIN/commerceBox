/**
* A cool Tab entity
*/
component persistent="true" table="tabs" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="alias" ormtype="string";	property name="summary" ormtype="string";	property name="keywords" ormtype="string";	property name="content" ormtype="text";	property name="islive" ormtype="boolean";	
	// Relationships
	property name="Page"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="Page"
			 fkcolumn="tab_id";
			 
	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};
	
	// Constructor
	function init(){
		super.init(useQueryCaching="false");
		return this;
	}
}
