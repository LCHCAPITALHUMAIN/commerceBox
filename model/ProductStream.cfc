/**
* A cool ProductStream entity
*/
component persistent="true" table="product_streams" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";
	property name="datecreated" ormtype="date";
	property name="dateupdated" ormtype="date";
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