/**
* A cool Shipping entity
*/
component persistent="true" table="order_shipping_addresses" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="name" ormtype="string";	property name="street1" ormtype="string";	property name="street2" ormtype="string";	property name="city" ormtype="string";	property name="state" ormtype="string";	property name="postal" ormtype="string";	property name="country" ormtype="string";	
	
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
