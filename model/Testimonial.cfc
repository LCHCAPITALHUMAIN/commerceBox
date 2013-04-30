/**
* A cool Testimonial entity
*/
component persistent="true" table="testimonials" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="fullname" ormtype="string";	property name="summary" ormtype="string";	property name="keywords" ormtype="string";	property name="content" ormtype="text";
	property name="datecreated" ormtype="date";
	property name="dateupdated" ormtype="date";	property name="islive" ormtype="boolean";	
	
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
