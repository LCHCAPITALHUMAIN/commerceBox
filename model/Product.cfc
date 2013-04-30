/**
* A cool ction name="cr entity
*/
component persistent="true" table="products" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="summary" ormtype="string";	property name="keywords" ormtype="string";	property name="model" ormtype="string";	property name="content" ormtype="text";	property name="views" ormtype="integer";	property name="datecreated" ormtype="date";	property name="dateupdated" ormtype="date";	property name="islive" ormtype="boolean";	
	// Relationships
	property name="Item"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="ProductItem"
			 fkcolumn="product_id";
	property name="Review"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="ProductReview"
			 fkcolumn="product_id";
	property name="ProductImage"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="ProductImage"
			 fkcolumn="product_id";
	property name="Stream"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="ProductStream"
			 fkcolumn="product_id";
			
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
