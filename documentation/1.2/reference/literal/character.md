---
layout: reference11
title_md: '`Character` literals'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

A literal notation for a [`Character`](#{site.urls.apidoc_1_1}/Character.type.html) 
value.

## Usage 

A `Character` literal is a single character enclosed in paired single quotes, 
for example:

<!-- try: -->
    Character x = 'x';
    Character quote = '\'';

## Description

### Escaping

A character literals may contain an _escape sequences_. Backslash is used 
as an escape character. The following characters *must* be escaped when 
they're used within a plain `String` literal:

* backslash, `\`, must be written as `\\`
* single quote, `'`, must be written as `\'`
* backtick, `` ` ``, must be written as `` \` ``

The following traditional C-style escape sequences are also supported:

* tab, `\t`
* newline, `\n`
* return, `\r`
* form feed, `\f`
* backspace, `\b`
* double quote, `\"`

### Unicode Escapes

You can use Unicode escapes within character literals. Like this, identifying
a Unicode character using a hexadecimal code:

<!-- try: -->
    Character therefore = '\{#2234}'; // Unicode therefore symbol
    
Or, alternatively, using the Unicode character name:

<!-- try: -->
    Character therefore = '\{THEREFORE}';

Of course, you can directly embed a Unicode character in a `Character`
literal:

<!-- try: -->
    Character therefore = '∴';

But this is highly discouraged, since it causes problems when sharing source
code across operating systems with different default character encodings.

## See also

* [Character literals in the language specification](#{site.urls.spec_current}#characterliterals)

