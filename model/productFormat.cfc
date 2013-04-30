/**
* A cool ProductFormat entity
*/
component persistent="true" table="product_formats" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";
	property name="summary" ormtype="string";
	property name="keywords" ormtype="string";	property name="prefix" ormtype="string";	property name="islive" ormtype="boolean";	
	// Relationships
	property name="Item" 
			 fieldtype="one-to-many" 
			 fkcolumn="product_format_id" 
			 cfc="ProductItem";
			 
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
