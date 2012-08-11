//Put the footer at the bottom event for small content
var primaryContentHeight = 0;
var footerOffsetBottom = 0;

function footerGravity() {
  var correction = $(window).height() - footerOffsetBottom;
  if (correction > 0) {
    $('#primary-content').css('min-height', primaryContentHeight + correction);
  }
}

$(function() {
  primaryContentHeight = $('#primary-content').height();
  footerOffsetBottom = $('.footer-bar').outerHeight() + $('.footer-bar').offset().top;
  footerGravity();
  $(window).resize(footerGravity);
});

// IDE windows

function collectSource($hl){
	var src = collectSourceFromComment($hl);
	if (src == undefined) {
		src = collectSourceFromHighlighter($hl);
	}
	if (src == "") src = undefined;
	return src;
}

function collectSourceFromComment($hl){
	var src = undentSource(extractComment($hl, "try:"));
	if (src == undefined) {
		var srcpre = undentSource(extractComment($hl, "try-pre:")); 
		var srcpost = undentSource(extractComment($hl, "try-post:"));
		if (srcpre || srcpost) {
			src = collectSourceFromHighlighter($hl);
			if (src != undefined) {
				src = (srcpre || "") + src + (srcpost || "");
			}
		}
	}
	return src;
}

function collectSourceFromHighlighter($hl){
	var txt = "";
	jQuery(".line", $hl).each(function (index, line){
		var first = true;
		jQuery("code", line).each(function (index, code){
			if(first)
				first = false;
			else
				txt += " ";
			// replace the &nbsp; with normal spaces
			txt += jQuery(code).text().replace(/\u00A0/g, ' ');
		});
		txt += "\n";
	});
	return txt;
}

function extractComment($hl, prefix){
	// Let's look for Comment blocks that appear before $hl
	var prev = $hl[0].previousSibling;
	while (prev && (prev.nodeType == 3 || prev.nodeType == 8)){
		if (prev.nodeType == 8){
			// A Comment block
			var txt = trimComment(prev.textContent);
			if (txt.indexOf(prefix) == 0) {
				// If it had the right prefix we return the contents of the comment
				return txt.substr(prefix.length);
			}
		} else {
			// A Text element, which we ignore
		}
		prev = prev.previousSibling;
	}
	return;
}

function trimComment(txt) {
	// We remove all whitespace from the start of the string
	txt = txt.replace(/^\s+/, "");
	// But we onyl remove spaces and tabs from the end
	txt = txt.replace(/[ \t]+$/, "");
	return txt;
}

function undentSource(src) {
	if (src) {
		// First we strip from the left until the first newline
		var p = src.indexOf("\n");
		if (p >= 0) {
			src = src.substr(p + 1);
		}
		
		// We make sure there are no tabs to mess things up
		src = src.replace(/\t/g, "    ");
		
		// Now we find the shortest common sequence of spaces starting all lines
		var indent = getCommonIndent(src);
		
		// And finally we strip the common indent from all lines
		if (indent != undefined) {
			var re = new RegExp("^" + indent, "gm");
			src = src.replace(re, "");
		}
	}
	return src;
}

function getCommonIndent(src) {
	var indent = undefined
	var lines = src.split("\n");
	for (idx in lines) {
		var spc = lines[idx].match("^ *");
		if ((indent == undefined) || spc.length < indent.length) {
			indent = spc;
		}
	}
	return indent;
}

var $editorIFrame;

function updateEditor(src){
	$editorIFrame.get(0).contentWindow.setEditCode(src);
}

function postSyntaxHighlighting(){
	jQuery(".syntaxhighlighter").each( function(index, element){
		var $elem = jQuery(element);
		var id = $elem.attr("id");
		var highlighter = SyntaxHighlighter.vars.highlighters[id];
		if(!(highlighter instanceof SyntaxHighlighter.brushes.Ceylon))
			return;
		$elem.addClass("with-editor");
		var $button = jQuery("<span class='bubble-button' title='Try this code in an online Ceylon editor'>Try</span>");
		var src = collectSource($elem);
		if (src){
			$button.click(function(){
				// collect the source
				if($editorIFrame){
					updateEditor(src);
				} else {
					// We must set the document.domain to be the same as the one set on http://try.ceylon-lang.org/embed.jsp
					// otherwise we can't touch their iframe and get the editor because we would have different subdomains
					// See https://developer.mozilla.org/en-US/docs/Same_origin_policy_for_JavaScript
					// We don't do it for localhost, though if localhost uses try.ceylon-lang.org it will not work and you
					// need to start your browser with security checks disabled to test this on localhost
					// Chrome would be "chromium-browser --disable-web-security" for example
					if(document.domain != "localhost")
						document.domain = "ceylon-lang.org";
					$editorIFrame = jQuery("<iframe class='code-editor' src='http://try.ceylon-lang.org/embed.jsp?src='>");
					$editorIFrame.load(function(){
						updateEditor(src);
					});
				}
				$editorIFrame.dialog({
					width: 800,
					height: 500,
					closeText: "Close",
					modal: true
				});
			});
			$elem.append($button);
		}
	});
}
