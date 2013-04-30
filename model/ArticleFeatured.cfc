/**
* A cool ArticleFeatured entity
*/
component persistent="true" table="article_featured" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="increment";
	
	// Properties
	property name="datestart" ormtype="date";	property name="dateend" ormtype="date";	
	// Relationships
	property name="Article" 
			 fieldtype="many-to-one" 
			 fkcolumn="article_id" 
			 cfc="Article";
			 
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
