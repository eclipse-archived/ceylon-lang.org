---
layout: reference
title: '`Character` literals'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

A `Character` literal is a single character enclosed between backticks (`` ` ``), 
for example:


    Character x = `x`;
    Character backtick = `\``;

## Description

### Unicode characters

Since Ceylon source files are preprocessed for unicode escapes prior to parsing
you can use unicode escapes within character literals, like this:


    Character therefore = `\u2234`; // an escaped Unicode therefore symbol

### Escaping

Backslash is used as an escape character. The following characters must be 
escaped when they're used in a `Character` literal:

* backtick (\`), escaped as `` \` ``
* backslash (`\`), escaped as `\\`
* tab, escaped as `\t`
* formfeed, escaped as `\f`
* newline, escaped as `\n`
* return, escaped as `\r`
* backspace, escaped as `\b`

In addition, the following may be escaped with a backslash:

* single quote (`'`), escaped as `\'`
* double quote (`"`), escaped as `\"`

## See also

* [Character literals in the language specification](#{page.doc_root}/#{site.urls.spec_relative}#characterliterals)

