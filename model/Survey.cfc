/**
* A cool Survey entity
*/
component persistent="true" table="surveys" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";	property name="alias" ormtype="string";	property name="summary" ormtype="string";	property name="keywords" ormtype="string";	property name="datestart" ormtype="date";	property name="dateend" ormtype="date";	property name="password" ormtype="string";	property name="exitmsg" ormtype="string";	property name="author" ormtype="string";	property name="datecreated" ormtype="date";	property name="dateupdated" ormtype="date";
	property name="isfeatured" ormtype="boolean";	property name="islive" ormtype="boolean";	
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
