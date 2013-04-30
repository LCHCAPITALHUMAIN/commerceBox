/** vim:se ai lbr sts=4 sw=4 ts=4: **/
/**
 * TinyBox v.0.2 - a tiny library for overlaying content over a page
 *
 * Copyright (c) 2007 Alexandru Marasteanu <http://alexei.417.ro/>
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place, Suite 330, Boston, MA 02111-1307 USA
 */


Object.extend(Element, {
	show : function() {$A(arguments).each(function(i) {
		$(i).style.display =
			($(i).tagName.toLowerCase() == 'div' ? 'block' : '');
	});}
});

function $T() {
	var a = [];
	$A(arguments).each(function(i) {
		a.push($A(document.getElementsByTagName(i)));
	});
	return((a = a.flatten()).length > 1 ? a : a[0]);
};

var Over = {id: 'tiny-over'}, Load = {id: 'tiny-load'}, Tbox = {id: 'tiny-tbox'};
var Tiny = {
	initialize: function() {
		[Over, Load, Tbox].each(function(i) {
			new Insertion.Bottom($T('body'), '<div id="' + i.id + '"></div>');
		});
		Event.observe(document, 'click', Tiny.toggle.bindAsEventListener(Tiny));
	},

	toggle    : function(e) {
		switch(Event.findElement(e, 'a').rel) {
			case 'tiny-hide': Tiny.hide(e); Event.stop(e); break;
			case 'tiny-show': Tiny.show(e); Event.stop(e);
		}
	},

	show      : function(e) {
		/*@cc_on
		Tiny.scroll = {x: $T('html').scrollLeft, y: $T('html').scrollTop};
		window.scrollTo(0, 0);
		$T('html', 'body').each(function(i) {
			Element.addClassName(i, 'tiny-ie-hack');
		});
		@*/
		Over.show ? Over.show() : Element.show(Over.id);
		new Ajax.Updater(Tbox.id, Event.findElement(e, 'a').href, {
			onCreate  : function() {
				Load.show ? Load.show() : Element.show(Load.id);
			},
			onComplete: function() {
				Load.hide ? Load.hide() : Element.hide(Load.id);
				Tbox.show ? Tbox.show() : Element.show(Tbox.id);
			}
		});
	},

	hide      : function(e) {
		/*@
		$T('html', 'body').each(function(i) {
			Element.removeClassName(i, 'tiny-ie-hack');
		});
		window.scrollTo(Tiny.scroll.x, Tiny.scroll.y);
		@*/
		$(Tbox.id).update('');
		Tbox.hide ? Tbox.hide() : Element.hide(Tbox.id);
		Over.hide ? Over.hide() : Element.hide(Over.id);
	}
};

Event.observe(window, 'load', Tiny.initialize);

// Script.aculo.us effects
// fadein/fadeout effects for the overlay
Object.extend(Over, {
	show : function() {
		var elid = this.id;
		if ($(elid).style.display != 'block')
			new Effect.Fade(elid, {
				from: 0.1, to : 0.9, duration : 0.5,
				beforeStart : function() { Element.show(elid); }
			});
	},

	hide : function() {
		var elid = this.id;
		Effect.Fade(elid, {
			from : 0.9, to : 0.1, duration : 0.5,
			afterFinish : function() { Element.hide(elid); }
		});
	}
});
