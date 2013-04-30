/**
* A cool Poll entity
*/
component persistent="true" table="polls" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="islive" ormtype="boolean";	property name="isfeatured" ormtype="boolean";	
	// Relationships
	property name="Option"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="PollOption"
			 fkcolumn="poll_id";
			 
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
