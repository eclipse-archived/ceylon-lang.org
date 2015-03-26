---
layout: reference12
title_md: '`String` literals'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

A literal notation for a [`String`](#{site.urls.apidoc_1_1}/String.type.html) 
value.

## Usage 

A `String` literal is written between paired double quotes:

<!-- try: -->
    String example = "This is a trivial example";
    String escaping = "\"Escaping\" with a backslash";
    String multiline = "Strings may
                        span lines";// note indentation, see below
    
A verbatim `String` literal is written between paired triple-double quotes:

<!-- try: -->
    String verbatim = """<p>"Almost, but not quite, entirely unlike tea."</p>"""

## Description

### Escaping

Plain string literals may contain _escape sequences_. Backslash is used as an 
escape character. The following characters *must* be escaped when they're 
used within a plain `String` literal:

* backslash, `\`, must be written as `\\`
* double quote, `"`, must be written as `\"`
* backtick, `` ` ``, must be written as `` \` ``

In a plain `String` literal, the following traditional C-style escape sequences 
are also supported:

* tab, `\t`
* newline, `\n`
* return, `\r`
* form feed, `\f`
* backspace, `\b`
* single quote, `\'`

In contrast, verbatim `String` literals do not support *any* escaping, so you 
can use characters like `"`, `\`, and `` ` `` freely, with their literal 
interpretation.

### Unicode characters

You can use the same [unicode escapes](../character/#unicode_escapes) within 
plain string literals as in `Character` literals. Like this:

<!-- try: -->
    String quotation = "I think, \{#2234} I am"; // Unicode therefore symbol

Or using the Unicode character name:

<!-- try: -->
    String quotation = "I think, \{THEREFORE} I am";

Of course, you can also directly embed a Unicode character in a `String`
literal:

<!-- try: -->
    String quotation = "I think, ∴ I am";

But this is highly discouraged, since it causes problems when sharing source
code across operating systems with different default character encodings.

### Line spanning

String literals may span lines. A line break in a string literal _always_
results in a (Unix-style) newline character in the resulting `String`, 
irrespective of the platform-specific character used to encode the end 
of line in the source file itself. 

For example, a multiline string in a source file which uses `\r\n` as line 
separator (the Windows convention) will be compiled to a string which uses 
`\n` as line separator.

If a different convention is really required, use [escaping](#escaping) 
instead of line spanning literals.

Every line of a string literal spanning multiple lines is understood to
begin at the same column. Leading whitespace is automatically stripped
from the resulting `String`. For example:

    String greeting = "Hello
                       World";

And:

    String greeting = """Hello
                         World""";

Are both exactly equivalent to:

    String greeting = "Hello\nWorld";

### Interpolation

Plain strings containing two backticks, ` `` `, are not considered
literal strings, but [string templates](../../expression/string-template). 

Verbatim strings do not support interpolation.

## See also

* [`String` literals](#{page.doc_root}/tour/basics/#strings_and_string_interpolation) 
  in the Tour of Ceylon 
* [`String` literals in the language specification](#{site.urls.spec_current}#stringliterals)
* [`String` templates](../../expression/string-template)

