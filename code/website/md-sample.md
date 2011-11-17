---
layout: default
title: Markdown .md file
unique_id: codepage
tab: documentation
author: Emmanuel Bernard
---
# Example of Markdown syntax

This page shows various examples of markdown syntax elements including code 
and highlighted code. This support the original 
[Markdown](http://daringfireball.net/projects/markdown/) 
syntax (detailed in the link). We also support some of 
the [Markdown Extra](http://michelf.com/projects/php-markdown/extra/)
extensions especially support for tables.


This is a h1 header
===================

This is a h2 header
-------------------

### this is a h3 header

This is some paragraph. To create a new paragraph, make sure to leave 
a blank line. 
If you don't, this is considered the same paragraph. So make sure
to leave a blank line.

Like this.

You can also avoid the extra line by ending the paragraph with two spaces.  
The next paragraph is glued.

You can define lists like this

* first
* second
* third

You can of course put things in bold like __this__ or **that** and things in 
italic like _this_ or *that*.

You can define [links](http://hibernate.org) or explicit links 
<http://hibernate.org>

Use backtick to use inline code `load("META-INF/persistence.xml")`.
Prefix code with 4 spaces to write a block of code (without syntax highlighting)

    public class Hello {
    }
  
You can also use syntax highlighting by using an HTML *pre* element
and use `class="brush: ceylon"` or `class="brush: java"`.

<pre class="brush: java">
public class Hello {
    public String name;
}
</pre>

<pre class="brush: ceylon">
shared class Hello() {
    shared String name;
}
</pre>

You can also write tables

|Title|Description|
|-----|-----------|
|Coco|Nuts|
  