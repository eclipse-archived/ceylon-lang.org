---
layout: reference11
title_md: 'Markdown'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The [`ceylon doc`](#{site.urls.ceylon_tool_current}/ceylon-doc.html) 
tool assumes the arguments of the 
[`doc`](../doc/), [`by`](../by/), [`deprecated`](../deprecated/), 
[`throws`](../throws/), and [`license` ](../license/)
annotations are formatted using 
[Markdown](http://daringfireball.net/projects/markdown/) syntax.

## Usage

See the [Markdown documentation](http://daringfireball.net/projects/markdown/) 
for examples.

## Description

The Markdown [syntax](http://daringfireball.net/projects/markdown/syntax) 
is well documented on the linked site. 

Markdown is intended to be very close to plain text. The means that the 
documentation is easily read when viewing source code.

### Syntax highlighting

More often than not code blocks within documentation will be snippets of 
Ceylon source code. Therefore the default behavior is to syntax-highlight 
codeblocks as if they were Ceylon source code.

When the code block does not contain Ceylon source code, fenced code blocks
may be used to disable syntax highlighting.

### Code blocks

The usual Markdown syntax for code blocks is just to indent the code using 
4 spaces:

<!-- try: -->
    "You can call this method like this:
     
         Anything result = method();"
    void method() {}


### Fenced code blocks

As an extension to the basic Markdown syntax, `ceylon doc` supports
Github-style "fenced code blocks". A fenced code block doesn't require 
indentation, but "fences" the code block with a line starting with 
a sequence of three or more tildes (`~~~`):

<!-- try: -->
    "You can call this method like this:
     ~~~
     Anything result = method();
     ~~~"
    void method() {}

You can state the language being used in the code block by following the 
tildes with the name of the language.

<!-- try: -->
    "Documentation can contain XML:
     ~~~xml
     <p>If I never see another angle-bracket again,
        I won't be sorry.</p>
     ~~~
     Or Java:
     ~~~java
     List<String> strings = new ArrayList<>();
     ~~~"
    void method() {}

Supported syntaxes include:

* Java
* XML

Unsupported syntaxes are not highlighted at all.

### Wiki-style links

As an extension to the basic Markdown syntax, `ceylon doc` supports 
"Wiki-style" links for linking to the documentation of other declarations. 
These links are enclosed within double square brackets,
`[[` and `]]`:

<!-- try: -->
    "This method returns [[Anything]]."
    Anything method() => null;
    
    "Prints the given object's [[Object.string]]."
    void printString(Object obj) => print(obj.string);

The link text will be the name of the linked-to declaration, output
using `<code>` tags (therefore rendered by the browser in a 
monospaced typeface).

You can specify a different link text by including it before the name of 
the linked-to declaration, separating the two with a pipe `|`:

<!-- try: -->
    "This method returns a [[whole number|Integer]]."
    Integer method() => 1;

In this case the link text will not be output using `<code>` tags.

The declaration name can be fully qualified, using `::` to separate the package 
part of the fully qualified name from the declaration part. This is useful when 
you need to refer to a declaration which has not been `import`ed by the current
compilation unit. 

<!-- try: -->
    "This method actually returns a [[com.example.foo::Foo]]"
    Anything method() => createFoo();

## See also

* The [Markdown](http://daringfireball.net/projects/markdown/) documentation

