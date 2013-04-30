/**
* A cool Survey entity
*/
component persistent="true" table="surveys" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";
	property name="isfeatured" ormtype="boolean";
	//Relationships
	property name="Question"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="SurveyQuestion"
			 fkcolumn="survey_id";
			 
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