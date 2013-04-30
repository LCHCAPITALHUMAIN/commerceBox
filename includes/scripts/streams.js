function play(id,frmt){
	//$('response').style.visibility='visible';
	$('playlist').innerHTML='<img src=\"/includes/images/throbber.gif\" style=\"margin-left:50px; margin-top:10px;\" />';	
	var myAjax = new Ajax.Updater('playlist','/index.cfm/media/doPlaylist', {
		method: 'get', 
		parameters: {productid: id, format: frmt}
		});
	Effect.Appear('playlist');
}