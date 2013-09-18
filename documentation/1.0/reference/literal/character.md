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

A `Character` literal is a single character enclosed between single quotes (`'`), 
for example:


    Character x = 'x';
    Character quote = '\'';

## Description

### Unicode characters

You can use Unicode escapes within character literals, like this:

    Character therefore = `\{#2234}`; // an escaped Unicode 'therefore' symbol
    
Alternatively you can use the Unicode character name:

    Character because = `\{BECAUSE}`; // an escaped Unicode 'because' symbol

### Escaping

Backslash is used as an escape character. The following characters must be 
escaped when they're used in a `Character` literal:

* single quote ('), escaped as `\'`
* backslash (`\`), escaped as `\\`
* tab, escaped as `\t`
* formfeed, escaped as `\f`
* newline, escaped as `\n`
* return, escaped as `\r`
* backspace, escaped as `\b`

In addition, the following may be escaped with a backslash:

* double quote (`"`), escaped as `\"`

## See also

* [Character literals in the language specification](#{site.urls.spec_current}#characterliterals)

