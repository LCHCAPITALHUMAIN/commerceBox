/**
* A cool SurveyAnswer entity
*/
component persistent="true" table="survey_answers" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="increment";
	
	// Properties
	property name="ipaddress" ormtype="string";	
	// Relationships
	property name="Option" 
			 fieldtype="many-to-one" 
			 fkcolumn="survey_question_option_id" 
			 cfc="SurveyOption";
			 
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
