---
layout: reference
title: 'Markdown'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The [`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) 
tool assumes the
arguments of the 
[`doc`](../doc/), [`deprecated`](../deprecated/), 
[`throws`](../throws/) and [`license` ](../license/)
annotations are formatted using 
[Markdown](http://daringfireball.net/projects/markdown/) syntax.

## Usage

See the 
[Markdown documentation](http://daringfireball.net/projects/markdown/) 
for examples.

## Description

The Markdown [syntax](http://daringfireball.net/projects/markdown/syntax) 
is well documented on the linked site. 

It is intended to be very 
close to plain text. The means that the documentation is easily 
read when viewing source code.

### Syntax highlighting

More often than not code blocks within documentation will be
snippets of Ceylon source code. Therefore the default is to 
syntax-highlight codeblocks as if they were Ceylon source code.

When the code block does not contain Ceylon 
source code fenced code blocks can be used to 
prevent this highlighting.

### Fenced code blocks

As an extension to the basic Markdown syntax, `ceylon doc` supports
Github-style "fenced code blocks". The normal Markdown syntax for 
code blocks is just to indent the code using 4 (or more) spaces:

<!-- try: -->
    "You can call this method like this:
         
         Anything result = method();
    "
    void method() {}

A fenced code block doesn't require the indentation, but surrounds the
code block with a line starting with three or more backticks `\``:

<!-- try: -->
    "You can call this method like this:
     ```
     Anything result = method();
     ```
    "
    void method() {}

You can state the syntax being used in the code block by following the 
backticks with the name

<!-- try: -->
    "You can call this method like this:
     ```xml
     <p>If I never see another angle-bracket again,
     won't be sorry.</p>
     ```
    "
    void method() {}

Supported syntaxes include:

* Java
* XML

These will be syntax highlighted appropriately. Unsupported syntaxes are 
not highlighted at all.

### Wiki-style links

**Note: Some of aspects of Wiki-style links may be revised before 1.0**

As an extension to the basic Markdown syntax, `ceylon doc` supports 
"Wiki-style" links for linking to the documentation of other 
declarations. These links are enclosed within double square brackets,
`[[` and `]]`:

<!-- try: -->
    "This method returns [[Anything]]."
    Anything method() {}
    
    "Prints the given object's [[Object.string]]."
    void printString(Object obj) => print(obj.string);

The link text will be the name of the linked-to declaration, output
using `<code>` tags (therefore rendered by the browser in a 
monospaced typeface).

You can specify different link text by following the name of the linked-to 
declaration with a pipe `|`:

<!-- try: -->
    "This method returns a [[Integer|number]]."
    Integer method() {}

In this case the link text will not be output using `<code>` tags.

The declaration name can be fully qualified, using `::` to separate the package 
part of the fully qualified name from the declaration part. 
This is useful when you need to refer to a declaration which has not been
`import`ed (and, apart from the documentation, does not need to be). 

<!-- try: -->
    "This method actually returns a [[com.example.foo::Foo]]"
    Anything method() => foo();


## See also

* The [Markdown](http://daringfireball.net/projects/markdown/) documentation

