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
	console.log(src);
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
	return $hl.find("code").text();
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
		var line = lines[idx];
		if ($.trim(line).length > 0) { // Ignore empty lines
			var spc = line.match("^ *");
			if ((indent == undefined) || spc.length < indent.length) {
				indent = spc;
			}
		}
	}
	return indent;
}

var $editorIFrame;

function updateEditor(src){
	$editorIFrame.get(0).contentWindow.editSource(src);
}

function addTryButtons(){
	jQuery("pre[data-language]").each(function(index, element){
		var $elem = jQuery(element);
		var lang = $elem.attr("data-language");
		if (lang!="ceylon") return;
		var ttry = $elem.attr("data-try");
		if (ttry=="false") return;
		$elem.addClass("with-editor");
		var $button = jQuery("<span class='try-button' title='Try this code in an online Ceylon editor'>TRY ONLINE</span>");
		var src = collectSource($elem);
		if (src){
			$button.click(function(){
		        console.log(src);
				if($editorIFrame){
					updateEditor(src);
				} else {
					// We must set the document.domain to be the same as the one set on http://try.ceylon-lang.org/embedded.html
					// otherwise we can't touch their iframe and get the editor because we would have different subdomains
					// See https://developer.mozilla.org/en-US/docs/Same_origin_policy_for_JavaScript
					// We don't do it for localhost, though if localhost uses try.ceylon-lang.org it will not work and you
					// need to start your browser with security checks disabled to test this on localhost
					// Chrome would be "chromium-browser --disable-web-security" for example
					if(document.domain != "localhost")
						document.domain = "ceylon-lang.org";
					$editorIFrame = jQuery("<iframe class='code-editor' src='http://try.ceylon-lang.org/index.html?embedded=true'>");
					$editorIFrame.load(function(){
						updateEditor(src);
					});
				}
				$editorIFrame.dialog({
					width: 630,
					height: 555,
					closeText: "DONE",
					closeOnEscape: true,
					modal: true,
					title: "CEYLON WEB RUNNER"
				});
				jQuery(".ui-dialog-titlebar-close").html("<i class='fa fa-times'></i>&nbsp;DONE");
			});
			$elem.prepend($button);
		}
	});
}

// Roadmap

function loadMilestone(div, title, json, repo){
    var open = json.data.open_issues;
    var closed = json.data.closed_issues;
    var percentage = 100 * closed / (open + closed);
    var milestone = json.data.title;
    makeMilestoneDiv(div, title, open, closed, milestone, repo);
}

function makeMilestoneDiv(div, title, open, closed, milestone, repo){
	var percentage = 100 * closed / (open + closed);
	div.empty();
	
	if(title != null){
		jQuery("<div/>").addClass("title").text(title + ": ").append(jQuery("<a/>").attr("href", "https://github.com/ceylon/" + repo + "/milestones/" + milestone).text(milestone)).appendTo(div)
	}
	jQuery("<div/>").addClass("count").text("closed: " + closed + " — open: " + open).appendTo(div);

	var bar = jQuery("<div/>").attr('class', 'progress-bar');
	var progress = jQuery("<div/>").attr({'class': 'progress', 'style': 'width: ' + percentage + '%;'}).appendTo(bar);
	jQuery("<div/>").addClass('text').text(Math.round(percentage) + "%").appendTo(progress);
	div.append(bar);
	
	div.addClass("milestone-progress");
}

jQuery(function (){
	var $overall = jQuery("#milestone-overall");
	makeMilestoneDiv($overall, null, 100, 0);
	var open_total = 0;
	var closed_total = 0;
	
	jQuery("div[data-milestone]").each(function (index, elem){
		var $elem = jQuery(elem);
        var title = $elem.attr("data-title");
		var repo = $elem.attr("data-repo");
		var milestone = $elem.attr("data-milestone");
		var url = "https://api.github.com/repos/ceylon/" + repo + "/milestones/" + milestone + "?callback=?";
		makeMilestoneDiv($elem, title, 100, 0, "1.3");
		jQuery.getJSON(url, function(json){
		    open_total += json.data.open_issues;
		    closed_total += json.data.closed_issues;
			loadMilestone($elem, title, json, repo);
			makeMilestoneDiv($overall, null, open_total, closed_total);
		});
	});
	addTryButtons();
});

/*
 Linked section headers:
 Every header with id that contains no <a> child nodes
 gets its content wrapped by a link to that anchor.
 For example:
 
     <h2 id="a_really_simple_program">A <em>really</em> simple program</h2>
     <h2 id="a_really_simple_program"><a class="anchor" href="http://localhost:4242/documentation/1.0/tour#a_really_simple_program">A <em>really</em> simple program</a></h2>
 
 TODO: This should be done by the Markdown processor; see #308.
 */
jQuery(function($) {
    $(":header[id]").each(function(index, elem) {
        var $elem = $(elem);
        var anyLink = false;
        $elem.children().each(function() {
            if($(this).is("a"))
                anyLink = true;
        });
        if(!anyLink) {
            var html = $elem.html();
            $elem.empty();
            $elem.append($("<a>").attr("href", document.URL.replace(/\/?(\#.*)?$/, "") + '#' + $elem.attr("id")).attr("class", "anchor").html(html));
        }
    });
});

jQuery(function($) {
    $(".nav-tabs > li > a").each(function(index, elem) {
        var $elem = $(elem);
        $elem.click(function() {
          var $li = $elem.parent();
          if($li.hasClass("active")){
            return false;
          }
          $li.siblings().removeClass("active");
          $li.addClass("active");
          var target = $elem.attr("aria-controls");
          var $tabs = $li.parent().next();
          $tabs.children().removeClass("active");
          $("#"+target).addClass("active");
          return false;
        });
    });
});
