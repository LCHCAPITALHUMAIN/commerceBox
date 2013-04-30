// JavaScript Document

$(document).ready(function(){
	$('#newsletter').submit(process);
	
	function process(e){
		e.preventDefault();
		$('#response')
			.show(0)
			.text("Adding email address...")
			.load('index.cfm?event=newsletter.doSignUp&email='+$('#email').val());
		e.stopPropagation();
	};
});