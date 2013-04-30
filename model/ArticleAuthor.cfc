component persistent="true" table="article_authors" extends="coldbox.system.orm.hibernate.ActiveEntity" {
	
	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="firstName" ormtype="string";
	property name="lastName" ormtype="string";
	property name="image" ormtype="string";
	property name="content" ormtype="blob";
	property name="islive" ormtype="boolean";
	
	//relationships
	property name="Articles" 
			 singularname="Article" 
			 type="array" 
			 fieldtype="one-to-many" 
			 cfc="Article" 
			 inverse="false" 
			 fkcolumn="author_id";
	
	// Validation Constraints
	this.constraints = {
		firstName = {required=true}, 
		lastName = {required=true},
		image = 	{required=false},
		content = {required=false},
		isLive = {required=false}
	};
	
	// Constructor
	function init(){
		super.init(useQueryCaching="false");
		return this;
	}

	public function getFullName() {
		return this.get("firstName") & " " & get("lastName");
	}

}