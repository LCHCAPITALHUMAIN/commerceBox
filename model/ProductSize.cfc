/**
* A cool ction name="crSize entity
*/
component persistent="true" table="product_sizes" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="summary" ormtype="string";	property name="views" ormtype="integer";
	property name="datecreated" ormtype="date";
	property name="dateupdated" ormtype="date";	property name="islive" ormtype="boolean";	
	// Relationships
	property name="Products"
			fieldtype="many-to-many" 
			CFC="Product" 
			linktable="products_sizes" 
			FKColumn="product_size_id" 
			inversejoincolumn="product_id" 
			lazy="true" 
			cascade="all" 
			orderby="product_id";
			
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
