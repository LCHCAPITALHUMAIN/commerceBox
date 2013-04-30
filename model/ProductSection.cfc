/**
* A cool ProductSection entity
*/
component persistent="true" table="product_sections" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="summary" ormtype="string";	property name="keywords" ormtype="string";	property name="views" ormtype="integer";	property name="islive" ormtype="boolean";	
	// Relationships
	property name="Products"
			fieldtype="many-to-many" 
			CFC="Product" 
			linktable="products_sections" 
			FKColumn="product_section_id" 
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
