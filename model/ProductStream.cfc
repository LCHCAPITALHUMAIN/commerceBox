/**
* A cool ProductStream entity
*/
component persistent="true" table="product_streams" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="summary" ormtype="string";	property name="keywords" ormtype="string";	property name="path" ormtype="string";	property name="isaudio" ormtype="boolean";	property name="isvideo" ormtype="boolean";
	property name="datecreated" ormtype="date";
	property name="dateupdated" ormtype="date";	property name="views" ormtype="integer";	property name="islive" ormtype="boolean";	
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
