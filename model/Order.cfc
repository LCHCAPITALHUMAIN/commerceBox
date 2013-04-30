/**
* A cool Order entity
*/
component persistent="true" table="orders" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="product_customer_id" ormtype="integer";	property name="tax" ormtype="double";	property name="total" ormtype="double";	
	// Relationships
	property name="Item"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="OrderItem"
			 fkcolumn="order_id";
	property name="Billing"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="OrderBillingAddress"
			 fkcolumn="order_id";
	property name="Shipping"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="OrderShippingAddress"
			 fkcolumn="order_id";
			 
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
