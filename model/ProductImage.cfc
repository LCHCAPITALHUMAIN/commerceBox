/**
* A cool ProductImage entity
*/
component persistent="true" table="product_images" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="path" ormtype="string";	property name="caption" ormtype="string";	property name="credit" ormtype="string";	property name="datecreated" ormtype="date";	property name="dateupdated" ormtype="date";	property name="islive" ormtype="boolean";	
	
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
