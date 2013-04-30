/**
* A cool ProductFeatured entity
*/
component persistent="true" table="product_featured" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="increment";
	
	// Properties
	property name="datestart" ormtype="date";	property name="dateend" ormtype="date";
	property name="islive" ormtype="boolean";	
	// Relationships
	property name="Product" 
			 fieldtype="many-to-one" 
			 fkcolumn="product_id" 
			 cfc="Product";
			 
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
