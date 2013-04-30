/**
* A cool NewsletterSubscriber entity
*/
component persistent="true" table="newsletter_subscribers" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="fullname" ormtype="string";	property name="email" ormtype="string";	property name="datecreated" ormtype="date";	property name="dateupdated" ormtype="date";	property name="islive" ormtype="boolean";	
	
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
