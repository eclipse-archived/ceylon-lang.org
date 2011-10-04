---
layout: reference
title: `String` literals
tab: documentation
author: Tom Bentley
---

# #{page.title}

## Usage 

A `String` literal is enclosed between double quotes (`"`)

<!-- lang: ceylon -->

    String example = "This is a trivial example";
    String escaping = "Special characters are \"escaped\" with a backslash";
    String multiline = "Strings may
    span lines";

## Description

### Unicode characters

Since Ceylon source files are preprocessed for unicode escapes prior to parsing
you can use unicode escapes within string literals, like this:

<!-- lang: ceylon -->

    String quotation = "I think \u2234 I am"; // an escaped Unicode therefore symbol

### Escaping

Backslash is used as an escape character. The following characters **must** be 
escaped when they're used in a `String` literal:

* backslash (`\`)
* double quote (`"`)

In addition the following *may* be escaped with a backslash

* tab, escaped as `\t`
* newline, escaped as `\n`
* return (`\r`)
* form feed (`\f`)
* backspace (`\b`)
* backtick (`\``)
* single quote (`'`)

### Line spanning

String literals may span lines. If they do then the newline line separator is 
used ('UN*X convention'), irrespective of the platform-specific character 
used to encode the end of line in the source file. 

For example, a multi-line string in a source file which uses `\r\n` as line 
separator (the 'Windows convention') will be compiled to a string which uses 
`\n` as line separator.

If having a different convention is really required use [escaping](#escaping) 
instead of line spanning literals.

## See also

* [String literals](/documentation/tour/basics/#strings_and_string_interpolation) 
  in the Tour of Ceylon 
* [String literals in the language specification](#{site.urls.spec}#stringliterals)
* [String templates](../../expression/string_template)

