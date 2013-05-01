/**
* A cool User entity
*/
component persistent="true" table="users" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="firstname" ormtype="string";	property name="lastname" ormtype="string";	property name="email" ormtype="string";	property name="password" ormtype="string";	property name="datecreated" ormtype="date";	property name="dateupdated" ormtype="date";	property name="islive" ormtype="boolean";	
	// Relationships
	property name="Roles"
			fieldtype="many-to-many" 
			CFC="UserRole" 
			linktable="users_roles" 
			FKColumn="user_id" 
			inversejoincolumn="user_role_id" 
			lazy="true" 
			cascade="all" 
			orderby="role_id";
			 
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
