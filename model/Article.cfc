/**
* A cool Article entity
*/
component persistent="true" table="articles" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" generator="increment";
	
	// Properties
	property name="title" ormtype="string";
	property name="alias" ormtype="string";	property name="summary" ormtype="string";
	property name="keywords" ormtype="string";	property name="content" ormtype="text";	property name="views" ormtype="integer";
	property name="datecreated" ormtype="string";
	property name="dateupdated" ormtype="string";	property name="islive" ormtype="boolean";	
	// Relationships
	property name="Author" 
			 fieldtype="many-to-one" 
			 fkcolumn="author_id" 
			 cfc="ArticleAuthor";
			 
	property name="Section" 
			 fieldtype="many-to-one" 
			 fkcolumn="article_section_id" 
			 cfc="ArticleSection";
			 
	property name="Products"
			fieldtype="many-to-many" 
			CFC="Product" 
			linktable="articles_products" 
			FKColumn="article_id" 
			inversejoincolumn="product_id" 
			lazy="true" 
			cascade="all" 
			orderby="product_id";
			 
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
