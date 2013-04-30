/**
* A cool PollVote entity
*/
component persistent="true" table="poll_votes" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="ipaddress" ormtype="string";	
	// Relationships
	property name="Vote" 
			 fieldtype="many-to-one" 
			 fkcolumn="poll_vote_id" 
			 cfc="PollVote";
			 
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
