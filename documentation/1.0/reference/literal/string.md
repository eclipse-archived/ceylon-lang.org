---
layout: reference
title: '`String` literals'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

A `String` literal is enclosed between double quotes (`"`)

    String example = "This is a trivial example";
    String escaping = "\"Escaping\" with a backslash";
    String multiline = "Strings may
                        span lines";// note indentation, see below
    
A verbatim `String` literal is enclosed between three double quotes (`"""`)

    String verbatim = """<p>"Almost but not quite entirely unlike tea."</p>"""

## Description

### Unicode characters

You can use unicode escapes within string literals, like this:

    String quotation = "I think \{#2234} I am"; // an escaped Unicode therefore symbol

### Escaping

Backslash is used as an escape character. The following characters **must** be 
escaped when they're used in a plain `String` literal:

* backslash (`\`)
* double quote (`"`)

In addition the following *may* be escaped with a backslash in a plain `String` literal.

* tab, escaped as `\t`
* newline, escaped as `\n`
* return (`\r`)
* form feed (`\f`)
* backspace (`\b`)
* backtick (`\``)
* single quote (`'`)

In contrast, verbatim `String` literals do not support *any* escaping, so 
you can use characters like `"` freely. This means a vebatim String literal 
cannot end with a `"`.

### Line spanning

String literals may span lines. If they do then the newline line separator is 
used ('UN*X convention'), irrespective of the platform-specific character 
used to encode the end of line in the source file. 

For example, a multi-line string in a source file which uses `\r\n` as line 
separator (the 'Windows convention') will be compiled to a string which uses 
`\n` as line separator.

If having a different convention is really required use [escaping](#escaping) 
instead of line spanning literals.

### Initial whitespace

So that you can indent multi-line `String` literals, initial whitspace one lines
following the line containing the opening `"` character is removed. 
The whitespace trimming algorithm understands the usual conventions for 
spaces and tabs in indentation.

## See also

* [String literals](#{page.doc_root}/tour/basics/#strings_and_string_interpolation) 
  in the Tour of Ceylon 
* [String literals in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#stringliterals)
* [String templates](../../expression/string-template)

