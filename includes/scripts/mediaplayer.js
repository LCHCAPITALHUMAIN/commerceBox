//media player functions
var currentPosition;
var currentVolume;

function sendEvent(typ,prm) {
	thisMovie("mediaplayer").sendEvent(typ,prm);
};

function loadFile(fil,tit,lnk,img,fid) {
	thisMovie("mediaplayer").loadFile(fil,tit,lnk,img,fid);
};

function thisMovie(movieName) {
    if(navigator.appName.indexOf("Microsoft") != -1) {
		return window[movieName];
	} else {
		return document[movieName];
	}
};

function getUpdate(typ,pr1,pr2) {
	if(typ == "time") { currentPosition = pr1; }
	else if(typ == "volume") { currentVolume = pr1; }
	var id = document.getElementById(typ);
	id.innerHTML = typ+ ": "+Math.round(pr1);
	pr2 == undefined ? null: id.innerHTML += ", "+Math.round(pr2);
};

function itemData(obj) {
	var nodes = "";
	for(var i in obj) { 
		nodes += "<li>"+i+": "+obj[i]+"</li>"; 
	}
	document.getElementById("data").innerHTML = nodes;
};
	
function loadPlayer(fil,fid,loc,stream,img,rtn) {
	var str = "";
	var FO = { movie:"/movies/mediaplayer.swf",id:"mediaplayer",width:"320",height:"260",majorversion:"8",build:"0",bgcolor:"#FFFFFF",allowfullscreen:"true",
		flashvars:"image="+img+"&file="+fil+"&id="+fid+str+"&autostart=true&fullscreenpage=/movies/fullscreen.html&fsreturnpage="+rtn };
	UFO.create(FO, loc);
};