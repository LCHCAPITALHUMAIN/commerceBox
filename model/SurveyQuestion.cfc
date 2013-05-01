/**
* A cool SurveyQuestion entity
*/
component persistent="true" table="survey_questions" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="islive" ormtype="boolean";	
	// Relationships
	property name="QuestionType" 
			 fieldtype="many-to-one" 
			 fkcolumn="survey_question_type_id" 
			 cfc="SurveyQuestionType";
	property name="Option"
			 type="array" 
			 fieldtype="one-to-many"
			 cfc="SurveyQuestionOption"
			 fkcolumn="survey_question_id";
			 
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
