/**
* A cool ction name="crItem entity
*/
component persistent="true" table="product_items" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="price" ormtype="double";	property name="specialprice" ormtype="double";	property name="isspecial" ormtype="boolean";	property name="islive" ormtype="boolean";	
	
	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};
	
	// Constructor
	function init(){
		super.init(useQueryCaching="false");
		return this;
	};
}
