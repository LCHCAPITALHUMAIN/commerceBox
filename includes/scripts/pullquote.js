/*
pullquote function by Roger Johansson, http://www.456bereastreet.com/
*/
var pullquote = {
	init : function() {
	// Check that the browser supports the methods used
		if (!document.getElementById || !document.createElement || !document.appendChild) return false;
		var oElement, oPullquote, oPullquoteP, oQuoteContent, i, j;
	// Find all span elements with a class name of pullquote
		var arrElements = document.getElementsByTagName('span');
		var oRegExp = new RegExp("(^|\\s)pullquote(\\s|$)");
		for (i=0; i<arrElements.length; i++) {
	// Save the current element
			oElement = arrElements[i];
			if (oRegExp.test(oElement.className)) {
	// Create the blockquote and p elements
				oPullquote = document.createElement('blockquote');
				oPullquote.className = oElement.className
				oPullquoteP = document.createElement('p');
	// Insert the pullquote text
				for(j=0;j<oElement.childNodes.length;j++) {
					oPullquoteP.appendChild(oElement.childNodes[j].cloneNode(true));
				}
				oPullquote.appendChild(oPullquoteP);
	// Insert the blockquote element before the span elements parent element
				oElement.parentNode.parentNode.insertBefore(oPullquote,oElement.parentNode);
			}
		}
	},
	// addEvent function from http://www.quirksmode.org/blog/archives/2005/10/_and_the_winner_1.html
	addEvent : function(obj, type, fn) {
		if (obj.addEventListener)
			obj.addEventListener( type, fn, false );
		else if (obj.attachEvent)
		{
			obj["e"+type+fn] = fn;
			obj[type+fn] = function() { obj["e"+type+fn]( window.event ); }
			obj.attachEvent( "on"+type, obj[type+fn] );
		}
	}
};

pullquote.addEvent(window, 'load', function(){pullquote.init();});