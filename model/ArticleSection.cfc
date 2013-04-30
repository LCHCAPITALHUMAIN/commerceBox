/**
* A cool ArticleSection entity
*/
component persistent="true" table="article_sections" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="alias" ormtype="string";	property name="summary" ormtype="string";	property name="keywords" ormtype="string";	property name="views" ormtype="integer";	property name="islive" ormtype="boolean";	
	
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
