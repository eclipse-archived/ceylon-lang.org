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
		$button.click(function(){
			// collect the source
			var src = collectSource($elem);
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
	});
}
