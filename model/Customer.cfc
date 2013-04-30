/**
* A cool Customer entity
*/
component persistent="true" table="customers" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="firstname" ormtype="string";	property name="lastname" ormtype="string";	property name="email" ormtype="string";	property name="phone" ormtype="string";	property name="affiliate" ormtype="string";	
	// Relationships
	property name="Order"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="Order"
			 fkcolumn="product_customer_id";
	
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
