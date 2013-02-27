/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
            var keywords = 'module package import alias class interface object given value assign void function of ' +
                           'extends satisfies adapts abstracts in out return break continue throw ' +
                           'assert dynamic if else switch case for while try catch finally then ' +
                           'this outer super is exists nonempty';
            var annotations = 'shared abstract formal default actual variable deprecated small late ' +
                              'literal doc by see throws optional license';

		this.regexList = [
			{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	css: 'comments' },		// one line comments
			{ regex: /\/\*([\s\S]*?)?\*\//gm,				css: 'comments' },	 	// multiline comments
			{ regex: /\/\*(?!\*\/)\*[\s\S]*?\*\//gm,			css: 'preprocessor' },	// documentation comments
			{ regex: /"[^"]*"/gm,						css: 'string' },	 	// strings
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },		// strings
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },		// strings
			{ regex: /\b(([\d]+|\d{1,3}(_\d{3})*)(\.([\d]+|(\d{3}(_\d{3})*)*))?(E\+\d+)?[munpfkMGTP]?|0x[a-f0-9]+)\b/gi,			css: 'value' },			// numbers
//			{ regex: /(\?|\.\.\.|-&gt;)/g,					css: 'keyword' },		// ? ... ->
			// this is only dual-level, expand manually for three levels
//			{ regex: /&lt;\s*((in|out)\s+)?\w+(&lt;\s*((in|out)\s+)?\w+([,|]\s*((in|out)\s+)?\w+)*&gt;)?([,|]\s*((in|out)\s+)?\w+(&lt;\s*((in|out)\s+)?\w+([,|]\s*((in|out)\s+)?\w+)*&gt;)?)*&gt;/g,						css: 'color2' },
			{ regex: new RegExp(this.getKeywords(keywords), 'gm'),		css: 'keyword' },		// ceylon keyword
			{ regex: /\b[A-Z][a-zA-Z0-9_]*/g,				css: 'color1' },		// ceylon type
			{ regex: new RegExp(this.getKeywords(annotations), 'gm'),	css: 'functions' }		// ceylon annotations
			];

		this.forHtmlScript({
			left	: /(&lt;|<)%[@!=]?/g, 
			right	: /%(&gt;|>)/g 
		});
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['ceylon'];

	SyntaxHighlighter.brushes.Ceylon = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
