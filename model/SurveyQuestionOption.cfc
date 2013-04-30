/**
* A cool SurveyQuestionOption entity
*/
component persistent="true" table="survey_question_options" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="increment";
	
	// Properties
	property name="answer" ormtype="string";	property name="islive" ormtype="boolean";	
	
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
